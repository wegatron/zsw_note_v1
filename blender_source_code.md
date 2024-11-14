
# Blender Source code
## Project Compile On Linux
* 安装开发包(依赖库)
    svn上的库比较陈旧, 直接安装系统库.
    ```bash
    ./build_files/build_environment/install_linux_packages.py --all
    ```

<!-- * 预编译的第三方依赖库: 
    https://svn.blender.org/svnroot/bf-blender/trunk/lib/
    更新oidn: https://www.openimagedenoise.org/downloads.html
    更新openpgl: https://github.com/OpenPathGuidingLibrary/openpgl/archive/refs/tags/v0.5.0.zip -->

* 使用系统的库
    -DWITH_LIBS_PRECOMPILED=OFF
* Shader预编译(保证shader代码是正确的):
    CMAKE option WITH_GPU_SHADER_BUILDER=On.
    Only shaders that are part of the SHADER_CREATE_INFOS and .do_static_compilation(true) is set, will be compiled.

## Project Compile On Windows
预编译第三库: https://svn.blender.org/svnroot/bf-blender/trunk/lib/win64_vc15

## Blender Rendering

| 代码目录 | 描述 |
| --- | --- |
| `source/blender/gpu/` | 通用的GPU backend 和 通用的gpu shader node(function) |
| `source/blender/draw/`| viewport绘制 和 EEVE渲染引擎(包括EEVEE和EEVEE next下一个版本, 可以获得更写实的效果, 并且支持了一些新的特性: 光线追踪、实时displacement...) |

`source/blender/draw/eevee/shaders/infos`, `source/blender/gpu/shaders/infos` 等中描述了shader源码的使用.

### EEVEE Principled BSDF Node 全链路

shader代码: `source/blender/gpu/shaders/material/gpu_shader_material_principled.glsl`
c++源码: `source/blender/nodes/shader/nodes/node_shader_bsdf_principled.cc`

* node_declare 定义了该节点UI向外暴露的信息

* principle bsdf 包含多个子模块, 通过flag进行开关

    ```c++
    static int node_shader_gpu_bsdf_principled(GPUMaterial *mat,
                                            bNode *node,
                                            bNodeExecData * /*execdata*/,
                                            GPUNodeStack *in,
                                            GPUNodeStack *out) {
        ...                                                         
        bool use_diffuse = socket_not_zero(SOCK_SHEEN_WEIGHT_ID) ||
                            (socket_not_one(SOCK_METALLIC_ID) &&
                            socket_not_one(SOCK_TRANSMISSION_WEIGHT_ID));
        eGPUMaterialFlag flag = GPU_MATFLAG_GLOSSY;
        if (use_diffuse) {
        flag |= GPU_MATFLAG_DIFFUSE;
        }
        ...
        GPU_material_flag_set(mat, flag);
        return GPU_stack_link(mat,
                            node,
                            "node_bsdf_principled",
                            in,
                            out,
                            GPU_constant(&use_diffuse_f),
                            GPU_constant(&use_coat_f),
                            GPU_constant(&use_refract_f),
                            GPU_constant(&use_multi_scatter),
                            GPU_uniform(&use_sss));
    }
    ``` 

* Shader code assemble
    * `source/blender/draw/engines/eevee_next/eevee_material.cc`
        `material_create_info_ammend`, `material_pass_get` 调用`material_shader_get` 获取Material对应的GPUMaterial(此处利用shader uuid, 保证每一个Material的每种类型只有一个GPUMaterial)
    <!-- * `source/blender/draw/engines/eevee/eevee_shaders.cc`. 
        `EEVEE_shaders_material_shaders_init` 初始化, 构建基础的code lib.
        `EEVEE_material_default_get`/`EEVEE_material_get` 获取Material对应的GPUMaterial(此处利用shader uuid, 保证每一个Material的每种类型只有一个GPUMaterial) -->
    * `source/blender/gpu/intern/gpu_codegen.cc` 根据node tree组装shader源码, 
        `GPU_generate_pass` 根据codegen的hash值进行cache
        eevee_shader.cc: `eevee_shader_material_create_info_amend` 生成完整shader code.
        `GPU_pass_compile`中调用`GPU_shader_create_from_info`创建shader.
    * `source/blender/draw/engines/eevee_next/eevee_shader.cc`
        调用backend创建shader(没有shader cache). `source/blender/gpu/intern/gpu_shader.cc` : GPU_shader_create

参考: [blender中添加自定义节点](https://zhuanlan.zhihu.com/p/508277873)

Q1: 如何实现既支持数值, 又支持从纹理采样?
    通过code gen根据nodetree组装shader code

Q2: gpu_shader_material_principled.glsl在哪里被用到? (Material, Nodetree从哪里来?)

Q3: 在blender源码中大量使用了裸指针, 为什么?

Q4: gpu material的uuid如何生成?
    uuid只是代表material是在何种geometry+pipeline类型下.


### NodeTree System

bNode

bNodeSocket

bNodeLink

Q: node中的shader/c++代码如何体现?

Q: node link如何与shader对应起来?

## Ray Tracying

光线追踪去噪, 包括oidn(Intel Open Image Denoise)和Optix.
源码: intern/cycles/integrator/denoiser.h

使用[OpenPGL](https://github.com/OpenPathGuidingLibrary/openpgl)(包含了STOA的基于ML的算法)进行path guiding, 提高采样质量.

## good idea
文档 https://developer.blender.org/docs/features/

* [decision tree](https://developer.blender.org/docs/handbook/guidelines/design/decision_tree/)

* [dependency graph](https://developer.blender.org/docs/features/core/depsgraph/)
    dependency graph 不止是一个依赖图, 还保存着当前的计算结果数据(DNA), 渲染系统只能从dependency graph中获取当前的数据, 不能访问原始的DNA数据.
    核心的数据结构 + 核心计算
    在blender中, 每种数据块都有一个自己的ID, 放在struct(数据块)的头部. 数据块的类型在`idtype.cc`中可以查询得到. 通过`GS(id-\>name)`可以将name转化为idtype enum类型. BTW不同的数据块, 放到IDNode中, 则成了不同类型的数据节点.
    cow实现: IDNode中有两个ID的指针: id_org和id_cow. 当本地数据有修改时, 则id_cow需要进行深度拷贝, 并evaluate.

     DepsgraphNodeBuilder::build_scene_render --> DepsgraphNodeBuilder::build_scene_compositor中可以看到整个场景的node tree的depsgraph构建过程.

     tag和数据更新的逻辑
        depsgraph_eval.cc:DEG_evaluate_on_framechange
            deg_graph->tag_time_source(); deg_flush_updates_and_refresh
                deg::deg_graph_flush_updates
        可以通过python函数debug_relations_graphviz将图导出

* [function system](https://developer.blender.org/docs/features/nodes/proposals/function_system/)
    这里作者提到, 使用LLVM固然是一种选择, 但会使得过程变得复杂(不好调试). 而MultiFunction其实是处理批量数据, 所以单个evaluate方式进行.
    [runtime function system >> MultiFunction](source/blender/functions/FN_multi_function.hh)
        通过定义signature来设置了function的input/output
    [runtime type system >> CPPType](source/blender/blenlib/BLI_cpp_types.hh)
        在signature中需要知道input的type信息
    [example](source/blender/functions/tests/FN_multi_function_test.cc)
    
    ```c++
    class AddFunction : public MultiFunction {
    public:
        AddFunction()
        {
            static Signature signature = []() {
            Signature signature;
            SignatureBuilder builder("Add", signature);
            builder.single_input<int>("A");
            builder.single_input<int>("B");
            builder.single_output<int>("Result");
            return signature;
            }();
            this->set_signature(&signature);
        }
        void call(const IndexMask &mask, Params params, Context /*context*/) const override
        {
            const VArray<int> &a = params.readonly_single_input<int>(0, "A");
            const VArray<int> &b = params.readonly_single_input<int>(1, "B");
            MutableSpan<int> result = params.uninitialized_single_output<int>(2, "Result");
            mask.foreach_index([&](const int64_t i) { result[i] = a[i] + b[i]; });
        }
    };
    ```

    * [Procedure](source/blender/functions/FN_multi_function_procedure.hh) 将多个MultiFunction组件成网络, 支持以图形界面的方式进行动态组装. branch/loop/call/deconstruct...
        这里分为: procedure, procedure_builder, procedure_optimizer, procedure_executor
    [example](source/blender/functions/tests/FN_multi_function_procedure_test.cc)
        
    * [LazyFunction](FN_lazy_function_test.cc) CPU Lazy Function Graph used by Geometry Node
        SideEffectProvider 用来标记function会有额外的输出操作(修改全局变量、记录日志...)
        GraphExecutor 本身也是一个LazyFunction, 与filament的FrameGraph先compile+culling的逻辑不同, LazyFunction采用由输出去请求输入计算的方式(省去了预处理操作)
        ```c++
        /**
        * Main entry point to the execution of this graph.
        */
        void execute(Params &params, const Context &context)
        {
            //...
            CurrentTask current_task;
            if (is_first_execution_) {
            /* Allocate a single large buffer instead of making many smaller allocations below. */
            char *buffer = static_cast<char *>(
                local_data.allocator->allocate(self_.init_buffer_info_.total_size, alignof(void *)));
            this->initialize_node_states(buffer); // 并行初始化buffer
            // ...
            /* Retrieve and tag side effect nodes. */
            Vector<const FunctionNode *> side_effect_nodes;
            if (self_.side_effect_provider_ != nullptr) {
                side_effect_nodes = self_.side_effect_provider_->get_nodes_with_side_effects(context);
                for (const FunctionNode *node : side_effect_nodes) {
                BLI_assert(self_.graph_.nodes().contains(node));
                const int node_index = node->index_in_graph();
                NodeState &node_state = *node_states_[node_index];
                node_state.has_side_effects = true;
                }
            }
            // side effect node need compute
            this->schedule_side_effect_nodes(side_effect_nodes, current_task, local_data);
            }

            this->schedule_for_new_output_usages(current_task, local_data);
            this->forward_newly_provided_inputs(current_task, local_data);

            this->run_task(current_task, local_data); // 真正执行
        }
        ```
        
    GPU Shader Graph
        对于GPU上的node graph如何生成 LLVM IR

* RenderSystem
    blender/render/RE_** 渲染相关接口
    blender/draw/engines/eevee_next eevee_next渲染引擎
    
    | 文件 类 | 函数 | 作用 ｜
    | --- | --- | --- |
    | eevee_camera.hh | sync() | 将camera的数据信息, 更新到CameraData中, 后续通过data_get函数获取, 传递到gpu |
    | eevee_instance.hh | render_sample() | 一次采样的渲染, 在blender中使用了sampling.step()来随机每次采样的偏移量, 这里会有多个view的渲染:capture_view(捕捉环境光和探针)、main_view(最终场景的渲染)、lookdev_view(开发和调试视图) |
    | eevee_view.hh | render() | 其中有6个view(为了后续支持全景相机panoramic camera), 但真正启用的却只有一个. 具体步骤包括: setup(RT,Lights,HiZ), volume prepass, defered.render, background.render, ao.render, forward.render, transparent_pass, postfx |
    | eevee_pipeline.hh | DeferredPipeline::render | opaque_layer渲染不透明物体, 具体步骤包括: Pre-pass, G-buffer pass, Light Evaluation, Combine Pass; refraction_layer渲染反射 |
    | eevee_hizbuffer.cc | HiZBuffer::sync | 使用compute pass计算zbuffer的mip map(取最大值), 然后取物体的bbox, 定位到mip level的4个depth值进行判断是否被剔除. 真正的mip数据保存在2个hiz_tex_中 |
    | draw_manager.cc | Manager::submit | 绑定视图、计算可见性、设置绘制状态并提交绘制命令。 |
    |

    * [Hiz pass](https://www.rastergrid.com/blog/2010/10/hierarchical-z-map-based-occlusion-culling/)
        source/blender/draw/engines/eevee_next/shaders/infos/eevee_hiz_info.hh 相关的shader,c++数据定义
        source/blender/draw/engines/eevee_next/shaders/eevee_hiz_update_comp.glsl



* Allocator

* Blender的自动测试
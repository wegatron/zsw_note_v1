---
tags: rendering, GameEngine
---

![[scene_render_overview.excalidraw|700]]
## USD/Hydra
作为MaterialX的一个重要的container, USD提供了一个重要的渲染架构——Hydra. 将scene 和 render拆解开来, 使得多种不同的场景表示和多种不同的渲染器, 可以相互随意组合.
[usd-hydra 开源代码](https://github.com/PixarAnimationStudios/USD/tree/5c5ebddff35012461a2b0ba773c47f05730cbab4/pxr/imaging/hd)
[usd-hydra siggraph 2019 introduction](https://graphics.pixar.com/usd/files/Siggraph2019_Hydra.pdf)
![[rc/usd_hydra.png]]

在Hydra中, 场景元素可以用HydraPrimitives来表示:
![[hydra_scene_description.png]]
![[rc/hydra_primitives.png]]

example code:
```c++
// 主要流程
int main() 
{
    // Hydra initialization
    HdEngine engine;
    TinyRenderDelegate renderDelegate;
    HdRenderIndex *renderIndex = HdRenderIndex::New(&renderDelegate);
    TinySceneDelegate sceneDelegate(
	    renderIndex, SdfPath::AbsoluteRootPath()); 
    // Create your task graph 
    // collection determine what you want to render from the render index
    HdRprimCollection collection(...);
    HdRenderPassSharedPtr renderPass(
	    renderDelegate.CreateRenderPass(renderIndex, collection));
    HdRenderPassStateSharedPtr renderPassState(
	    renderDelegate.CreateRenderPassState());
    HdTaskSharedPtr taskRender(
	    new RenderTask(renderPass, renderPassState));
    HdTaskSharedPtr taskColorCorrection(new ColorCorrectionTask());
    HdTaskSharedPtrVector tasks = { taskRender, taskColorCorrection };
    // Populate scene graph and generate image
    sceneDelegate->Populate();
    engine.Execute(renderIndex, &tasks);
    // Change time causes invalidations, and generate image
    sceneDelegate->SetTime(1);
    engine.Execute(renderIndex, &tasks);
    return EXIT_SUCCESS;
}

class TinySceneDelegate final: public HdSceneDelegate 
{ 
public:
    // Scene delegate implementation 
    HdMeshTopology GetMeshTopology(SdfPath const& id) override;
    GfMatrix4d GetTransform(SdfPath const& id) override;
    VtValue Get(SdfPath const& id, TfToken const& key) override;

    // Primvar data is organized by its topological dimension,
    // That is: per-prrimitive, per-face, per-vertex, etc.
    HdPrimvarDescriptorVector GetPrimvarDescriptors(
	    SdfPath const& id,...) override; 
    // Scene graph population
    void Populate(); // 更新数据
    ... 
};

class TinyRenderDelegate final: public HdRenderDelegate
{
public:
    // Create/Destroy supported types of 
    // Hydra primitives (Rprim, Sprim, Bprim) 
    HdRprim *CreateRprim(TfToken const& typeId, SdfPath const& rprimId, 
	    SdfPath const& instancerId) override 
    {
	    return new TinyRenderDelegate_Mesh(
		    typeId, rprimId, instancerId);
    } 

    void DestroyRprim(HdRprim *rPrim) override 
    {
	    delete rPrim;
    } 
    ...
};

class TinyRenderDelegate_Mesh final: public HdMesh 
{
public:
    void Sync(HdSceneDelegate *delegate, HdDirtyBits *dirtyBits ...) override 
    {
        SdfPath const& id = GetId();
        if (HdChangeTracker::IsTransformDirty(*dirtyBits, id))
        {
            delegate->GetTransform(id);
            cout << "Pulling new transform -> " << id << endl;
        }
        *dirtyBits &= ~HdChangeTracker::AllSceneDirtyBits;
    }
    HdDirtyBits GetInitialDirtyBitsMask() const override
    {
        return HdChangeTracker::AllDirty;
    }
    ...
};
```
在整套 Hydra `scene graph` 是外部的, `USD/pxr/usd/usd/stage.h:UsdStage` 提供了usd文件的加载.
	![[usd_view.png]]

USD Hydra结合方式:
![[usd_hydra_integrating.png]]
[AMD RadeonProRenderUSD](https://github.com/GPUOpen-LibrariesAndSDKs/RadeonProRenderUSD/tree/3d90ef60534545d6a4b7af97092560740b26b65a/pxr/imaging/plugin/hdRpr) 实现了HdEngine.
[simple USD Render View Example with Qt C++ / QML](https://mtw75.medium.com/simple-usd-render-view-example-with-qt-c-qml-4bc000d15567) 直接使用UsdImagingGLEngine.

## MaterialX
MaterialX 提供了一套完整的材质体系+渲染方案(相关实现opengl/metal), 按照其标准定义的材质可以在不同的渲染器中得到完全一致的渲染效果. MaterialX可以被打包在gltf、usd文件中.

![[materialx_render_tree.png]]

![[materialx_render_combine_0.png]]

![[materialx_render_combine_1.png]]


### MaterialViewer 源码分析

渲染除了参考`MaterialXView`之外, 还可以参考`MaterialXRender`. 其最终都调用了`GlslProgram`、`MslProgram`, 由其进行shader、资源绑定.

![[materialx_render]]

1. mesh加载
	读取文件数据后, 将数据拷贝到materialx的数据结构中.
	![[rc/materialx_load_mesh.png]]
	
2. material的加载、初始化(shader编译)
	这里用到了UDIM, 参考 https://zhuanlan.zhihu.com/p/428735300
	![[materialx_load_build.png]]
	
	根据material node创建ShaderGraph, 由ShaderGraph来生成shader.
	![[rc/materialx_shader_create.png]]
	
	```c++
	// 加载Material, 将Material存放到
	// std::map<mx::MeshPartitionPtr, mx::MaterialPtr> 
	// _materialAssignments;
	void loadDocument()
	{
		// 加载Material
		mx::readFromXmlFile(doc, filename, _searchPath, &readOptions);
        // Apply direct lights.
        applyDirectLights(doc);

		// material
	    {
			mx::MaterialPtr mat = _renderPipeline->createMaterial();
			mat->setDocument(doc);
			mat->setElement(typedElem);
			mat->setMaterialNode(materialNodes[i]);
			newMaterials.push_back(mat);
	    }
		// Generate a shader for the new material.
		// 这里shader已经根据material设置了预设值
		// 根据material node创建ShaderGraph, 由ShaderGraph来生成shader.
        mat->generateShader(_genContext)
        {
	        // Create the root shader graph
		    ShaderGraphPtr graph = ShaderGraph::create(
			    nullptr, name, element, context);
			    // Create uniforms for the published graph interface
		    for (ShaderGraphInputSocket* inputSocket : graph->getInputSockets())
		    {
		        // Only for inputs that are connected/used internally,
		        // and are editable by users.
		        if (!inputSocket->getConnections().empty() && graph->isEditable(*inputSocket))
		        {
		            psPublicUniforms->add(inputSocket->getSelf());
		        }
		    }
        }
	    
		// 没有材质则设置为默认材质
		mx::GlslMaterialPtr fallbackMaterial = newMaterials[0];
		if (!_mergeMaterials || fallbackMaterial->getUdim().empty())
		{
			for (mx::MeshPartitionPtr geom : _geometryList)
			{
				if (!_materialAssignments[geom])
				{
					assignMaterial(geom, fallbackMaterial);
				}
			}
		}
	}
	```
	这里shader已经根据material设置了预设值:
	```glsl
	// Uniform block: PublicUniforms
	uniform displacementshader displacementshader1;
	uniform float SR_default_base = 1.000000;
	uniform vec3 SR_default_base_color 
		= vec3(0.800000, 0.800000, 0.800000);
	uniform float SR_default_diffuse_roughness = 0.000000;
	uniform float SR_default_metalness = 0.000000;
	uniform float SR_default_specular = 1.000000;
	```
3. 绘制
	![[materialx_render.png]]

	```c++
	for (const auto& assignment : _materialAssignments)
	{
		mx::MeshPartitionPtr geom = assignment.first;
		mx::GlslMaterialPtr material = assignment.second;
		shadowState.ambientOcclusionMap = 
			getAmbientOcclusionImage(material);
		if (!material)
		{
			continue;
		}
	
		material->bindShader();
		material->bindMesh(_geometryHandler->findParentMesh(geom));
		if (material->getProgram()->hasUniform(mx::HW::ALPHA_THRESHOLD))
		{
			material->getProgram()->bindUniform
				(mx::HW::ALPHA_THRESHOLD, mx::Value::createValue(0.99f));
		}
		material->bindViewInformation(_viewCamera);
		material->bindLighting(_lightHandler, _imageHandler, shadowState);
		material->bindImages(_imageHandler, _searchPath);
		material->drawPartition(geom);
		material->unbindImages(_imageHandler);
	}
	```

除此之外, 还可以参考`GlslRender`

## ECS System
### vulkan scene graph 
感觉接口设计得很"现代"——正式我们想要的:
```c++
// https://github.com/vsg-dev/vsgExamples/blob/master/examples/app/vsgviewer/vsgviewer.cpp
auto group = vsg::Group::create();
auto object = vsg::read(filename, options);
group->addChild(node);
vsg_scene = group;

auto camera = vsg::Camera::create(perspective, lookAt, vsg::ViewportState::create(window->extent2D()));

...
auto commandGraph = vsg::createCommandGraphForView(window, camera, vsg_scene);

viewer->assignRecordAndSubmitTaskAndPresentation({commandGraph});

viewer->compile();

// rendering main loop
while (viewer->advanceToNextFrame() && (numFrames < 0 || (numFrames--) > 0)) {...}
```
另外, 也提供了low level 使用:
```c++
// https://github.com/vsg-dev/vsgExamples/blob/master/examples/commands/vsgdraw/vsgdraw.cpp
```

### Bevy
![[render_graph0.jpg]]
RenderGraph中的一个node即一种类型的process, 其通过遍历(query) world中所有符合条件的entity, 并进行处理:
```rust
pub struct QueryState<Q: WorldQuery, F: ReadOnlyWorldQuery = ()> {
    world_id: WorldId,
    pub(crate) archetype_generation: ArchetypeGeneration,
    pub(crate) matched_tables: FixedBitSet,
    pub(crate) matched_archetypes: FixedBitSet,
    pub(crate) archetype_component_access: Access<ArchetypeComponentId>,
    pub(crate) component_access: FilteredAccess<ComponentId>,
    // NOTE: we maintain both a TableId bitset and a vec because iterating the vec is faster
    pub(crate) matched_table_ids: Vec<TableId>,
    // NOTE: we maintain both a ArchetypeId bitset and a vec because iterating the vec is faster
    pub(crate) matched_archetype_ids: Vec<ArchetypeId>,
    pub(crate) fetch_state: Q::State,
    pub(crate) filter_state: F::State,
}
```
![[render_graph1.jpg]]
RenderGraph中, 通过add_node, add_edge. 来构建整个处理流程图.
```rust
let mut draw_2d_graph = RenderGraph::default();
draw_2d_graph.add_node(graph::node::MAIN_PASS, pass_node_2d);
draw_2d_graph.add_node(graph::node::TONEMAPPING, tonemapping);
draw_2d_graph.add_node(graph::node::END_MAIN_PASS_POST_PROCESSING, EmptyNode);
draw_2d_graph.add_node(graph::node::UPSCALING, upscaling);
let input_node_id = draw_2d_graph.set_input(vec![SlotInfo::new(
    graph::input::VIEW_ENTITY,
    SlotType::Entity,
)]);
draw_2d_graph.add_slot_edge(
    input_node_id,
    graph::input::VIEW_ENTITY,
    graph::node::MAIN_PASS,
    MainPass2dNode::IN_VIEW,
);
draw_2d_graph.add_slot_edge(
    input_node_id,
    graph::input::VIEW_ENTITY,
    graph::node::TONEMAPPING,
    TonemappingNode::IN_VIEW,
);
draw_2d_graph.add_slot_edge(
    input_node_id,
    graph::input::VIEW_ENTITY,
    graph::node::UPSCALING,
    UpscalingNode::IN_VIEW,
);
draw_2d_graph.add_node_edge(graph::node::MAIN_PASS, graph::node::TONEMAPPING);
draw_2d_graph.add_node_edge(
    graph::node::TONEMAPPING,
    graph::node::END_MAIN_PASS_POST_PROCESSING,
);
draw_2d_graph.add_node_edge(
    graph::node::END_MAIN_PASS_POST_PROCESSING,
    graph::node::UPSCALING,
);
graph.add_sub_graph(graph::NAME, draw_2d_graph);

```

![[rc/ecs_system.png]]

![[render_graph.png]]


## PhysicsX
Oasis 物理第一弹：基于WebAssembly 的 PhysX : https://juejin.cn/post/7006491278611316750

## 方案

使用entt构建自己的scene manager. 然后利用MaterialX构建renderpass, 进行渲染. 后期, 可以通过加入converter将scene graph转化为 Hydra 的prim, 从而利用其他渲染器进行渲染.

![[scene_graph_0.png|280]]  ![[scene_graph_1.png|400]]

render graph可参考:
1. [OpenSceneGraph/VulkanSceneGraph](https://github.com/vsg-dev/VulkanSceneGraph/tree/master/include/vsg/nodes) 渲染和场景共享同一份数据, 只参考, 难度适中
2. [blender eevee render](https://github.com/blender/blender/blob/a1f52a02a874db139ee0af5dd57cea8e6b546a04/source/blender/draw/engines/eevee/eevee_engine.c#LL196C53-L196C53) 不直接迁移的原因: 1> 移动端支持; 2> 迁移工作量大
	可以参考blender(eevee-next)和vsg中对于scene graph以及其转化为render pass list的设计与实现.
	blender使用Depsgraph作为桥接, 转化为render pass list(这个与我们ae图层渲染的依赖图关系类似). 
	```c++
	// Depsgraph in source/blender/depsgraph/intern/depsgraph.h
	// source/blender/render/RE_engine.h
	void (*draw)(struct RenderEngine *engine,
	               const struct bContext *context,
	               struct Depsgraph *depsgraph);
	```
3. vulkan-samples simple ecs scene manager 使用materialx中的数据结构
4. bevy

## 实现
整体结构设计:
![[scene_render_overview.excalidraw|700]]

[rendering_basic](rendering_basic.md)

## Reference

### 重要的参考
[usd-hydra siggraph 2019 introduction](https://graphics.pixar.com/usd/files/Siggraph2019_Hydra.pdf)
[A Deep Dive into Universal Scene Description and Hydra](https://dl.acm.org/doi/pdf/10.1145/3305366.3328033)
[MaterialX Interoperability in USD/Hydra](https://wiki.aswf.io/pages/viewpage.action?pageId=22286781)


### USD 相关

[simple USD Render View Example with Qt C++ / QML](https://mtw75.medium.com/simple-usd-render-view-example-with-qt-c-qml-4bc000d15567_)
[usd library python examples](https://developer.nvidia.com/usd/tutorials#traversal)

[Universal Scene Description](https://openusd.org/release/index.html)
[AMD USD™ Hydra™ plug-in for Blender®](https://gpuopen.com/learn/amd-usd-hydra-blender/)

### MaterialX
glTF MaterialX:
[Create a MaterialX graph for the glTF BSDF](https://github.com/KhronosGroup/glTF/issues/2001)

MaterialX Document:
https://materialx.org/assets/MaterialX.v1.38.Spec.pdf

https://materialx.org/assets/ASWF_OSD2021_MaterialX_slides_final.pdf

MaterialX Data Libraries:
https://github.com/AcademySoftwareFoundation/MaterialX/tree/main/libraries#bxdf-graph-library

### 其他

[sketchfab 3d模型下载](https://sketchfab.com/)

[3d 模型文件格式对比](https://www.rapidcompact.com/doc/3dformats/index.html)

[gltf vs usd](https://help.sketchfab.com/hc/en-us/articles/360046421631-glTF-GLB-and-USDZ)

[usd 介绍(知乎)](https://zhuanlan.zhihu.com/p/486361476)

[实时虚拟角色 知乎专栏](https://www.zhihu.com/column/soulshell)
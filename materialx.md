MaterialX 提供了一套完整的材质体系+渲染方案(相关实现opengl/metal), 按照其标准定义的材质可以在不同的渲染器中得到完全一致的渲染效果. MaterialX可以被打包在gltf、usd文件中.

![[materialx_render_tree.png]]

![[materialx_render_combine_0.png]]

![[materialx_render_combine_1.png]]


## MaterialViewer 源码分析

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


## USD/Hydra
作为MaterialX的一个重要的container, USD提供了一个重要的渲染架构——Hydra. 将scene 和 render拆解开来, 使得多种不同的场景表示和多种不同的渲染器, 可以相互随意组合.
[usd-hydra 开源代码](https://github.com/PixarAnimationStudios/USD/tree/5c5ebddff35012461a2b0ba773c47f05730cbab4/pxr/imaging/hd)
[usd-hydra siggraph 2019 introduction](https://graphics.pixar.com/usd/files/Siggraph2019_Hydra.pdf)
![[rc/usd_hydra.png]]



## Reference

重要的参考:
[usd-hydra siggraph 2019 introduction](https://graphics.pixar.com/usd/files/Siggraph2019_Hydra.pdf)
[A Deep Dive into Universal Scene Description and Hydra](https://dl.acm.org/doi/pdf/10.1145/3305366.3328033)
[MaterialX Interoperability in USD/Hydra](https://wiki.aswf.io/pages/viewpage.action?pageId=22286781)

USD 相关:
[Universal Scene Description](https://openusd.org/release/index.html)
[AMD USD™ Hydra™ plug-in for Blender®](https://gpuopen.com/learn/amd-usd-hydra-blender/)


glTF MaterialX:
[Create a MaterialX graph for the glTF BSDF](https://github.com/KhronosGroup/glTF/issues/2001)

MaterialX Document:
https://materialx.org/assets/MaterialX.v1.38.Spec.pdf

https://materialx.org/assets/ASWF_OSD2021_MaterialX_slides_final.pdf

MaterialX Data Libraries:
https://github.com/AcademySoftwareFoundation/MaterialX/tree/main/libraries#bxdf-graph-library

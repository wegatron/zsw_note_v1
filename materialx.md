介绍:MaterialX 提供了一套完整的材质体系+渲染方案(相关实现opengl/metal), 按照其标准定义的材质可以在不同的渲染器中得到完全一致的渲染效果.
![[materialx_render_tree.png]]

![[materialx_render_combine_0.png]]

![[materialx_render_combine_1.png]]

## MaterialViewer 源码分析

1. material的加载、初始化(shader编译)
![[materialx_load_build.png]]
```c++
void Viewer::initialize()
{
	//加载模型, 数据保存到_geometryHandler, _geometryList_
	loadMesh(_searchPath.find(_meshFilename));

	// 加载材质
	loadDocument()
}

void loadDocument()
{
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

2. 绘制
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

## 迁移

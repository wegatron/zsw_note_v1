---
tags:
  - cg/shading
---
## [Normal vs Displacement vs Bump Maps: Differences and when to use which](https://www.cgdirector.com/normal-vs-displacement-vs-bump-maps/)

* bump map: 只改变几何顶点位置, 通过单通道的颜色来记录位移量.
* normal map: 只改变法向, 记录了切平面的标架下的法向.
* displacement map: 既改变几何顶点位置, 又改变法向.

![[rc/bump-map-vs-normal-map-vs-displacement-map.jpg]]

与bump map相比, normal map(左边)的阴影是一个光滑的圆:
![[rc/bump-mapping-comparison-to-real-geometry.jpg]]

在渲染器中, 使用normal map可以实现用较少的几何网格来绘制精细的物体, 提高渲染性能:
![[normal-map-imp.jpg]]

```c++
vec3 map_normal = getNormalFromNormalMap();
vec3 out_normal = mix(normal, normal * map_normal, intensity);
```

bump map, 现在基本被弃用, 非必要不用.
![[rc/bump-map.jpg]]
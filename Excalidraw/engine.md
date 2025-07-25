---

excalidraw-plugin: parsed
tags: [cg]

---
==⚠  Switch to EXCALIDRAW VIEW in the MORE OPTIONS menu of this document. ⚠==


# Excalidraw Data

## Text Elements
ECS ^aemlwLa8

Job System ^0X6qjcum

Frame Graph ^fIQDKoCr

RHI ^Yo5otioh

Memory Management ^2A9O3eWJ

[面向数据编程](https://www.cnblogs.com/KillerAery/p/11746639.html#%E5%88%86%E9%85%8D%E9%A1%B5%E5%AF%B9%E9%BD%90%E7%9A%84%E5%86%85%E5%AD%98) ^7nAeXE8U

[Desc-简洁的ECS实现](https://zhuanlan.zhihu.com/p/372326175) ^FAyB1vgn

[ecs with code](https://zhuanlan.zhihu.com/p/618971664) ^UOoHCRtH

DataChunk ^TV59hukw

Archetype ^U5u9na2n

Archetype是components的某种特定组合所代表的类型.
包含了: 
该类型的SOA数据-DataChunk, 
该类型的hash,
以及该类型所拥有的的ComponentList类型 ^RmY0aTof

find_or_create_archetype ^2RQZSV7g

在给entity添加新的component时,
会搜索是否有合适的Archetype,
若没有, 则需要创建. ^tbBy9scw

然后在该Archetype所拥有的
DataChunk中申请一块存放该
entity component的空间. ^zfFGN27k

set_entity_archetype ^btCmy5eL

提升灵活性 + 内存局部性
在unity中, 逻辑也是组件 ^qZJKyjTH

build_component_list ^5y6NwLfh

find match ^hA74l2lv

else create new Archetype ^WpnaxnHg

return archetype ^nD4GpUIC

create_chunk_for_archetype ^JQq3kbnI

if entity is empty ^uuVkMslm

find free chunk and insert ^zlDBO5pr

move entity to Archetype ^HPGfQtit

get_entity_component ^Ceb0eMnT

获取entity所属的data chunk和在index.
在data chunk中获取该类型的component的内存offset,
配合index获取数据reference. ^mNfcyzt4

程序性能分析: perf, valgrind
缓存命中分析: cachegrind, perf mem ^9OhOOl5o

alignas: 只有在特殊情况下才需要. ^SuG1cFdW

c++ Pmr: 针对一些特定的应用场景 ^TYNx4xEf

[entt crash course](https://skypjack.github.io/entt/md_docs_md_entity.html) ^oweSLIxH

vulkan-samples:
1. 以scene_graph为主, 其中的node可以添加component. 主要的component是Mesh(包含材质==renderable)
2. scene_graph只存储数据, 由各个pass(system), 进行相关事务的处理.
3. 节点之间有明确的父子关系, 通过向上查找更新节点的world transform. ^mXUwRtws

filament:
1. filament中通过几个不同的Manager与entt::registry类似, 将entity分为几个大类: Renderable, Light, Camera 
2. 由FScene::prepare负责将scene中的entity转化为可渲染的集合数据mRenderableData
    主要处理light, renderable
3. filament中View来定义了一个场景的渲染配置. 比如: 相机、阴影、后处理等.
4. 在节点更新时同时更新其所有子节点. 通过child、next指针实现父子节点树(每个节点大小固定). ^okDtks7D

assimp

 ^g9nlQL6E

## Embedded Files
2f4019311d325714a77e2978072fa603d7b99307: [[Pasted Image 20230829173016_781.png]]

%%
## Drawing
```compressed-json
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

CAA=
```
%%
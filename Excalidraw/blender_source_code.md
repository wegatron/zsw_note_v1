---

excalidraw-plugin: parsed
tags: [excalidraw]

---
==⚠  Switch to EXCALIDRAW VIEW in the MORE OPTIONS menu of this document. ⚠== You can decompress Drawing data with the command palette: 'Decompress current Excalidraw file'. For more info check in plugin settings under 'Saving'
 
# Excalidraw Data

## Text Elements
bNodeTree ^tHtIFQEe

GPUMaterial ^FUI8BQbU

ShaderModule ^UjmNiZXv

* Geometry Nodes: Used for procedural modeling.
* Shader Nodes: Used to create Materials for objects
* Composite Nodes: Used to edit rendered images
* Texture Nodes: Used to create custom textures ^dwS4EnxK

eMaterialPipeline ^APnrQ3xI

eMaterialGeometry ^9W1dumFC

::Material ^Ze2vOXMN

定义了材质的基础信息（roughness, color, alpha...)
nodetree指针, 描述材质节点结构 ^oQla4lXr

enum, 用来描述渲染特性, 例如deferred、forward、shadow ^OrjLGheZ

几何数据类型: mesh、point cloud、curve、volume... ^DZkeVc3p

1. node_declare(NodeDeclarationBuilder &b) 定义了一种材质在材质编辑器中的参数.
    blender/source/blender/nodes/shader/nodes/node_shader_*
    在register node时, 调用GPU_stack_link指定shader和in/out参数(GPUNodeStack)
 ^D4ZqocJJ

eShaderTye枚举值用于表示渲染过程中各种着色器类型:
DEFERRED_*: 处理延迟光照
DEBUG_*: 调试专用
DOF_*: 景深处理'
LIGHTPROBE_*: 光照探针
SURFEL_*: 表面着色
SUBSURFACE_*: 次表面散射 ^jtmlgNUC

material_shader_get ^xyQeqDAg

MaterialModule ^wv9BUndB

初始化时，默认创建三种材质:
    diffuse_mat、metallic_mat、error_mat ^y0FHHhU0

material from object ^BjZcp6xu

GPUShader ^83fnfEOP

GPUPass ^q5NUfYST

gpu material 的生成 ^JzQPsOtL

material_sync
-->material_pass_get ^h3iuFMww

MaterialPass ^cRG5UWPW

包含：
GPUMaterial*
PassMain::Sub* ^MpZsUFOk

这里gpu_fn指向node_shader_*中的函数 ^wDFcRM48

GPUNodeGraph 数据结构 ^bTtr4Lj3

GPUNodeGraph 构建 ^dC28cueu

GPU_stack_link与GPU_link类似,
参数来源是GPUNodeStack ^Ozsddqfx

GPUNodeGraph: blender/source/blender/gpu/intern/gpu_node_graph.* ^Rc0pipnD

## Embedded Files
49ee80f4aef4da80e06a1ea1219b11c780e44a88: [[blender_shader_node_exec.png]]

916ccfac0ab0cc28b8eb69b06898f069527ea65f: [[blender_material_pass_get.png]]

84ead61fb310310135e8162cb55d512fead02d91: [[blender_node.png]]

c7430acf8b2305f64d4aa37f682f8447f25befbe: [[blender_node_stack.png]]

3a43beb1b7a0e29cd439d3955d206e0e0cc449b2: [[blender_ntree_exec_gpunodes.png]]

bf357d0e7a7d7f8c4c39ee77070646e57b6f264b: [[blender_gpu_input.png]]

07019ca6ddd6f921eaeed86a5be72ae778e4ab6e: [[blender_gpu_output.png]]

fd53a1953702f7b92bb83d6d5665db2f5e30afee: [[blender_node_link.png]]

c8163bf40a1af03360db63e76a0f9e8b4af16e80: [[blender_gpu_node.png]]

9c486dfb7f4cba11af906f485970752bf9efb50e: [[blender_gpu_node_stack.png]]

9803ea4d0fb099b0ca5b9bdfcd7ad833e54b7620: [[blender_gpu_link.png]]

7fe6d8afe3f6163cc7ff139d8beb6bc8387792bf: [[blender_node_graph_example.png]]

cc695aa9c1a593829a8f80b515a4fdc17d181a3f: [[blender_node_cpp_define.png]]

8447f72b68521d08ebee46e86b24ed193c3e2696: [[blender_gpu_node_fn.png]]

%%
## Drawing
```compressed-json
N4KAkARALgngDgUwgLgAQQQDwMYEMA2AlgCYBOuA7hADTgQBuCpAzoQPYB2KqATLZMzYBXUtiRoIACyhQ4zZAHoFAc0JRJQgEYA6bGwC2CgF7N6hbEcK4OCtptbErHALRY8RMpWdx8Q1TdIEfARcZgRmBShcZQUebQB2bR4aOiCEfQQOKGZuAG1wMFAwYogSbggAOQAOADVNeIBRAHEAEQANAEYKgFUAVgBHeIAZZ3oAdQ44FOLIWERywOwojmVg

6ZLMbmcOgGYATm0ANh2AFmOTjsOT3sv4k/4SmC2eE5Ojy5Oqjp4dngAGDp7Q58AqQCgkdTcDodN57OF7KonO7fDp/Pb3UFSBCEZTSbi9RI8Ik8XZ3G4deKAh6QayrcSoP7UiDMKCkNgAawQAGE2Pg2KRygBiDoIEUi9aQTS4bDs5RsoQcYg8vkCiSs6zMOC4QJZCUQABmhHw+AAyrA1hJBB49Sy2ZyxhDJNwQTNmayOQgzTALegrWUmfLcRxwjk0

B0mWwtdg1E8w39GZi5cI4ABJYih1C5AC6TP15Ayae4HCExqZhEVWHKuD+evliuDzAzRVdc3pO1BAF8mWEEMRuBciRSdr8mYwWOwuGgXuHMWPWJwKpwxFCCX9ekDvlUy8wWmkoL3uPqCGEmZphIqGsEMlkM/kZoVQSVW+V95goBKSmU1QAJKApgBiACKDRII+XaPs2rpfugJoAJoAIItMQLQdC0ABSACyMAuAAKrKewAAodAA+gA0h+szwPSEDamy

VBgaCOaYkIcDELg+59mG8SnFU8RVFU65XPETJEBw7JFiW+AiWwMoHmgR74GEBTgcUkGlJx6BQL+AHAUgTLPmqWDvkymxoNsw7aAiZxDvEVm8cJmKxqgzhElU2i9GuOx3Ds67WX8OxMuCxCQnGOxHPC5KUrxvRMpI2K4u+U4xZitI+gmrq2h6yr8kKYqinpmJSjKSYKkqvI5Wq5AcJq2qZMZmKGsaXo+syvL+pimX2o6zrdu6nLNdRfp9gGwhBiGU

IRlGMZQvGTIlam6Z5Exrp5rgBYacWpaYuWxCVhIuAdLW57EA2GabVJHUIHJvCoqi/x/BirpzhOzrQqOTDzhwi4cMuYaAhcZwAoc267sEHGHseCCnsdl7pHVt7LSULFseDXE8XxAl/FUPkieW4loOd0myRpCknpir6JegmiLrtOGBAVrrkBQOFGeU1NsLT9N6vqnBQCahBGPS/y5rz/5rUaTnJS2RnwUQyiTugYhZEwepjlA5gELLOIKxA+gkMQax

MnoWS4OWTCFhI1R1I0rSdD0AzDKMExTBGpA4uWBAs2+bM0wgdNXXquBCFAbAAErhAL9KskIUOYqJCDfvFeJhkkvTKQ8anQRA/SaBhNTbC0rRoU08SkUIofxIQcAVMww3k1RCwIEsqUMxs3AIm5lI7IcvSnA9vQnGuTJOdsPCJHsA8dL0iKHB0vFoi6JRBSFqBTx0RyHJvA4+T5U/A5icU4snqDT9oa97D8l/ThcUslC33DpSUnXcuVqroMK+Xiqe

0qynWZUqi+KqNUdT1RWkaU05pBptTrhlPqCAHTBSdFOXqdpPSQPKENI6fhJCnQmpiSM0pppxkfpAeaaYEa5nzAgC2qBCbbQrKZdAuBkgjVKrgtAkFKLzDQO2GYKkn5XQ0iSEkiI/jAi3LOD6L0wzXFvpAZ6C4lz0iqIcRE1k5GlB3Hua6pNY6ujPKVWG15sh5Ago+Lh1EKYUXUuUf83QUxVAAEKAU0N0CAYFqQPnvJALOFR/yOMOPYjgpAGjYFDg

SUgwFQ7sk0KRVuLYG77VIHRdx94OyMSZMjdi10hyz0OHxXoxwcZxzxhJLaro+TEwhopBA6cCiZw0hAOxDjnGuL1AZTSrMTIzX8mfMefwSTAiBDsKoi9IAj2hOvLyXwgSIgJB5EkgVuphiJNobGcIHoFL3jwDRh8ErOg0ffNAJC3SoOym/CAH88p6iKr/Y65zAEai1CA7m4CBoYOgTaOBCCV5jNOR6d5lpPmsLGo2PBroCHRlgD0ua8oFoUIalQmh

dCoIMKrDsLB9ZxoE0kt2QR/Z4gAh4HsIl71xycChK8E5CivpKPxPkuEyINGEC0WDHRkNoaGKvPDJamTWLZI0rk24Akin7wqaUnF5SSiVM5CTDl5NWYSCaARboGFsluwILWSgXtKYQGVaq9VVh8Dc15vzQWzoTk8yyGLPW+BJb6RlnLHWSt9wCjJerdwWt5blD1sQA28SIDGyiGbUgNDs653zqhIuJcy4VyrjXGBJR+Tuw4J7RV6B9VqtdUawOwcw

4R3NWgaOejpVm0TkfSm68dl1NUttRp/QAJchgG0AwHRHEpjnhhBoNQuTKAAFpNE2PpRJ6BFjLDpHqRhCIDjDPRDsFEO8xWPC2JPbQXkBliOOIcAZxwlmIJXOvTeW9vg7xuIU2KSdKbbqZEchkKCsqv1yp/ANtySqKgeZVJ5tVdS5jeegoF1p71dX3cgjqcDAW+mBZiQMODsWr0moQ6FxDYXJnIbyxFa1qEbVxfQ3ajCaInExSdODnDoAjt4cUfhA

h8UrM3DwKoexLhks+jNH4zGJzfV+qvT4tl6OUhBtouVNTOUXm5TeUx95OEWJfF08xNiJDdAAFb6AqIQPtbR6CpL4Z4qT8n0B+ICUEkJYSIlRJiXE6xHSaLJLYPRNJGTmL8tRqvbieSCmitxmJMpF0KkyVldUpSlGM51vKEplTamNPtJHdAWTrop1wjPvknYD1jg7MRDOV0I9eg/DWYS/4m9u47oCpiZeSDV4WR2XCOewiGNiL+Xs4+Oyb0rDSkBl

+ACJBXPyjcn+b7/4VU0kA55dVXlNX/ZBwDYHUE/LK385+EHWqTcZqNWDYKwwIahU5VEJyyGLTQNmShmHkU4dRXhqsvQiPsNoSdgROSsYzOBN8djFK4xsckeS2lP02zXGxtPJEAm2VCbJvomGYmTH7cRpALJzmhX5JFcOJdkBRL42u1KpHfn2XCYVd7CQJpJC4F2qQDCHMSwBqZjq8oeOCdMGJ8QUnJqshmqFpa0W4s7X4gdW+L1zq6oq3dRrfA3O

fX60NpiINptgyhvrY25trb22du7b2gdQ78Fu38GmnHMF8eE9p/Tm9ebw6sELagYtnmE6XqhKnGtXjPyNOIBQE0JwGgcEwORYd3DOne26WZXYYV4y9xET5Rj6Jh5bDnn8BIpwPKMbXAx6eEjXSle4MluIF8fipa+E1g+Fu0AEjPoxqeJweA927vEQ5LX6QnOfh+9+eUv6FV63/Gv0AhvftASURqEDvRQKW0/b5yzeBtYW5gkFq2MwZaTVNJDq9ZqJ

jhWhiHh31rebLGi/ahxLtwZRbdwVAJY8PXo89hWBI/k0s4/SS4094zF/PdtVlCBnO6JE8QIxPLF+OZRjk7iPH+IeV+55lHbfdHKpeSeVaWTXCAAAKlQCaAQAMAf1IBgFQF9nkFQG6DCGIFQB5lIFQDgDZDEDp3IHwFQH0A5iCHLGUG0AAB0OBoCqdCdkCyDUD0DewTc2BUBsBAhslUAs0mAjVmAsD+RUA7BFMm5sgaDoCeR9A4A2BWB9xGDdpmCM

C2DUBew1BUAdRCdWDCB9BohwgJDUAdURAEAFDwg0AWDMCQ4OCuD5DsAhAWQDATcjJjCcgAxtV00oCYC4CMhWQkCUDzDlDsDcD8DewRACASCyDRJKCDD6CmBTClDWCrDOCQh5DeCNVFJBCcCRCxDmADCpCZC5CTD/C0DlCrC1CoANDMgtDMCdC9DcjaDDDnDAh4iAjEj2DkjuC7CHD9AnC3wXCGc+ZI4oR14TgRkfgsZe4/huINErUoAbUJYOdsco

AhcJBgh9R295EmAPVNYnUXxIw9RxcQ1js0cIBk11d8AKcJBoDYD4DfCWiSjWCgi8CZJQiiCIjdoojqCGjYicDiiLCVCOjUjDVjxMjhDNBRClh6jJCDACi1AiimDWjLD2DyjKiKxAgajdDlB9CGijDmi/jSj2ibCTCuiQ4eiKZ+j9cQ5Dchii1SAY4zdy19kU5q0gt6kQsJBRjdxJBsB4hGgWhNB/wE4/gcJQ5AIxh9gosPcIAx175vdV4SREh8kB

l08KQxF+JQ8zIXgwpB5iVhwx59gi94g/kk8wwL4Eg54y94ht1VEsZVEL0K1uB8kz50toQSUBJfg/lb0q84Fm8ut699FG97lH1P1qphsf0Go/1u8Ple8BB+8QNB8psAVxsIBiA2AZADxR8rsJ9IBIUiEZ8dt589tMxIcDQkVsMTido9omF4hN81tUBSMOkKMwAqNmQaNysSU9grSJ4NEaVhj/Ij9z9nRGN8lCVd079QYH9MdgcSgDFRM4ZxN9szFv

EyMpSrFPEfFGl4ICJglAIdhMAUwtNWTJM5Ms5FNYIahJAThiIKBegYB/wOB+hQ5MB9R2QuQmgMJ8AMJLNotaJbNDzmyHNXRocv9u5hVCkEcACV844McgdakjybcNzygtydy9yDz3dLFYs24VkLIJ4gQu4SVAROyNTnJiQ11UR7J508LN5jSB9LgI9dgERgQxE1wzh1Ts8HSkpmsJ1jk2tfS68X1AzSpm91RQy29Rsu8WoR9EzgNfkh9kypLltsEs

yNs8ztsUMWIF9iyl8sMoLTsqyaIqhayzobtqM7svIfgi98kj8ZoQ93tPpBywx+Ie549eIAdJzYLn9X8FytKP8BUoRXMwKPMSkvNJUfNpUYKAsS1ZgPCEA0ijUCIq5yDgwtVmYYq4qCAErEB44BimcLURZrU2d7UliVjFZec3V3ttjBddiJBfV/UDjeYJdzZGlOSEBuTeSGh+TBTvxhTRTxS9g9QziPYLi0rgT8BMqkqA0g4qSC0o46SoqIB45GTj

4q0054KGlyhsB+hJAdhLwagUxvwZDNBCBnBQ5CAAB5XiIYBoSU6iGUivSdKEIkQ4JILyYcE4Ts74ElByTLLYfYMKHZa4dEbdLGPiYrRPWiieJIOZKY7GYlK4bMrEDi1AI0tZejX7Q4bstcMRLi1raS9rAbS5finrYqJvYMwbL9F5X9MbKMgDdqWBabAfObcDZM1M9MxNSAGDZS/BKfLbWfV0XbBFFaMs3Sz8NfJhfq1hLFOshs8jTsPFa6fU6eaE

C4ayuMOEAculLiYlf4AeDyNyx/MAmc0Hec8HTMJc+8FcjCr3E8xpPYMYDoOnfQf8Lkf8qjBC23JCigZwUgYgGAbof8eILkYiJtBAPYBANCGAPtbAAib8qU38uzPhQCpGJzECo0svC+L4TeSC0KomfzUAmpa3daiQO2h2oQJ2l29CmTa2uLR6iyNEIEckUY1LP5EebuA4PuCkfJXub4aePdFeOedeXodcaKT4UZTPXZHPXgcvbiu9PGvi59Ymu5IS

smlvCmkbKmiSnvOmvvBm+Mpm1BYfKDRS0FcfFS6fNSufVDIsg7DDZfHO3DfS3AeCIykW0yjSVRUZOrWeVWmfElDWr7HpL4AEIEP5FlCcg2rHEHLlE2wW5Oz/QVbiNO9cejS4RHBaiVVHMK4AvOrAw26KiA2K0am4nwxAlKy49AQh7NAgYhhAp4fKwY43YWBqVnW1Iq8A5Y6q0q5Wcqp6LYgXEq3WEXANQ4yXMNTa7a3a/aw64606i64Ya612FNDX

XVShvg6h7w2h3Naao3Wa+k4K83JGlawu9k9AXEfQHgIwGADCPYO1YiOAM4QCYKeIRTNCQyyuiQO6idOU7uXobQLGVEN69dcytBkeHZCPHjVU7GQeNEAZPusrNeDeY9H4XuM9NBhrK9E5L03ilev0gSkmoMjrcm0SymiM6mySo+nej0GbHqPGw+mM6UlbLmiFHmmFS+jS6+ks1aO+zB1fM7faRxF+jhR8S25POWy6HJRi1RDyG4H+svMGkoM/TWlz

MRaEH4RjfWqc+a2cl/MHW8c2hJVczCqCRpPtBAHgegM6toDCCoV2nTG28oFoZwXoUOE4IwTCdkIwDCYgTAM65gGABCVRIYWO6ieO25/Zj23HBCJCFCdCLCXCfCIiMiYFqsGzBOyjJOqHFOhB0Ckc+jKYk5ZHV+haiK/OwLZs4LY58oU585y565m6qujYiARhfYZ64lUYhjWRAJqyxyZ4X4SyXiSJvuGJmi+MhjF6uEYlQikRMve0pkqenGyvbJwp

wmhe7+fJ5e5VkS4Bde0pze6M7e2M3e2S2p+SipjmxpuDBG3M8+vmkoAW9DIWo7csrB0oMWmiCu6DY6K7IA1snJf4NefUhG3stAO4U/KRRRABmRQi0cgEDZjywqY24xWBzF+B/ynFu4bdckbOnp6CkA3ByBp8Dw5AZAdK41Nw1KiA4t0tnKmk3gFnAq1hxY9hgRl1PnCq/hzhwRv1UXV0ERpq8oMxixqxmxmAOxhxpxlxtx1XJR4aytkt0arR/NHR

7gU3fRpaytK3Nakx04wCfAXAE4fANoHhp8aLNczEZlwlM+QGXYQEX7IEYi7YbiBIX/C+FEO4fiEV35VRI4QpTdDl7urPV0dJocvx1yMeDG16zO6e3G+mh9ZV3JxevrYS1vEpsBMpre9m/5GS2bOSmmibA1hppSy1s+3mgsq+5N0sp1olys/DXAFoQZnNjKNsiy3YfpR6BZ8NhWIvalTjhy3gf4f4EZKeONyKzy3Zh1uBvytGPJdcElC4AljBn1mV

TZznXVQALO1ABJOUADC5QABXNAAKWMABC3QAL/VAABD0AEP5QAewNAAIf85pDGoA4Nfns4IDgHx20Dc4AEoaCOAyDWQrpABwY0AAiU+zwAeeNAAH+P08ACCgwATodABlv0ABDzMhjwzT3Twz0zyzmzi1xsezvQFUJz/AFz3ANz7QTzjgbz3aXzhAQLkL8LvT6L+Lmt43aEI4NEG9qYu4CeYvb6jvFhhY3PVTgRtYxltWDt7WPYl2MXBqo451xR84

8hiAZL/T4z8z6z2zrLhz3L1AZz1zjzrznz+mKr1AMLyL2LhLykpd2t1d8VYMddy3Fk8ltkyliQM60gRTIYJoOKPtelwyaurC+UsecVo9B6HeLr8ZMPbdH94lP/EkDyMvDRE01AN694Ts6PK0wpQDkoYDsMXx14RjbuVLG0zPBVh+JVgmhDtVpe99FerVsMxlzvOpgj5+ap0DWD/qFmtM8GTM4j7mxDUj9S+FCTyALpnS++vS2jhRz1thLfEy31wV

bGc4TeW/Xhj7R03k/+rjSZbiPYU4WyET0lrZxNt/HyoCrFtNtzeHbubNpTkl/N6c/BlR4sfQezwACldABTczC8ACY7QAZfNABPJ0AHIDezwAaPlAAgzV2n1CYHRMAEAGbAigbUYgCP5gbXP88tubzIMu53t30Lr3v3wPkPhAMP5JXsKP/kGPn2+PxPqgeh3KlZNddcZLLXlZ14K4PYeh+Y9nPr4qztwb1WPhz1TtkOcb3tyb0R6b6d2bmKh39Pj3

n3/31AYP0P8Pwv6P2PsvgnJPlKA3Galduahkyeoxrdx79AFoPtTkGobAHYAfk9w5n7yARhE9CPeeL6oEbs04B95LN4M4AirX14QpfjErAfKPdyFPHoz18t42NdinKznhnwCkQnAkKGwYxE8eKc9HJkTXJ5IcqeKHHVmhz1a01MOjPRmrhxais0OeEvE+uCknw89Wm/NQshRyF7HEXWNHKsP+AY4+sew79Nrn3E+A/1VEYbD7HxxvZeQkQyWeZj4n

vwQNbeEAbZl5VNo31jeqbaToFQgrBVAC0vZTvG3YblBAAB4qABVeUAAOpoADtjQAN4+gAaPU0AGQBPhHxkLlgKi2APkEIDj52FSAjACPvQF5Bl0EARXRLhAW0H6DjBpg8IJIAsFsArBHBWwfYJEBOCXBvgDIB4Mr61sYQ7kIvNjDXDF5/o86FvoVSbaFsucnfPPkNx747FRuaofYkbCH79sReSaNXENTm7eDDBJgkgv4MCHBCbBwgMIY4IQDODXB

0Qtzou2pLG5Lupaa7rv03b3da0B/CAC0BOB9p+gMkNCGhC+6e5GWjCcyG5B8hbp3qpwfYEOAfZfB+WHkXYEXgnhIh72f/UVslksiAgh6hSK4HVgnqGNbWNIe6ogJZ740LkZPBvOq0p6asMB4ZLAfT1wFxljWzwhbEQIzIkCx8ZAnMi02QxtN+e7+R1t0x9YMD9oaFCXlLWMonFWB/lK0oPCRB2k7K0iE+G9HxERt1eRebLFaWJQJ5PwoglTgm2gZ

JsBeEAYCtizToUixEivAYcoJOKqDROSxcoOvFoRkFiIu0GwbVAAAUvsXcKKPIDqxOAjiIQEaAYIAAyTQO51QDJdAAAHKABZz306AAKdX06AA0f0ACJ8YAAs1QALRyBnQAEPKOgr4qgDtGoBNAwQNEgoEEAiAxACgR0VUSYAKAyu4QF0drm9G+iIgvo4iAn2pykBiIkBGgvaNQC6jAgqgFkHEV9GAA303s6ABgGKd76pQxUQGUMRGRx+c1OYYwnIA

BiVcsLYGDjWixR+qX2GaB/gldPBuqAUSGJFF7tAgEosglKNbHsQJw8oxUXERVFqjNROovTvqL07GjzRVom0dGPtGejnRro0QAgA9FOjCcPopgv6PDGrjFCm4hAKGIDERioxHAGMXGIQAJjXUgo3aKmNQAZisxLIH+HmLxgFiixTAUsTYGEBQBKx1YsgrWJlD1jYhjDetnMQyHt9m2OQ9Yt31ICVUBG/feqibCm5EtBqqaWdo2O0DnidxLY8UZKKb

hdjZRHAXsfgGVGqj1R2nbUXqMNGmiLR1o20TOOXHej5x7o2cSuKDHrjGJa4kMU+P3HTi7Rx408UmLIKXjrxKqbMXePzGFi9xL48se+J0FViVUNYnMeyF/Hr9tGF3bfmuyGF3d+ERddAIpigD6B8AygHoB6wOZW1Fhj1PPISnDyzxB4tkdjqDzQAHBR6vJK4NHh1p4jwae9d6jX1+zF5Z4rHKkZAEx6oBeIa6NELPFh7ZZ8kiyFKI8NnrPD561yVA

aTS+Fr0fhHeSMuU3qZ4C96BA6iCCMw6rdT63PTbJQLtbUDGRtAkfqLyrBu5URxGOsiwLbJ0USUaNY4UrxYx2SCQavC/BcB7iogde45QTLyKgZzkGRcIyTjDgCpw5wKFvJQUSx5F69VO5QT0HuJwgwAEAgALPNAAfHKAAeBSd6AA4uUAAWEYAC5PL3oAHH4wANBeZowACAqWowAALugAJyCTRvgmgi0AaD/gGgocUOB1UjFoBAAIJqAAwF0ABveoA

H34wAJKKgAc0dnpDQRxN0CaDfSrxgAVejAAyHJO9npZ1f8HDMAD2ZoAEfbf6QAHIaCQwFME0G/A4QCIocM6o4gaBwzwZgAIuMAuNBE0N0FDhvShgcM/aYACN0+6QzO6COJGZzM+CFyCpmQE0AgAQmsOZgAY1NAAIDoNjFpPxFaetO2l7Sjpp0i6ddPumPSTBkMt6R9K+nCzUA/04GeDMhnQzYZestMUjJRkcAWgaMzGTjL+n4yOAhM4maTPJmUzq

ZYMumdzOZkNBWZesjmVzI4CMzeZTM/8ALKFmiyJZ0sv8fSBnR8QXg90Y4JcB2R/JZirfNhlkI4aFD0AXffnL3yznQBihE3WCcP3gmVDEJKfOWatM2k7SDpx0z3udKum3SHpT0q2a9PemfSWgcMg2aDIhmtyTZcM82cjNRnoy9Z2MvGQTKJkkyyZFM8OagFpn0zA5Icn2WzM5l3TuZwc/mYLLhliz2ZUsnoZv1pJ6MruBjCAcMI0nbsDMgSFMMElC

ThJ4gkSd6eZgDRWZQWcpVEFcD8bDgYQlFAeJRQfZIhEgU8buPPE3gD04eA+eigxjmYzIVEq4AZH5MRpytTg68BuonJUTzojSY5V0FkyQHwcUB7winv1guTU8xKG9P4V8iNbxNsp+rPKZlwKnNMKB0IqgeRzKnC1yhPiN1rgBuaS1apTYYZh0h4BjMmOCtfyD3ThDTTWpBIwECOGJGfYuMVWQlCD00TgNaRQ0nZjAwkwzBdMVmM9suSziYAYAgEBA

P0BaDwRlArtDFkyJN5ox0QAyKrO9Q0SEt2FxLPNk/kxCWDvKd4GYF4pmAkJigfwR8JDjAA+L/FzpZHkJ0YpwLD85iZBZZB7hoLE5mCpsmACzCWK92LIKQnrDZoEQghuoZxbeIgmOIdoFBbgKRjSDGIw0DaZ2rLn0BtoO0VQLtD2n7SDoPwBoGSPYQfigcfIWMU4D8BZbTpPEEAZQLgCmBoA3ggyG4BPAxpqJRkgyw0JgF7A5KrB3mIRSUCqJFLFQ

JSoZhbXKV1RKlEaAuNGlLjlxK41cWuK0p5hdEtgEeeMNE0JQDJeSIqTBc32GbDLRlyNF6iMjwoXBSQF8RHIL0IALLiASyvJZg1WWxltQyxVFnFAJxEsqi8EaFSEEaSvzMQQQM8BQE2bGMxhBioxSYrMXzCYs1/Jlu3GOBrJw8HcKyUnNf6QClSArfYeuBuDCCIA8Pe6Ej0RDJyL4syBBQFPR4PCZ63pM5MgNVYEK0BSU4ppgNSnocaFFCqpvgJNZ

4cUy7PUEcfXBHrZCpqle4UMtKmjTBebCxjqLT6ZMIzqzA6XpiLQDulJlf2H+qiE6kWpCKIqE5GAwGnzS6Rw0w3jILGkgUf8qiMvNcEt4qDrebi9QTVVGq7jwxxELEoy3JweFdCVDfAGGsJwRqH8DXZnOkMbbASM5LbMquBMgmdtaqPbEoH2ylzlBL5RmW+aZkfmxIA0CE5Rj6lDXsSk1jLKaudz6EqTj5N3ZkqtRGEIU9MGADoDhCGBsAOgQwCoJ

kE0AmgvIHQSQPoD+AYQY4BKzxgWpv7J4PICQYvNjBhCsUG6NkiACPB+V+MJ4dFRED5A8hoN4endPxpSBJTTLX2LyoDpPWvRRT+VJPV4fgoDIfCiFjycVSlIBVSqcBMq7DjUyBGmt6m+UiEacShH5k+emlD1bqqo7OKkRTCGOjwquwy0PcTZFsmapPijEpi3SndcG1QCqI71HHXgUs2hAEgEQ+wGVv1MByDSja9I91eC2kzfcNiELdABQHoB7BoZi

oAZh4iY29rHmzzV5u80+bfNfm/zeCIC2RZJIUkfG48nosaQcAOg34E0KHBqCKZVU3gJ+i52IiHBAIuAfoAM3XIjMZNf5BiDMBLLMjTetwXksSD+ROL9V2DTFfvzY3MrON3G4gEZvrhX8TJPCTeJHnoyUURkBIc4K/y17uRD126Y9UPTAFuT+6rwPxrJ2Yqx5a+3KyerypojRSBVcHUnm+pnKCVPhBNEhah0lXYD8O/wyhUBsqas8FVClEoGBrVUM

KipTCkqSwp1WUcER0vRDTREAgmqMRDU6yQSGuCPrJFL2QjX/VkV8dssw4KoCFMdU0i1B9Gt1Z4ss3WKXM6MUZADVm3+ruRgavBoSt1SltdcS66Uu4QgJHaScJ22YlXzrZpreuJ8frp21bbHtNiEEkbt6hqpCMYJwaEuRIFFADqh1I6sdROspDTrZ186mblUI8IXa6cJ25tb0N0bzVFqakrtefLGEwA/g/4b8N+EkDdAaw7jBYQ9R4RD1tAOPbGFE

x/kt0tgjfJIAEx8izbfga4BGiyo/n+RG+QIB6O9SJCytj4ZwoBR8FUQ8RpwaDHBbFKFXxSRViUord8Np5pSMOAG+BLRWoX/rOedZK1pBovrML2mNAvVYiM4Whw+tLrLDd/IEh8ROyaDAjQyltUrIN0LwCKbrxt768GNni/jVnEE0vM3mGED5l8x+Z/MAWVQIFsZpfmosLFFmvlHIPW0/4iQA8bbTNOcVzTHdC0iQIAFwlQANOagANGVkxgAGH/AA

G3mAAS6MADYSoAC+9QAJByw45AJxNQCOB9Q+oewjuNjUR8fCBAIgNgGIgN7w+/INvexBlkp6M92e/PcXrL36cK9h4+0dXtr1hAu9UARvQ/mb3mAp9EfDvRGNjUprHqfjWeDfl4jDhOVWdZhg23u0aIKYA3XITmve06xoJJQ4uWUMc2nEy5ta3vZntz2F7S95eyvePrr0L6m9xoefe3pszL7u9Z3BHVvyPkDCT5y1M+RS1c3u7hNXu0Tb7ok1SaCd

1mFJHKVGLakSUYxLGGPGQav9V1aIG4FFtGIxaz1ECq9muFwpiIJ4AyEZEooCkIgkguFEZPgdSE7rRd1Wl4U+gl3vrCFyHZKbLr/XlaFdTPeDPKvSkEcGtIhprRqrI7a7WF8Gm/d1twAmgGOaGoWOCpl5pt8sMILGD/W6XW6EepwcRT3GI0iCVFi2yUAbxd3yaLaOio5q5scSKYo6cAQ4JgCECh7igq2iPUOFsXEpGMDinbS6wT1BqSgHi6QY+BCV

gA/FkRwJZ4giP0VB4DK69VQZ+CuVzE9ByHlr1m2Hq50JwQJWktCBQBMlagDiCCspgsCoghS4pSsFKXDNdlWQMNP9sHXDrR1HAcdZOrB1zr4kgvdpRmBuXbpu4GwyjZ8AxpD1BlbyiEQCqBWlGVl2mVFTxqqPmLtlroOo3+EaSDtLG1jWxvYz00TtXGFyno9coPW9x4QmbRjJSL8mkIRlluedDrUBDfykQYTEHpMcWW5KyjkkdQwUqhV0QYVFUtZY

qARXfGkVKLFA6ivwDornN3azSRAAcNOGXDbhpA7ot+7DhsevUpEBSHep1ZqV2pNE4xlsgMrikcW+JkCAYORKjSN+YELcLlYZa2DhrHLa+uFXcHRV0uvg+JXIVtZhDCNebCBvEN0LwN1rXnjCJg2dNddXWzhThEN3y0EG3kWbTsgt2cd8QPHUjZGzrYvAjS5ukw8oudWJ7XV6ikaUb09XYsZOHOoQQEdzqqKM5dauNVgTZA9FsiSwHvegFjVqNiCe

YRwnadp6mpa2TDFaD1zb4PaO++c57afrzkfbHTX2y/T9uv3jCnmHukTT7vE3+7A9o/KHRASdPpFrTbp8EmIX3nLtD5SOstCjqxWub4IXtH2n7QDpB0Q6YdCOlHWQ3eaQWIet+USDeCC7vJJID4L3FwNvB2uBWfiEQc/bxNrgCQLdLyQ7KdlkTPOymN3COCYL1wUxU46MQQExT2DcU7rAlIKbMnv1/BsrYtgZ4AiqFoh+XarvoXkDmtUGwUx020p0

Demj9NxChpIz8KR0gi2Y8IsFRX4YQc8Dka9ramrwqVk2pZiojnRnoHdwRiw87ukGeGpO62nw/Yonimnc2ODUCxAFCN7N7wcR9cgEvvBBKIj2wIc1aVLy2R663EAk/eGnMRTjD858g6MTyNh644BRoo9kteNEtPjGyxwNUaWNrKwcYjLajtXwB7UDqdgGRudUuri8LalyjpccjXTtcCkvcenRarkSXH3lg9AeGqXTpOTVTYyZ48CqYuhV1D6yhY8x

YqNfHbMPxuFf8cRWwrTNFfUE+CdgpFnEKEgM8heSvI3k7yD5J8i+TfIfkvySBlFTXRt2JBP6VWBjFAoEgPsSQYUKLb8BUQAheIZwEg/GRvZ9JorvuG+HHknPcA+IZFcjbPGoOAgrSS57LZyFXP+l8tH63g1udZPcmKtsqxK8rsEPHm+TGuzVfa3a3lTqOnCmoCocfMe5nz8FN+pleSyc7CU+G+U3GCwUkb7KSzaeBPEQajGaN7lOjWBeW0QXw9UF

7wzqVguOLFOAa1xftpQuaLig6F8xJhdotoXzE5kdeCehQZvUp46Vi61lfnQ5W7olFK0jRY8MiR6LBgLJSUZ0s36WLBlji5ABWNhoWqbVPkgKSFIikxSEpOZQcbMgR4e4OGzrqMiBoA0xjVxuyWsi50YLyV/kN7GJcBUvHllull838c82A3/rRlgEyZaBPOL4VFl5FY2Zsu2YITaO1zUppU1qaNNGELTfBB016aDNXmoycCbX7+WT4ZwyjeBzXDTE

nsPLMyOuhr6M7MFDitEHE2dDEojgPwI0j0q8gK80thjM0mojJMc7ptXkQqy+s4NrnJdG54hTLqqu1azWWHRXXVcPPSrGrjW089Ieg2Xnb6wvBQ5wrGDdWbDT5j4w1OHIRXe4cp5XiG1mX/nlTBIASD8uE4LWxBTula6ha0VyZbD1/VzdtUIBCB/wGECgGiwApnWDTabGC34bgtx6b9QR/a68cztHWTrGFmI+EfMREgDgwIcyrratI9wLjYAQEHEG

Nud3M2fS+IO9ZSWfWMl314o8TdBXlHIVrFrZfWVqNcXGkjRwHS0baOg6Z1nR/Y1coRtHALgXwREGOZGTvUnjQyzG6gDeBzxrget4RKsNV7DN5l89t48aD0vzHNl7F1ezsvXvlBDg/QXALBFIgdAzq2AIpRBLaBQArmXITAN+CaBsAD7El5yBHkEiGlVhr7AeK5P5o33syWl6Y6Tf6tuhIVNNigKZfpvmXATllphMzeWNgnWbdllzQ5fQD53C7xd6

yyLZY1E7sNcQCkNlmTkM6VECC0JvQfr5zI+IW6seOranBTFxWm2mgyMaZUBS9aT6mDiufF3W3GTUuu2yybIXVWhDSut2yrrBFNMvbNrGQ7CP1NwbOtFZQO11fvN1TTV4d4cuiBeAamCNfq+O1xjLxHpTgE10w1qaQuSDxO7WqzfIOMO8RcT8F3zHtYLZ29LTzp0MdhGwA0FnAzgAAHxpmjUdjUIMwEbUOndY9a1J+k6yc5OCAeTxsIU+jl5U99gE

9Nf6ZAmBns1ucgoaGa7Z1UIzjVYtRIE5uqb1NmmrUPzckC6b9NhmganfqQlJP0iKTn6GU+yehqtQ1TyNTmeUkgGkcBZwxhAYe6ubTAHAAiN+AoB7A0ImAXAL0BqC4BNAfwfmHoBwiHQkDi6gNLfyJAR43qSpWxaqSZVZZEg71NA5gtGTzoPIO689TcESbw1kmu8L84guPgja74WWy251jy2SgCtn6kMtqx/UGg5d7tvGsIf3pJlHboG3k57chGML

zzWu6x7Bo63+29dhqmiG0GDvcOEeYdv1nHk7KDJrVStfQz3UBCJzFzqd808td1OMbrDTLg7dYizjYx9QHAfUA0DOox1zNH13yuNPTbm80GDmq3vE7Jbs3WHEAKVzK7ld1mxXiJ5dSskHh+Nw8KDM3fsA1Ot0Z0c6YJoC6ngPRZHv5uIL4b+WWlx6GVziuo8Va4LctDJsqzwfQH6PdWbJ3F3KuA2EueTRHNXSR2KmkJtVNj6l9eYfq0dYIEp8ZhpC

vVA1oXBGqeNRtG1yKupKWGU2kIFfmGJBlh1a8q5Apm8pp6rna7tq1fzUrESqFVD8SKf6ou3tTuR3dr9OH7HULT7hsGfac6x81wjUob099D0ADnRzk52c4udXObn5gNgPc8mczs5uPbvcWs9bUbP0Ggw7Z+pMgO6u4IiEZCKhEwjYRnAeEZQIRBIjVSxXfl37i5EisBO/nfSmW2cHCtNcDhxh2yFQb8euuL7lkAELrQuC+qt9Pr2+4AL4gBN4wpxp

lTSedslW8mIbsVRi+3MRvnhHJ+q7udoVxuTzpLs85rta2yG2rIp+x3S9wCfcnHfCkO71ZZfv0hr2B7LNatiY+OL86yOrL1JAv7bQnGi8J2to2t2Lq721kKnXb20JPkLjdw68EpbsnW27517xKB4IoQeBHPGYQcUGcBvAbg8H/yIh/IPJLUl5dpHF9f0A/X37hlpe5TbKUAPLYtQeoM0HaBdA+ggwEYOMEmAoPejUArlYUi+pl4iQ5t15fg7mVE3t

LJNsFWTeBvf22Lixv+ww5Nphp1jw7LY+OygDOM9jcNw+2g7PioNGKnwLGNeuOAKXr77ysKF8AuACDDS7j1HuF6mN/XzoHx6m4zbMvEByHlDuhyCYYe2XIq9l3tc4A+aKgqgocE0G0Gvn4BfgewUOBwEOCkQ/aC6sQrKXPaPVIBAkLXl9QZU7INEEyF4Ovqib9xM6qw111PAOC/5eS3cYAf9Bg8DxLIRBi4Iyl4zdSLbAb+k1weDdMm9HlVgxzG5q

uAbme7BnD/VuJeSGLHApil0KavO/GOFNH3AIy8v5thmP7cC0jujlvFuLU3Ebl0/eRO7B+PMnwT3qZCXaLT2dh3V/0F6A9B9QsEE0OKcVdT263hpy4LDUlY7qNXu1xC5DAG9ZwKfVPmn+KYRNHNiVKybLJZGm0hT0TReB9qiAOAhSAvgNTrhIqXgD5GM4UcReuF2ATFbK96pGtSYRdverbpVlF+VdDc/fw3hj9k1G6B8W+zHXPKQ5Y59s675DtLx+

poCzevnKUhWT87Hox9yOsfXH5PLZFvZFJ8f4gwn+6sgsqu8kLPvw7E/Cqtuk9GaFVARHyfdvk/qfvt7dvqdpzMhdvLNaO7adVV85k777T07DRDejAI3sbxN44BTfiUs3+b4t8h3lyPC+qFP2CkAMHyTcba0Ax2tXg7PRhrm/UBUFIg7A2AuAegNwvrPlBaiWJXhzvDXTpZorGBqeLt+dBuQN1AkBnSSiHpS+ThK8d6va/hDH/j/O6gKfOnfdIhrg

fkAeiLv19i74O8YJ//jptsatNzWHh2y1HxzYANAgQIx67ejcxDQj1IESXCDTJcyPc1kl5nHfrQVobgWLUmsCRF7wD8/ofYABoQ/Rn2s0GUQcDnhQ/ealaszaC2kcRQ4GbxOBvwKoGIgzyIYFIgKgbAH0AhAUiAaB4gegH1BDyEsnD8VtOPyc0q3RqH9sIAd6iuhZtfUBOBcAPPhOA2IWbQQAxEA6BCAUQPYE0BoQHkgkDXgXAH4gbQdwHpAQlAhw

6BLFRQ2wBuYKjyN0ogKAFQdkLKohKUjYNkHeVmvFh17U0IIwEAgCIZgDOooAJM2NchfRhE+B26eJQ3VGVKnR4QPJf4Fsh+IXkiIMteBK37pEQc4Q2RQFR7DRAz/dLWg5/XB/0DcPvY3ww93/Gnk/8jzSNwADrfP7ywQQAsHxI9vbC8ybtIAIgJICyAigNggqAmgLoCGApgJYDLFdqwQ1OFQjzRFmLBqWyx8DbsiUUC3NR2Lc+BSyitIHoBGidVaN

F1TUUpBCjgid1tNzDTxoQBBXZ8W3Tnxk923UxjgAhAEglGpUAAzkAB8V0AAEIyKdlATYO2CrTfYKODM/b026599Qd0e185HOXbYQzc/ULlB+K/RncfWGtWmcJAE4K2CKnYgguC93RHR35j3VHVPde1IBxAcwHCBygdYHWBwwh4HRB2QdHnZb3uo5SK0kPRKDWZALwKQURzDxwtHDU+oIpFRG/p9/eJnXA1kU3VcxrvbXwx5J6O7yAtHvTsme8mMP

12J4DfJFyDc0gr7y/UP/X7yAD//QETyCBQj2yKCwA0jxatk3KlxaCA7GjzJwvWB80Y8kfGLw0NzVYlHjA14JlQI0v3blzngPSTXg1Nxgxa0mCltYVysMs7ZchztWNXVzCQmgXoG6AxgAiCDs5NC0Itos4fp25shnbTVGdBbCZyD0fyEPRdDB/MYX1BAIfUD7RSAs6jGBnAKAFggUwGAB2AWYQCBwgphLgH9C46QMPswzPKxS8MJpUGhPsmVZYMCN

pPbV3BCs4W0PtDHQoO0F8iVRhFHMwlMII8g0QXiBCYw8LKx+x6dJLCf42KQk0epuzW9nRBB4XEyf4YPPX2fUOQ2vC5CJBVFwqs+Q833yDLfLKRMcGrW33jd1VB31KC5DOx3oFOFFgPo9Ogv1h8h8sBXh/px7fQ0650TejFAYFtJa2rdwLGYJE9EGbAwzpbgTgJcVVg8QXWCIAUtnb9XCaDDO1DtUal/DV9ft2z8gJJp0zUntVpyeDx3YXG7Yp3d4

LDRIQ0B3AdIHQgGgd4QxEKQdN3MfnO0gIjP0UkW1YENUlQQ7n0aRQw8MMjDow2MPjDEwhAGTDUwglRfdTXQKSdIQGUck7IWuF/nltnIXl3chTdd6iAZxEaF3PUVEY+1PVP6ATjhA0mSegSxjgUYJvw4QU9USD2Q5IPe9tHT710deQzIP5Dsg3D2MdAAvSJB8iPJq3ADJQtrRTcZQl31o4nQfcKBsTNXgGR8pwRYO15mQn+iSFuXEZFm0WuPqSggb

wk0KFdpgxkVmDRPXwxhAa7K7i5FiwhP3cU5PRchU97wKI1OslXBKJmA54Z6ick1SATjE9/lMAGcA5It/m+BjDKgx7hJ7EsnSVCjWe0YsovRe0qMf7BL3s9kvRpGQjoQtCIwi4HBB2wicvVB2cAI8ZJnkjzdGZDuAMbCrzPgh6JilJAKRD/ga9rPYh27VYvCm3qibPCCU686bG/QZsaHJmx69OLPrz14yIn1Ax1wkXoBNAL+ZjXQBZ/Z52GIxIykX

IsRUC4QfYMaZ6iAVIoHuCCDwFeMhGRnqWyC7DonDGjxNRwu4ASBKQK4HOBMYF4Fe81IoUGf94wRDi0j0XHSPnCv/aUF/8A0TKX7p8POrUgDCg9XTMiTkP+G9YXHa6ERB4BWRWTwffBAJJE2wLf0lZ1mDAMicvgX9gRBcAx30ZF2A2t0ijZpEsPmoeAsNGHJsAbACPBsAP4BXd+Y+jE0AqgBAE0AMaa5yI0qgfUEoNyREIB7g9wjqHUD5PLQJ0DOF

QgH0DnfU1SMCTAxACWiLA/YmIcdXXtQwg4APtGYB/aM6nEgaw3zWRoxWJRxhAhkHxj8DeIiyB4wmKOxTuNOzMkPbgI8YZAINIXVJhg8kQM+AXgPSBjGtIVIp4U0c8FKcNfQ4YopjnDfhG330jcg2kxq0RQ1cOI9xQkoMh9fbeERpdRTGjztiapAmJgCEGLA2nQeyMa1/NPHXjjI1ZtWrFk5mYnUyCjhPXMJxZ1kW9ns1m3aKI/C23DwkABQZUABq

FUAAsf5oJM0UagPFfwtVHLBi2E0C0BICIp3Hip4jgBni41OePycF4jgCXiV4kCPlJ3IYEGsg50OPDVIB3dOTz9QJPITe1ngsblL84JZxS+C5udeOniVUUth3jGwPeIPjNAVeM79czbvwPdkdUiJsCs4JTH6ATgTAHZBMAQyUR8Z/TEkuizIELVyxgaUZBi1SUHiJcgSUIGPXBkQDI3yRwgsrEHh14ZUhUQzgVcHSx4g3XwxoEgEGiBBZ4ckS+AIY

+ONJ5oYl/x0dbbbSNIVEY6iG/8UYwUIPNDInFxVVzHYoI3DFKDoPyU2yJ/l/5ffKemjsprZUzuN4PQ4SZUQoxBkIsGKIBXbjC4ijjZiKOIsLNNuAo0F4DEQJFVnh9QTQHnRRFAEB8gEATOh4BsATQCHpiAG4B4Aw+AnAGRiARjDUCCADQMfANY7MMUMy2P2zTdYEdiANizA6o2NirA943ATGkCoEcQjARwEkAmgPQKQMLo3h2cAMYUnW+jHleKwN

JiKeIU/pDDDcGuAdaAcwVMTkc/x2RLISrEaTkGdcFYSs4jg06wOE2GO4T4Y3hLTiFVAROMIhE8DS5MFw3ONMiJQvGIVDoAo3QakBBPoPrjXnblz8duyV4CUVNEryG0TPokmL8izDW8PwCqXQxMZFjEhC0FcsXYIDEZvIYWIFiqgTQHGJegfUCuBiAYQNwAvIB5NGR9QY231AdkTQDz4fk/xJ9BNAzxG0CQkzhX0AdY7cN6gokjMFMCjYsXEsCZjS

E23ZiAUOBaB7knCBqAVcMV2yS5SaONJ05eTI1Ao0DEpLOFRyDGlGIJ4GZA6l/YnhAEhcsPxzhon/AeFHCdhfxj7hh6ZJljjlzNpN9JOk9czf9vvVONK0FsAZL/9Fw9GOXCCPAoNVUxQ/k0TdCOaRP+s2yD+jx9SYqcEHhuXUr2v8CKNaxVcYLD+miUdk4J3219ktgJrcyg3TCzghADCDOohgKAHoAJvDCCgBDQDoCaAxgegCEAhAFMAIhy4y0IDD

ZNLMJSjORTmJii0OXgJ2B92HYB+T5A+oGrAzmPYGwAnk/YGIB9gNxPyxJAyQP5iceW5P+TAk+8GCTA02H0fpkQ8JJh9SHYwOhTDY+LwOJ4U02LLDGkCgBaB/wMJAwhPgAlRNdhfVAC15sefyHp1GpIhOIpHvSyEYMfVeJVZDewnhEgEi3OkN18pkLGHWFuOLtJal4XccMhjOQ1IOnCTfTDwRi+knOIzjxUkRNMcxEu33B85Uk1Oh8OrGj1Oj5U3h

QPDZeG/Hk5d9BRM3V9DBI1qx4AoJwmDtTKYLCcU3dZO4hwOT6L9iOY+PS5jE/CAEABN+MAAZxN+DiIaVz85AARBU2JPcUjELRQAF/FHQSKcoMmDLgzEMoUQbVICNDIwzM/CkD8YzgayVcx32F+x9Nbg6+IO1j9MCUL8oJV4MLVp3CJIqEt3DwiwzNg2DI4AEMpDPDUCMgznQygQ4A3zMj3U+RPddnXV1ggYAHgH6BDgCgDQh4fLJKQTeHIkCtJcs

C+wHgklQJ13VngLGASEXgfyA8SxEf6OpSDDYe2+joQNUmvwNTc/xwoB4K8K7TTdO/xXS2E14V5TX/QrQFTt0oVOTIRU1GP3Nhk5mlGSj0tcPt8IfYyIVT6pImJVJTwviH0NasbqXCkdU1OhSsr1fYD0TyPSl1NT7wo5IHiTE28J5jGkTQH1AfIeIGIA/gBAHiBcACrPiAPk7ABOAz+MOmqzFFMRDOAEAAkClivkq4Dd9uwNWPii0ooFM1iaPLhw7

wDAyFPLTygStPMC4Uk2Oi9EUsYUljSIUOB2ATQW8gJVsU1bynBsDZ0mLwBkVcHytWwlZAOAB4WZDuAkQFRBdiQPU4Fp08sX1QISaEiAUBB19T4DopjgVHkfTl0jR25ScmTzK4T+UnhJK1f1HcwCyhk0AJGTd04yOxiE3FrUgDoswmI0hB4G1x/oeMXUPxteXYEFSyWRdLOkVDQ/yK/TssqHw7if0ql2OS4nIeKppeA/FkBA8AQ4D9RiAQ4H1BX2E

IEEQVEc5x+SjSEQMeUEAYQKljUYgbIIChsoJJGzH6TFPGzdYjEX1iK0mJPMU4khFLNis4IYGUBFMCgG6A2gFoCvSrMLbPFtb2cZVgUe4c4yuBthRIGSxwovuARBudczPoxWWWKyRtgBAEFoNJ6ZE1J1UQYYyHolIhBRQ9q8P7OhiukwHJ6Tgcs5NBzkYwZLFThE4UKMisY6VJxiJkuyMVTroQlCHog2euOHAtQpuITteSZnzjlsctNn/TRkB+z39

DUz9KQsz0knKE8U3cnPj9Kc0pl4D9QdxPDSLhddE8T4gTQAvhNAcWJ2BGc9xIV5iAW5P1BegBAGSxcAMPgFyAk9WOGyQUmjzoYS0mzymyJAGbNiS5s+JM/tEk0LGYACIQCHiBAICn02zVMt+VwooaIpCyNnKOOx+pNSDyTJSt9UvBujXXcDiktfgYGO8kBwGDzusT4n/g8heldrmQ97/dzKhi/cvlO8ygciVRBzhU0PNFScg/dMjzRE6HJjzYc8l

yiyb0mROuhssNPF0MCrZAMClPgYcD4hhoumPW1/0jnSTyEFI0LTsWY9rUOT2tKvK4CissxLEZjvUrMHgDoEfJ7Tt0PvOOBqsw4GrBmcxxM0BhA/UEuBHEzhKfhBcwFJFyp8x+iMBwUkuKlyoU6bNlzq0+bOsDFs1zSZkjARTFUB50PfL0JeHPXNJ11QkARh5iKZLBWEA8U9CtIy8fsmtz6MBIFkRgtGbX98dfCATu9mw3/AE4g/K3OwVf837Mf8A

CrzLRcU43zNAL/M8AsCzKtCHJCyoc6PPET84yRMQLK4mZNgCB4Uaxjtb7dj0wKPEp+3fScw9a0QZhweMFGQh7LLKTcLIg5LNT8syT01ca80NN5jGslRGIBrE+rKaypQaEBHzr1IQI29FFbLFKyw6axI8gx8gFKCTJ8gtNdY6Xa52ELbHGQsMC5ChfIUL5c2tKkze1NgB4BliyQDGAuQB52n8JAHXN+4b8cJi15JWEwu7JjskijOBEtSdX8YBkIcN

ddkcvFKakrgDE0pBKTY+CbDWk1D19zn/f3KALA8kAuDywCn/zDzICiPLaTgfaIuPSJEyLPhykChPLfN3qJRIJFrhbl0/yh6ejB/d8CmyGm9Z4BEF7pK3PZKlDcsjOwqKoowrICizk3gIRB/IEIDEC/gaxPrprnPAF6A28zQAaKE0mrOIBsYHYE6yTgeoCYoc0ifPEKRi7rWudNi4uLYyIVefPQBF8uXOXyFcutLZgcIVkBOAhgRTAxR7YtTJhA3I

ePDdzXgA0kRBiKSrASA08B4ongWWapKnAfIXLCqw08+MHg96sBILeKfchOPXSk47pMCLekvzNCz2DPDwlTMYwjhhz1wyEq1VSi4U0lydwsYoGR3fHfBspnXYkFRz4SymOGIx4WbVUQsc3EtJLKC39MfDXqOGgSM1bWuyqLTkr8M/FdoJoHIAXOVAH0F6uZPlb8ZJMglLKRlSQArK9BKsvqcbta4O6MaM3Pzozb4sdyL8OnC/SLlIzD4Ol5X4msu6

BfYesvLLKy07kIigDPMxBCJMsEMWKs4JUHow7CBAHhMtiwnTlIx4Ic3roSQS+y+UTi4vHf4dkHK138P6U72JNonXHnyKYadH2nSqTTlKKt2kycOdKZw030FTgiz0raTvSg9JXCwsvONlS4coMoo9LIibPTc2YfyEjKBrRyjVIi8Rvi4EUi5RK4x1hTeA5Zrw3ZPTLyiruNyLsyhunWRCwgrJOSq3IstrKSysssbK4uIvTT9xyussorUAaiqPj2yt

pU7KM1G+IeCT9RjL75mMyACLUxS2/Q4yICYsoQBJyqiporAE9ZzEywDDdkkzgw3tTOoTAP1H6B9QcXLOjxXbxnZFP5Hxn8hRzEY3Ct9gI4A5Z+IJSKmUNTeHhMKxfSjScoooKdP8l6QzJm8L3ip0o0juQ5ONXozfHdKjznbP8ugLD02ApiLgKhApKKwK6UIgrKpCQGudCMePJiykc1jllMz8imIVgSQRuKVMuMfJCRBo8ZLGKK7wwktwqVXYiw1D

sQt8Prs1gscqElcxZHEAA4OSzFkcAwUAAeeWoAaCa0Rd5AABLtAAejMRK78R9T6tACPKAbxOSXvExIGqsEk6qxquaqdBNqs6ryKtBB/hmKgCRz92K7ss4qGMmCL7KXgq9P4rS00cuErBJW8Uqq8YEau6Ahq9kAaqmqjgBaqOqrqrkkRM+cpIjFy/aIkBRkTAD7RAIdkCEARShBO2L987bP45bIIypPQAvIegwTjC0X138bcqW3RBzKgfEKRfGXiC

uz8sWxTzKnCxrAtKQrNlhPVEQMvC9ynKx0vYS/CgHO+K3SoPLp4QigEogK904EudtQSv0rgKAyuVPxipeKuOTxrSeMoVgEszAs21QFa/1zy0YQqu0MgGHKrLzv0ivLJziKinNOTis8oHqyEAenKqAR8ofIeTLgHYH5j6sgQqTSbkyWMOBNAbAHJ1RzHgFKy+SwbOKB80hnwiqqYNcGkKBK28QlKYUqtPmKFsxXMaRQ4IWLgAq4K2TbT3AzH0DinX

Yr1PiEaVun+BzSWZENzk5R6NdciEmvihq2sm42eLKYMcJ+znKlINcqN09IJ8z3S78qiKfKgyL8qAKgKvBLYiwMuFqJciFMgrIqsRBgrVQ1eDOyk5D0mtUYQbl3RBoQHyXm0sKwnMCjScyPzSyzcv5SJFgMqTxDSLTDtzoqKKhsrQAGJWiWEAFxJcS9FSAFQE2CFAKwSYAbAGDJDE5QBsu0AAE/8IrZdUESrErx6miTnq6JRcQnq5634MXruGFeu4

y16yis3r5qq+K7Kj9Hsu4r85AcreChygSp2rd6mav3qHRQ+pdEp6+iX/rz6petIAr6oQGIgb6jeq3rsFDfiAT+hTZ3EzwDOSp7Us4UiBOBFMEJCMAnQ7Qrn835WxLGihBM4EHhooPELDA+WKyFRAT8X4GBBuWcdNvsEsE/yYa4QJ7MawhzHeDO8BITXz7rvspIL/yOkgms0jXSjyq/K/ismsETw84LIPp04/OvCyT0kCsZrpkyUyHJGUWZnTy0qm

OWBqYQabV5roLTaxPsew6kTbrS8/ErE5Ra13Q3tugWCEUx6AUgDlAcIY0CaBAIIQHgh+gQgCaA2gNoEzd0whs39TE6bMOoL3wyWroLGkfmJGNcAXAHjSOgc50yNiUFQI+S/gVxKnh92evOwAKQYgAHoXklWIyhRCoYoFKzag1X0prnGsnPT8laXPkLYU3thrTHauUr+0rGmxrsbSABxvwAnGlxrcaPGrxqYj6HX7mVo3IQ4QKx0K34CAzl0fwPdd

T4zeE7IWwkF1opL2PUm+ibXCwtYbK0VXwQq8inuCBgf8tzJ8Lk6o31TqeQn4sxdSan8uzrM46mpkawSuRohLT00xtnzWg8MqnYpE6EtUNnQJyJuhkcpvgpBdDdWkwLpFOXkmIlFUgtOSMyql3WSYLIbSNISq0DNiirBMoOOtvEZKIKbm7bxFVI10R/NnRzdPAu8RtgFZtVNXqdZuVqyo6e0qjLPOe0i8F7PWNs8loqh0Wiq0+yJBtGkdBswaGgbB

urDX7eGwZBLIIQUMNhIu4BBoRoiYyxdGvGqISSSHT41WjaHH1g2jabWh2QMxbHaKYd+vNfIkArUm1LtSHUp1MIAXUt1I9SvUnqvUrmIjtO4hA47oM3R+jUBWMKHodyGyxRkbu2bzTvSIINIYmPW1k4teV/OBB+WfpCYoVEYvBGQHSn0i0ddml0oDzia34qOas6tGKprIc7yokNY8guKJyi4kuqmKbzfDGucJaCuMVCmXPq3miq67RumUuXVVM7Se

BFCvpBplPswg4cq4Fq7rsWPVI/Ylg8WurzTkg62NqFPeFtbssLWI3MR77NdFsUMDVHnhBtPPKKTkPW0cn+BvW44CqBCWuixnsSW6qPJbZCuqNpb1ouLxXtGoipTtwUUtFIxSfPTpQLxPgMeEtIbS7LBslFLAVrfsyWj+3wAWvMhza9qW8Vq2i5W4G0YcMVZhxULdXFMHZBvwGABNACICgAmKHI0oB+rdcp63cheSf9I+AhOAOuTx0QfJLQNf2d8z

NLb7EZHX1CkcinwT6MOOpqS/WwVV8LPiwAoCKRGoIrEb+k0IvByxQqNpgKLmoCuatJkqAPRFEioRH2BFTH8zsqGADPPV4TS7Iw0RQW5HNGJrgFjsBaq3Yuo7rRa8qPraaC0kqlqnq1ZP1AjSKWIEgSQSrIlifk3nMOBHE7WpeBewaRTP4zmR6KNqhck2uGLEW0YqKa/gZ+lKaqbGYslK5imUtNjwAZaBog4AOAFrF9wGoyfA4oDIHKA5YPEAeAGA

QgAQAKARxA/L4OGvRC7smvipEAQEFMH3B9AM0Gw6dm1uEDQIuvZWi7AuzdIyD3SxLoL56jaLv/BsXfysy7Iu6Lti7arKAoK7ku9IGK7s4oyLK7su9IFDhQfCfBq6/waLrOpqOnzocFCu9IH/BfTdOSa6ourrs9N/xdrqS7au/QB1R6M9vD66iu1r02iRaKbvSBncDrxvbuvOVvm79AchxWkpSP+HWBmQTgl5BD2MPG2xSdPuD4gksMkFvhdutkGN

BM3BW1ngkgG3IisBOHZHmYIAIwDYADAVzoWYCAedRThg8T6mtw1u+rto6FgY6B265QEgDbLH4LVQh79wd5Qu7we4gFpwEAZ3CudggRbWh6AitSEcReQRpDsapQMUQVJ7OQnpuhhIDlt6B3OPUHDhlAEsG1AFgZQHx7xiInuyreAZnvQcKegHo666oSroQBWunCTo6fOoXnDg0SFdrmNUe66AQbA0IgHeUJe1NA867qiFGDhsqPMwB73TZgBNBU0O

ACR6Uez0XR7pQdWEYAcId7uNQOLf9rCBggJYBegjYewlJJNu+kALKq3CqPggLeg3qN6Fc8ABUgySpsHSQOwIAA==
```
%%

## LTC

利用LTC分布近似BRDF分布, 然后将LTC分布上的积分转化为clamped cosine上的积分, 通过其解析解求值.

各分布间的关系:
![[rc/ltc_relationship.png]]

## Reference
[利用LTC实现实时多边形面积光](https://zhuanlan.zhihu.com/p/350694154)
[PlayCanvas WebGL Game Engine](https://github.com/playcanvas/engine/blob/main/src/scene/shader-lib/chunks/lit/frag/ltc.js)
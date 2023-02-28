---
tag: summary/paper_note
---
## 特征点关于IMU位姿态求导
左扰动推导
<div style="text-align:center">
<img src="rc/jacobian_left.png">
</div>
右扰动推导
<div style="text-align:center">
<img src="rc/jacobian_right.png">
</div>

basalt中使用了左扰动, 使用链导法则求导. VINS中使用了右扰动, 并直接展开求导.
VINS中使用链导法则, 并结合左右扰动求导:
<div style="text-align:center">
<img src="rc/vins_jacobian_using_basalt_deduce.png">
</div>
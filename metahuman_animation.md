## mixamo to metahuman

参考: [Tutorial: Mixamo animations to Metahuman in Unreal Engine 5](https://www.youtube.com/watch?v=SXDmX1ronGw&t=210s)

1. 从mixamo获取animation, 并转化为UE兼容的animation.
	* 下载mixamo converter
	* 打开mixamo官网, 上传mixamo converter中`mixamo_converter/Mannequins/Quinn unreal engine 5/_SKM_Quinn.FBX`, 然后将所需要的animation应用到该mesh上, 导出fbx(without skin, uniform), 放到`mixamo_converter/IncomingFbx`目录下
	* 点击convert进行convert, 在`mixamo_converter/OutgoingFbx` 得到输出的fbx.

2. 新建UE project. `film` -> `blank`, 通过Quexel Bridge添加metahuman, 在content browser中将metahuman拖入场景, 然后在项目中添加`ThirdPerson`
	![[Pasted image 20230509142343.png]]
	![[Pasted image 20230509154814.png]]

3. 将转换好的fbx拖入下方content browser, skeleton选择`SK_Mannequin_Skeleton`, import.
	![[Pasted image 20230509142931.png]]

4. 在content browser中搜索`RTG_UE4Manny_UE5Manny`打开.
	![[Pasted image 20230509144229.png]]

5. 在`Target Preview Mesh`中选择与metahuman对应的body mesh. 在下方`Asset Browser`中选择导入的Animation, 即可进行预览. 然后点击export将动画导出到自定义目录.
	![[Pasted image 20230509145045.png]]

6. 将Animation Mode设置为 Use Animation Assert
	![[Pasted image 20230509202552.png]]
	![[Pasted image 20230509150243.png]]

7. force lod 0
	![[Pasted image 20230510105123.png]]
	![[Pasted image 20230510105143.png]]
	![[Pasted image 20230510105200.png]]
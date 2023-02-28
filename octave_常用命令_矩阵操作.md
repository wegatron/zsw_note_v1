---
tag: programming_language/octave_matlab
---
[TOC]

# Octave Tutorial

## 一般命令

##### 更改提示符 PS1

```
octave:11> PS1('>> ')  % 更改提示符
>>
```

##### 帮助命令 help
>> help hist

##### 幂
```
>> 2^6  % 幂
ans = 64
```

##### 逻辑运算

```
>> 7 && 3 % AND
ans = 0

>> 7 || 0 % OR
ans =  1

>> xor(7,0)
ans =  1
```

##### 打印 disp
```
>> disp(a)    % 打印
 3.1416
>> disp( sprintf( '%0.2f' , a) )
3.14
```

##### format
```
>> format long   % 长小数
>> a
a =  3.14159265358979
>> format short  % default
>> a
a =  3.1416
```

##### 矩阵
```
>> a=[1 2 ; 3 4 ; 5 6]
a =

   1   2
   3   4
   5   6

>> v=[1 2 3]
v =

   1   2   3

>>  v = 1:0.1:2  % start:step:end,   1行11列矩阵 
v =

 Columns 1 through 9:

    1.0000    1.1000    1.2000    1.3000    1.4000    1.5000    1.6000    1.7000    1.8000

 Columns 10 and 11:

    1.9000    2.0000


>> v = 1:6   % start:end
v =

   1   2   3   4   5   6
```

###### ones
```
>> ones(2,3)
ans =

   1   1   1
   1   1   1

>> c = 2*ones(2,3)
c =

   2   2   2
   2   2   2
```

###### zeros
```
>> w = zeros(1,3)
w =

   0   0   0
```

###### rand 随机矩阵
```
>> rand(3,3)
ans =

   0.398462   0.832512   0.595303
   0.410825   0.726594   0.015361
   0.600570   0.555390   0.150527
```

###### 正态随机矩阵 randn
```
>> randn(3,3)
ans =

   0.0226734  -0.3335212  -0.0013326
   0.0497447  -0.5800039  -0.2202317
  -0.3534828   0.1645582  -0.7277182
```



###### 单位矩阵 eye
```
>> eye(4)
ans =

Diagonal Matrix

   1   0   0   0
   0   1   0   0
   0   0   1   0
   0   0   0   1

```

##### 直方图 hist
```
>> w = -6 + sqrt(10)* (randn(1,10000));
>> setenv("GNUTERM","qt")
>> hist(w)
>> hist(w,50) % 50个bar
```

画直方图报错处理:
```

    setenv("GNUTERM","qt")
```

如果不想每次都输入，把这条命令加入到:
```    
vim ~/.octaverc
```

##### size 和 length

```
>> A = [1 2; 3 4; 5 6];
>> size(A)
ans =

   3   2

>> size(A,1)
ans =  3
>> length(A) # 返回最大维度
ans =  3
```

##### linux 命令: cd / ls / pwd
---

##### who/whos 查看当前工作环境中存储的所有的变量
```
>> who
Variables in the current scope:

A    a    ans  c    v    w
```

##### 清除命令 clear [var]

不提供var， 表示全部清除

---

##### 保存命令 save
```
>> v = priceY(1:10)
>> save save.data v [-ascii];  % -ascii 保存为文本方式
```

## 矩阵数据移动
```matlab
>> A=[1 2;3 4;5 6];
>> A(3,2)     % 取矩阵中的某个元素
ans =  6
>> A(2,:)    % : 表示所有的数据, 这里指 第2行数据
ans =

   3   4

>> A([1 3], : )   % 取 第1，3行数据
ans =

   1   2
   5   6
   
>> A(:,2) = [10;11;12]   % 修改第2列的值
A =

    1   10
    3   11
    5   12   

>> A = [A,[100;101;102]]  % append
A =

     1    10   100
     3    11   101
     5    12   102

>> A=[1 2;3 4;5 6];     % 还是 append 的例子
>> B=[11 12;13 14;15 16];
>> [A B]
ans =

    1    2   11   12
    3    4   13   14
    5    6   15   16

>> [A;B]
ans =

    1    2
    3    4
    5    6
   11   12
   13   14
   15   16
   
>> A(:)     % 小技巧，flatten 一个矩阵，按列顺序排列
ans =

     1
     3
     5
    10
    11
    12
   100
   101
   102

```

## 矩阵运算

##### reshape
```matlab
A = [1 4 7 10; 2 5 8 11; 3 6 9 12];
% A = 3×4
%     1     4     7    10
%     2     5     8    11
%     3     6     9    12
B = reshape(A,2,6);
% B = 2×6
%     1     3     5     7     9    11
%     2     4     6     8    10    12
```

##### 加法 A + B , 各元素相加
```
>> A + B
ans =

   12   14
   16   18
   20   22
```   

##### 数加 A+1  , 所有元素+1

```
>> A+1
ans =

   2   3
   4   5
   6   7
```

##### 乘法 A*B ,  矩阵乘法
---

##### 矩阵点乘 A.*B  , 各元素相乘:  

    A=[1;2];B=[3;4];   % sum(A.*B) == A'*B 


#### 叉积 cross, 至少一个维度大于3

---

##### 矩阵数乘法 A *2  , 所有元素 *2

##### A.^2          , 所有元素平方  

```
>> A.^2
ans =

    1    4
    9   16
   25   36
```

##### 1 ./ A   , 所有元素的倒数
```
>> 1./A
ans =

   1.00000   0.50000
   0.33333   0.25000
   0.20000   0.16667
```

##### 对数log(A)，指数exp(A)

##### abs 绝对值

##### -v  % -1*v

##### max(A)  最大值 

```
>> val = max(A)
val =

   5   6

>> val , index  = max(A)
val =

   5   6

index =

   5   6
   
>> max(A,[],1)      % 按列求最大值，默认
ans =

   5   6

>> max(A,[],2)      % 按行求最大值
ans =

   2
   4
   6   
   
>> max(max(A))      % 矩阵范围的最大值
ans =  6
>> max(A(:))        % 矩阵范围的最大值 
ans =  6   
```

##### max(A,B) , 返回一个矩阵，元素是 A,B各元素的最大值

##### Filter A <= 3  , 各元素比较的结果
```
>> A <= 3
ans =

   1   1
   1   0
   0   0
```

##### find( filter ) : find( A<=3), 注意接受 find返回值的变量个数
```
>> r,c = find( A<=3)
ans =

   1
   2
   4
   
>> [r,c] = find(A<=3)
r =

   1
   2
   1

c =

   1
   1
   2
   
```

##### 求和 sum 
```
>> sum(A)
ans =

    9   12
    
>> sum(A,1)
ans =

    9   12

>> sum(A,2)
ans =

    3
    7
   11
   
>> B=[1 2;10,12]    % 主对角线 辅对角线求和
B =

    1    2
   10   12

>> sum( sum(B.*eye(2)) )   % 主对角线 求和
ans =  13
>> sum( sum(B.*flipud(eye(2))) )  % 辅对角线 求和
ans =  12
```


##### 求积 prod
```
>> prod(A)
ans =

   15   48
```

##### floor, ceil

##### Transpose 转置  A'
```
>> A'
ans =

   1   3   5
   2   4   6
```   

##### magic 好玩但没卵用
```
>> magic(3)
ans =

   8   1   6
   3   5   7
   4   9   2
```

<h2 id="84becd6270e11d304352cfd8cce872b3"></h2>

##### invert 逆矩阵  pinv
```
>> C=magic(3)
C =

   8   1   6
   3   5   7
   4   9   2

>> pinv(C)
ans =

   0.147222  -0.144444   0.063889
  -0.061111   0.022222   0.105556
  -0.019444   0.188889  -0.102778
```

#### a=a( : )   

确保向量a 转为 列向量

## cell array

```matlab
a={ 'a' , 'b' , 'c'  }
a = 
{
  [1,1] = a
  [1,2] = b
  [1,3] = c
}
```

## 图像相关
存取png图片
```matlab
[rgb, map, alpha] = imread('xxx.png');

imwrite(rgb, 'xxx.png', 'png', 'Alpha', alpha);
```

读取视频
```matlab
r = VideoReader("xxx.mp4")
im = [];
while (r.hasFrame())
   img = readFrame (r);
   if (isempty (im))
     im = image (img);
     axis off;
   else
     set (im, "cdata", img);
   endif
   drawnow
endwhile
```

## 拟合
定义函数:
```matlab
modelfun =  @(b, x) b(1)*log(b(2)*(x-off)+b(3)*((x-off).*(x-off)));
```
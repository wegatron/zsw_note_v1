---
tag: programming/octave_matlab
---

# 控制语句

#### for
```matlab
>> for i=1:10,
>   v(i) = 2^i ;  % ;不要漏
> end;
>> indices= 1:10; % 序列
>> for i=indices,
>   disp(i);
> end;
 1
 2
 3
 4
 5
 6
 7
 8
 9
 10
 
```

#### while
```matlab
>> i=1;
>> while i<=5,
>   v(i) = 100;
>   i=i+1;
> end;
>> 
```

#### if  elseif else
```matlab
>> w=1;
>> if w==1 && w<=3,
>   disp('one') ;
> elseif w==2,
>   disp('two') ;
> else
>   disp("other");
> end;
one
```

#### break, continue
---

# 方法

##### 定义 function RETURN = FUNC_NAME( PARAMS )

##### 多个返回值 function [RET1, RET2] = FUNC_NAME( PARAMS )

##### 例子: 代价函数J

```matlab
function J=costFunctionJ( X,y, theta )

% X is the design matrix [1, A ]
% 注意语句后面加上;  不然每一步都会有输出

m=size(X,1);   % feature 数量
predictions = X*theta ;  % 矩阵-向量乘法,计算出所有的h(x)
sqrErrors = (predictions-y).^2 ;  % 计算误差的平方

J= 1/(2*m) * sum( sqrErrors ) ;    % 计算代价

end
```

```matlab
>> X =[1 1;1 2 ; 1 3]
X =

   1   1
   1   2
   1   3

>> Y = [1;2;3]
Y =

   1
   2
   3

>> theta = [0;1]
theta =

   0
   1

>> costFunctionJ( X,Y, theta )
ans = 0
>> theta = [0;0]
theta =

   0
   0

>> costFunctionJ( X,Y, theta )
ans =  2.3333

```
---

##### addpath(path) 添加搜索路径，以便 Octave 发现方法定义文件
```matlab
addpath(genpath('matlab')); % 添加目录以及其所有子目录到搜索路径
```

---
tag: programming/tools
---
# Maxima使用小结
## 基本语法
* assignment operator `:`或`::`
定义变量

* Operator: `=`
The equation operator, 用来表示等式, 不是赋值!!!

* ev (expr, arg_1, …, arg_n)
用来计算表达式的值, arg是如下一些值: `simp`, `noeval`, `nouns`, `expand`, `eval`, `x=...`等.

```maxima
(%i1) sin(x) + cos(y) + (w+1)^2 + 'diff (sin(w), w);
                                     d                    2
(%o1)              cos(y) + sin(x) + -- (sin(w)) + (w + 1)
                                     dw
(%i2) ev (%, numer, expand, diff, x=2, y=1);
                               2
(%o2)                cos(w) + w  + 2 w + 2.449599732693821
```
* expand(expr)
多项式展开

* factor(expr)
多项式分解

* Logical operators
`and`, `not`, `or`.

* 循环
>for variable: initial_value step increment thru limit do body 
>for variable: initial_value step increment while condition do body 
>for variable: initial_value step increment unless condition do body 
>for variable in list do body

* 大小
`length (expr)`
返回expr的大小, 对于list返回元素的个数, 对于矩阵, 返回列的数量.

* 注释, 与C语言一样.

* kill
用来移除定义的符号
```maxima
kill(a_1, ..., a_n)
kill(all)
```

## 简化
* ratsimp
化简表达式

* 三角函数简化
trigsimp

* express(expr)
展开偏导微分算子(`grad`, `div`, `curl`, `laplacian`)和叉积(`~`).

## 矩阵和向量
* 生成一个矩阵
```maxima
genmatrix(name, rows, cols)
```

* 单位阵
```maxima
ident (n) 
```

* 矩阵相乘
```maxima
A.B
```
按元素相乘
```maxima
A * B
```

* 子矩阵`submatrix`
返回i_..行和j_...列被删除的子矩阵.
>submatrix (i_1, …, i_m, M, j_1, …, j_n)
>submatrix (i_1, …, i_m, M)
>submatrix (M, j_1, …, j_n)

* 矩阵大小`matrix_size`
Return a two member list that gives the number of rows and columns, respectively of the matrix M.

## 函数
* operator `::=`
定义宏(函数)

* operator `:=`
定义函数

```maxima
f(x) := x^2 + x
```

若函数比较复杂, 希望通过return来返回, 则必须使用block和return.
`block ([], expr1, ..., if (a > 10) then return(a), ..., exprn)`

* block
`block ([v_1, …, v_m], expr_1, …, expr_n)`
这里[v_1, …, v_m]该定义局部变量/该函数中需要用到的临时变量. 防止局部符号覆盖全局符号.
在进入block之前, 会将block中相应的符号的内容保存起来, 当退出block只时, 将相应符号的内容恢复.
`block (expr_1, …, expr_n)`

```maxima
f(x) := block([v, c, r],
  v : genmatrix(v, 3, 1),
  c : genmatrix(c, 3, 1),
  r : genmatrix(r, 1, 1),
  x);
```

* return (value)
显示地返回值

## 线性代数
* diff求微分
diff (expr, x, n) returns the n'th derivative of expr with respect to x. 
diff (expr, x_1, n_1, ..., x_m, n_m) returns the mixed partial derivative of expr with respect to x_1, …, x_m. It is equivalent to diff (... (diff (expr, x_m, n_m) ...), x_1, n_1). 
diff (expr, x) returns the first derivative of expr with respect to the variable x. 

* `jacobian (f, x)`, 返回jacobian矩阵, 第(i, j)项是`diff(f[i], x[j])`
```maxima
jacobian ([sin (u - v), sin (u * v)], [u, v]);
```

* `hessian (f, x)`, 返回hessian矩阵, 第(i,j)项是`diff(f, x[i], 1, x[j], 1)`
```maxima
(%i1) hessian (x * sin (y), [x, y]);
                     [   0       cos(y)   ]
(%o1)                [                    ]
                     [ cos(y)  - x sin(y) ]
```

## 有必要阅读的章节
refer to wxmaxima's maxima help:
> 7 . Introduction to operators
> 9 . Simplification
> 10 . Mathematical Functions
> 14 . Polynoimials
> 23 . Matrices and Linear Algebra
> 36 . Function Definition
> 37 . Program Flow
> 57 . f90
> 68 . linearalgebra
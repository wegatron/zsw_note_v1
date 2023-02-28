---
tag: programming_language/c++
---
## Ceres札记
[TOC]

### 基本概念
优化问题
$$
\begin{aligned}\min_{\mathbf{x}} &\quad \frac{1}{2}\sum_{i} \rho_i\left(\left\|f_i\left(x_{i_1}, ... ,x_{i_k}\right)\right\|^2\right) \\
\text{s.t.} &\quad l_j \le x_j \le u_j\end{aligned}
$$

* ResidualBlock
    $\rho_i\left(\left\|f_i\left(x_{i_1},...,x_{i_k}\right)\right\|^2\right)$
* CostFunction
    $f_i(\cdot)$
* Parameter Block
    $\{x_i, ..., x_{i_k}\}$
* LossFunction
    $\rho_i$, a LossFunction is a scalar valued function that is used to reduce the influence of outliers on the solution of non-linear least squares problems.

### CostFunction
对于一个优化问题, CostFunction提供残差和Jacobian的计算, 以及residual, parameters的维度信息:
```c++
class CostFunction {
 public:
  // 实现此函数
  virtual bool Evaluate(double const* const* parameters,
                        double* residuals,
                        double** jacobians) = 0;

  // 这两个函数理论上应该要实现, 但vins MarginalizationFactor中就没有实现
  // User code inheriting from this class is expected to set these
  // two members with the corresponding accessors.
  // This information will be verified by the Problem when added with Problem::AddResidualBlock()
  const vector<int32>& parameter_block_sizes();
  int num_residuals() const;

 protected:
  vector<int32>* mutable_parameter_block_sizes();
  void set_num_residuals(int num_residuals);
};
```

若参数和残差维度已知, 则可以使用SizedCostFunction:
```c++
template<int kNumResiduals,
         int N0 = 0, int N1 = 0, int N2 = 0, int N3 = 0, int N4 = 0,
         int N5 = 0, int N6 = 0, int N7 = 0, int N8 = 0, int N9 = 0>
class SizedCostFunction : public CostFunction {
 public:
  // 只需实现此函数
  virtual bool Evaluate(double const* const* parameters,
                        double* residuals,
                        double** jacobians) const = 0;
};
```

CostFunction中Jacobian的计算可以自己实现, 也可以使用ceres的自动求导生成. 自动求导又分为数值求导(不推荐, 当残差为库函数时不得已使用)和自动推导(推荐使用).

* 参数维度编译时确定的自动求导:
    ```c++
    template <typename CostFunctor,
           int kNumResiduals,  // Number of residuals, or ceres::DYNAMIC.
           int N0,       // Number of parameters in block 0.
           int N1 = 0,   // Number of parameters in block 1.
           int N2 = 0,   // Number of parameters in block 2.
           int N3 = 0,   // Number of parameters in block 3.
           int N4 = 0,   // Number of parameters in block 4.
           int N5 = 0,   // Number of parameters in block 5.
           int N6 = 0,   // Number of parameters in block 6.
           int N7 = 0,   // Number of parameters in block 7.
           int N8 = 0,   // Number of parameters in block 8.
           int N9 = 0>   // Number of parameters in block 9.
    class AutoDiffCostFunction : public
    SizedCostFunction<kNumResiduals, N0, N1, N2, N3, N4, N5, N6, N7, N8, N9> {
     public:
      explicit AutoDiffCostFunction(CostFunctor* functor);
      // Ignore the template parameter kNumResiduals and use
      // num_residuals instead. 当kNumResiduals为DYNAMIC时
      AutoDiffCostFunction(CostFunctor* functor, int num_residuals);
    };

    // example
    CostFunction* cost_function
        = new AutoDiffCostFunction<MyScalarCostFunctor, 1, 2, 2>(
            new MyScalarCostFunctor(1.0));              ^  ^  ^
                                                        |  |  |
                            Dimension of residual ------+  |  |
                            Dimension of x ----------------+  |
                            Dimension of y -------------------+

    CostFunction* cost_function
        = new AutoDiffCostFunction<MyScalarCostFunctor, DYNAMIC, 2, 2>(
            new CostFunctorWithDynamicNumResiduals(1.0),   ^     ^  ^
            runtime_number_of_residuals); <----+           |     |  |
                                               |           |     |  |
                                               |           |     |  |
              Actual number of residuals ------+           |     |  |
              Indicate dynamic number of residuals --------+     |  |
              Dimension of x ------------------------------------+  |
              Dimension of y ---------------------------------------+

    class MyScalarCostFunctor {
      MyScalarCostFunctor(double k): k_(k) {}

      template <typename T>
      bool operator()(const T* const x , const T* const y, T* e) const {
        e[0] = k_ - x[0] * y[0] - x[1] * y[1];
        return true;
      }

     private:
      double k_;
    };
    ```

    __这里, MyScalarCostFunctor必须按照此格式来写, 必须是template函数.__

* 参数维度运行时确定的自动求导
    使用DynamicAutoDiffCostFunction.

* 参数维度编译时确定的数值求导:
    ```c++
    template <typename CostFunctor,
              NumericDiffMethodType method = CENTRAL,
              int kNumResiduals,  // Number of residuals, or ceres::DYNAMIC.
              int N0,       // Number of parameters in block 0.
              int N1 = 0,   // Number of parameters in block 1.
              int N2 = 0,   // Number of parameters in block 2.
              int N3 = 0,   // Number of parameters in block 3.
              int N4 = 0,   // Number of parameters in block 4.
              int N5 = 0,   // Number of parameters in block 5.
              int N6 = 0,   // Number of parameters in block 6.
              int N7 = 0,   // Number of parameters in block 7.
              int N8 = 0,   // Number of parameters in block 8.
              int N9 = 0>   // Number of parameters in block 9.
    class NumericDiffCostFunction : public
    SizedCostFunction<kNumResiduals, N0, N1, N2, N3, N4, N5, N6, N7, N8, N9> {
    };


    // 更加简单, 不必为template.
    struct ScalarFunctor {
     public:
      bool operator()(const double* const x1,
                      const double* const x2,
                      double* residuals) const;
    }

    // CENTER为数值求导方法
    CostFunction* cost_function
    = new NumericDiffCostFunction<MyScalarCostFunctor, CENTRAL, DYNAMIC, 2, 2>(
        new CostFunctorWithDynamicNumResiduals(1.0),               ^     ^  ^
        TAKE_OWNERSHIP,                                            |     |  |
        runtime_number_of_residuals); <----+                       |     |  |
                                           |                       |     |  |
                                           |                       |     |  |
          Actual number of residuals ------+                       |     |  |
          Indicate dynamic number of residuals --------------------+     |  |
          Dimension of x ------------------------------------------------+  |
          Dimension of y ---------------------------------------------------+
    ```
* 参数维度运行时确定的数值求导
    使用DynamicNumericDiffCostFunction


### 优化问题的构建
通过Problem::AddResidualBlock()添加残差块, problem.AddParameterBlock添加优化参数.

* AddResidualBlock
    添加CostFunction, LossFunction(可选), 并将CostFunction与parameter block联系在一起, 同时也隐式地添加了parameter block.
    ```c++
    problem.AddResidualBlock(marginalization_factor, NULL,
                                 last_marginalization_parameter_blocks);
    problem.AddResidualBlock(f_td, loss_function, para_Pose[imu_i], para_Pose[imu_j],
     para_Ex_Pose[0], para_Feature[feature_index], para_Td[0]);
    ```

* AddParameterBlock
    可以显式地添加parameter block, 这会再次验证参数的信息(数量, 维度). 由于AddResidualBlock已经隐式地添加了parameter block, 显式添加没有必要. 当参数过参数化时, 可以用(参考vins中用四元素作为优化变量).
    ```c++
    // 这里优化变量为四元素, 过参数化了overparameterize
    // 自己实现了local parameterization, 这个实现实际上是抽取了四元素的虚部: \sin(0.5*\theta) * axis
    ceres::LocalParameterization *local_parameterization = new PoseLocalParameterization();
    problem.AddParameterBlock(para_Pose[i], SIZE_POSE, local_parameterization);
    ```

* SetParameterBlockVariable和SetParameterBlockConstant
    通过SetParameterBlockConstant将parameter block定义为固定值, 通过SetParameterBlockVariable来取消该操作.
    ```c++
    if (!ESTIMATE_EXTRINSIC)
    {
        ROS_DEBUG("fix extinsic param");
        problem.SetParameterBlockConstant(para_Ex_Pose[i]);
    }
    ```

LocalParameterization:
>Sometimes the parameters x can overparameterize a problem. In that case it is desirable to choose a parameterization to remove the null directions of the cost.

```c++
class LocalParameterization {
 public:
  virtual ~LocalParameterization() {}

  // 如何通过新的x跟新原x
  virtual bool Plus(const double* x,
                    const double* delta,
                    double* x_plus_delta) const = 0;
  
  // 原x对新x的Jacobian
  virtual bool ComputeJacobian(const double* x, double* jacobian) const = 0;

  // 可以使用默认
  virtual bool MultiplyByJacobian(const double* x,
                                  const int num_rows,
                                  const double* global_matrix,
                                  double* local_matrix) const;
  
  virtual int GlobalSize() const = 0; // 原x维度
  virtual int LocalSize() const = 0; // 当下x维度
};
```

### 线性求解器
求解$H \Delta x = g$, 求解器有: DENSE_QR, DENSE_NORMAL_CHOLESKY, SPARSE_NORMAL_CHOLESKY, CGNR, __DENSE_SCHUR__(小规模, 适用于滑窗优化), SPARSE_SCHUR, ITERATIVE_SCHUR.

使用SCHUR补时的参数顺序: Ceres允许用户通过ParameterBlockOrdering给出关于参数消元顺序的提示, 也可以自行选择. (现在貌似不显式地给出了, VINS和SLAM book2代码中都未再显式给出)
> Ceres allows the user to provide varying amounts of hints to the solver about the variable elimination ordering to use. This can range from no hints, where the solver is free to decide the best ordering based on the user’s choices like the linear solver being used, to an exact order in which the variables should be eliminated, and a variety of possibilities in between.

### 一个完整的Demo

## Reference
[Ceres Modeling Non-linear Least Squares](http://ceres-solver.org/nnls_modeling.html)
[Ceres Solve]
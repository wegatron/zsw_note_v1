---
tag: algorithms/slam
---
# VINS Estimator
## Overview
Vins estimator是VINS中最重要的一个节点, 很多工作在该节点完成. 包括: `相机初始化`, `IMU预积分`, `相机和IMU的align`, `calibration`, `关键帧选择`, 以及`残差优化`.
流程图:
![VINS Estimator](rc/vins_estimator)

大自流程:
1. 通过各个callback获取数据保存在各自的buf之中. IMU的callback还进行实时积分, publish实时位姿.
2. 使用`getMeasurement`函数, 将imu和图像特征点数据做对齐, 上一帧图像和当前帧图像之间imu数据和当前帧图像打包.
3. 若未初始化, 则初始化. 若已初始化, 则对打包的imu数据进行预积分, 并优化里程`solveOdometry();`.
4. 更新预积分, 并publish各个消息.

两个主要函数: `processIMU()`, `processImage()`.

重要数据结构:
```c++
/**
 * 用于管理滑动窗口对应的特征点数据. 
 * 通过它可以查询当前滑动窗口中能够观测到的所有角点，
 * 以及这些角点被滑动窗口内的哪些帧观测到了
 */
class FeatureManager
{
public:
    /**
     * 把当前帧图像（frame_count）的特征点添加到feature容器中
     * 计算第2最新帧与第3最新帧之间的平均视差（当前帧是第1最新帧）
     * 也就是说当前帧图像特征点存入feature中后，并不会立即判断是否将当前帧添加为新的关键帧，
     * 而是去判断当前帧的前一帧（第2最新帧）。
     * 当前帧图像要在下一次接收到图像时进行判断（那个时候，当前帧已经变成了第2最新帧）
     *
     * @return 第２最新帧(当前帧的前一帧)是否是关键帧
     */
    bool addFeatureCheckParallax(int frame_count,
        // x,y,z, p_u, p_v, velocity_x, vecolicty_y
        const map<int, vector<pair<int, Eigen::Matrix<double, 7, 1>>>> &image,
        double td);
private:
    list<FeaturePerId> feature; //!< 通过FeatureManager可以得到滑动窗口内所有的角点信息
};


/**
 * 保存了所有特征点数据, 以及对应的IMU与积分信息, RT, 是否是关键帧.
 */
class ImageFrame
{
public:
    ImageFrame(){};
    ImageFrame(
        const map<int, vector<pair<int, Eigen::Matrix<double, 7, 1>>>>& _points,
        double _t);
    map<int, vector<pair<int, Eigen::Matrix<double, 7, 1>> > > points;
    double t;
    Matrix3d R;
    Vector3d T;
    IntegrationBase *pre_integration;
    bool is_key_frame;
};


// 在Estimator中包含
Estimator::FeatureManager f_manager;
Estimator::map<double, ImageFrame> all_image_frame;
```

重要的类:
```c++
/**
 * IMU预积分.
 */
class IntegrationBase
{
    IntegrationBase(const Eigen::Vector3d &_acc_0, const Eigen::Vector3d &_gyr_0,
        const Eigen::Vector3d &_linearized_ba, const Eigen::Vector3d &_linearized_bg);
    
    /**
     * 添加一组imu数据, 并向前propagate一步
     */
    void push_back(double dt, const Eigen::Vector3d &acc, const Eigen::Vector3d &gyr);

    /**
     * 使用新的ba, bg 更新预积分状态
     */
    void repropagate(const Eigen::Vector3d &_linearized_ba, 
        const Eigen::Vector3d &_linearized_bg);
    
    /**
     * 向前积分一步
     */
    void propagate(double _dt, const Eigen::Vector3d &_acc_1,
        const Eigen::Vector3d &_gyr_1);
};


/**
 * IMU残差项
 */
class IMUFactor : public ceres::SizedCostFunction<15, 7, 9, 7, 9>
{
public:
    IMUFactor(IntegrationBase* _pre_integration);
    virtual bool Evaluate(double const *const *parameters,
        double *residuals, double **jacobians) const;
};

/**
 * 计算IMU和相机之间的旋转外参
 */
class InitialEXRotation
{
public:
    bool CalibrationExRotation(vector<pair<Vector3d, Vector3d>> corres,
        Quaterniond delta_q_imu,
        Matrix3d &calib_ric_result);
};
```

残差优化:
```c++
void Estimator::solveOdometry()
{
    if (frame_count < WINDOW_SIZE)
        return;
    if (solver_flag == NON_LINEAR)
    {
        TicToc t_tri;
        f_manager.triangulate(Ps, tic, ric); // 三角化
        ROS_DEBUG("triangulation costs %f", t_tri.toc());
        optimization();
    }
}
```



## Reference
[VINS-Mono代码解读——状态估计器流程](https://blog.csdn.net/qq_41839222/article/details/86293038)
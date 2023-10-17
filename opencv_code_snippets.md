---
tag: programming/libs
---
# Opencv code snippets
## Feature2d
1. orb feature
    ```c++
    cv::Ptr<cv::ORB> orb = cv::ORB::create(num_features, scale_factor, levels);
    orb->detectAndCompute(img, cv::Mat()/*mask*/, keypoints, descriptor); 
    ```

2. binary feature flann match
    ```c++
    // flann index using hash
    cv::FlannBasedMatcher matcher(
        new cv::flann::LshIndexParams(20/*table number*/, 10/*keysize*/, 2/*multi_probe_level*/));
    matcher.add(des_train);
    std::vector<cv::DMatch> matches;
    matcher.match(des_query, matches, cv::Mat() /*mask*/);
    ```

## Matrix Operations
1. conversion from cv::Mat and cv::Matx
    ```c++
    cv::Matx33d tmp_a;
    cv::Mat a(tmp_a);
    a.copyTo(tmp_a);
    ```

2. conversion of different element type
    ```c++
    cv::Mat A(10, 10, CV_32F);
    cv::Mat B(10, 10, CV_64F);
    A.convertTo(B, CV_64F);
    ```

3. svd decomposition
    ```c++
    cv::Mat u,w,vt;
    cv::SVD::compute(A,w,u,vt,cv::SVD::MODIFY_A| cv::SVD::FULL_UV);

    A = u * cv::Mat::diag(w) * vt;
    ```

4. eigen decomposition
    ```c++
    cv::Mat evalues, evec;
    if (!cv::eigen(A, evalues, evec)) return 0;
    ```

## opencv计算Pose
计算的是从前一个坐标系转换到后一个坐标系的rt, 比如:
```c++
// rt from camera of p1 to camera of p2
cv::recoverPose(cv_E, p1, p2, K, r, t, inlier_mask);

// rt from obj to camera
cv::solvePnPRansac(obj_pts, img_pts, cv_K, cv::Mat(), rvec, tvec);
```

## Opencv Mat元访问的几种方法比较
三种访问Mat元素的方法
1. `M.at<float>(i, j)`方法
2. `M.ptr<float>( i )[ j ]`方法
3. `M.data + M.step[0] *i + M.step[1] * j`方法

性能测试:
opencv版本: 3.2, cpu: Intel© Core™ i5-4210H CPU @ 2.90GHz × 2, 内存: 8G.
```c++
#include <iostream>
#include <opencv2/opencv.hpp>
#include <chrono>

void test_1(cv::Mat &M)
{
    for(int i=0; i<1000; ++i)
    {
        for(int j=0; j<1000; ++j)
            M.at<float>(i,j) = i+j;
    }
}

void test_2(cv::Mat &M)
{
    for(int i=0; i<1000; ++i)
    {
        auto pd = M.ptr<float>(i);
        for(int j=0; j<1000; ++j)
            pd[j] = i+j;
    }
}

void test_3(cv::Mat &M)
{
    for(int i=0; i<1000; ++i)
    {
        for(int j=0; j<1000; ++j)
            *reinterpret_cast<float*>(M.data + i*M.step[0]+j*M.step[1]) = i+j;
    }
}

void test_4(cv::Mat &M)
{
    float * ptr = reinterpret_cast<float*>(M.data);
    for(int i=0; i<1000; ++i)
    {
        for(int j=0; j<1000; ++j) {
            *ptr = i+j;
            ++ptr;
        }
    }
}

int main(int argc, char * argv[])
{
    cv::Mat M1(1000, 1000, CV_32F);
    auto tp0 = std::chrono::high_resolution_clock::now();

    test_1(M1);
    auto tp1 = std::chrono::high_resolution_clock::now();
    std::cout << "at = "
              << std::chrono::duration_cast<std::chrono::microseconds>(tp1-tp0).count()
              << std::endl;

    cv::Mat M2(1000, 1000, CV_32F);
    tp0 = std::chrono::high_resolution_clock::now();
    test_2(M2);
    tp1 = std::chrono::high_resolution_clock::now();
    std::cout << "ptr = "
              << std::chrono::duration_cast<std::chrono::microseconds>(tp1-tp0).count()
              << std::endl;


    cv::Mat M3(1000, 1000, CV_32F);
    tp0 = std::chrono::high_resolution_clock::now();
    test_3(M3);
    tp1 = std::chrono::high_resolution_clock::now();
    std::cout << "data = "
              << std::chrono::duration_cast<std::chrono::microseconds>(tp1-tp0).count()
              << std::endl;


    cv::Mat M4(1000, 1000, CV_32F);
    tp0 = std::chrono::high_resolution_clock::now();
    test_4(M4);
    tp1 = std::chrono::high_resolution_clock::now();
    std::cout << "data_2 = "
              << std::chrono::duration_cast<std::chrono::microseconds>(tp1-tp0).count()
              << std::endl;
    return 0;
}
```


单位:微秒
|      | debug | release |
| ---- | ----- | ------- |
| at方法 | 5041 | 1359 |
| ptr方法 | 3730 | 1641 |
| data_1方法 | 7277 | 1803 |
| data_2方法 | 3359 | 1626 |

当假设数据是完全顺序存储的情况下, 可以使用第二种裸指针的方式, 但这是一种危险的方式, 会引入bug:
```c++
#include <iostream>
#include <opencv2/opencv.hpp>
#include <chrono>

void test_1(cv::Mat &M)
{
    for(int i=0; i<10; ++i)
    {
        for(int j=0; j<10; ++j)
            M.at<float>(i,j) = i;
    }
}

void test_4(cv::Mat &M)
{
    float * ptr = reinterpret_cast<float*>(M.data);
    for(int i=0; i<5; ++i)
    {
        for(int j=0; j<5; ++j) {
            //M.at<float>(i,j);
            //*reinterpret_cast<float*>(M.data + i*M.step[0]+j*M.step[1]) = 0;
            *ptr = 0;
            ++ptr;
        }
    }
}

int main(int argc, char * argv[])
{
    cv::Mat M1(10, 10, CV_32F);
    test_1(M1);
    cv::Mat M2 = M1.colRange(5,10).rowRange(0,5);
    std::cout << M2 << std::endl;
    test_4(M2);
    std::cout << M1 << std::endl;
    std::cout << M2 << std::endl;
    return 0;
}
```

输出:
```
[0, 0, 0, 0, 0;
 1, 1, 1, 1, 1;
 2, 2, 2, 2, 2;
 3, 3, 3, 3, 3;
 4, 4, 4, 4, 4]
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
 3, 3, 3, 3, 3, 3, 3, 3, 3, 3;
 4, 4, 4, 4, 4, 4, 4, 4, 4, 4;
 5, 5, 5, 5, 5, 5, 5, 5, 5, 5;
 6, 6, 6, 6, 6, 6, 6, 6, 6, 6;
 7, 7, 7, 7, 7, 7, 7, 7, 7, 7;
 8, 8, 8, 8, 8, 8, 8, 8, 8, 8;
 9, 9, 9, 9, 9, 9, 9, 9, 9, 9]
[0, 0, 0, 0, 0;
 0, 0, 0, 0, 0;
 0, 0, 0, 0, 0;
 3, 3, 3, 3, 3;
 4, 4, 4, 4, 4]
```

__总结: 使用at保证正确性, 且不影响程序性能.__

## Reference
[cv::Mat像素遍历方法比较](https://www.jianshu.com/p/fc2f247fc2c4)
[OpenCV中高效的像素遍历方法](https://cloud.tencent.com/developer/article/1457892)
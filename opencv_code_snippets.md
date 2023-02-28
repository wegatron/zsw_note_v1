---
tag: programming_language/c++
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
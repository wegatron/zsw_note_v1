---
tag: programming/cpp
---
# 并行计算
## Overview
根据粒度从大到小, 并行可分为:进程并发、线程并行、指令级并行、数据级并行. 
`并发`并不是真正意义上的并行, 不是真正意义上的同时进行，但又是客观存在同时进行两件事:
>并发 = 小明可以一边玩手机一边看电视。
但是在事实上，他的眼睛在看电视的时候不能看手机，他在看手机没法盯着电视屏幕。
他的眼睛飞快在两个屏幕上切换

`并行`是真正意义上的同时进行.
* 进程和线程的并行(真正意义上的并行), 通过超线程或多核的方式实现.
* 指令级并行通过指令流水实现.
* 数据级并行是粒度最低的, 单一指令运行多个操作数并行计算. CPU提供了可以一下子执行多个数据计算的指令, 如一条指令同时取很多操作数, 一条指令同时计算多个加和操作等.

## 数据级并行SIMD C++ Example
```c++
#include <iostream>
using namespace std;

#include <sys/time.h>
#include <cstdlib>
#include <cstdint>

#include <immintrin.h>

inline double timestamp() {
    struct timeval tp;
    gettimeofday(&tp, NULL);
    return double(tp.tv_sec) + tp.tv_usec / 1000000.;
}

int testSSE(const int32_t * ghs, const int32_t * lhs, size_t n) {
    int result[4] __attribute__((aligned(16))) = {0};
    __m128i vresult = _mm_set1_epi32(0);
    __m128i v1, v2, vmax;

    for (int k = 0; k < n; k += 4) {
        v1 = _mm_load_si128((__m128i *) & lhs[k]);
        v2 = _mm_load_si128((__m128i *) & ghs[k]);
        vmax = _mm_add_epi32(v1, v2);
        vresult = _mm_max_epi32(vresult, vmax);
    }
    _mm_store_si128((__m128i *) result, vresult);
    int mymax = result[0];
    for (int k = 1; k < 4; k++) {
        if (result[k] > mymax) {
            mymax = result[k];
        }
    }
    return mymax;
}

int testAVX(const int32_t * ghs, const int32_t * lhs, size_t n) {
    int result[8] __attribute__((aligned(32))) = {0};
    __m256i vresult = _mm256_set1_epi32(0);
    __m256i v1, v2, vmax;

    for (int k = 0; k < n; k += 8) {
        v1 = _mm256_load_si256((__m256i *) & ghs[k]);
        v2 = _mm256_load_si256((__m256i *) & lhs[k]);
        vmax = _mm256_add_epi32(v1, v2);
        vresult = _mm256_max_epi32(vresult, vmax);
    }
    _mm256_store_si256((__m256i *) result, vresult);
    int mymax = result[0];
    for (int k = 1; k < 8; k++) {
        if (result[k] > mymax) {
            mymax = result[k];
        }
    }
    return mymax;
}

int testNormal(const int32_t * ghs, const int32_t * lhs, size_t n) {
    int max = 0;
    int tempMax;
    for (int k = 0; k < n; k++) {
        tempMax = lhs[k] + ghs[k];
        if (max < tempMax) {
            max = tempMax;
        }
    }
    return max;
}

void alignTestSSE() {

    int n = 4096;
    int normalResult, sseResult, avxResult;
    int nofTestCases = 1000;
    double time, normalTime, sseTime, avxTime;

    int lhs[n] __attribute__ ((aligned(32)));
    int ghs[n] __attribute__ ((aligned(32)));

    for (int k = 0; k < n; k++) {
        lhs[k] = arc4random();
        ghs[k] = arc4random();
    }

    /* Warming UP */
    for (int k = 0; k < nofTestCases; k++) {
        normalResult = testNormal(lhs, ghs, n);
    }

    for (int k = 0; k < nofTestCases; k++) {
        sseResult = testSSE(lhs, ghs, n);
    }

    for (int k = 0; k < nofTestCases; k++) {
        avxResult = testAVX(lhs, ghs, n);
    }

    time = timestamp();
    for (int k = 0; k < nofTestCases; k++) {
        normalResult = testNormal(lhs, ghs, n);
    }
    normalTime = timestamp() - time;

    time = timestamp();
    for (int k = 0; k < nofTestCases; k++) {
        sseResult = testSSE(lhs, ghs, n);
    }
    sseTime = timestamp() - time;

    time = timestamp();
    for (int k = 0; k < nofTestCases; k++) {
        avxResult = testAVX(lhs, ghs, n);
    }
    avxTime = timestamp() - time;

    cout << "===========================" << endl;
    cout << "Normal took " << normalTime << " s" << endl;
    cout << "Normal Result: " << normalResult << endl;
    cout << "SSE took " << sseTime << " s" << endl;
    cout << "SSE Result: " << sseResult << endl;
    cout << "AVX took " << avxTime << " s" << endl;
    cout << "AVX Result: " << avxResult << endl;
    cout << "SpeedUP SSE= " << normalTime / sseTime << endl;
    cout << "SpeedUP AVX= " << normalTime / avxTime << endl;
    cout << "===========================" << endl;

}

int main()
{
    alignTestSSE();
    return 0;
}
```

Test:
```c++
$ clang++ -Wall -mavx2 -O3 -fno-vectorize SO_avx.cpp && ./a.out
===========================
Normal took 0.00324106 s
Normal Result: 2143749391
SSE took 0.000527859 s
SSE Result: 2143749391
AVX took 0.000221968 s
AVX Result: 2143749391
SpeedUP SSE= 6.14002
SpeedUP AVX= 14.6015
===========================
```

## Reference
[VAX Toturial](https://www.codeproject.com/Articles/874396/%2FArticles%2F874396%2FCrunching-Numbers-with-AVX-and-AVX)
[指令级并行，线程级并行，数据级并行区别](https://www.zhihu.com/question/21823699)
[常用SSE指令介绍](https://blog.csdn.net/gengshenghong/article/details/7010615)
[microsoft SSE document](https://docs.microsoft.com/en-us/previous-versions/visualstudio/visual-studio-2010/zzd50xxt(v%3dvs.100))
[SIMD各种指令集:MMX, SSE, AVX, 3D Now](https://blog.csdn.net/conowen/article/details/7255920)
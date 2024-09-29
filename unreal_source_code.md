# Unreal 源码笔记
## Shader Data Binding
先从一个GlobalShader来展示UE中一个渲染流程的实现:

shader:
```hlsl
// 输入的顶点数据和光照信息
struct FMaterialPixelParameters
{
    float3 WorldPosition;
    float3 Normal;
    float3 LightDir;
    float3 ViewDir;
};

float3 MainPS(FMaterialPixelParameters parameters)
{
    float3 albedo = float3(1.0, 0.0, 0.0); // 红色漫反射
    return SimpleBRDF(albedo, normalize(parameters.Normal),
        normalize(parameters.LightDir));
}
```

c++代码:
```c++
// 声明自定义Shader类
class FMySimpleBRDFShader : public FGlobalShader
{
    DECLARE_SHADER_TYPE(FMySimpleBRDFShader, Global);

public:
    DECLARE_SHADER_TYPE(FMySimpleBRDFShader, Global);

    // 声明要传递到Shader的参数
    BEGIN_SHADER_PARAMETER_STRUCT(FParameters, )
        SHADER_PARAMETER(FVector, LightDirection)  // 绑定光照方向
        SHADER_PARAMETER(FVector, ViewDirection)   // 绑定视角方向
        SHADER_PARAMETER(FMatrix, WorldMatrix)     // 绑定世界变换矩阵
    END_SHADER_PARAMETER_STRUCT()

    FMySimpleBRDFShader() {}
    FMySimpleBRDFShader(const ShaderMetaType::CompiledShaderInitializerType& Initializer)
        : FGlobalShader(Initializer)
    {
    }
};

// 定义Shader入口
IMPLEMENT_GLOBAL_SHADER(FMySimpleBRDFShader, "/Shaders/MySimpleBRDF.usf", "MainPS", SF_Pixel);
```

这里有两个问题:
1. 数据是如何绑定的? 在c++侧如何设置数据, 而引擎是如何将设置的数据与shader中的数据相互关联起来的?
2. 数据是如何对齐的?

### 数据绑定位置

```c++
// file RenderCore/Public/GlobalShader.h
class FGlobalShader : public FShader
{
public:
...
template<typename TViewUniformShaderParameters>
inline void SetParameters(FRHIBatchedShaderParameters& BatchedParameters,
    FRHIUniformBuffer* ViewUniformBuffer)
{
    // 这里根据TViewUniformShaderParameters的meta信息, 找到与shader对应的Uniform Buffer
    // 从而将ViewUniformBuffer设置到对应的solot上(将绑定信息加入到BatchedParameters)
    const auto& ViewUniformBufferParameter = static_cast<const FShaderUniformBufferParameter&>(
        GetUniformBufferParameter<TViewUniformShaderParameters>());
    SetUniformBufferParameter(BatchedParameters, ViewUniformBufferParameter, ViewUniformBuffer);
}
};

// file RenderCore/public/Shader.h
template<typename UniformBufferStructType>
FORCEINLINE_DEBUGGABLE const TShaderUniformBufferParameter<UniformBufferStructType>& 
    GetUniformBufferParameter() const
{
    const FShaderUniformBufferParameter& FoundParameter = GetUniformBufferParameter
        (UniformBufferStructType::FTypeInfo::GetStructMetadata());
    return static_cast<const TShaderUniformBufferParameter<UniformBufferStructType>&>(FoundParameter);
}
```

查看UE源码`Engine/Source/Developer/Windows/ShaderFormatD3D/Private/`, 以及
`Engine/Source/Developer/VulkanShaderFormat/Private/VulkanShaderCompiler.cpp`,
发现也没有对binding point进行重排(使用DXC编译出的spirv就好了).
会解析出spirv中的资源`SpirvShaderCompilerSerializedOutput::FShaderResourceTable`.


### 数据对齐

数据按照std140的方式对齐(各个图形API的兼容性更好, 读取效率更高) 

```c++
BEGIN_SHADER_PARAMETER_STRUCT(FMyShaderParameters, )
    SHADER_PARAMETER(float, MyScalar)
    SHADER_PARAMETER(FVector3f, MyVector3)
    SHADER_PARAMETER(float, MyScalar2)
    SHADER_PARAMETER_TEXTURE(Texture2D, SourceTexture)
    SHADER_PARAMETER_SAMPLER(SamplerState, SourceTextureSampler)
END_SHADER_PARAMETER_STRUCT()
// 展开后
class  FMyShaderParameters { public: FMyShaderParameters () {} struct FTypeInfo { static constexpr int32 NumRows = 1; static constexpr int32 NumColumns = 1; static constexpr int32 NumElements = 0; static constexpr int32 Alignment = 16; static constexpr bool bIsStoredInConstantBuffer = true; static constexpr const ANSICHAR* const FileName = "Unknown"; static constexpr int32 FileLine = __builtin_LINE(); using TAlignedType = FMyShaderParameters; static const FShaderParametersMetadata* GetStructMetadata() { static FShaderParametersMetadata StaticStructMetadata( FShaderParametersMetadata::EUseCase::ShaderParameterStruct, EUniformBufferBindingFlags::Shader, L"FMyShaderParameters", L"FMyShaderParameters", nullptr, nullptr, FTypeInfo::FileName, FTypeInfo::FileLine, sizeof(FMyShaderParameters), FMyShaderParameters::zzGetMembers()); return &StaticStructMetadata; } }; static FUniformBufferRHIRef CreateUniformBuffer(const FMyShaderParameters& InContents, EUniformBufferUsage InUsage) { return nullptr; } private: typedef FMyShaderParameters zzTThisStruct; struct zzFirstMemberId { enum { HasDeclaredResource = 0 }; }; typedef void* zzFuncPtr; typedef zzFuncPtr(*zzMemberFunc)(zzFirstMemberId, TArray<FShaderParametersMetadata::FMember>*); static zzFuncPtr zzAppendMemberGetPrev(zzFirstMemberId, TArray<FShaderParametersMetadata::FMember>*) { return nullptr; } typedef zzFirstMemberId
    zzMemberIdMyScalar; public: TShaderParameterTypeInfo<float>::TAlignedType MyScalar ; static_assert(TShaderParameterTypeInfo<float>::BaseType != UBMT_INVALID, "Invalid type " "float" " of member " "MyScalar" "."); private: struct zzNextMemberIdMyScalar { enum { HasDeclaredResource = zzMemberIdMyScalar::HasDeclaredResource || !TShaderParameterTypeInfo<float>::bIsStoredInConstantBuffer }; }; static zzFuncPtr zzAppendMemberGetPrev(zzNextMemberIdMyScalar, TArray<FShaderParametersMetadata::FMember>* Members) { static_assert(TShaderParameterTypeInfo<float>::bIsStoredInConstantBuffer || TIsArrayOrRefOfTypeByPredicate<decltype(L""), TIsCharEncodingCompatibleWithTCHAR>::Value, "No shader type for " "MyScalar" "."); static_assert( (((::size_t)&reinterpret_cast<char const volatile&>((((zzTThisStruct*)0)->MyScalar))) & (TShaderParameterTypeInfo<float>::Alignment - 1)) == 0, "Misaligned uniform buffer struct member " "MyScalar" "."); Members->Add(FShaderParametersMetadata::FMember( L"MyScalar", (const TCHAR*)L"", 34, ((::size_t)&reinterpret_cast<char const volatile&>((((zzTThisStruct*)0)->MyScalar))), EUniformBufferBaseType(TShaderParameterTypeInfo<float>::BaseType), EShaderPrecisionModifier::Float, TShaderParameterTypeInfo<float>::NumRows, TShaderParameterTypeInfo<float>::NumColumns, TShaderParameterTypeInfo<float>::NumElements, TShaderParameterTypeInfo<float>::GetStructMetadata() )); zzFuncPtr(*PrevFunc)(zzMemberIdMyScalar, TArray<FShaderParametersMetadata::FMember>*); PrevFunc = zzAppendMemberGetPrev; return (zzFuncPtr)PrevFunc; } typedef zzNextMemberIdMyScalar
    zzMemberIdMyVector3; public: TShaderParameterTypeInfo<FVector3f>::TAlignedType MyVector3 ; static_assert(TShaderParameterTypeInfo<FVector3f>::BaseType != UBMT_INVALID, "Invalid type " "FVector3f" " of member " "MyVector3" "."); private: struct zzNextMemberIdMyVector3 { enum { HasDeclaredResource = zzMemberIdMyVector3::HasDeclaredResource || !TShaderParameterTypeInfo<FVector3f>::bIsStoredInConstantBuffer }; }; static zzFuncPtr zzAppendMemberGetPrev(zzNextMemberIdMyVector3, TArray<FShaderParametersMetadata::FMember>* Members) { static_assert(TShaderParameterTypeInfo<FVector3f>::bIsStoredInConstantBuffer || TIsArrayOrRefOfTypeByPredicate<decltype(L""), TIsCharEncodingCompatibleWithTCHAR>::Value, "No shader type for " "MyVector3" "."); static_assert( (((::size_t)&reinterpret_cast<char const volatile&>((((zzTThisStruct*)0)->MyVector3))) & (TShaderParameterTypeInfo<FVector3f>::Alignment - 1)) == 0, "Misaligned uniform buffer struct member " "MyVector3" "."); Members->Add(FShaderParametersMetadata::FMember( L"MyVector3", (const TCHAR*)L"", 35, ((::size_t)&reinterpret_cast<char const volatile&>((((zzTThisStruct*)0)->MyVector3))), EUniformBufferBaseType(TShaderParameterTypeInfo<FVector3f>::BaseType), EShaderPrecisionModifier::Float, TShaderParameterTypeInfo<FVector3f>::NumRows, TShaderParameterTypeInfo<FVector3f>::NumColumns, TShaderParameterTypeInfo<FVector3f>::NumElements, TShaderParameterTypeInfo<FVector3f>::GetStructMetadata() )); zzFuncPtr(*PrevFunc)(zzMemberIdMyVector3, TArray<FShaderParametersMetadata::FMember>*); PrevFunc = zzAppendMemberGetPrev; return (zzFuncPtr)PrevFunc; } typedef zzNextMemberIdMyVector3
    zzMemberIdMyScalar2; public: TShaderParameterTypeInfo<float>::TAlignedType MyScalar2 ; static_assert(TShaderParameterTypeInfo<float>::BaseType != UBMT_INVALID, "Invalid type " "float" " of member " "MyScalar2" "."); private: struct zzNextMemberIdMyScalar2 { enum { HasDeclaredResource = zzMemberIdMyScalar2::HasDeclaredResource || !TShaderParameterTypeInfo<float>::bIsStoredInConstantBuffer }; }; static zzFuncPtr zzAppendMemberGetPrev(zzNextMemberIdMyScalar2, TArray<FShaderParametersMetadata::FMember>* Members) { static_assert(TShaderParameterTypeInfo<float>::bIsStoredInConstantBuffer || TIsArrayOrRefOfTypeByPredicate<decltype(L""), TIsCharEncodingCompatibleWithTCHAR>::Value, "No shader type for " "MyScalar2" "."); static_assert( (((::size_t)&reinterpret_cast<char const volatile&>((((zzTThisStruct*)0)->MyScalar2))) & (TShaderParameterTypeInfo<float>::Alignment - 1)) == 0, "Misaligned uniform buffer struct member " "MyScalar2" "."); Members->Add(FShaderParametersMetadata::FMember( L"MyScalar2", (const TCHAR*)L"", 36, ((::size_t)&reinterpret_cast<char const volatile&>((((zzTThisStruct*)0)->MyScalar2))), EUniformBufferBaseType(TShaderParameterTypeInfo<float>::BaseType), EShaderPrecisionModifier::Float, TShaderParameterTypeInfo<float>::NumRows, TShaderParameterTypeInfo<float>::NumColumns, TShaderParameterTypeInfo<float>::NumElements, TShaderParameterTypeInfo<float>::GetStructMetadata() )); zzFuncPtr(*PrevFunc)(zzMemberIdMyScalar2, TArray<FShaderParametersMetadata::FMember>*); PrevFunc = zzAppendMemberGetPrev; return (zzFuncPtr)PrevFunc; } typedef zzNextMemberIdMyScalar2
    zzMemberIdSourceTexture; public: TShaderResourceParameterTypeInfo<FRHITexture*>::TAlignedType SourceTexture = nullptr; static_assert(UBMT_TEXTURE != UBMT_INVALID, "Invalid type " "FRHITexture*" " of member " "SourceTexture" "."); private: struct zzNextMemberIdSourceTexture { enum { HasDeclaredResource = zzMemberIdSourceTexture::HasDeclaredResource || !TShaderResourceParameterTypeInfo<FRHITexture*>::bIsStoredInConstantBuffer }; }; static zzFuncPtr zzAppendMemberGetPrev(zzNextMemberIdSourceTexture, TArray<FShaderParametersMetadata::FMember>* Members) { static_assert(TShaderResourceParameterTypeInfo<FRHITexture*>::bIsStoredInConstantBuffer || TIsArrayOrRefOfTypeByPredicate<decltype(L"Texture2D"), TIsCharEncodingCompatibleWithTCHAR>::Value, "No shader type for " "SourceTexture" "."); static_assert( (((::size_t)&reinterpret_cast<char const volatile&>((((zzTThisStruct*)0)->SourceTexture))) & (TShaderResourceParameterTypeInfo<FRHITexture*>::Alignment - 1)) == 0, "Misaligned uniform buffer struct member " "SourceTexture" "."); Members->Add(FShaderParametersMetadata::FMember( L"SourceTexture", (const TCHAR*)L"Texture2D", 37, ((::size_t)&reinterpret_cast<char const volatile&>((((zzTThisStruct*)0)->SourceTexture))), EUniformBufferBaseType(UBMT_TEXTURE), EShaderPrecisionModifier::Float, TShaderResourceParameterTypeInfo<FRHITexture*>::NumRows, TShaderResourceParameterTypeInfo<FRHITexture*>::NumColumns, TShaderResourceParameterTypeInfo<FRHITexture*>::NumElements, TShaderResourceParameterTypeInfo<FRHITexture*>::GetStructMetadata() )); zzFuncPtr(*PrevFunc)(zzMemberIdSourceTexture, TArray<FShaderParametersMetadata::FMember>*); PrevFunc = zzAppendMemberGetPrev; return (zzFuncPtr)PrevFunc; } typedef zzNextMemberIdSourceTexture
    zzMemberIdSourceTextureSampler; public: TShaderResourceParameterTypeInfo<FRHISamplerState*>::TAlignedType SourceTextureSampler = nullptr; static_assert(UBMT_SAMPLER != UBMT_INVALID, "Invalid type " "FRHISamplerState*" " of member " "SourceTextureSampler" "."); private: struct zzNextMemberIdSourceTextureSampler { enum { HasDeclaredResource = zzMemberIdSourceTextureSampler::HasDeclaredResource || !TShaderResourceParameterTypeInfo<FRHISamplerState*>::bIsStoredInConstantBuffer }; }; static zzFuncPtr zzAppendMemberGetPrev(zzNextMemberIdSourceTextureSampler, TArray<FShaderParametersMetadata::FMember>* Members) { static_assert(TShaderResourceParameterTypeInfo<FRHISamplerState*>::bIsStoredInConstantBuffer || TIsArrayOrRefOfTypeByPredicate<decltype(L"SamplerState"), TIsCharEncodingCompatibleWithTCHAR>::Value, "No shader type for " "SourceTextureSampler" "."); static_assert( (((::size_t)&reinterpret_cast<char const volatile&>((((zzTThisStruct*)0)->SourceTextureSampler))) & (TShaderResourceParameterTypeInfo<FRHISamplerState*>::Alignment - 1)) == 0, "Misaligned uniform buffer struct member " "SourceTextureSampler" "."); Members->Add(FShaderParametersMetadata::FMember( L"SourceTextureSampler", (const TCHAR*)L"SamplerState", 38, ((::size_t)&reinterpret_cast<char const volatile&>((((zzTThisStruct*)0)->SourceTextureSampler))), EUniformBufferBaseType(UBMT_SAMPLER), EShaderPrecisionModifier::Float, TShaderResourceParameterTypeInfo<FRHISamplerState*>::NumRows, TShaderResourceParameterTypeInfo<FRHISamplerState*>::NumColumns, TShaderResourceParameterTypeInfo<FRHISamplerState*>::NumElements, TShaderResourceParameterTypeInfo<FRHISamplerState*>::GetStructMetadata() )); zzFuncPtr(*PrevFunc)(zzMemberIdSourceTextureSampler, TArray<FShaderParametersMetadata::FMember>*); PrevFunc = zzAppendMemberGetPrev; return (zzFuncPtr)PrevFunc; } typedef zzNextMemberIdSourceTextureSampler	
zzLastMemberId; public: static TArray<FShaderParametersMetadata::FMember> zzGetMembers() { TArray<FShaderParametersMetadata::FMember> Members; zzFuncPtr(*LastFunc)(zzLastMemberId, TArray<FShaderParametersMetadata::FMember>*); LastFunc = zzAppendMemberGetPrev; zzFuncPtr Ptr = (zzFuncPtr)LastFunc; do { Ptr = reinterpret_cast<zzMemberFunc>(Ptr)(zzFirstMemberId(), &Members); } while (Ptr); Algo::Reverse(Members); return Members; } } ;
```

对于`MyVector3`, 可以使用align as这种方式来设置头部对齐, 再根据FVector3f的结构体自动添加padding.
另外相关的信息也会通过`Members->Add`添加到`Members`数组中去.

自己实现的话, 可以把Texture/TextureSampler拆分开, 那么前部的数据, 是否可以直接映射到UBO中?


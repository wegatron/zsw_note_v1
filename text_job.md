---
tag: projects
---
## 单字底图
1. AE的设计
    参考自适应底图的设计, 每个单字加一个形状图层, 用来表示文字的区域, 但不需要layout标记来表示拉伸的方式.
    注: 利用第一个字的shape layer来计算背景图的缩放, 其他shaper layer的目的是为了计算底图与文字的位置对齐.    

2. `atomae_textfx.js` line 1635:
    ```javascript
    // 添加bbt=3的逻辑
    if (layerMarker.byo_bg_type !== ATOM.ByoBgTypeNone) {
            animateText.textByoBackground = new ATOM.ByoBackground();
            var imageSet = [];
            var findRes = ATOM.findAutoBgLayer(layerVar);
            if (findRes.autobg != undefined && findRes.shapelyr != undefined) {
                ATOM.makeLayerTexImage(findRes.autobg, drawDesc, imageSet, undefined);
                ATOM.exportByoParts(findRes.shapelyr, findRes.autobg, animateText.textByoBackground);
            }
    ```

3. 验证script改完之后, 原自适应底图是否正常.

4. 修改解析代码
    ```c++
    struct QTextByoBackImage{
        MBool applyLines;
        MBool closePath;
        MFloat  boardScale;
        //MRECTF  textRect;
        //MRECTF  byoRect;
        Array<MRECTF>   textRect; //!< 存放单字大小
        Array<MRECTF>   byoRects; //!< 存放单字底图大小
        Array<QTextByoSubRegion> regions;
        std::shared_ptr<BitmapRGBA8> imageRef;
    };
    QVET_ERR_TA_PARSER_BASE
    CVETextAnimationParamParser::ParseTextByoBg()
    {
        // if (m_pMarkUp->FindElem("textRect")) {
        //     GET_OPTIONAL_DOUBLE_ATTR("left", 0, bgParam.textRect.left);
        //     GET_OPTIONAL_DOUBLE_ATTR("top", 0, bgParam.textRect.top);
        //     GET_OPTIONAL_DOUBLE_ATTR("right", 0, bgParam.textRect.right);
        //     GET_OPTIONAL_DOUBLE_ATTR("bottom", 0, bgParam.textRect.bottom);
        // }
        // if (m_pMarkUp->FindElem("layerRect")) {
        //     GET_OPTIONAL_DOUBLE_ATTR("left", 0, bgParam.byoRect.left);
        //     GET_OPTIONAL_DOUBLE_ATTR("top", 0, bgParam.byoRect.top);
        //     GET_OPTIONAL_DOUBLE_ATTR("right", 0, bgParam.byoRect.right);
        //     GET_OPTIONAL_DOUBLE_ATTR("bottom", 0, bgParam.byoRect.bottom);
        // }
    }
    ```

    背景图片的读取:
    ```c++
    CQVETTextRenderFilterOutputStreamImpl::Load(MVoid* pURL)
    {
        //if(mpTextParser->getImageSource()){
        //    mpTextParser->getImageSource()->pkgPath = m_szTemplateFile;
        //    LoadImageToTexture(*mpTextParser->getImageSource(), hSessionCtx);
        //}

        if(!mpTextParser->getImageSource().empty()){
            for (auto& img_src : mpTextParser->getImageSource())
            {
                img_src.pkgPath = m_szTemplateFile;
                LoadImageToTexture(img_src, hSessionCtx);
            }
        }        
    }
    ```

    背景图片的合并:
    ```c++
    
    ```

    sprite设置, 参考*获取每个glyph在视图中的位置信息:
    ```c++
    CQVETTextRenderFilterOutputStreamImpl::JumpIconAnimation() {
        // 获取每个glyph以及每行的信息
        Array<MRECTF> lines(lenCnt);
        Array<QEVTTextRange> lineRanges(lenCnt);
        Array<Array<MRECTF>> linesglyphs(lenCnt);
        Array<Array<MRECTF>> linesDescentglyphs(lenCnt);
        for (MInt32 i = 0; i < lenCnt; i++) {
            m_hTextDrawer->getTextGlyphsOfLine(i, lineRanges[i], linesglyphs[i]);
            m_hTextDrawer->getTextGlyphsOfLine(i, lineRanges[i], linesDescentglyphs[i], MFalse);
            for (int j = 0; j < linesDescentglyphs[i].size(); j++) linesglyphs[i][j].bottom = linesDescentglyphs[i][j].bottom;
            m_hTextDrawer->getTextLines(i, lines[i]);
            glyphSum += linesglyphs[i].size();
        }
    }
    ```

5. 渲染支持
    ```c++
    MRESULT CQVETTextRenderFilterOutputStreamImpl::DrawByoBgSprite(MFloat alpha)
    {
        // 为每个字设置一个背景, 并设置背景的textcoord
        // 多图背景支持
    }
    ```

    思路: 做一次预渲染, 将背景整合到一张纹理上.

    question:
    * 背景的绘制流程
        ```c++
        CQVETTextRenderFilterOutputStreamImpl::RenderBackItem {
            InitUpdateByoRender() {
                bindLinearTex(m_hByoBgTexture, m_pByoBgSpriteAtlas, 0); // 绑定纹理, sprite与背景关联
            }
            DrawByoBgSprite() { // sprite textcoord设置并绘制
            }
        }
        ```
    
    * 如何预绘制生成一个纹理
        目标输出类型: `CQVETTexture* m_hByoBgTexture;`
        参考文字纹理合并绘制
        ```c++
        struct TextureCache{
            MBool chnnels[4];
            Sptr<TextureWP> textureRef;
            TextureCache(){
                textureRef = nullptr;
                memset(chnnels, 0, sizeof(MBool)*4);
            }
        };        
        CQEVTTextRenderCommon::prepareTexture()
        {
            TextureCache * dstTexture;
            mpMerger = std::make_shared<RenderWp>(pContext);
            CHECK_QREPORT_RET(mpMerger->prepare(config));
            mpMerger->setOneZeroBlendMode();
            CHECK_QREPORT_RET(mpMerger->renderTex(*dstTexture.textureRef/*TextureWp*/,*tempTex));
        }

        // 使用
        {
            RenderWp::bindTexture(const TextureWP& tex, int index) {
                QVETGLsamplerSource sampleSource = { 0 };
                sampleSource.pTexture = (CQVETTexture*)tex.mTexHandle;
                sampleSource.texType = QVET_GL_TEXTURE_TYPE_IAMGE_2D;
                sampleSource.minFilter = sampleSource.magFilter = QVET_GL_SAMPLER_FILTER_LINEAR;
                return mpRender->bindSamplerSource(index, &sampleSource);
            }
        }
        ```

        将多张背景图片合并到一张, 以期减少text数量.
        ```c++
        // 按行存储
        class Bitmap
        {
            // 创建
            Bitmap(MUInt32 w,MUInt32 h);

            // 获取宽和高
            MUInt32 width() const { return _width; }
            MUInt32 height() const { return _height; }
        };
        typedef Bitmap<MByte,4> BitmapRGBA8;
        ```
6.  文字排版调整
    诺底图只有一个, 则相邻两个文字中心之间的距离等于底图的宽度; 若底图多余一个则相邻两个文字中心之间的距离等于textRect_0与textRect_1之间的中心距离.

## 文字字间距&行间距问题
__基本原理__: 除了tracking, 其他均为像素点的值(相对于frameHeight). tracking则时相对于font size.
* graphPointSize(字号): 定义了文字大小.
    AE导出为: fontSize/layerHeight
    引擎库中使用: 根据当前frameSize做一个缩放  m_Settings.fGraphPointSize * frameHeight
* Leading(行间距): 定义了两行之间基线的距离的像素值.
    AE导出为: leading/layerHeight
    引擎库中使用: 根据当前的frameSize做一个缩放  leading * viewportHeight
* Tracking(字间距): 定义了两个字符之间的空隙的像素值.
    AE导出为: tracking
    引擎库中使用: tracking * mTextContext.pointSize * 0.001


## Text occlusion
在更新时将深度图数据获取到并传递到render中：
```c++
MRESULT CQVETTextRenderFilterOutputStreamImpl::UpdateFrameBuffer()
{
    // ...
    auto depth = pTrack->GetParentTrack()->GetDepth();
    m_hTextDrawer->setDepth(depth);
    // ...
}
MVoid CQEVTTextRenderCommon::setDepth(void *depth)
{
    mpDepth = depth;
}
```

由于纹理不支持float32, 所以研究了render engine的[纹理管理使用机制](xy_render_engine.md).
故而, 我应该只需要对texture的创建进行扩展, 使其支持float32即可, 对其他部分不影响.

得到shader program:
```c++
GLint	QGTSpriteRender::createProgram(void** ppProgram, QGTprogramDesc* pDesc)
{
	QGTshadeProgram* pProgram = (QGTshadeProgram*)MMemAlloc(MNull,sizeof(QGTshadeProgram));
	if (NULL == pProgram)
		return GL_OUT_OF_MEMORY;
	MMemSet(pProgram, 0, sizeof(QGTshadeProgram));
	*ppProgram = pProgram;

	GLuint program = glCreateProgram(); // !!!!!!!!!!
```

将深度图作为纹理添加到绘制中:
```c++
CQEVTTextRenderCommon::renderTo()
{

    if(hasText && mpTextRenders[0]){
        Array<Sptr<TextureWP>> allTexs; // add depth map as texture
        // ...
        for (int i = layerCnt - 1; i >= 0; i--) {
            CHECK_QREPORT_RET(mpTextRenders[i]->bindTextures(allTexs));
        }   
    }
}
```

```c++
MHandle CQVETGLESTexture::CreateTextureWithImage(MHandle hGLContext,
									MBITMAP* pImage, MDWord dwColorSpace)

TextureWP::TextureWP(void* pContext, const BitmapRGBA8& source) {
    if(!source.isEmpty()){
        MBITMAP tempMap = ToMBITMAP(source);
        mTexHandle = CQVETGLTextureUtils::CreateTextureWithImage(pContext, &tempMap, MV2_COLOR_SPACE_RGB32);
    }
}
```

修改fragment shader实现occlusion:
```c++
CQEVTTextRenderCommon::prepareRender()
{
    makeShaderDesc(mTextStyleAnimate, mTextShader)
    {
        // 在此处更新shader
        static const char* fragShader_derivatives_enable = {...;
        static const char* fragShader_main = "(";

        auto& samplers = shaderConfig.samplerNames;
        samplers.clear();
        samplers.push_back("u_sampler0");
    }
}
```


method by jinkuang:
```c++
#if defined(__IPHONE__ZZZ)
            auto depthMap = *reinterpret_cast<CVPixelBufferRef*>(mpDepth);
            CVPixelBufferLockBaseAddress(depthMap, CVPixelBufferLockFlags(0));
            auto width = CVPixelBufferGetWidth(depthMap);
            auto height = CVPixelBufferGetHeight(depthMap);
            auto yBaseAddress = CVPixelBufferGetBaseAddressOfPlane(depthMap, 0);
            auto yBytesPerRow = CVPixelBufferGetBytesPerRowOfPlane(depthMap, 0);
            auto yLength = yBytesPerRow * height;
            void* pTexData = CVPixelBufferGetBaseAddress(depthMap);
            
            static GLuint texId = 0;
            if (0 == texId) {
                glGenTextures(1, &texId);
                glBindTexture(GL_TEXTURE_2D, texId);
                glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
                glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
            }
            glBindTexture(GL_TEXTURE_2D, texId);
            glTexImage2D(GL_TEXTURE_2D, 0, GL_DEPTH_COMPONENT, width, height, 0, GL_DEPTH_COMPONENT, GL_FLOAT, pTexData);
            
//            CVOpenGLESTextureCacheRef
//            CVOpenGLESTextureRef
//            CVMetalTextureCacheRef
//            CVMetalTextureRef
            
            // copy and bind data to texture
            std::vector<float> depth_data(yLength/4+1); // add extra 1 float for safty
            MMemCpy(depth_data.data(), yBaseAddress, yLength);
            CVPixelBufferUnlockBaseAddress(depthMap, CVPixelBufferLockFlags(0));
            int texture_id =allTexs.size();
            
            // create texture and bind texture
            //glGenTextures();
            
#endif
```
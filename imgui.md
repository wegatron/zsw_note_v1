# IMGUI (Immediate Mode GUI) 
每帧的UI元素都动态生成, 然后可以获取该ui元素的状态, 并生成相应的渲染资产(vertex data, command list等). 而真正的渲染命令, 需要在自己的程序中进行提交.

## 与vulkan的集成
在render system中设置一个UI Pass. 在启动时, 先进行UI Pass的初始化, 再进行UI元素的创建. 在world绘制完成后再绘制UI Pass.

```c++
// setup Dear ImGui context
IMGUI_CHECKVERSION();
ImGui::CreateContext();
ImGuiIO& io = ImGui::GetIO();
io.ConfigFlags |= ImGuiConfigFlags_NavEnableKeyboard;
io.ConfigFlags |= ImGuiConfigFlags_NavEnableGamepad;
io.ConfigFlags |= ImGuiConfigFlags_DockingEnable;
io.IniFilename = nullptr;

// setup Dear ImGui style
ImGui::StyleColorsDark();
//ImGui::StyleColorsLight();

ImGui_ImplGlfw_InitForVulkan(g_engine.windowSystem()->getWindow(), true);

ImGui_ImplVulkan_InitInfo init_info = {};
init_info.Instance = driver->getInstance();
init_info.PhysicalDevice = driver->getPhysicalDevice();
init_info.Device = driver->getDevice();
auto queue = driver->getGraphicsQueue();
init_info.QueueFamily = queue->getFamilyIndex();
init_info.Queue = queue->getHandle();
init_info.PipelineCache = ctx.resource_cache->getPipelineCache();
init_info.DescriptorPool = ctx.descriptor_pool->getHandle();
init_info.Allocator = nullptr;
init_info.MinImageCount = frames_data.size();
init_info.ImageCount = frames_data.size();
init_info.CheckVkResultFn = check_vk_result;

// 若要与volk一起使用的话, 参考: https://zhuanlan.zhihu.com/p/634912614
ImGui_ImplVulkan_LoadFunctions(
      [](const char *function_name, void *vulkan_instance) {
        auto instance_ptr = gdriver->getInstancePtr();
        return vkGetInstanceProcAddr(*instance_ptr, function_name);
      },
      reinterpret_cast<void *>(instance_ptr));
bool is_success = ImGui_ImplVulkan_Init(&init_info, render_pass_); // render_pass_
ASSERT(is_success, "failed to init imgui");

// 加载各种font
// add consola font
const float k_base_font_size = 14.0f;
const float k_icon_font_size = k_base_font_size * 0.8f;
const auto& fs = g_engine.fileSystem();
io.Fonts->AddFontFromFileTTF(fs->absolute("asset/engine/font/consola.ttf").c_str(), k_base_font_size);

// add icon font
ImFontConfig icons_config;
icons_config.MergeMode = true;
icons_config.PixelSnapH = true;
icons_config.GlyphMinAdvanceX = k_icon_font_size;
static const ImWchar icons_ranges[] = { ICON_MIN_FA, ICON_MAX_16_FA, 0 };
io.Fonts->AddFontFromFileTTF(fs->absolute("asset/engine/font/fa-solid-900.ttf").c_str(), k_icon_font_size, &icons_config, icons_ranges);
// ...
VkCommandBuffer command_buffer = VulkanUtil::beginInstantCommands();
ImGui_ImplVulkan_CreateFontsTexture(command_buffer);
VulkanUtil::endInstantCommands(command_buffer);
ImGui_ImplVulkan_DestroyFontUploadObjects();

// create frame buffer
```

## UI元素与布局控制
### UI元素
IM GUI以窗口为完整的单位, 在窗口中添加各种UI元素——参考[imgui.h](https://github.com/ocornut/imgui/blob/master/imgui.h)
(Arrow/Image/Radio)buttons、(Combo/Check)box、ProgressBar、Drag(Float/Int)、Slider、Input(Text/Float/Int)、ColorEditor、TreeNode、PlotLines、MenuBar、Table...

### 布局控制
使用docking分支([介绍](https://github.com/ocornut/imgui/wiki/Docking)), 支持UI元素停靠的窗口边缘. 在一个小的窗口内部, 通过布局命令来设置UI元素的布局位置.

```c++
// title_buf是窗口的名字(全局唯一), 可以用'##'或'###'来给窗口附加一个隐藏的id
// p_open是一个bool 地址, 表示是否要再窗口右上角添加关闭按钮
//    static bool open = true;
//    if(!open) return;
//    if (!ImGui::Begin(m_title_buf, &open))
//    {
//        ImGui::End();
//        return;
//    }
// 返回bool, 表示这个窗口是否被打开
ImGui::Begin(title_buf, p_open, window_flags)
// ...

// 位置控制
ImGui::SameLine();
ImGui::SetCursorPosX(region_w * 0.5f - kButtonSize.x * 1.5f - spacing.x);
ImGui::End();
```

## UI操作和响应设置

推荐使用eventpp来进行UI事件的传递.

```c++
if(ImGui::Button(play_icon_text, kButtonSize))
{
    // button被按下, 
}

// 通过给指针, 来获取UI值
ImGui::InputInt(label.c_str(), &variant.get_value<int>());
```
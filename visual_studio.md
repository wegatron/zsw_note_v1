---
tag: programming_language/c++
---
Visual studio

## console 和 window subsystem切换

![switch subsystem](rc/visualstudio_subsystem_switch.png)

winmain和main的切换:

```c++
int main() { 
	return WinMain(GetModuleHandle(NULL), NULL, GetCommandLine(), SW_SHOW); 
} 
```


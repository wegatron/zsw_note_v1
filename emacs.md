---
tag: programming/tools
---
# emacs 配置
尽量适应其原配置, 提高应对环境变化的能力.
* 背景颜色的配置
    ```
    M-x set-background-color #E3EDCD
    ```

* 显示行号/ToolBar等
Options--->Hide/Show

* windows 中文卡顿问题
    ```
    (setq inhibit-compacting-font-caches t)
    ```

* 设置字体
在Emacs中, 通过菜单Options –> Set Default Font, 设置好你喜欢的字体.

* 清除eshell buffer
    ```
    clear t
    ```


* conect elpa on start
```
;(package-refresh-contents)
```

* chinese input
.bashrc中加入

```
LC_CTYPE='zh_CN.UTF-8'

alias emacs='env LC_CTYPE=zh_CN.UTF-8 emacs'
```

* set c++ code style
```
M-x set-style
cc-mode
```

* 环境变量设置
init.el


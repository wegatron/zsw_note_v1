---
tag: tools
---
## sed 命令
sed 是一种在线编辑器，它一次处理一行内容.

```bash
sed [options] commands [inputfile...]
```

__options__

| 选项  | 作用 |
|------|------|
| -n | 使用安静(silent)模式。在一般 sed 的用法中，所有来自 STDIN 的数据一般都会被列出到终端上。但如果加上 -n 参数后，则只有经过sed 特殊处理的那一行(或者动作)才会被列出来 |
| -i  | 直接修改读取的文件内容, 而不是输出到终端 |
| -r | sed 的动作支持的是延伸型正规表示法的语法。(默认是基础正规表示法语法) |


__commands__
command 字符串编辑命令的组合.
| 选项  | 操作 |
|------|------|
| s | 替换(一般使用最多) |
| a | 新增 |
| d | 删除 |

__examples__

```bash
# 将当前目录下, 除了.git中的所有文件中的 TARGET_OS_OSX修改为TARGET_OS_MACCATALYST
# 这里g表示全部替换, 若是没有g, 则只替换一个/行
grep -rl "TARGET_OS_OSX" ./ --exclude-dir=.git | \
xargs sed -i "" 's/TARGET_OS_OSX/TARGET_OS_MACCATALYST/g'

grep -rl "SDKROOT = macosx" ./ --exclude-dir=.git | \
xargs sed -i "" 's/SDKROOT = macosx/SDKROOT = iphoneos/g'
```

## 不同文件多次执行
```bash
find ./ -name=project.pbxproj -exec git stage {} \;
```

## 同步文件内容
```bash
# -v verbose
# -r --recursive 对子目录以递归模式处理
# -u --update 仅仅进行更新, 也就是跳过所有已经存在于DST, 并且文件时间晚于要备份的文件, 不覆盖更新的文件.
rsync -vru [src] [dst]
```

gdb print long string
```bash
call (void)puts(stage._code)
```
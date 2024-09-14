---
tag: programming/tools
---
## git 分支操作
```bash
git branch --remote # 显示所有远程分支
git switch -c [local_branch_name] origin/test # 切换出远程分支
git checkout [local_branch_name]
git branch -d [local_branch_name]
git push origin --delete [remote_branch_name]
```

## git 合并

```bash
# [A, B] 包含A
git cherry-pick A^..B

# (A, B] 不包含A
git cherry-pick A..B

# A和B
git cherry-pick A B
```

## git remote
远程处理
```bash
# 查看远程信息
git remote -v

# 删除远程
git remote remove [name]

# 添加远程
git remote add [name] [url]
```

## 创建本地远程仓库

```bash
git init --bare e:/tmp2/remote.git
git clone e:/tmp2/remote.git local
git clone user@server[port]:/path/to/repo/name_to_repo.git
```

worktree
```bash
mkdir [src_dir]
cd [src_dir]
git clone --bare [url] .bare
echo "gitdir: ./.bare" > .git
git worktree add main
```

## ssh
①. 生成key
```bash
# 自动保存到~/.ssh目录下
ssh-keygen -t rsa -C "YOUR EMAIL"
```
②. 在gitlab/github中添加key, 将id_rsa.pub中的内容复制到其中即可.

③. 在ubuntu上还需要添加ssh key到ssh-agent
```bash
# 权限设置, 不允许其他用户访问
chmod 400 ~/.ssh/id_rsa

# 添加
ssh-add
```
④. github测试
```bash
ssh -T git@github.com
```
⑤. 在windows上, 需要开启openssh服务.
	安装: win -> 设置 -> 应用 -> 可选功能 -> openssh
	启动服务: win-> 服务 -> openssh

## git submodule
1. 添加submodule
```bash
git submodule add [URL to Git repo]
git submodule init
```
2. 移除submodule
```bash
# 删除相应项目的cache
git rm --cached [name]
# 删除相应项目的文件
rm -rf pod-library
# 删除 .git/modules 中的相应文件
rm -rf .git/modules/[name] 
# 修改文件 .gitmodules 删除相应项
vim .gitmocules
# 修改 .git/config 文件, 删除相应项
vim .git/config
```

3. Cloning a repository that contains submodules
```bash
git clone --recursive [URL to Git repo]
git submodule update --init
# if there are nested submodules, -j means parallel download
#git submodule update --init --recursive -j 8
git submodule update --remote # 更新到与submodule设定的url最新的commit
git submodule update --checkout # checkout与父项目相同的commit
```

4. submodule 更新到最新版本
```bash
git pull --recurse-submodules
git submodule update --remote --merge # 更新到与remote相同的版本
```

5. 清除远程已经被删除的分支

```bash
git fetch --prune origin
```

reference: https://git-scm.com/docs/git-submodule

## git lfs

track 之后, 文件任然需要进行stage才会加入到版本管理中.

```bash
git lfs install # git lfs 初始化

git lfs track *.svg # 选择要用lfs追踪的文件

git lfs ls-files # 查看被lfs跟踪的文件

git lfs untrack 1.png # 取消lfs跟踪的文件
```

## git rebase
```bash
pick：保留该commit（缩写:p）
reword：保留该commit，但我需要修改该commit的注释（缩写:r）
edit：保留该commit, 但我要停下来修改该提交(不仅仅修改注释)（缩写:e）
squash：将该commit和前一个commit合并（缩写:s）
fixup：将该commit和前一个commit合并，但我不要保留该提交的注释信息（缩写:f）
exec：执行shell命令（缩写:x）
drop：我要丢弃该commit（缩写:d）
```

## git 仓库过大问题
修改 `~/gitconfig`, 添加如下信息
```file
[core] 
packedGitLimit = 512m 
packedGitWindowSize = 512m 
[pack] 
deltaCacheSize = 2047m 
packSizeLimit = 2047m 
windowMemory = 2047m
```

克隆:
```bash
git config --global core.compression 0 # turn off compression
git clone --depth 1 <repo_URI>
git fetch --unshallow 
```

## git LF/CRLF
`git config --global autocrlf [true|false|input]`
在windows上设置为true, 在下载时自动将LF转化为CRLF, 提交时自动将CRLF转化为LF.
mac/linux上设置为input, 在提交时自动转化为LF.

更稳妥的方式, 设置为false, git不进行转换.
可以在项目中指定各类文件的eol, 在项目根目录下创建一个 .gitattributes 文件
```
# 为所有文本文件设置 LF 换行符
*.txt text eol=lf

# 为所有 Markdown 文件设置 LF 换行符
*.md text eol=lf

# 为所有 HTML 文件设置 CRLF 换行符
*.html text eol=crlf

# 为所有二进制文件禁用自动换行符转换
*.png binary
*.jpg binary
```

如果 .gitattributes `git add --renormalize .` 将清理后的文件添加到索引(更新索引中文件的eol)
然后, 若本地文件eol与配置不同, 则将会在提交时自动修正, 会清除未配置之前的CRLF/LF导致的diff.
(可以看到, 执行该命令后, 所有因为LF/CRLF导致的diff消失了), 而git diff时会提示文件eol与目标不适配,
git会在提交时自动修正.


## gitkaren

[4.1 下载破解工具](https://github.com/wanZzz6/Modules-Learn/blob/master/%E6%8A%80%E6%9C%AF/Gitkraken%20%E6%9C%80%E6%96%B0%E7%89%88v9.x%E7%A0%B4%E8%A7%A3%E6%95%99%E7%A8%8B.md#41-%E4%B8%8B%E8%BD%BD%E7%A0%B4%E8%A7%A3%E5%B7%A5%E5%85%B7)

下载链接: [百度网盘](https://pan.baidu.com/s/1dFEWCdzVg1bibn3GSYjuTw?pwd=6666)

此破解工具之前发布于github上的源码已被和谐，此次用到的破解工具来源于同一作者，程序开源，**切勿用于商业用途**。

（原地址：[https://github.com/PMExtra/GitCracken.git）](https://github.com/PMExtra/GitCracken.git%EF%BC%89)

[4.2 环境准备](https://github.com/wanZzz6/Modules-Learn/blob/master/%E6%8A%80%E6%9C%AF/Gitkraken%20%E6%9C%80%E6%96%B0%E7%89%88v9.x%E7%A0%B4%E8%A7%A3%E6%95%99%E7%A8%8B.md#42-%E7%8E%AF%E5%A2%83%E5%87%86%E5%A4%87)

- 安装 [Node.js](https://nodejs.org/zh-cn) >=12
    
- 安装yarn包管理工具
    
    ```shell
     npm install --global yarn
    ```    

[4.3 开始破解](https://github.com/wanZzz6/Modules-Learn/blob/master/%E6%8A%80%E6%9C%AF/Gitkraken%20%E6%9C%80%E6%96%B0%E7%89%88v9.x%E7%A0%B4%E8%A7%A3%E6%95%99%E7%A8%8B.md#43-%E5%BC%80%E5%A7%8B%E7%A0%B4%E8%A7%A3)

**⚠再次提醒：破解之前先关闭 Gitkraken 软件，Mac平台确保在底部Dock栏中也彻底关闭该软件**

解压破解工具，进入 GitCracken 目录，然后在此目录打开命令行，依次执行以下3条命令：
```shell
yarn install
yarn build
node dist/bin/gitcracken.js patcher --asar C:/Users/{填上你的用户名}/AppData/Local/gitkraken/app-7.5.5/resources/app.asar
```

## Reference
[Git合并指定commit到当前分支](https://www.jianshu.com/p/3d3275e0035c)
---
tag: tools
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

reference: https://git-scm.com/docs/git-submodule

## git lfs

track 之后, 文件任然需要进行stage才会加入到版本管理中.

```bash
git lfs install # git lfs 初始化

git lfs track *.svg # 选择要用lfs追踪的文件

git lfs ls-files # 查看被lfs跟踪的文件

git lfs untrack 1.png # 取消lfs跟踪的文件
```


## svn git 一起工作方法
以git为主, 使用一个专用的git branch `svn`来跟踪svn的版本. svn的更新只在该branch中进行, 然后通过merge的方式合并到其他branch.

### 创建工作
1. 保存/备份当前的修改.

2. 重新download一个新的`svn`仓库, 并提交到git.

3. 将`git`仓库下载到本地. 取出`.git`文件并替换到`svn目录下`.

4. 新建分支`svn`与svn同步, `svn_local`存储一些本地的不需要提交的修改.

5. 每一个任务创建一个新的`feature`分支在上边开发.

6. 当需要合并svn更新时, 切换到`svn`分支, 提交svn版本更新到git.

### 树形结构
```
.
├── master #主线[弃用]
├── svn #与svn保持完全同步
│    ├── svn_local #存储一些本地的不需要提交的修改
│    │    ├── feature1 #新功能开发分支
│    │    ├── feature2 #... 
```

### 后期如何更新
* git分支如何合并来自svn的更新
    1. git切换到`svn`分支
        ```bash
        svn update
        ```
    2. 切换到`svn_local`, rebase其到`svn`(可以在source tree上操作).
        ```bash
        git rebase 
        ```
    3. 切换到`feature`分支, rebase其到`svn_local`.
        ```bash
        git rebase
        ```
* feature分支如何合并到svn
    1. 创建当前分支的拷贝
        ```bash
        git checkout -b tmp 8b30a59
        ```
    2. 使用rebase分离出feature的修改序列(不包含`svn_local`)部分
        ```bash
        # 这里表示以svn 这个分支为base, 应用a9df44e ~ 8b30a59的修改到tmp
        git rebase --onto svn a9df44e^
        ```
    3. 若上一步成功, 则将之前的`svn`删除, 将`tmp`改为`svn`. 然后切换到`svn`, 提交到svn.

* 其他常用操作
    1. 删除一个分支上的某些git commit
    ```bash
    git rebase -i <commit-hash> # 将pick改为drop
    ```

    2. 直接rebase到同源的一个分支
    ```bash
    git rebase <branch_name>
    ```

    3. 将多个git提交合并
    ```bash
    git rebase -i <base_hash>
    # 第一行 r, 其余选择s
    ```

    4. 终止git rebase
    ```bash
    git rebase --abort
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

## svn patch 制作

```bash
svn up # 更新到最新
svn diff -r [old revision] [files]

# windows powershell set utf8
chcp 65001
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

修改`./git/config`
```
[remote "origin"]
    url=<git repo url>
    fetch = +refs/heads/master:refs/remotes/origin/master
```

```
fetch = +refs/heads/master:refs/remotes/origin/master
```

to

```
fetch = +refs/heads/svn:refs/remotes/origin/svn
```

do fetch again.

## Reference
[Git合并指定commit到当前分支](https://www.jianshu.com/p/3d3275e0035c)
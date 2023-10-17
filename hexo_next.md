---
tag: tools
---
# 使用Hexo&next搭建博客
## hexo docker安装
```Dockerfile
# FROM 指定基础镜像node.js
FROM node:latest

MAINTAINER wegatron, wegatron@hotmail.com

# RUN 执行命令
# install hexo
# install search plugin
# mathjax setting refer to
# https://github.com/theme-next/hexo-theme-next/blob/master/docs/MATH.md
RUN npm install hexo-cli -g \
        &&npm install hexo-generator-search --save \
        &&npm install hexo-generator-searchdb --save \
        &&npm uninstall hexo-renderer-marked --save \
        &&npm install hexo-renderer-pandoc
# init
VOLUME /blog

# hexo default port
# just tell user to expose this port
# should using docker run -p to expose this port
EXPOSE 4000
```

启动命令
```bash
sudo docker run -it -p 127.0.0.1:4000:4000 -v \
    /media/wegatron/data/workspace/wegatron.github.io:/blog hexo:wegatron bash
```

## hexo&next配置
有两个主要的配置文件: 
* `\blog\_config.yml`以下称为`站点配置文件`
* `\blog\themes\next\_config.yml`以下称为`主题配置文件`

改用中文: 修改`站点配置文件`中的`language`值为`zh-CN`, 与`\blog\themes\next\languages\zh-CN.yml`对应.

修改`站点配置文件`中的`author`, `title`, `description`等为自己博客的主题和描述.

## 博客内容维护
初始化:
```bash
hexo init
npm install
```
创建新的贴子: `hexo new [post_name]`

### 搜索功能
站点配置文件中加入:
```yaml
search:
  path: search.xml
  field: post
  format: html
  limit: 10000
```

### 数学公式支持
主题配置文件中启用mathjax
```yaml
math:
  # Default (true) will load mathjax / katex script on demand.
  # That is it only render those page which has `mathjax: true` in Front-matter.
  # If you set it to false, it will load 
  # mathjax / katex srcipt EVERY PAGE.
  per_page: true

  # hexo-renderer-pandoc (or hexo-renderer-kramed) required for full MathJax support.
  mathjax:
    enable: true
    # See: https://mhchem.github.io/MathJax-mhchem/
    mhchem: false
```
这里`per_page`若设置为`true`, 则需要在博客文章头部显示启用`mathjax`:
```markdown
---
title: ***
date: ***
mathjax: true
---
```

多个下标时有一个bug:
refere to: https://linkinpark213.com/2018/04/24/mathjax/

### 创建分类和标签
运行如下命令:
```bash
hexo new page categories # 创建分类
hexo new page tags # 创建标签
```
在`sources`下生成两个文件`categories/index.md`和`tags/index.md`. 然后, 在主题配置文件 找到menu，将`categorcies`, `tags`取消注释. 之后对于帖子只需要加入关键字段即可:
```markdown
title: 分类测试文章标题
categories: 分类名
tags:
 - 标签1
 - 标签2
```

### 图片管理
将所有图片保存在站点的`sources/images`目录下, 然后使用绝对路径引用(可兼容vscode).
```
![LIO framework](/images/lio_framework.PNG)
```

### Link between post
1. 使用post的路径作为url, 修改`站点配置文件`
  ```yaml
  permalink_pathed_title:
    use: true
    prefix: ""
    postfix: "" # optional
  ```

  ```yaml
  permalink: :id/
  ```
2. 抹去`.md`
对插件`hexo-hrefmd`做一下修改, 将plugin放入站点目录的`node_modules`, 并在站点的`package.json`文件中添加该依赖.

3. 安装`hexo-asset-link`, 使用相对路径



## 站点管理命令
启动服务器: `hexo s`
清理缓存文件: `hexo clean`
生成静态文件: `hexo g [options]`, options可以是`-d`通过git部署到服务器上(等价于git提交和push)

## TODO
参考 https://leijiezhang001.github.io/KLT/ 如何处理\\的问题
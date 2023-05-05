---
tag: programming_language
---
## ELF文件解析
### 目标文件和可执行文件
编译器编译源代码后生成的文件叫做 __目标文件__, 而目标文件经过编译器链接之后得到的就是可执行文件.
目前, PC平台流行的 __可执行文件__ 格式(Executable)主要包含如下两种, 它们都是COFF(Common File Format)格式的变种:
* Windows下的 __PE__(Portable Executable)
* Linux下的 __ELF__(Executable Linkable Format)

目标文件就是源代码经过编译后但未进行连接的那些中间文件(windows的`.obj`, linux的`.o`), 它与可执行文件的格式非常相似, __所以一般跟可执行文件格式一起采用同一种格式存储__. 除此之外, 动态和静态链接库也采用该种格式存储. 在Windows下采用PE-COFF文件格式; Linux下采用ELF文件格式.
![elf](elf-file-format.png)

ELF 文件主要由四部分组成:
* ELF Header
* ELF Program Header Table (或称Program Headers、程序头)
* ELF Section Header Table (或称Section Headers、节头表)
* ELF Sections

备注: 段(Segment)与节(Section)的区别, 段是程序执行的必要组成, 当多个目标文件链接成一个可执行文件时, 会将相同权限的节合并到一个段中. 相比而言, 节的粒度更小.

### ELF各个模块解析
#### ELF Header
ELF Header记录了ELF文件的一些基本信息, 如:
* ELF 魔数
    通过对魔数压缩了ELF文件的一些基本信息: ELF的可执行文件格式的头4个字节为`0x7F` `e`  `l` `f`; Java的可执行文件格式的头4个字节为`c` `a` `f` `e`.
* ELF文件类型
    ETL_REL 可重定位文件, `.o`文件
    ET_EXEC 可直接执行程序.
    ET_DYN 共享目标文件, `.so`
* ...

查看ELF Header信息:
```bash
$ readelf -h hello.o

ELF Header:
Magic:   7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00
Class:                             ELF64
Data:                              2's complement, little endian
Version:                           1 (current)
OS/ABI:                            UNIX - System V
ABI Version:                       0
Type:                              REL (Relocatable file)
Machine:                           Advanced Micro Devices X86-64
Version:                           0x1
Entry point address:               0x0
Start of program headers:          0 (bytes into file)
Start of section headers:          672 (bytes into file)
Flags:                             0x0
Size of this header:               64 (bytes)
Size of program headers:           0 (bytes)
Number of program headers:         0
Size of section headers:           64 (bytes)
Number of section headers:         13
Section header string table index: 10
```
#### Program Header Table

#### Section
节的分类参考Section Header Table中的节类型, 这里介绍一下一些重要的section:

![elf-sections](elf-sections.png)

* `.text` section
    程序代码指令的代码节. 一段可执行程序, 如果存在Phdr, 则`.text`节就会存在于`text`段中. 类型为`PROGBITS`.
* `.rodata` section
    rodata节保存了只读的数据, 如一行C语言代码中的字符串. 由于`.rodata`节是只读的, 所以只能存在于一个可执行文件的只读段中. 因此, 只能在text段(不是data段)中找到`.rodata`节. 类型为`PROGBITS`.
* `.plt` section (过程链接表)
    `.plt`节也称为过程链接表(Procedure Linkage Table), 其包含了动态链接器调用从共享库导入的函数所必需的相关代码. 类型为`PROGBITS`.
* `.data` section
    `.data`节存在于data段中, 其保存了初始化的全局变量等数据. 类型为`PROGBITS`.
* `.bss` section
    `.bss`(Block Started by Symbol)节存在于data段中, 占用空间不超过4字节, 仅表示这个节本省的空间. `.bss`节保存了未进行初始化的全局变量和静态变量. 程序加载时数据被初始化为0, 在程序执行期间可以进行赋值. 由于`.bss`节未保存实际的数据, 所以节类型为`NOBITS`.
* `.rel.*` section (重定位表)
    重定位表保存了重定位相关的信息, 这些信息描述了如何在链接或运行时, 对ELF目标文件的某部分或者进程镜像进行补充或修改. 类型为`REL`.
* `.dynsym`节(动态链接符号表)
    `.dynsym`节保存在text段中. 其保存了从共享库导入的动态符号表. 类型为`DYNSYM`.
* `.symtab`节(符号表)
    `.symtab`节是一个`ElfN_Sym`的数组, 保存了符号信息. 节类型为`SYMTAB`.


备注: `.dynsym`保存了引用来自外部文件符号的全局符号. `.dynsym`保存的符号是`.symtab`所保存符合的子集, `.symtab`中还保存了可执行文件的本地符号. 如全局变量, 代码中定义的本地函数等. `.dynsym`在运行时会被装载到内存, 而`.symtab`不是必须的, 只用来进行调试和链接.

#### Section Header Table
ELF节头表是一个节头数组. 每一个节头都描述了其所对应的节的信息, 如节名、节大小、在文件中的偏移、读写权限等. __编译器、链接器、装载器都是通过节头表来定位和访问各个节的属性的__.

查看节头表
```bash
$ readelf -S hello.o

There are 13 section headers, starting at offset 0x2a0:

Section Headers:
  [Nr] Name              Type             Address           Offset
       Size              EntSize          Flags  Link  Info  Align
  [ 0]                   NULL             0000000000000000  00000000
       0000000000000000  0000000000000000           0     0     0
  [ 1] .text             PROGBITS         0000000000000000  00000040
       0000000000000015  0000000000000000  AX       0     0     1
  [ 2] .rela.text        RELA             0000000000000000  000001f0
       0000000000000030  0000000000000018   I      11     1     8
  [ 3] .data             PROGBITS         0000000000000000  00000055
       0000000000000000  0000000000000000  WA       0     0     1
  [ 4] .bss              NOBITS           0000000000000000  00000055
       0000000000000000  0000000000000000  WA       0     0     1
  [ 5] .rodata           PROGBITS         0000000000000000  00000055
       000000000000000d  0000000000000000   A       0     0     1
  [ 6] .comment          PROGBITS         0000000000000000  00000062
       0000000000000035  0000000000000001  MS       0     0     1
  [ 7] .note.GNU-stack   PROGBITS         0000000000000000  00000097
       0000000000000000  0000000000000000           0     0     1
  [ 8] .eh_frame         PROGBITS         0000000000000000  00000098
       0000000000000038  0000000000000000   A       0     0     8
  [ 9] .rela.eh_frame    RELA             0000000000000000  00000220
       0000000000000018  0000000000000018   I      11     8     8
  [10] .shstrtab         STRTAB           0000000000000000  00000238
       0000000000000061  0000000000000000           0     0     1
  [11] .symtab           SYMTAB           0000000000000000  000000d0
       0000000000000108  0000000000000018          12     9     8
  [12] .strtab           STRTAB           0000000000000000  000001d8
       0000000000000013  0000000000000000           0     0     1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings), l (large)
  I (info), L (link order), G (group), T (TLS), E (exclude), x (unknown)
  O (extra OS processing required) o (OS specific), p (processor specific)
```

节类型
| 常量 | 值 | 含义 |
| --- | --- | --- |
| NULL      | 0  |  无效节
| PROGBITS  | 1  |  程序节、代码节、数据节都是这种类型
| SYMTAB    | 2  |  符号表
| STRTAB    | 3  |  字符串表
| RELA      | 4  |  重定位表, 该节包含了重定位信息
| HASH      | 5  |  符号表的哈希表
| DYNAMIC   | 6  |  动态链接信息
| NOTE      | 7  |  提示性信息
| NOBITS    | 8  |  表示该节在文件中没有内容, 如`.bss`节
| REL       | 9  |  该节包含了重定位信息
| SHLIB     | 10 |  保留
| DNYSYM    | 11 |  动态链接的符号表

## 程序运行时的内存映像
一个由C/C++编译的程序占用的内存分为以下几个部分:
1. __栈区 (stack)__ 由编译器自动分配释放, 存放函数的参数值, 局部变量的值等.
2. __堆区 (heap)__ 一般由程序员分配释放, 若程序员不释放, 程序结束时可能由OS回收.
3. __全局区 (静态区) (static)__ 存储全局变量和静态变量, 初始化的全局变量和静态变量在一块区域, 未初始化的全局变量和未初始化的静态变量在相邻的另一块区域. 程序结束后有系统释放.
4. __文字常量区__ 常量字符串就是放在这里的. 程序结束后由系统释放.
5. __程序代码区(text)__ 存放函数体的二进制代码.

![process image](process_image.png)

example:
```c++
const char * g_str_a = "global const char * str a"; // g_str_a存于全局(静态)初始化区, 值为1e200000 00000000, 字符串数据存于.rodata in elf 地址: 04200000 00000000
const char * g_str_b = "global const char * str b"; // g_str_b存于全局(静态)初始化区, 值为1e200000 00000000, 字符串存于.rodata in elf

unsigned int a = 0xFFFFFFFF;    //全局初始化区 存于.data
char * p1;     //全局未初始化区 .bss

int main(int argc, char * argv[]) 
{ 
    int b;                   //栈 
    char s[] = "abc";        //s[]在栈区，abc在常量区 .rodata 
    char *p2;                //栈 
    const char *p3 = "123456";     // .rodata in elf; 123456在常量区, p3在栈上 
    static int c = 0xABCDEFAA;       //全局（静态）初始化区, 值存在.data
    static char * p4;
    return 0;
} 
```

```bash
objdump -s zsw_test
...
Contents of section .data:
 4000 00000000 00000000 08400000 00000000  .........@......
 4010 ffffffff aaefcdab 04200000 00000000  ......... ......
 4020 1e200000 00000000                    . ......        
# 这里数据是小端, 低位数据存于低位地址
```

堆和栈的区别
1. stack的空间由操作系统自动分配/释放, heap上的空间需要手动分配/释放.
2. 栈的空间有限, 堆是很大的自由存储区.
3. 程序在编译期对变量和函数分配内存都在栈上进行, 且程序运行过程中函数调用参数的传递也在栈上进行.

备注: BSS存放的是未初始化的全局变量和静态变量, 数据段存放的是初始化后的全局变量和静态变量.

## Reference
[计算机那些事(4)——ELF文件结构](http://www.chuquan.me/2018/05/21/elf-introduce/)
[执行可执行程序时内存分配的方式&&BSS段](https://michaelyou.github.io/2015/03/07/%E6%89%A7%E8%A1%8C%E5%8F%AF%E6%89%A7%E8%A1%8C%E7%A8%8B%E5%BA%8F%E6%97%B6%E5%86%85%E5%AD%98%E5%88%86%E9%85%8D%E7%9A%84%E6%96%B9%E5%BC%8F/)
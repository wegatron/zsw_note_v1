---
tag: programming_language/python
---
# basic data struct
 * basic
```python
l = [1,2,3,4,'aasd'] # list, array
len(l) # size of l
l.append(element)
l.insert(index, element)
l.extend(l2)
l.remove(elem) # search for the first instance to remove
l.pop(index)
list[1:-1] # slice result is [2,3,4]

t = (1,2,3) #tuple

# using hash tables
d = {'a':1, 'b':2} #dict
d['a'] = 12 # update or insert
d['a'] # if key not exist throw KeyError
d.get('a') # return None if key not exist
if 'a' in d # check if 'a' is a key of d
d.items() # return (key,value) tuples
d.keys() # return key list
d.values()
del d['a'] # delete
```
* basic combination
```python
[('a',1,2),('c',2,3)] #records
{"one":[1,2,3], "two":[2,3,4]}
```
# basic operation
## loops
```python
if s in names: # judge if s is in array names
for s in names: # for loop
for i in range(a,b): # for loop
```

## inner functions
sort
```python
names = ['asd','aaa','bbb']
# sort(names, key=, reverse=)
# key is a function convert the names to, for which to sort
sort(names) # sort names increasing order
sort(names, reverese=true) # sort names in decreassing order
sort(names, key=names.lower)
sort(names, key=names.length)
def MyFn(s):
    return s[-1]
sort(names, key=MyFunc)
```

## file operation
### basic file operation
```python
import codecs
f = open('name', 'r', 'Utf-8') # r,w,a,b + U; codes is optimoal
# U means Universal for text mode, convert different line ending to '\n'
# b means binary
```
echo a file
```python
f = open('foo.txt', 'rU')
  for line in f:   ## iterates over the lines of the file
    print line,    ## trailing , so print does not add an end-of-line char
                   ## since 'line' already includes the end-of line.
  f.close()
```
read
```python
f.readline() ## return '' if reach the last line, return '\n' if read a empty line
f.read(size) ## read asic or binary depends on open mode
```
write
```python
f.write('string') # write a string to file
f.write("{0:.4f} {1:.4f} {2:.4f}\n".format(rec[0], rec[1], rec[2])) # format write
```

### binary data
convert from or to binary
```python
i=10
single_byte = i.to_bytes(1, byteorder='big', signed=True) # only one byte, big-endian(arm), little (x86)
i = int.from_bytes(b'\x00\x0F', byteorder='little')
i = int('01010000', 2) # binary to int
```

decode and encode
```python
## binary <--> base64
import binascii
base64_data = binascii.b2a_base64(binary_data)
import codecs
base64_data = codecs.encode(binary_data, 'base64')

## binary <--> utf8
message = binary_data.decode('utf-8')
binary_data = message.encode('utf-8')
```

format output
```python
a_byte = b'\xff'  # 255
i = ord(a_byte)   # Get the integer value of the byte
bin = "{0:b}".format(i) # binary: 11111111
hex = "{0:x}".format(i) # hexadecimal: ff
oct = "{0:o}".format(i) # octal: 377
```
get current system bytes order
```python
import sys
print("Native byteorder: ", sys.byteorder)
```
## regular expression
更详细的内容可参考 https://www.ibm.com/developerworks/cn/opensource/os-cn-pythonre/index.html
```python
'^' # matches the start of string
'.' # any character
'\w' '\d' '\D' # world character; digit character, non digit character
'\s' '\t' # white space , tab
'\n' # new line
'[ ]' # They’re used for specifying a character class, which is a set of characters that you wish to match. [a-z], [abc]
```

## system
```python
iomport system
```
set system environment
```python
os.putenv("path", "D:/usr/boost_1_68_0/lib64-msvc-14.1;d:/usr/FLANN/bin")
```

execute command
```python
os.system("cmd")
```

## print
refere to https://www.geeksforgeeks.org/python-output-formatting/
```python
# Python program showing  
# use of format() method 
  
# using format() method 
print('I love {} for "{}!"'.format('Geeks', 'Geeks')) 
  
# using format() method and refering  
# a position of the object 
print('{0} and {1}'.format('Geeks', 'Portal')) 
  
print('{1} and {0}'.format('Geeks', 'Portal')) 
```

output:
```
I love Geeks for "Geeks!"
Geeks and Portal
Portal and Geeks
```

```python
# Python program showing  
# a use of format() method 
  
# combining positional and keyword arguments 
print('Number one portal is {0}, {1}, and {other}.'
     .format('Geeks', 'For', other ='Geeks')) 
  
# using format() method with number  
print("Geeks :{0:2d}, Portal :{1:8.2f}". 
      format(12, 00.546)) 
  
# Changing positional argument 
print("Second argument: {1:3d}, first one: {0:7.2f}". 
      format(47.42, 11)) 
  
print("Geeks: {a:5d},  Portal: {p:8.2f}". 
     format(a = 453, p = 59.058)) 
```

output:
```
Number one portal is Geeks, For, and Geeks.
Geeks :12, Portal :    0.55
Second argument:  11, first one:   47.42
Geeks:   453, Portal:    59.06
```

## The underscore `_ `
1. 在解释器中`_`表示上一个表达式的结果相当于octave的`ans`

2. 用来表示unpack时忽略掉的值
      ```python
      x, _, y = (1, 2, 3)
      x, *_, y = (1, 2, 3, 4, 5)
      # Ignore the index
      for _ in range(10)
            do_something()
      ```
3. 用来表示一些特殊的函数或变量
      * 前置单下划线, 用来表示private的class成员变量或成员函数, 以及对外不可见的变量或函数(import时不会被带入)

      * 前置双下划线, `__method`成员函数名称会被修饰成`_ClassName__method`

      * 前后双下划线, 一些特殊的函数和变量(magic method), 比如:`__init__`, `__len__`, `__eq__`


## google drive download

```bash
pip install gdown
```

需要下载的链接: `https://drive.google.com/file/d/1jUB5yD7DP97-EqqU2A9mmr61JpNwZBVK/view`, 这里标志符为:`1jUB5yD7DP97-EqqU2A9mmr61JpNwZBVK`.

```bash
gdown https://drive.google.com/uc?id=标识符
```


对于大文件可能会出错, 使用如下方式下载:
```python
gdown.download(
    "https://drive.google.com/uc?export=download&confirm=pbef&id=1ghvzYXdmiCuX5I757id73jWuRLMCzXAX",
    "ckpt/00000189-checkpoint.pth.tar"
)
```

对于带有`confirm=t`的文件, 可以使用(curl支持断点续传):
```bash
curl -L -o data/my-file.h5 'https://drive.google.com/uc?id=my-file-id-here&confirm=t
```

## colab debug

```python
!pip install ipdb

# in python file
## refere to https://xmfbit.github.io/2017/08/21/debugging-with-ipdb/
ipdb.set_trace()
```
# 字符串

内部是 SDS

SDS 的全称是：simple dynamic string

数据结构是这样的：

* len，记录已经使用的数据的长度，不包括 `\0`
* free，记录还剩下的数据的长度
* buf，字符数据存储处，以 `\0` 结尾

[下图的在线链接点这里](https://dreampuf.github.io/GraphvizOnline/#digraph%20G%20%7B%0Anode%20%5Bshape%3Drecord%5D%0Anode1%20%5Blabel%3D%22%3Cf1%3E%20len%20%7C%20%3Cf2%3E%20free%20%7C%20%3Cf3%3E%20buf%22%5D%0Anode1%3Af1%20-%3E%20len%20%5Blabel%3D%22int%22%5D%0Anode1%3Af2%20-%3E%20free%20%5Blabel%3D%22int%22%5D%0Anode1%3Af3%20-%3E%20buf%20%5Blabel%3D%22%5B%5Dchar%22%5D%0A%0Alen%20%5Bshape%3Dcircle%20label%3D%225%22%5D%0Afree%20%5Bshape%3Dcircle%20label%3D%223%22%5D%0Abuf%20%5Blabel%3D%22'h'%20%7C%20'e'%20%7C%20'l'%20%7C%20'l'%20%7C%20o%20%7C%20'%5C%5C0'%20%7C%20%7C%20%7C%20%22%5D%0A%7D)

```text
digraph G {
  node [shape=record]
  node1 [label="<f1> len | <f2> free | <f3> buf"]
  node1:f1 -> len [label="int"]
  node1:f2 -> free [label="int"]
  node1:f3 -> buf [label="[]char"]
  
  len [shape=circle label="5"]
  free [shape=circle label="3"]
  buf [label="'h' | 'e' | 'l' | 'l' | o | '\\0' | | | "]
}
```

![](../../.gitbook/assets/graphviz-redis-sds.svg)

SDS 有几个优点

* 求长度是 O\(1\) 的
  * 因为只需要返回 len 的数据即可
* 二进制安全的
  * 普通的 c 字符串，因为以 \0 结尾，所以无法在字符的中间包含 \0，但是 sds 可以
* 可以快捷的进行增删操作，而无需频繁申请和释放内存
* 避免溢出错误
  * 普通的 c 字符串，append 字符串的时候，可能会有溢出的错误
  * sds 因为知道数据的长度，所以可以预先进行扩容，不可能溢出




# 整数集合

## 数据结构

```go
type intset {
    encoding uint32
    length uint32
    contents []byte
}
```

encoding 有三个可能值，分别是：

* INTSET_ENC_INT16
* INTSET_ENC_INT32
* INTSET_ENC_INT64

表示 contents 是以 int16、int32、int64 中的哪种方式来存储数据的

length 表示整数集合的数据长度

contents 存储了真正的数据

## contents 如何存储数据

contents 中的数据组织结构是通过 encoding 确定的

同一时间只有一种编码方式

* 假设 encoding == INTSET_ENC_INT16

那么 contents 就是以 int16 存储数据的

每个 int16 在 go 中占用 2 个字节，所以 content 每 2 个字节代表一个 int16 的数据

* 假设 encoding == INTSET_ENC_INT64

那么 contents 就是以 int64 存储数据的

每个 int64 在 go 中占用 8 个字节，所以 content 每 8 个字节代表一个 int64 的数据

## encoding 如何确定

在整数集合初始化的时候，是根据所有的数据的最大值来确定 encoding 的，比如最大的数据是 int16 的，那么 encoding 就是 INTSET_ENC_INT16

在后续有数据添加进来的时候，如果出现了 int32 或者 int64，会发生 **升级** 操作，升级为 INTSET_ENC_INT32 或者 INTSET_ENC_INT64 encoding 的。

在同一个时刻，只有一种 encoding，contents 只以一种方式存储数据

假如 INTSET_ENC_INT16 升级为 INTSET_ENC_INT64

* 首先修改 encoding
  * 修改为 INTSET_ENC_INT64
* 然后修改 contents
  * 根据数据的长度 和 int64 申请足够大的内存( 至少 `(length+1) * 8` 字节)
  * 根据 length 找到 contents 中的最后一个数据的位置
  * 从 contents 中的最后一个 int16 开始，将数据复制到新申请的内存的最后一个位置（按照 8 字节来组织的位置）
  * 然后往前遍历
* 插入的数据在合适的位置插入 contents

## 只能升级，不能降低

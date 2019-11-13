# 函数的参数传值还是传引用

### python 的参数传递是什么类型的呢

#### python 的参数是传引用的吗

下面的代码在函数内修改了 n 的值，但是函数外，n 没有被修改，所以不是传引用的。

```python
In [1]: def inc(n):
   ...:     print(id(n))
   ...:     n = n + 1
   ...:     print(id(n))


In [2]: n = 3

In [3]: id(n)
Out[3]: 4455332976

In [4]: inc(n)
4455332976
4455333008

In [5]: n
Out[5]: 3
```

#### python 的参数是传值的吗

下面的函数在函数内部列表被修改，同时外面的列表也被修改了，所以不是传值的。

```python
In [6]: def change_list(l):
   ...:     print(l)
   ...:     l.append('new data')
   ...:     print(l)
   ...:     return l


In [7]: a = ['a', 'b', 'c']

In [8]: b = change_list(a)
['a', 'b', 'c']
['a', 'b', 'c', 'new data']

In [9]: a
Out[9]: ['a', 'b', 'c', 'new data']

In [10]: b
Out[10]: ['a', 'b', 'c', 'new data']

In [11]: id(a)
Out[11]: 4491734664

In [12]: id(b)
Out[12]: 4491734664
```

#### python 的参数是根据参数的可变不可变来决定传值还是传引用的吗

下面的函数的入参都是一个可变的 list 结构，但是根据处理方式的不同：有的列表在函数外没有被修改，有的列表在函数外被修改了，所以 python 的参数传递问题也不是根据可变不可变对象来决定的。

```python
In [14]: def change_me(l):
    ...:     print(id(l))
    ...:     new_list = l
    ...:     print(id(new_list))
    ...:     if len(new_list) > 5:
    ...:         new_list = ['a', 'b', 'c']
    ...:     for i, e in enumerate(new_list):
    ...:         if isinstance(e, list):
    ...:             new_list[i] = '***'
    ...:     print(new_list)
    ...:     print(id(new_list))
    ...:

In [15]: a = ['1', ['2'], ['3'], '4']

In [16]: change_me(a)
4491010632
4491010632
['1', '***', '***', '4']
4491010632

In [17]: a
Out[17]: ['1', '***', '***', '4']

In [18]: b = [1, 2, 3, 4, 5, 6]

In [19]: change_me(b)
4492261704
4492261704
['a', 'b', 'c']
4491169736

In [20]: b
Out[20]: [1, 2, 3, 4, 5, 6]
```

{% hint style="info" %}
要理解这个问题，首先需要先理解 python 的对象的概念，以及对象的可变不可变。
{% endhint %}

### python 对象的可变和不可变

> 可变：mutable
>
> 不可变：immutable

#### 基础数据类型的可变与不可变

| 类型 | 不可变 | 可变 | 备注 |
| :--- | :--- | :--- | :--- |
| bool | ✅ |  |  |
| int | ✅ |  |  |
| float | ✅ |  |  |
| str | ✅ |  |  |
| tuple | ✅ |  |  |
| frozenset | ✅ |  | 不可变的set |
| list |  | ✅ |  |
| dict |  | ✅ |  |
| set |  | ✅ |  |

对象 object

在 python 内部，所有的数据都是一个 `对象（object）`。

object 有几个函数可以操作

* id\(o\)
  * 返回一个 object 的唯一数字 id
  * 在创建的时候确定，不可更改
  * 内部实现上返回了内存地址
* o is b
  * 判断 o 和 b 两个 object 是不是同一个 object
  * 或者说 o 和 b 两个变量是不是引用的同一个 object
* type\(o\)
  * 返回一个 object 的类型










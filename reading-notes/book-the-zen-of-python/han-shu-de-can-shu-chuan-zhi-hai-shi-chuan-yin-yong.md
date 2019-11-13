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

### python 对象

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

#### 在 python 内部，所有的数据都是一个 `对象（object）`。

#### object 有几个函数可以操作

* id\(o\)
  * 返回一个 object 的唯一数字 id
  * 在创建的时候确定，不可更改
  * 内部实现上返回了内存地址
* o is b
  * 判断 o 和 b 两个 object 是不是同一个 object
  * 或者说 o 和 b 两个变量是不是引用的同一个 object
* type\(o\)
  * 返回一个 object 的类型

#### object 操作

1. 将 `10` 赋值给 `x`

![y = 10](https://cdn.nlark.com/yuque/__graphviz/579ec1790f041c672935145ccc5452ee.svg)

2. 然后将 `x` 赋值给 `y`

![](https://cdn.nlark.com/yuque/__graphviz/48bc84a2bb3467f8fb91000015a02838.svg)

{% hint style="info" %}
这个时候，`x` 和 `y` 都是引用了同一个 `object(int: 10)`
{% endhint %}

3. 然后将 `y` 加上 `10`

![y += 10](https://cdn.nlark.com/yuque/__graphviz/1665d3c3600152a84c56e964e73a1032.svg)

{% hint style="info" %}
`int` `object` 是不可变的，所以需要创建一个新的 `object`，类型为 `int`，值为 `20`，并且让 `y` 引用这个 `object`
{% endhint %}

4. 将 `x` 设置为一个可变 object 列表

![x = \[1, 2\]](https://cdn.nlark.com/yuque/__graphviz/0262a6ddfbdaecb8761d60484ff9e317.svg)

5. 将 `y` 设置为 `x`

![y = x](https://cdn.nlark.com/yuque/__graphviz/e8c4f04b217c2fd202a138b9c0c440b4.svg)

{% hint style="info" %}
x 和 y 都引用了一个 list object
{% endhint %}

6. `y` append 一个数据

![y.append\(3\)](https://cdn.nlark.com/yuque/__graphviz/e5c49b40390873bc30053b5c9be92da4.svg)

{% hint style="info" %}
因为 list object 是可变的，所以 append 操作会直接修改这个 object 本身

x 和 y 仍然同时引用了这个 object
{% endhint %}

7. 将一个新的列表赋值给 `y`

![y = \[4, 5\]](https://cdn.nlark.com/yuque/__graphviz/d1d09f3dc07dc5bd558702280e03442b.svg)

{% hint style="info" %}
虽然列表 object 是可变的，但是直接赋值操作不是操作列表。

y 会引用一个新创建的类别 object。
{% endhint %}









### 参考

* [《编写高质量代码：改善Python程序的91个建议 建议31：记住函数传参既不是传值也不是传引用》](https://weread.qq.com/web/reader/a773170597d8e93668ebfcfk3f131c022583d0efb2c4298)
* [Mutable vs Immutable Objects in Python](https://medium.com/@meghamohan/mutable-and-immutable-side-of-python-c2145cf72747)
* [本文插图来自语雀](https://www.yuque.com/chenyunpeng-zkr3i/xedeha/hc4mq1)






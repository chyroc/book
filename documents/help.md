# 写作技巧

### 如何快速保存剪贴板的图片

```shell
brew install pngpaste

uuid_file="$(echo $(uuidgen) | tr '[:upper:]' '[:lower:]').png"
save_file=".gitbook/assets/${uuid_file}"
pngpaste ${save_file}

echo "file is save to file: ${save_file}"
echo ${save_file} | pbcopy
```

![](../.gitbook/assets/68a1dff8-1080-4da0-b8fa-7bc315c48411.png)


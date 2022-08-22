# EasyAES
AES 加密解密库, 兼容PHP, Android, iOS平台。

可以在三个平台间加密解密数据，确保某个平台加密的数据，在另外两个平台能够解密。

## 使用方法

### Android/Java用法：
```Java
String text = "this is pliat text.";
EasyAES aes = new EasyAES("****************", 128, "################");
// 加密
String data = aes.encrypt(text);
// 解密
String plainText = aes.decrypt(data);
```


### PHP版本用法（兼容php7.x，8.x）：
```PHP
$text = "this is plain text.";
$aes = new EasyAES('****************', 128, '################');
// 加密
$data = $aes->encrypt($text);
// 解密
$plainText = $aes->decrypt($data);
```
注意：php5.x版本用到了[mcrypt](https://www.php.net/manual/en/book.mcrypt.php)扩展，需要安装并在php.ini中开启。7.0及以上版本使用ssl模块，无需mcrypt。


### iOS版本用法
```Object-C
NSData* pData = ...//encrypted data form server
NSData* plaitData = [NSData AES128DecryptedData:data];
```


### Python版本用法
```Python
text = "this is plain text."
aes = EasyAES('****************', '################')
# 加密字符串
data = aes.encrypt(text)
# 解密字符串
plainText = aes.decrypt(data)
```

以上所有版本都需要设置下自己的加密密码以及偏移向量iv，均为16位字符。

后期计划加上C#, C, C++版本，敬请期待。

更多信息请访问我的博客[帝都码农](http://diducoder.com)
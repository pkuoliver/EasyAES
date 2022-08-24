# EasyAES
AES 加密解密库, 兼容PHP, Android, iOS, Python, C#平台。

可以在五个平台间加密解密数据，确保某个平台加密的数据，在另外四个平台能够解密。

## 使用方法

### Android/Java用法：
``` java
String text = "this is pliat text.";
EasyAES aes = new EasyAES("password here", 256, "iv here");
// 加密
String data = aes.encrypt(text);
// 解密
String plainText = aes.decrypt(data);
```


### PHP版本用法（兼容php7.x，8.x）：
``` php
$text = "this is plain text.";
$aes = new EasyAES('password here', 256, 'iv here');
// 加密
$data = $aes->encrypt($text);
// 解密
$plainText = $aes->decrypt($data);
```
注意：php5.x版本用到了[mcrypt](https://www.php.net/manual/en/book.mcrypt.php)扩展，需要安装并在php.ini中开启。7.0及以上版本使用ssl模块，无需mcrypt。


### iOS版本用法
``` objc
NSString *text = @"this is plain text.";
EasyAES *aes = [[EasyAES alloc] initWithKey:@"your key" bit:256 andIV:@"your iv"];
// encrypt
NSString *data = [aes encrypt:text];
// decrypt
NSString *plainText = [aes decrypt:data];

// 加密/解密 NSData对象
NSData *pData = ...//已经加密的NSData对象
NSData *plainData = [aes decryptedData:pData];
NSData *encData = [aes encryptedData:plainData];
```


### Python版本用法
``` python
text = "this is plain text."
aes = EasyAES('password here', 256, 'iv here')
# 加密字符串
data = aes.encrypt(text)
# 解密字符串
plainText = aes.decrypt(data)
```


### C#版本用法
``` csharp
string text = "this is plain text.";
EasyAES aes = new EasyAES("password here", 256, "iv here");
// 加密
string encText = aes.Encrypt(text);
// 解密
string decText = aes.Decrypt(encText);
```

以上所有版本都需要设置下自己的加密密码以及偏移向量iv，不能为空。


## 128位还是256位
256位的AES加密算法有着更高的安全性，因此强烈推荐使用256位的加密方法，不过会造成一些性能损失。

如果对性能非常敏感，可以使用128位的方法，只需要将构造函数的第二个参数改为128即可。

## 其他

后期计划加上C, C++版本，敬请期待。

更多信息请访问我的博客[帝都码农](http://diducoder.com)
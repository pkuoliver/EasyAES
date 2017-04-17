# EasyAES
AES encrypt/decrypt, Android, iOS, php compatible(兼容php, Android, iOS平台) 

可以在三个平台间加密解密数据，确保某个平台加密的数据，在另外两个平台能够解密。

## Android版本用法：
```Java
String text = "this is pliat text.";
// encrypt
String data = EasyAES.encryptString(data);
// dencrypt
String plaitText = EasyAES.dencryptString(data);
```


## php版本用法：
```PHP
function encryptString($content) {
	$aes = new EasyAESCrypt('****************', 128, '################');
	return $aes->encrypt($content);
}
 
function decryptString($content) {
	$aes = new EasyAESCrypt('****************', 128, '################');
	return $aes->decrypt($content);
}
```
注意：php版本用到了mcrypt模块，需要安装并在php.ini中开启


## iOS版本用法
```Object-C
NSData* pData = ...//encrypted data form server
NSData* plaitData = [NSData AES128DecryptedData:data];
```


以上所有版本都需要设置下自己的加密密码以及偏移向量iv，均为16位字符。

后期计划加上C#, C, C++版本，敬请期待。

更多信息请访问我的博客[帝都码农](http://diducoder.com)
# EasyAES
AES encrypt/decrypt library, Android, iOS, php compatible.

Data can be encrypted and decrypted between three platforms, ensuring that data encrypted on one platform can be decrypted on the other two platforms.

[中文版说明](./README_CN.md)

## Usage

### Android：
```Java
String text = "this is plain text.";
// encrypt
String data = EasyAES.encryptString(text);
// dencrypt
String plainText = EasyAES.dencryptString(data);
```


### PHP：
```PHP
$text = "this is plain text.";
// encrypt
$data = EasyAES::encryptString($text);
// dencrypt
$plainText = EasyAES.dencryptString($data);
```
Notes：The php5.x version uses the [mcrypt](https://www.php.net/manual/en/book.mcrypt.php) extension, which needs to be installed and enabled in php.ini. php7.0 and above use the ssl module, so mcrypt is no longer required.


### iOS
```Object-C
NSData* pData = ...//encrypted data form server
NSData* plaitData = [NSData AES128DecryptedData:data];
```


All of the above usage need to set own password and offset vector(iv), both of which are 16-bit characters.

## TODO List

Later plans to complete the C#, C, C++ version, so stay tuned.

For more information, please visit my blog [帝都码农](http://diducoder.com)
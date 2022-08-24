# EasyAES
AES encrypt/decrypt library, Android, iOS, PHP, Python, C# compatible.

Data can be encrypted and decrypted between five platforms, and data encrypted on one platform can be decrypted on the other four platforms.

[中文版说明](./README_CN.md)

## Usage

### Android：
``` java
String text = "this is plain text.";
EasyAES aes = new EasyAES("password here", 256, "iv here");
// encrypt
String data = aes.encrypt(text);
// decrypt
String plainText = aes.decrypt(data);
```


### PHP：
``` php
$text = "this is plain text.";
$aes = new EasyAES('password here', 256, 'iv here');
// encrypt
$data = $aes->encrypt($text);
// decrypt
$plainText = $aes->decrypt($data);
```
Notes：The php5.x version uses the [mcrypt](https://www.php.net/manual/en/book.mcrypt.php) extension, which needs to be installed and enabled in php.ini. php7.0 and above use the ssl module, so mcrypt is no longer required.


### iOS
``` objc
EasyAES *aes = [[EasyAES alloc] initWithKey:@"your key" bit:256 andIV:@"your iv"];
// encrypt
NSString *data = [aes encrypt:text];
// decrypt
NSString *plainText = [aes decrypt:data];

// encrypt/decrypt NSData
NSData *pData = ...//encrypted data form server
NSData *plainData = [aes decryptedData:pData];
NSData *encData = [aes encryptedData:plainData];
```


### Python
``` python
text = "this is plain text."
aes = EasyAES('password here', 256, 'iv here')
# encrypt string
data = aes.encrypt(text)
# decrypt string
plainText = aes.decrypt(data)
```


### C#
``` csharp
string text = "this is plain text.";
EasyAES aes = new EasyAES("password here", 256, "iv here");
// encrypt
string encText = aes.Encrypt(text);
// decrypt
string decText = aes.Decrypt(encText);
```

All of the above usage need to set own password and offset vector(iv).

## 128 bit or 256 bit
The 256-bit AES encryption algorithm has higher security, so it is strongly recommended to use the 256-bit encryption method, but it will cause some performance losses.

If you are very sensitive to performance, you can use the 128-bit method, just change the second parameter of the constructor to 128.

## TODO List

Later plans to complete the C, C++ version, so stay tuned.

For more information, please visit my blog [帝都码农](http://diducoder.com)
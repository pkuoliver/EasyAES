# EasyAES
AES encrypt/decrypt, Android, iOS, php compatible(兼容php, Android, iOS平台) 


Android版本用法：
String text = "this is pliat text.";
// encrypt
String data = EasyAES.encryptString(data);
// dencrypt
String plaitText = EasyAES.dencryptString(data);


php版本用法：
function encryptString($content) {
        $aes = new MagicCrypt('****************', 128, '################');
        return $aes->encrypt($content);
}

function decryptString($content) {
        $aes = new MagicCrypt('****************', 128, '################');
        return $aes->decrypt($content);
}
注意：php版本用到了mcrypt模块，需要安装并在php.ini中开启


iOS版本用法
NSData* pData = ...//nsdata form server
NSData* plaitData = [NSData AES128DecryptedData:data];
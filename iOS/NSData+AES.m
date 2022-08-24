#import "NSData+AES.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>
#import "GTMBase64.h"

@implementation NSData (Encryption)

- (NSData *)AES128EncryptWithKey:(NSString *)key iv:(NSString *)iv{//加密
	const char *cStr = [key UTF8String];
	unsigned char pKey[kCCKeySizeAES128 + 1];
	bzero(pKey, sizeof(pKey));
	CC_MD5(cStr, strlen(cStr), pKey);

	cStr = [iv UTF8String];
	unsigned char pIV[kCCKeySizeAES128 + 1];
	bzero(pIV, sizeof(pIV));
	CC_MD5(cStr, strlen(cStr), pIV);

	NSUInteger dataLength = [self length];
	NSMutableData *mData = [NSMutableData dataWithData:self];

	dataLength = [mData length];
	size_t bufferSize = dataLength + kCCBlockSizeAES128;
	void *buffer = malloc(bufferSize);

	size_t numBytesEncrypted = 0;
	CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
										  kCCAlgorithmAES,
										  0x0001,
										  pKey,
										  kCCBlockSizeAES128,
										  pIV,
										  [self bytes],
										  dataLength,
										  buffer,
										  bufferSize,
										  &numBytesEncrypted);
	if (cryptStatus == kCCSuccess) {
		return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
	}
	free(buffer);
	return nil;
}


- (NSData *)AES128DecryptWithKey:(NSString *)key iv:(NSString *)iv{//解密
	const char *cStr = [key UTF8String];
	unsigned char pKey[kCCKeySizeAES128 + 1];
	bzero(pKey, sizeof(pKey));
	CC_MD5(cStr, strlen(cStr), pKey);


	cStr = [iv UTF8String];
	unsigned char pIV[kCCKeySizeAES128 + 1];
	bzero(pIV, sizeof(pIV));
	CC_MD5(cStr, strlen(cStr), pIV);

	NSUInteger dataLength = [self length];
	size_t bufferSize = dataLength + kCCBlockSizeAES128;
	void *buffer = malloc(bufferSize);

	size_t numBytesEncrypted = 0;
	CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
										  kCCAlgorithmAES,
										  0x0000,
										  pKey,
										  kCCBlockSizeAES128,
										  pIV,
										  [self bytes],
										  dataLength,
										  buffer,
										  bufferSize,
										  &numBytesEncrypted);
	if (cryptStatus == kCCSuccess) {
		// unpadding
		unsigned char* pChar = (unsigned char*)buffer;
		pChar += (numBytesEncrypted - 1);
		int pad = (int)*pChar;
		pChar = (unsigned char*)buffer;
		pChar += numBytesEncrypted - pad;
		*pChar = '\0';
		return [NSData dataWithBytesNoCopy:buffer length:(numBytesEncrypted - pad)];
	}
	free(buffer);
	return nil;
}

- (NSData *)AES128EncryptedDataWithKey:(NSString *)key
{
	return [self AES128EncryptedDataWithKey:key iv:nil];
}

- (NSData *)AES128DecryptedDataWithKey:(NSString *)key
{
	return [self AES128DecryptedDataWithKey:key iv:nil];
}

- (NSData *)AES128EncryptedDataWithKey:(NSString *)key iv:(NSString *)iv
{
	return [self AES128Operation:kCCEncrypt key:key iv:iv];
}

- (NSData *)AES128DecryptedDataWithKey:(NSString *)key iv:(NSString *)iv
{
	return [self AES128Operation:kCCDecrypt key:key iv:iv];
}

- (NSData *)AES128Operation:(CCOperation)operation key:(NSString *)key iv:(NSString *)iv
{
	const char *cStr = [key UTF8String];
	unsigned char pKey[kCCKeySizeAES128 + 1];
	bzero(pKey, sizeof(pKey));
	CC_MD5(cStr, strlen(cStr), pKey);

	char keyPtr[kCCKeySizeAES128 + 1];
	bzero(keyPtr, sizeof(keyPtr));
	[key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];


	cStr = [iv UTF8String];
	unsigned char pIV[kCCKeySizeAES128 + 1];
	bzero(pIV, sizeof(pIV));
	CC_MD5(cStr, strlen(cStr), pIV);

	char ivPtr[kCCBlockSizeAES128 + 1];
	bzero(ivPtr, sizeof(ivPtr));
	if (iv) {
		[iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
	}

	NSUInteger dataLength = [self length];
	size_t bufferSize = dataLength + kCCBlockSizeAES128;
	void *buffer = malloc(bufferSize);

	size_t numBytesEncrypted = 0;
	CCCryptorStatus cryptStatus = CCCrypt(operation,
										  kCCAlgorithmAES,
										  0x00000000,
										  pKey,
										  kCCBlockSizeAES128,
										  pIV,
										  [self bytes],
										  dataLength,
										  buffer,
										  bufferSize,
										  &numBytesEncrypted);
	if (cryptStatus == kCCSuccess) {
		return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
	}
	free(buffer);
	return nil;
}

+ (NSData *)AES128EncryptedData:(NSData *)pData {
	//Set password and iv string here
	pData = [pData AES128EncryptWithKey:@"****************" iv:@"################"];
	return [GTMBase64 encodeData:pData];
}

+ (NSData *)AES128DecryptedData:(NSData *)pData {
	//Set password and iv string here
	pData = [GTMBase64 decodeData:pData];
	return [pData AES128DecryptWithKey:@"****************" iv:@"################"];
}
@end

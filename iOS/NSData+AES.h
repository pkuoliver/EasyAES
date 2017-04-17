#import <Foundation/Foundation.h>

@class NSString;

@interface NSData (Encryption)

- (NSData *)AES128EncryptWithKey:(NSString *)key iv:(NSString *)iv;   //加密
- (NSData *)AES128DecryptWithKey:(NSString *)key iv:(NSString *)iv;   //解密

- (NSData *)AES128EncryptedDataWithKey:(NSString *)key;
- (NSData *)AES128DecryptedDataWithKey:(NSString *)key;
- (NSData *)AES128EncryptedDataWithKey:(NSString *)key iv:(NSString *)iv;
- (NSData *)AES128DecryptedDataWithKey:(NSString *)key iv:(NSString *)iv;

+ (NSData *)AES128DecryptedData:(NSData *)pData;
+ (NSData *)AES128EncryptedData:(NSData *)pData;
@end

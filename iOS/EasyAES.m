//
//  EasyAES.m
//  Test
//
//  Created by Wang Meng on 2022/8/23.
//

#import "EasyAES.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>
#import "GTMBase64.h"

#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@interface EasyAES(){
@private
    int mBit;
    uint mSize;
    unsigned char pIV[kCCKeySizeAES128 + 1];
    NSData *mPKey;
}
@end

@implementation EasyAES
- (instancetype)initWithKey:(NSString*)key andIV:(NSString*)iv {
    self = [super init];
    return [self initWithKey:key bit:128 andIV:iv];
}

- (instancetype)initWithKey:(NSString*)key bit:(int)bit andIV:(NSString*)iv {
    self = [super init];
    
    mBit = bit;
    mSize = kCCKeySizeAES128;
    if(mBit == 256) {
        mSize = kCCKeySizeAES256;
    }
    
    const char *cStr = [key UTF8String];
    unsigned char pKey[mSize + 1];
    bzero(pKey, sizeof(pKey));
    if(mBit == 256) {
        CC_SHA256(cStr, (CC_LONG)strlen(cStr), pKey);
    } else {
        CC_MD5(cStr, (CC_LONG)strlen(cStr), pKey);
    }
    mPKey = [NSData dataWithBytes:pKey length:mSize+1];

    cStr = [iv UTF8String];
    bzero(pIV, sizeof(pIV));
    CC_MD5(cStr, (CC_LONG)strlen(cStr), pIV);
    
    return self;
}

-(NSData*)operat:(int)opt data:(NSData*)pData {
    NSUInteger dataLength = [pData length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);

    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(opt,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding,
                                          mPKey.bytes,
                                          mSize,
                                          pIV,
                                          [pData bytes],
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

-(NSData*)encryptData:(NSData*)pData {
    pData = [self operat:kCCEncrypt data:pData];
    if(pData) {
        return [GTMBase64 encodeData:pData];
    }
    return nil;
}

-(NSData*)decryptData:(NSData*)pData {
    pData = [GTMBase64 decodeData:pData];
    return [self operat:kCCDecrypt data:pData];
}

-(NSString*)encrypt:(NSString*)content {
    if(content == nil)
        return nil;
    
    NSData* pData = [content dataUsingEncoding:NSUTF8StringEncoding];
    pData = [self encryptData:pData];
    return [[NSString alloc] initWithData:pData encoding:NSUTF8StringEncoding];
}

-(NSString*)decrypt:(NSString*)content {
    if(content == nil)
        return nil;
    
    NSData* pData = [content dataUsingEncoding:NSUTF8StringEncoding];
    pData = [self decryptData:pData];
    return [[NSString alloc] initWithData:pData encoding:NSUTF8StringEncoding];
}
@end

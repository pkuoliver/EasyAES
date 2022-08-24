//
//  EasyAES.h
//  Test
//
//  Created by Wang Meng on 2022/8/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EasyAES : NSObject
- (instancetype)initWithKey:(NSString*)key andIV:(NSString*)iv;
- (instancetype)initWithKey:(NSString*)key bit:(int)bit andIV:(NSString*)iv;

-(NSData*)encryptData:(NSData*)pData;
-(NSData*)decryptData:(NSData*)pData;

-(NSString*)encrypt:(NSString*)content;
-(NSString*)decrypt:(NSString*)content;
@end

NS_ASSUME_NONNULL_END

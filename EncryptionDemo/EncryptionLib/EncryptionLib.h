//
//  EncryptionLib.h
//  EncryptionDemo
//
//  Created by GrayLand on 17/2/9.
//  Copyright © 2017年 GrayLand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@interface EncryptionLib : NSObject {
    
}

+ (NSString *)md5encrypt:(NSString *)inputStr;
+ (NSString *)sha1encrypt:(NSString *)inputStr;

+ (NSData *) doCipherUseAesMethod:(NSData *)sTextIn
                              key:(NSData *)sKey
                          context:(CCOperation)encryptOrDecrypt;

+ (NSData *) doCipherUse3DesMethod:(NSData *)sTextIn
                               key:(NSData *)sKey
                           context:(CCOperation)encryptOrDecrypt;

+ (NSData *) doCipherUseDesMethod:(NSData *)sTextIn
                              key:(NSData *)sKey
                          context:(CCOperation)encryptOrDecrypt;

+ (NSData *) doCipherUseCastMethod:(NSData *)sTextIn
                               key:(NSData *)sKey
                           context:(CCOperation)encryptOrDecrypt;

+ (NSString *)encodeBase64WithString:(NSString *)inputStr;
+ (NSString *)encodeBase64WithData:(NSData *)inputData;

+ (NSData *) decodeBase64WithString:(NSString *)strBase64;

@end


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

+ (NSData *) md5:(NSString *)str;


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

+ (NSString *) encodeBase64WithString:(NSString *)strData;

+ (NSString *) encodeBase64WithData:(NSData *)objData;

+ (NSData *) decodeBase64WithString:(NSString *)strBase64;

@end


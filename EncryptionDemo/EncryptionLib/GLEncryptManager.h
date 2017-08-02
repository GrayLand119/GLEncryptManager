//
//  GLEncryptManager.h
//  EncryptionDemo
//
//  Created by GrayLand on 17/2/9.
//  Copyright © 2017年 GrayLand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@interface GLEncryptManager : NSObject {
    
}

#pragma -mark Hash

+ (NSString *)encryptMD5WithString:(NSString *)inputStr;
+ (NSString *)encryptSHA1WithString:(NSString *)inputStr;

#pragma -mark Encrypt & Decrypt

/**
 *  @brief 执行 AES128 加密/解密
 *
 *  @param inputData inputData
 *  @param key       key
 *  @param operation operation=kCCEncrypt - 加密, operation=kCCDecrypt - 解密
 *
 *  @return  result
 */
+ (NSData *)excuteAES128WithData:(NSData *)inputData
                       secureKey:(NSData *)key
                       operation:(CCOperation)operation;

+ (NSData *)excuteAES256WithData:(NSData *)inputData
                       secureKey:(NSData *)key
                       operation:(CCOperation)operation;

+ (NSData *)excuteDESWithData:(NSData *)inputData
                    secureKey:(NSData *)key
                    operation:(CCOperation)operation;

+ (NSData *)excute3DESWithData:(NSData *)inputData
                     secureKey:(NSData *)key
                     operation:(CCOperation)operation;

+ (NSData *)excuteCASTWithData:(NSData *)inputData
                     secureKey:(NSData *)key
                     operation:(CCOperation)operation;

+ (NSData *)encryptWithData:(NSData *)inputData
                  secureKey:(NSData *)key
                  algorithm:(CCAlgorithm)algorithm
                  operation:(CCOperation)operation;



#pragma -mark Base64

+ (NSString *)encodeBase64WithString:(NSString *)inputStr;
+ (NSString *)encodeBase64WithData:(NSData *)inputData;

+ (NSData *)decodeBase64WithString:(NSString *)strBase64;

@end


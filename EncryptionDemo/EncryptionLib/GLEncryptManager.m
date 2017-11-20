//
//  GLEncryptManager.m
//  EncryptionDemo
//
//  Created by GrayLand on 17/2/9.
//  Copyright © 2017年 GrayLand. All rights reserved.
//

#import "GLEncryptManager.h"

#ifndef __IPHONE_7_0

static const char _base64EncodingTable[64] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

static const short _base64DecodingTable[256] = {
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -1, -1, -2, -1, -1, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -1, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, 62, -2, -2, -2, 63,
    52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -2, -2, -2, -2, -2, -2,
    -2, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
    15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -2, -2, -2, -2, -2,
    -2, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
    41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2
};

#endif

@implementation GLEncryptManager

#pragma -mark Hash

+ (NSString *)encryptMD5WithString:(NSString *)inputStr {
    const char *cStr = [inputStr UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5( cStr, (unsigned int)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

+ (NSString *)encryptSHA1WithString:(NSString *)inputStr {
    const char *cstr = [inputStr cStringUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [NSData dataWithBytes:cstr length:inputStr.length];
    //使用对应的CC_SHA1,CC_SHA256,CC_SHA384,CC_SHA512的长度分别是20,32,48,64
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    //使用对应的CC_SHA256,CC_SHA384,CC_SHA512
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

#pragma - mark Encrypt & Decrypt

+ (NSData *)excuteAES128WithData:(NSData *)inputData
                     secureKey:(NSData *)key
                     operation:(CCOperation)operation {
    return [GLEncryptManager encryptWithData:inputData secureKey:key algorithm:kCCAlgorithmAES128 operation:operation];
}

+ (NSData *)excuteAES256WithData:(NSData *)inputData
                     secureKey:(NSData *)key
                     operation:(CCOperation)operation {
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    NSString *keyStr = [[NSString alloc] initWithData:key encoding:NSUTF8StringEncoding];
    [keyStr getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [inputData length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(operation,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr,
                                          kCCKeySizeAES256,
                                          NULL,
                                          [inputData bytes],
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

+ (NSData *)excuteAES256CBCModeWithData:(NSData *)inputData key:(NSString *)key iv:(NSString *)iv operation:(CCOperation)operation {
    char keyPtr[kCCKeySizeAES256 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    // IV
    char ivPtr[kCCKeySizeAES256 + 1];
    bzero(ivPtr, sizeof(ivPtr));
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [inputData length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptorStatus = CCCrypt(operation, kCCAlgorithmAES128,
                                            kCCOptionPKCS7Padding,
                                            keyPtr, kCCKeySizeAES256,
                                            ivPtr,
                                            [inputData bytes], dataLength,
                                            buffer, bufferSize,
                                            &numBytesEncrypted);
    
    if(cryptorStatus == kCCSuccess){
        NSLog(@"Success");
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }else{
        NSLog(@"Error");
    }
    
    free(buffer);
    return nil;
}

+ (NSData *)excuteDESWithData:(NSData *)inputData
                        secureKey:(NSData *)key
                        operation:(CCOperation)operation {
    return [GLEncryptManager encryptWithData:inputData secureKey:key algorithm:kCCAlgorithmDES operation:operation];
}

+ (NSData *)excute3DESWithData:(NSData *)inputData
                     secureKey:(NSData *)key
                     operation:(CCOperation)operation {
    return [GLEncryptManager encryptWithData:inputData secureKey:key algorithm:kCCAlgorithm3DES operation:operation];
}

+ (NSData *)excuteCASTWithData:(NSData *)inputData
                     secureKey:(NSData *)key
                     operation:(CCOperation)operation {
    return [GLEncryptManager encryptWithData:inputData secureKey:key algorithm:kCCAlgorithmCAST operation:operation];
}

+ (NSData *)encryptWithData:(NSData *)inputData
                  secureKey:(NSData *)key
                  algorithm:(CCAlgorithm)algorithm
                  operation:(CCOperation)operation {
    
    NSData * dTextIn;
    
    dTextIn = [inputData mutableCopy];
    
    NSMutableData * dKey = [key mutableCopy];
    int moreSize = 0;
    
    //make key to standard;
    switch (algorithm) {
        case kCCAlgorithmDES:
            moreSize = kCCBlockSizeDES;
            [dKey setLength:kCCKeySizeDES];
            break;
        case kCCAlgorithm3DES:
            moreSize = kCCBlockSize3DES;
            [dKey setLength:kCCKeySize3DES];
            break;
        case kCCAlgorithmAES128:
            moreSize = kCCBlockSizeAES128;
            [dKey setLength:kCCKeySizeAES128];
            break;
        case kCCAlgorithmCAST:
            moreSize = kCCBlockSizeCAST;
            [dKey setLength:kCCKeySizeMaxCAST];
            break;
        case kCCAlgorithmRC4:
        case kCCAlgorithmRC2:
            moreSize = kCCBlockSizeRC2;
            [dKey setLength:kCCKeySizeMaxRC2];
            break;
        default:
            return nil;
            break;
    }
    
    uint8_t *bufferPtr1 = NULL;
    size_t bufferPtrSize1 = 0;
    size_t movedBytes1 = 0;
    unsigned char iv[8];
    memset(iv, 0, 8);
    
    bufferPtrSize1 = [inputData length] + moreSize;
    
    bufferPtr1 = malloc(bufferPtrSize1);
    memset((void *)bufferPtr1, 0, bufferPtrSize1);
    
    // cryption....
    CCCryptorStatus ccStatus = CCCrypt(operation, // CCOperation op
                                       algorithm, // CCAlgorithm alg
                                       kCCOptionPKCS7Padding|kCCOptionECBMode, // CCOptions options
                                       [dKey bytes], // const void *key
                                       [dKey length], // size_t keyLength
                                       iv, // const void *iv
                                       [dTextIn bytes], // const void *dataIn
                                       [dTextIn length], // size_t dataInLength
                                       (void *)bufferPtr1, // void *dataOut
                                       bufferPtrSize1, // size_t dataOutAvailable
                                       &movedBytes1); // size_t *dataOutMoved
    
    // output situation after crypt
    switch (ccStatus) {
        case kCCSuccess:
            NSLog(@"SUCCESS");
            break;
        case kCCParamError:
            NSLog(@"PARAM ERROR");
            break;
        case kCCBufferTooSmall:
            NSLog(@"BUFFER TOO SMALL");
            break;
        case kCCMemoryFailure:
            NSLog(@"MEMORY FAILURE");
            break;
        case kCCAlignmentError:
            NSLog(@"ALIGNMENT ERROR");
            break;
        case kCCDecodeError:
            NSLog(@"DECODE ERROR");
            break;
        case kCCUnimplemented:
            NSLog(@"UNIMPLEMENTED");
            break;
        default:
            break;
    }
    
    if (ccStatus == kCCSuccess){
        NSData *result = [NSData dataWithBytes:bufferPtr1 length:movedBytes1];
        free(bufferPtr1);
        return result;
    }
    free(bufferPtr1);
    return nil;
}

#pragma mark - Base64

+ (NSString *)encodeBase64WithString:(NSString *)inputStr {
#ifdef __IPHONE_7_0
    NSData *preData = [inputStr dataUsingEncoding:NSUTF8StringEncoding];
    return [preData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
#else
    NSData *data = [inputStr dataUsingEncoding:NSUTF8StringEncoding];
    return [EncryptionLib encodeBase64WithData:data];
#endif
}
+ (NSString *)encodeBase64WithData:(NSData *)objData {
    
#ifdef __IPHONE_7_0
    return [objData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
#else
    const unsigned char * objRawData = [objData bytes];
    char * objPointer;
    char * strResult;
    
    // Get the Raw Data length and ensure we actually have data
    int intLength = (int)[objData length];
    if (intLength == 0) return nil;
    
    // Setup the String-based Result placeholder and pointer within that placeholder
    strResult = (char *)calloc(((intLength + 2) / 3) * 4, sizeof(char));
    objPointer = strResult;
    
    // Iterate through everything
    while (intLength > 2) { // keep going until we have less than 24 bits
        *objPointer++ = _base64EncodingTable[objRawData[0] >> 2];
        *objPointer++ = _base64EncodingTable[((objRawData[0] & 0x03) << 4) + (objRawData[1] >> 4)];
        *objPointer++ = _base64EncodingTable[((objRawData[1] & 0x0f) << 2) + (objRawData[2] >> 6)];
        *objPointer++ = _base64EncodingTable[objRawData[2] & 0x3f];
        
        // we just handled 3 octets (24 bits) of data
        objRawData += 3;
        intLength -= 3;
    }
    
    // now deal with the tail end of things
    if (intLength != 0) {
        *objPointer++ = _base64EncodingTable[objRawData[0] >> 2];
        if (intLength > 1) {
            *objPointer++ = _base64EncodingTable[((objRawData[0] & 0x03) << 4) + (objRawData[1] >> 4)];
            *objPointer++ = _base64EncodingTable[(objRawData[1] & 0x0f) << 2];
            *objPointer++ = '=';
        } else {
            *objPointer++ = _base64EncodingTable[(objRawData[0] & 0x03) << 4];
            *objPointer++ = '=';
            *objPointer++ = '=';
        }
    }
    
    // Terminate the string-based result
    *objPointer = '\0';
    
    // Return the results as an NSString object
    return [NSString stringWithCString:strResult encoding:NSASCIIStringEncoding];
#endif
}

+ (NSData *)decodeBase64WithString:(NSString *)strBase64 {
    
#ifdef __IPHONE_7_0
//    NSData *preData = [strBase64 dataUsingEncoding:NSUTF8StringEncoding];
//    return [preData base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return [[NSData alloc] initWithBase64EncodedString:strBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
#else
    const char * objPointer = [strBase64 cStringUsingEncoding:NSASCIIStringEncoding];
    int intLength = (int)strlen(objPointer);
    int intCurrent;
    int i = 0, j = 0, k;
    
    unsigned char * objResult;
    objResult = calloc(intLength, sizeof(char));
    
    // Run through the whole string, converting as we go
    while ( ((intCurrent = *objPointer++) != '\0') && (intLength-- > 0) ) {
        if (intCurrent == '=') {
            if (*objPointer != '=' && ((i % 4) == 1)) {// || (intLength > 0)) {
                // the padding character is invalid at this point -- so this entire string is invalid
                free(objResult);
                return nil;
            }
            continue;
        }
        
        intCurrent = _base64DecodingTable[intCurrent];
        if (intCurrent == -1) {
            // we're at a whitespace -- simply skip over
            continue;
        } else if (intCurrent == -2) {
            // we're at an invalid character
            free(objResult);
            return nil;
        }
        
        switch (i % 4) {
            case 0:
                objResult[j] = intCurrent << 2;
                break;
                
            case 1:
                objResult[j++] |= intCurrent >> 4;
                objResult[j] = (intCurrent & 0x0f) << 4;
                break;
                
            case 2:
                objResult[j++] |= intCurrent >>2;
                objResult[j] = (intCurrent & 0x03) << 6;
                break;
                
            case 3:
                objResult[j++] |= intCurrent;
                break;
        }
        i++;
    }
    
    // mop things up if we ended on a boundary
    k = j; 
    if (intCurrent == '=') { 
        switch (i % 4) { 
            case 1: 
                // Invalid state 
                free(objResult); 
                return nil; 
                
            case 2: 
                k++; 
                // flow through 
            case 3: 
                objResult[k] = 0; 
        } 
    } 
    
    // Cleanup and setup the return NSData 
    NSData * objData = [[NSData alloc] initWithBytes:objResult length:j];
    
    free(objResult);
    
    return objData;
#endif
} 

@end

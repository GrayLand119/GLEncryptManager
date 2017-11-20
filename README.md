# EncryptionDemo
MD5,Base64,AES128,ASE256,3DES,DES,CAST加密

![example](https://github.com/GrayLand119/GLEncryptManager/blob/master/EncryptDemo1.jpg)

![example2](https://github.com/GrayLand119/GLEncryptManager/blob/master/EncryptDemo2.jpg)


# GLEncryptManager

## 使用方法

```
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
```

## 安装方法

在 Podfile 中添加以下代码:

```
pod 'GLEncryptManager', :git => "https://github.com/GrayLand119/GLEncryptManager.git"
```

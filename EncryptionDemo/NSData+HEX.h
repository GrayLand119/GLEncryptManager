//
//  NSData+HEX.h
//  BodyPlusECG
//
//  Created by GrayLand on 2017/11/20.
//  Copyright © 2017年 BodyPlus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (HEX)

+ (NSData *)dataWithHEXString:(NSString *)str;

- (NSString *)hexString;

@end

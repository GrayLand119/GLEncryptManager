//
//  SelectAlgorithmTableViewController.h
//  EncryptionDemo
//
//  Created by GrayLand on 17/2/11.
//  Copyright © 2017年 GrayLand. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AlgorithmType) {
    AlgorithmTypeMD5 = 0,
    AlgorithmTypeSHA1,
    AlgorithmTypeBase64,
    AlgorithmTypeAES128,
    AlgorithmTypeAES256,
    AlgorithmTypeAES256CBC,
    AlgorithmTypeDES,
    AlgorithmType3DES,
    AlgorithmTypeCAST,
    AlgorithmTypeNone
};

@interface SelectAlgorithmTableViewController : UITableViewController

@property (nonatomic, copy) void (^didSelectAlgorithmHandler)(NSString *title, AlgorithmType type);

@end

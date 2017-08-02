//
//  ViewController.m
//  EncryptionDemo
//
//  Created by GrayLand on 17/2/9.
//  Copyright © 2017年 GrayLand. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+TapHideKeyboard.h"
#import "SelectAlgorithmTableViewController.h"
#import "GLEncryptManager.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightBarBtnItem;
@property (weak, nonatomic) IBOutlet UIButton *decryptBtn;

@property (weak, nonatomic) IBOutlet UITextView *inputTextView;
@property (weak, nonatomic) IBOutlet UITextView *outputTextView;

@property (weak, nonatomic) IBOutlet UITextField *secureKeyTextFiled;

@property (weak, nonatomic) IBOutlet UILabel *runtimeLabel;

@property (nonatomic, assign) AlgorithmType algorithmType;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Add tap to hide keyboard method
    [self addTapToHideGestureInView:self.view];
    
}

#pragma mark - Setter

- (void)setAlgorithmType:(AlgorithmType)algorithmType {
    
    _algorithmType = algorithmType;
    
    _secureKeyTextFiled.enabled = algorithmType > AlgorithmTypeBase64;
    _decryptBtn.enabled = algorithmType > AlgorithmTypeSHA1;
}

#pragma mark - Encrypt & Decrypt

- (void)hashMD5 {
    _outputTextView.text = [GLEncryptManager encryptMD5WithString:_inputTextView.text];
}

- (void)hashSHA1 {
    _outputTextView.text = [GLEncryptManager encryptSHA1WithString:_inputTextView.text];
}

- (void)excuteBase64WithEncrypt:(BOOL)isEncrypt {
    
    NSString *resultString;
    if (isEncrypt) {
        resultString = [GLEncryptManager encodeBase64WithString:_inputTextView.text];
    }else{
        NSData *proData = [GLEncryptManager decodeBase64WithString:_inputTextView.text];
        resultString = [[NSString alloc] initWithData:proData encoding:NSUTF8StringEncoding];
    }
    
    _outputTextView.text = resultString;
    
}

- (void)excuteASE128WithEncrypt:(BOOL)isEncrypt {
    
    NSData *resultData;
    NSString *resultString;
    
    if (isEncrypt) {
        
        NSData *encryptData = [_inputTextView.text dataUsingEncoding:NSUTF8StringEncoding];
        resultData = [GLEncryptManager excuteAES128WithData:encryptData
                                               secureKey:[_secureKeyTextFiled.text dataUsingEncoding:NSUTF8StringEncoding]
                                               operation:kCCEncrypt];
        
        resultString = [GLEncryptManager encodeBase64WithData:resultData];
        
    }else{
        resultData = [GLEncryptManager excuteAES128WithData:[GLEncryptManager decodeBase64WithString:_inputTextView.text]
                                               secureKey:[_secureKeyTextFiled.text dataUsingEncoding:NSUTF8StringEncoding]
                                               operation:kCCDecrypt];
        resultString = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    }
    
    _outputTextView.text = resultString;
}

- (void)excuteASE256WithEncrypt:(BOOL)isEncrypt {
    
    NSData *resultData;
    NSString *resultString;
    
    if (isEncrypt) {
        
        NSData *encryptData = [_inputTextView.text dataUsingEncoding:NSUTF8StringEncoding];
        resultData = [GLEncryptManager excuteAES256WithData:encryptData
                                               secureKey:[_secureKeyTextFiled.text dataUsingEncoding:NSUTF8StringEncoding]
                                               operation:kCCEncrypt];
        resultString = [GLEncryptManager encodeBase64WithData:resultData];
        
    }else{
        resultData = [GLEncryptManager excuteAES256WithData:[GLEncryptManager decodeBase64WithString:_inputTextView.text]
                                               secureKey:[_secureKeyTextFiled.text dataUsingEncoding:NSUTF8StringEncoding]
                                               operation:kCCDecrypt];
        resultString = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    }
    
    _outputTextView.text = resultString;
}

- (void)excuteDESWithEncrypt:(BOOL)isEncrypt {
    
    NSData *resultData;
    NSString *resultString;
    
    if (isEncrypt) {
        NSData *encryptData = [_inputTextView.text dataUsingEncoding:NSUTF8StringEncoding];
        resultData = [GLEncryptManager excuteDESWithData:encryptData secureKey:[_secureKeyTextFiled.text dataUsingEncoding:NSUTF8StringEncoding] operation:kCCEncrypt];
        
        resultString = [GLEncryptManager encodeBase64WithData:resultData];
    }else{
        resultData = [GLEncryptManager excuteDESWithData:[GLEncryptManager decodeBase64WithString:_inputTextView.text] secureKey:[_secureKeyTextFiled.text dataUsingEncoding:NSUTF8StringEncoding] operation:kCCDecrypt];
        
        resultString = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    }
    
    _outputTextView.text = resultString;
}

- (void)excute3DESWithEncrypt:(BOOL)isEncrypt {
    
    NSData *resultData;
    NSString *resultString;
    
    if (isEncrypt) {
        NSData *encryptData = [_inputTextView.text dataUsingEncoding:NSUTF8StringEncoding];
        resultData = [GLEncryptManager excute3DESWithData:encryptData secureKey:[_secureKeyTextFiled.text dataUsingEncoding:NSUTF8StringEncoding] operation:kCCEncrypt];
        resultString = [GLEncryptManager encodeBase64WithData:resultData];
    }else{
        resultData = [GLEncryptManager excute3DESWithData:[GLEncryptManager decodeBase64WithString:_inputTextView.text] secureKey:[_secureKeyTextFiled.text dataUsingEncoding:NSUTF8StringEncoding] operation:kCCDecrypt];
        resultString = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    }
    
    _outputTextView.text = resultString;
}

- (void)excuteCASTWithEncrypt:(BOOL)isEncrypt {
    
    NSData *resultData;
    NSString *resultString;
    
    if (isEncrypt) {
        NSData *encryptData = [GLEncryptManager decodeBase64WithString:_inputTextView.text];
        resultData = [GLEncryptManager excuteCASTWithData:encryptData secureKey:[_secureKeyTextFiled.text dataUsingEncoding:NSUTF8StringEncoding] operation:kCCEncrypt];
        resultString = [GLEncryptManager encodeBase64WithData:resultData];
    }else{
        resultData = [GLEncryptManager excuteCASTWithData:[GLEncryptManager decodeBase64WithString:_inputTextView.text] secureKey:[_secureKeyTextFiled.text dataUsingEncoding:NSUTF8StringEncoding] operation:kCCDecrypt];
        resultString = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    }
    
    _outputTextView.text = resultString;
}

#pragma mark - OnEvent

- (IBAction)onEncrypt:(UIButton *)sender {
    
    [self.view endEditing:NO];
    
    NSDate* tmpStartData = [NSDate date];
    //Calculate runtime ======
    
    switch (_algorithmType) {
        case AlgorithmTypeMD5: {
            [self hashMD5];
        }break;
            
        case AlgorithmTypeBase64: {
            [self excuteBase64WithEncrypt:YES];
        }break;
            
        case AlgorithmTypeSHA1: {
            [self hashSHA1];
        }break;
            
        case AlgorithmTypeASE128: {
            [self excuteASE128WithEncrypt:YES];
        }break;
         
        case AlgorithmTypeASE256: {
            [self excuteASE256WithEncrypt:YES];
        }break;
            
        case AlgorithmTypeDES: {
            [self excuteDESWithEncrypt:YES];
        }break;
          
        case AlgorithmType3DES: {
            [self excute3DESWithEncrypt:YES];
        }break;
          
        case AlgorithmTypeCAST: {
            [self excuteCASTWithEncrypt:YES];
        }break;
            
        default:
            break;
    }
    
    //======
    double deltaTime = [[NSDate date] timeIntervalSinceDate:tmpStartData];
    NSLog(@"cost time = %f", deltaTime);
    _runtimeLabel.text = [NSString stringWithFormat:@"%.4fs", deltaTime];
    
}

- (IBAction)onDecrypt:(UIButton *)sender {
    
    [self.view endEditing:NO];
    
    NSDate* tmpStartData = [NSDate date];
    //Calculate runtime ======

    switch (_algorithmType) {
        case AlgorithmTypeBase64: {
            [self excuteBase64WithEncrypt:NO];
        }break;
            
        case AlgorithmTypeASE128: {
            [self excuteASE128WithEncrypt:NO];
        }break;

        case AlgorithmTypeASE256: {
            [self excuteASE256WithEncrypt:NO];
        }break;

        case AlgorithmTypeDES: {
            [self excuteDESWithEncrypt:NO];
        }break;
            
        case AlgorithmType3DES: {
            [self excute3DESWithEncrypt:NO];
        }break;
            
        case AlgorithmTypeCAST: {
            [self excuteCASTWithEncrypt:NO];
        }break;
            
        default:
            break;
    }
    
    //======
    double deltaTime = [[NSDate date] timeIntervalSinceDate:tmpStartData];
    NSLog(@"cost time = %f", deltaTime);
    _runtimeLabel.text = [NSString stringWithFormat:@"%.4fs", deltaTime];
    
}

- (IBAction)onSelectAlgorithm:(UIBarButtonItem *)sender {
    
    SelectAlgorithmTableViewController *vc = [SelectAlgorithmTableViewController new];
    
    __weak __typeof(self) ws = self;
    [vc setDidSelectAlgorithmHandler:^(NSString *title, AlgorithmType type) {
        
        [ws.rightBarBtnItem setTitle:title];
        ws.algorithmType = type;
    }];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end

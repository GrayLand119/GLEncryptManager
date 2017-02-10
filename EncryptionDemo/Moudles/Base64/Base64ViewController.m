//
//  Base64ViewController.m
//  EncryptionDemo
//
//  Created by GrayLand on 17/2/10.
//  Copyright © 2017年 GrayLand. All rights reserved.
//

#import "Base64ViewController.h"
#import "UIActionSheet+BlocksKit.h"
#import "EncryptionLib.h"

typedef NS_ENUM(NSUInteger, EncryptionType) {
    EncryptionTypeMD5,
    EncryptionTypeSHA1,
};

@interface Base64ViewController ()

@property (nonatomic, assign) EncryptionType encryptionType;

@property (weak, nonatomic) IBOutlet UITextView *encryptTextView;

@property (weak, nonatomic) IBOutlet UITextView *resultTextView;

@property (weak, nonatomic) IBOutlet UIButton *selectAlgorithmBtn;

@end

@implementation Base64ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"散列/哈希";
    
}

#pragma mark - Setter

- (void)setEncryptionType:(EncryptionType)encryptionType {
    
    _encryptionType = encryptionType;
    
    if (!_selectAlgorithmBtn) {
        return;
    }
    
    switch (encryptionType) {
        case EncryptionTypeMD5:
            [_selectAlgorithmBtn setTitle:@"MD5" forState:UIControlStateNormal];
            break;
            
        case EncryptionTypeSHA1:
            [_selectAlgorithmBtn setTitle:@"SHA1" forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
}
#pragma mark - onEvent

- (IBAction)onSelectAlgorithm:(id)sender {
    
    [_encryptTextView resignFirstResponder];
    
    UIActionSheet *sheet = [UIActionSheet bk_actionSheetWithTitle:@"选择算法"];
    
    __weak __typeof(self) ws = self;
    [sheet bk_addButtonWithTitle:@"MD5" handler:^{
        ws.encryptionType = EncryptionTypeMD5;
    }];
    
    [sheet bk_addButtonWithTitle:@"SHA1" handler:^{
        ws.encryptionType = EncryptionTypeSHA1;
    }];
    
    [sheet showInView:self.view];
}

- (IBAction)onEncrypt:(id)sender {
    
    [_encryptTextView resignFirstResponder];
    
    NSString *encryptString;
    
    switch (_encryptionType) {
        case EncryptionTypeMD5: {
            encryptString = [EncryptionLib md5encrypt:_encryptTextView.text];
        }break;
         
        case EncryptionTypeSHA1: {
            encryptString = [EncryptionLib sha1encrypt:_encryptTextView.text];
        }break;
            
        default:
            break;
    }
    
    _resultTextView.text = encryptString;
    
}

@end

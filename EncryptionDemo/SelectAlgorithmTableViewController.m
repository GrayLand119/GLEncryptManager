//
//  SelectAlgorithmTableViewController.m
//  EncryptionDemo
//
//  Created by GrayLand on 17/2/11.
//  Copyright © 2017年 GrayLand. All rights reserved.
//

#import "SelectAlgorithmTableViewController.h"

@interface SelectAlgorithmTableViewController ()

@property (nonatomic, strong) NSArray *cellTitles;

@end

@implementation SelectAlgorithmTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupViews];
    
}

- (void)setupViews {
    
    NSMutableArray *tArr = [NSMutableArray array];
    for (int i = 0; i < AlgorithmTypeNone; i++) {
        
        switch (i) {
                
            case AlgorithmTypeMD5: {
                [tArr addObject:@"MD5"];
            }break;
                
            case AlgorithmTypeSHA1: {
                [tArr addObject:@"SHA1"];
            }break;
                
            case AlgorithmTypeBase64: {
                [tArr addObject:@"Base64"];
            }break;
                
            case AlgorithmTypeASE128: {
                [tArr addObject:@"ASE128"];
            }break;
            
            case AlgorithmTypeASE256: {
                [tArr addObject:@"ASE256"];
            }break;
                
            case AlgorithmTypeDES: {
                [tArr addObject:@"DES"];
            }break;
                
            case AlgorithmType3DES: {
                [tArr addObject:@"3DES"];
            }break;
              
            case AlgorithmTypeCAST: {
                [tArr addObject:@"CAST"];
            }break;
                
            default:
                break;
        }
    }
    
    _cellTitles = tArr;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"commonCell"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellTitles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commonCell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = _cellTitles[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_didSelectAlgorithmHandler) {
        _didSelectAlgorithmHandler(_cellTitles[indexPath.row], indexPath.row);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end

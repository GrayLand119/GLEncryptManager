//
//  ViewController.m
//  EncryptionDemo
//
//  Created by GrayLand on 17/2/9.
//  Copyright © 2017年 GrayLand. All rights reserved.
//

#import "ViewController.h"
#import "Base64ViewController.h"

@interface ViewController ()
<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *cellTitles;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupViews];
}

- (void)setupViews {
    
    _cellTitles = @[@"加密/解密",
                    @"散列/哈希",
                    @"Base64",
                    @"图片/Base64"];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellTitles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"commonCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = _cellTitles[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
            
        case 0:{
            
        }break;
         
        case 1:{
            Base64ViewController *vc = [Base64ViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }break;
            
        case 2:{
            
        }break;
            
        case 3:{
            
        }break;
            
        default:
            break;
    }
}
@end

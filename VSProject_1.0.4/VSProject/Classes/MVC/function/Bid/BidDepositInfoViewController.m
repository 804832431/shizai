//
//  bidDepositInfoViewController.m
//  VSProject
//
//  Created by 陈 海涛 on 16/10/31.
//  Copyright © 2016年 user. All rights reserved.
//

#import "BidDepositInfoViewController.h"
#import "BidDepositTableViewCell.h"
#import "Masonry.h"
#import "BidDepositPayViewController.h"

@interface BidDepositInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) UIButton *payButton;

@end

@implementation BidDepositInfoViewController

- (UIButton *)payButton{
    if (_payButton == nil) {
        _payButton = [UIButton buttonWithType:UIButtonTypeCustom];

        [_payButton setBackgroundColor:[UIColor colorWithRed:255/255.0 green:185/255.0 blue:51/255.0 alpha:1]];
        [_payButton setTitle:@"立即支付" forState:UIControlStateNormal];
        [_payButton.titleLabel setTextColor:[UIColor whiteColor]];
        
        
        [_payButton addTarget:self action:@selector(payButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payButton;
}

- (void)payButtonAction{
    NSLog(@"%s",__func__);
    
    BidDepositPayViewController *payVC = [BidDepositPayViewController new];
    
    payVC.orderId = self.bidPro.orderId;
    
    [self.navigationController pushViewController:payVC animated:YES];
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        
        _tableView.backgroundColor = _Colorhex(0xf4f4f4);
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UINib *nib = [UINib nibWithNibName:@"BidDepositTableViewCell" bundle:nil];
        [_tableView registerNib:nib forCellReuseIdentifier:NSStringFromClass([BidDepositTableViewCell class])];
        
    }
    
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self vs_setTitleText:@"保证金支付"];
    
    __weak typeof(self) weakSelf = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.bottom.equalTo(weakSelf.view);
    }];
    
    
    [self.view addSubview:self.payButton];
    [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(weakSelf.view);
        make.height.mas_equalTo(50);
    }];
}


#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BidDepositTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BidDepositTableViewCell class])];
    
    cell.bidPro = self.bidPro;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static BidDepositTableViewCell *cell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
         cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BidDepositTableViewCell class])];
    });
    
    cell.bidPro = self.bidPro;
    
    NSLog(@"---------------%f",CGRectGetMaxY(cell.callbackDescription.frame));
    
    return CGRectGetMaxY(cell.callbackDescription.frame);

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001;
}



@end

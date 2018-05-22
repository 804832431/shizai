//
//  NewCenterOrderViewController.m
//  VSProject
//
//  Created by 陈 海涛 on 16/7/29.
//  Copyright © 2016年 user. All rights reserved.
//

#import "NewCenterOrderViewController.h"
#import "NewCenterOrderCell.h"
#import "BuyOrderViewController.h"
#import "ServiceOrderViewController.h"
#import "RefundViewController.h"

@interface  NewCenterOrderViewController ()
{
    
    NSArray *topNameArray;
    
}

_PROPERTY_NONATOMIC_STRONG(UITableView, tableView)
_PROPERTY_NONATOMIC_STRONG(UIImageView, headImageView)
_PROPERTY_NONATOMIC_STRONG(UILabel, nickNameLabel)

@end

@implementation NewCenterOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    
    
    [self vs_showRightButton:NO];
    
    
    [self vs_setTitleText:@"订单中心"];
    
    
    topNameArray = @[@"服务订单",@"购买订单",@"退款订单"];
    
    
    [self.view addSubview:self.tableView];
    
    
}





#pragma mark -- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return topNameArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 49;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewCenterOrderCell  *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NewCenterOrderCell class])];
    
    
    
    cell.contentTitleLabel.text = topNameArray[indexPath.row];
    
    
    
    return cell;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *title = topNameArray[indexPath.row];
    
    //@[@"服务订单",@"购买订单",@"退款订单"];
    if ([title isEqualToString:@"服务订单"]) {
        
        ServiceOrderViewController *vc = [ServiceOrderViewController new];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([title isEqualToString:@"购买订单"]) {
        
        BuyOrderViewController *vc = [BuyOrderViewController new];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([title isEqualToString:@"退款订单"]) {
        
        RefundViewController *vc = [RefundViewController new];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}


_GETTER_ALLOC_BEGIN(UITableView, tableView) {
    
    _tableView.frame = CGRectMake(0, 0, GetWidth(self.view), GetHeight(self.view));
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = (id<UITableViewDelegate>)self;
    _tableView.dataSource = (id<UITableViewDataSource>)self;
    
    _tableView.backgroundColor = _COLOR_WHITE;
    
    [_tableView registerClass:[NewCenterOrderCell class] forCellReuseIdentifier:NSStringFromClass([NewCenterOrderCell class])];
    
}
_GETTER_END(tableView)
@end

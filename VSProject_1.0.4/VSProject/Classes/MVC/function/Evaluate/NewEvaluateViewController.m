//
//  NewEvaluateViewController.m
//  VSProject
//
//  Created by 陈 海涛 on 16/7/30.
//  Copyright © 2016年 user. All rights reserved.
//

#import "NewEvaluateViewController.h"
#import "EvaluateOrderInfoCell.h"
#import "EvaluateOrderCell.h"
#import "EvaluateTextCell.h"
#import "BCNetWorkTool.h"



@interface  NewEvaluateViewController ()
{
    
    
    NSArray *topNameArray;
    
    
}

_PROPERTY_NONATOMIC_STRONG(UITableView, tableView)

_PROPERTY_NONATOMIC_STRONG(UIButton, bottomButton)

_PROPERTY_NONATOMIC_ASSIGN(NSInteger, score);

_PROPERTY_NONATOMIC_STRONG(NSString, evaluteContent)


@end

@implementation NewEvaluateViewController

- (UIButton *)bottomButton{
    if (_bottomButton == nil) {
        _bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bottomButton.backgroundColor = _COLOR_HEX(0xf15353);
        [_bottomButton addTarget:self action:@selector(buttonAciton) forControlEvents:UIControlEventTouchUpInside];
        [_bottomButton setTitle:@"提交评价" forState:UIControlStateNormal];
        [_bottomButton setTitleColor:_COLOR_WHITE forState:UIControlStateNormal];
        _bottomButton.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _bottomButton;
}

- (void)buttonAciton{
    
    if (self.score == 0) {
        [self.view showTipsView:@"请评价分数"];
        return;
    }
    
    if (self.evaluteContent.length > 500) {
        [self.view showTipsView:@"评价不能超过500字"];
        return;
    }
    
    if (self.evaluteContent.length == 0) {
        [self.view showTipsView:@"请评价文字"];
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    
    [self vs_showLoading];
    
    //    {"merchantId":10001,"orderId":"order12345","star":5,"remark":"备注"}
    
    NSDictionary *dic = @{@"merchantId":self.order.orderHeader.storeId,@"orderId":self.order.orderHeader.orderId,@"star":@(self.score),@"remark":self.evaluteContent};
    
    NSData *contentData = (NSData *)[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString* jsonContent = [[NSString alloc] initWithData:contentData encoding:NSUTF8StringEncoding];
    
    NSDictionary * contentDic = [NSDictionary dictionaryWithObjectsAndKeys:jsonContent,@"content", nil];
    
    [BCNetWorkTool executePostNetworkWithParameter:contentDic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.account/rate-merchant" withSuccess:^(id callBackData) {
        
        [weakSelf vs_hideLoadingWithCompleteBlock:NULL];
        
        [weakSelf.view showTipsView:@"评价成功！"];
        
        weakSelf.order.orderHeader.isCanRate = @"N";
        
        if (weakSelf.evaluateBlock) {
            weakSelf.evaluateBlock();
        }
        
        [weakSelf.navigationController popViewControllerAnimated:YES];
        
    } orFail:^(id callBackData) {
        
        [weakSelf vs_hideLoadingWithCompleteBlock:NULL];
        
        [weakSelf.view showTipsView:[callBackData domain]];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    
    
    [self vs_showRightButton:NO];
    
    
    [self vs_setTitleText:@"订单评价"];
    
    
    [self.view addSubview:self.tableView];
    
    [self.view addSubview:self.bottomButton];
    
    __weak typeof(self) weakSelf = self;
    [self.bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.equalTo(weakSelf.view);
        make.height.equalTo(@52);
    }];
    
    self.score = 5;
    
}





#pragma mark -- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 105;
    }else if (indexPath.row == 1){
        return 117;
    }else{
        return 300;
    }
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    __weak typeof(self) weakSelf = self;
    
    if (indexPath.row == 0) {
        
        EvaluateOrderInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EvaluateOrderInfoCell class])];
        cell.order = self.order;
        
        return cell;
    }else if(indexPath.row == 1){
        EvaluateOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EvaluateOrderCell class])];
        
        
        
        [cell setStarBlock:^(NSInteger score) {
            weakSelf.score = score;
        }];
        
        return cell;
        
    }else {
        
        EvaluateTextCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EvaluateTextCell class])];
        
        [cell setEvaluateTextBlock:^(NSString * str) {
            weakSelf.evaluteContent = str;
        }];
        
        return cell;
    }
    
    
}







_GETTER_ALLOC_BEGIN(UITableView, tableView) {
    
    _tableView.frame = CGRectMake(0, 0, GetWidth(self.view), GetHeight(self.view));
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = (id<UITableViewDelegate>)self;
    _tableView.dataSource = (id<UITableViewDataSource>)self;
    
    _tableView.backgroundColor = _COLOR_WHITE;
    
    [_tableView registerClass:[EvaluateOrderInfoCell class] forCellReuseIdentifier:NSStringFromClass([EvaluateOrderInfoCell class])];
    
    [_tableView registerClass:[EvaluateOrderCell class] forCellReuseIdentifier:NSStringFromClass([EvaluateOrderCell class])];
    
    [_tableView registerClass:[EvaluateTextCell class] forCellReuseIdentifier:NSStringFromClass([EvaluateTextCell class])];
    
    
    
}
_GETTER_END(tableView)

@end

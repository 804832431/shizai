//
//  RefundReasonViewController.m
//  VSProject
//
//  Created by 陈 海涛 on 15/11/26.
//  Copyright © 2015年 user. All rights reserved.
//

#import "RefundReasonViewController.h"
#import "UIColor+TPCategory.h"
#import "BCNetWorkTool.h"
#import "RefundResonTopTableViewCell.h"
#import "VSConst.h"
#import "ReundResonMiddleTableViewCell.h"
#import "ReundReasonBottomTableViewCell.h"
#import "PXAlertView.h"
#import "PXAlertView+Customization.h"

@interface RefundReasonViewController ()<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation RefundReasonViewController

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        
        UINib *nib = [UINib nibWithNibName:@"RefundResonTopTableViewCell" bundle:nil];
        [_tableView registerNib:nib  forCellReuseIdentifier:NSStringFromClass([RefundResonTopTableViewCell class])];
        
        
        nib = [UINib nibWithNibName:@"ReundResonMiddleTableViewCell" bundle:nil];
        [_tableView registerNib:nib  forCellReuseIdentifier:NSStringFromClass([ReundResonMiddleTableViewCell class])];
        
        nib = [UINib nibWithNibName:@"ReundReasonBottomTableViewCell" bundle:nil];
        [_tableView registerNib:nib  forCellReuseIdentifier:NSStringFromClass([ReundReasonBottomTableViewCell class])];
        
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self vs_setTitleText:@"申请退款"];
    
    __weak typeof(self) weakSelf = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    
    self.tableView.backgroundColor = _UIColorFromRGB(0xf1f1f1);
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
}


#pragma mark - UITableView delegate and dataSource method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        RefundResonTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RefundResonTopTableViewCell class])];
        cell.order = self.order;
        
        return cell;
    }else if (indexPath.row == 1) {
        
        ReundResonMiddleTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ReundResonMiddleTableViewCell class])];
        
        __weak typeof(self) weakSelf = self;
        [cell setCommitActionBlock:^(NSString *text) {
            [weakSelf okAction:text];
        }];
        
        
        return cell;
    }else if (indexPath.row == 2) {
        
        ReundReasonBottomTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ReundReasonBottomTableViewCell class])];
        
        
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 143;
    }else if(indexPath.row ==1){
        return 240;
    }else{
        return 225;
    }
}



#pragma mark -



- (void)okAction:(NSString *)text  {
    
    if (text.Trim.length == 0) {
        
        [self.view showTipsView:@"请填写退款说明"];
        
        return;
    }else if(text.length > 50){
        
        [self.view showTipsView:@"退款说明不超过50字"];
        
        return;
        
    }
    
    
    [self vs_showLoading];
    
    NSDictionary *dic = @{@"userLoginId":[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.username,//用户id
                          @"orderId":self.order.orderHeader.orderId,//	订单号
                          @"returnReason":text.Trim
                          };
    
    NSData *contentData = (NSData *)[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString* jsonContent = [[NSString alloc] initWithData:contentData encoding:NSUTF8StringEncoding];
    
    NSDictionary * contentDic = [NSDictionary dictionaryWithObjectsAndKeys:jsonContent,@"content", nil];
    
    [BCNetWorkTool executePostNetworkWithParameter:contentDic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.order/refund-order" withSuccess:^(id callBackData) {
        
        [self vs_hideLoadingWithCompleteBlock:nil];
        
        PXAlertView *alert =  [PXAlertView showAlertWithTitle:@"" message:@"您已成功提交申请,\n请耐心等待处理结果" cancelTitle:@"确定" completion:^(BOOL cancelled, NSInteger buttonIndex) {
            [self.navigationController popViewControllerAnimated:YES];
            
            if (self.RefundBlock) {
                self.RefundBlock(YES);
            }
        }];
        
        [alert setBackgroundColor:_Colorhex(0xffffff)];
        [alert setMessageColor:_Colorhex(0x252525)];
        
        
        [alert setCancelButtonBackgroundColor:_Colorhex(0x666666)];
        [alert setCancelButtonTextColor:_Colorhex(0x252525)];
        
        
        
    } orFail:^(id callBackData) {
        
        [self.view showTipsView:[callBackData domain]];
        
        if (self.RefundBlock) {
            self.RefundBlock(NO);
        }
        
        [self vs_hideLoadingWithCompleteBlock:nil];
    }];
    
}


@end

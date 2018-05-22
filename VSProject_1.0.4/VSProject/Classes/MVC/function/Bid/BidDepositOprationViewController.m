//
//  BidDepositOprationViewController.m
//  VSProject
//
//  Created by 陈 海涛 on 16/10/31.
//  Copyright © 2016年 user. All rights reserved.
//

#import "BidDepositOprationViewController.h"
#import "RequestBidDepositTableViewCell.h"
#import "BCNetWorkTool.h"
#import "BidderManager.h"


@interface BidDepositOprationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation BidDepositOprationViewController

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
        
        UINib *nib = [UINib nibWithNibName:@"RequestBidDepositTableViewCell" bundle:nil];
        [_tableView registerNib:nib forCellReuseIdentifier:NSStringFromClass([RequestBidDepositTableViewCell class])];
  
        
    }
    
    return _tableView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self vs_setTitleText:@"申请退款"];
    
  
    [self.view addSubview:self.tableView];
    
    __weak typeof(self) weakSelf = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.bottom.equalTo(weakSelf.view);
    }];
    
    
   
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
  
   
}


#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RequestBidDepositTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RequestBidDepositTableViewCell class])];
    
    cell.bidPro = self.bidPro;
    
    __weak typeof(self) weakSelf = self;
    [cell setRequestBidDepositBlock:^{
        [weakSelf vs_showLoading];
        /*
         partyId	用户id
         bidderId	投标企业id
         bidProjectId	项目id

         */
        NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
        
        NSDictionary *dic = @{
                              @"partyId":partyId,
                              @"bidderId":[BidderManager shareInstance].authedEnterPrise.bidder.id?:@"",
                              @"bidProjectId":self.bidPro.bidProjectId?:@""
                              };
        [BCNetWorkTool executeGETNetworkWithParameter:dic  andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.enterprise/refund-deposit/version/1.2.2" withSuccess:^(id callBackData) {
            
            [weakSelf vs_hideLoadingWithCompleteBlock:^{
                
            }];
            
            weakSelf.bidPro.canReturn = @"N";
            [weakSelf.tableView reloadData];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refundDepositSuccessNOtification" object:nil];
            
            [weakSelf.view showTipsView:@"提交成功"];
        } orFail:^(id callBackData) {
            
            [weakSelf vs_hideLoadingWithCompleteBlock:^{
                
            }];
            [weakSelf.view showTipsView:@"提交失败"];
        }];
    }];
    
    return cell;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static RequestBidDepositTableViewCell *cell = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RequestBidDepositTableViewCell class])];
    });
    
    cell.bidPro = self.bidPro;
    
    NSLog(@"---------------%f",CGRectGetMaxY(cell.callbackDescription.frame));
    
    return CGRectGetMaxY(cell.callbackDescription.frame);
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001;
}

@end

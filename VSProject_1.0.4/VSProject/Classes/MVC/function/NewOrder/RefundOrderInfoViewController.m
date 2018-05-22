//
//  RefundOrderInfoViewController.m
//  VSProject
//
//  Created by 陈 海涛 on 16/9/1.
//  Copyright © 2016年 user. All rights reserved.
//

#import "RefundOrderInfoViewController.h"
#import "BCNetWorkTool.h"
#import "OrderDetailDTO.h"
#import "MJExtension.h"
#import "RefundOrdersTitleTableViewCell.h"
#import "RefundOrdersProductTableViewCell.h"
#import "RefundMiddleTableViewCell.h"
#import "RefundRejectedTableViewCell.h"
#import "ReturnTableViewCell.h"
#import "ReturnManTableViewCell.h"
#import "ReturnAccpetTableViewCell.h"
#import "ReturnCompleteTableViewCell.h"

@interface RefundOrderInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)OrderDetailDTO *dto;

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation RefundOrderInfoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.order.orderHeader.orderStatus isEqualToString: SZ_RETURN_REQUESTED]) {
        self.title = @"退款申请中";
    }else if ([self.order.orderHeader.orderStatus isEqualToString: SZ_RETURN_ACCEPTED]) {
        self.title = @"同意退款";
    }else if ([self.order.orderHeader.orderStatus isEqualToString: SZ_RETURN_MAN_REFUND]) {
        self.title = @"拒绝退款";
    }else if ([self.order.orderHeader.orderStatus isEqualToString: SZ_RETURN_COMPLETED]) {
        self.title = @"完成退款";
    }
    
    [self vs_setTitleText:self.title];
    
    __weak typeof(self) weakSelf = self;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    [self.tableView registerClass:[RefundOrdersTitleTableViewCell class] forCellReuseIdentifier:NSStringFromClass([RefundOrdersTitleTableViewCell class])];
    [self.tableView registerClass:[RefundOrdersProductTableViewCell  class] forCellReuseIdentifier:NSStringFromClass([RefundOrdersProductTableViewCell class])];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"defaultCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[RefundMiddleTableViewCell  class] forCellReuseIdentifier:NSStringFromClass([RefundMiddleTableViewCell class])];
    
    UINib *nib = [UINib nibWithNibName:@"RefundRejectedTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:NSStringFromClass([RefundRejectedTableViewCell class])];
    
    nib = [UINib nibWithNibName:@"ReturnTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:NSStringFromClass([ReturnTableViewCell class])];
    
    nib = [UINib nibWithNibName:@"ReturnManTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:NSStringFromClass([ReturnManTableViewCell class])];
    
    nib = [UINib nibWithNibName:@"ReturnAccpetTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:NSStringFromClass([ReturnAccpetTableViewCell class])];
    
    nib = [UINib nibWithNibName:@"ReturnCompleteTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:NSStringFromClass([ReturnCompleteTableViewCell class])];
    
    
    [self loadData];
    
}


- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    return _tableView;
}

- (void)loadData{
    
    [self vs_showLoading];
    NSDictionary *dic = @{@"userLoginId":[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.username,//用户id
                          @"orderId":self.order.orderHeader.orderId,//	订单号
                          
                          };
    __weak typeof(self) weakSelf = self;
    [BCNetWorkTool executeGETNetworkWithParameter:dic  andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.order/get-return-order-view" withSuccess:^(id callBackData) {
        [weakSelf vs_hideLoadingWithCompleteBlock:nil];
        
        weakSelf.dto = [OrderDetailDTO mj_objectWithKeyValues:callBackData];
        
        
        [weakSelf.tableView reloadData];
        
    } orFail:^(id callBackData) {
        
        
        [weakSelf vs_hideLoadingWithCompleteBlock:nil];
        
    }];
    
}

#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else if(section == 1){
        
        if ([self.order.orderHeader.orderStatus isEqualToString: SZ_RETURN_MAN_REFUND]) {
            return 2;
        }
        
        return 1;
        
    }else{
        return 2;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    if (section == 0) {
        return 193;
    }else if(section == 1){
        
        if (indexPath.row == 0) {
            return 32;
        }else{
            return 155;
        }
        
    }else{
        if (indexPath.row == 0) {
            return 35;
        }else{
            return 100;
        }
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
    if (indexPath.section == 0) {
        
        if ([self.order.orderHeader.orderStatus isEqualToString:SZ_RETURN_REQUESTED]) {
            ReturnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ReturnTableViewCell class])];
            
            cell.dto = self.dto;
            
            return cell;
        }else if([self.order.orderHeader.orderStatus isEqualToString:SZ_RETURN_MAN_REFUND]){
            
            ReturnManTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ReturnManTableViewCell class])];
            
            cell.dto = self.dto;
            
            return cell;
            
        }else if([self.order.orderHeader.orderStatus isEqualToString:SZ_RETURN_ACCEPTED]){
            
            ReturnAccpetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ReturnAccpetTableViewCell class])];
            
            cell.dto = self.dto;
            
            return cell;
            
        }else if([self.order.orderHeader.orderStatus isEqualToString:SZ_RETURN_COMPLETED]){
            
            ReturnCompleteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ReturnCompleteTableViewCell class])];
            
            cell.dto = self.dto;
            
            return cell;
            
        }
        
        
        
    }else if(indexPath.section == 1){
        
        
        if (indexPath.row == 0) {
            RefundMiddleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RefundMiddleTableViewCell class])];
            cell.dto = self.dto;
            cell.order = self.order;
            
            return cell;
        }else{
            RefundRejectedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RefundRejectedTableViewCell class])];
            
            cell.dto = self.dto;
            
            return cell;
        }
        
        
    }else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            
            RefundOrdersTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RefundOrdersTitleTableViewCell class])];
            cell.order = self.order;
            
            cell.orderStatus.hidden = YES;
            
            return cell;
            
        }else{
            
            RefundOrdersProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RefundOrdersProductTableViewCell class])];
            
            cell.order = self.order;
            
            cell.orderTime.hidden = YES;
            
            return cell;
            
        }
    }
    
    
    
    return nil;
}


@end
























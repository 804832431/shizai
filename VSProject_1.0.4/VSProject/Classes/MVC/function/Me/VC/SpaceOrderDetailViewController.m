//
//  SpaceOrderDetailViewController.m
//  VSProject
//
//  Created by pangchao on 17/1/9.
//  Copyright © 2017年 user. All rights reserved.
//

#import "SpaceOrderDetailViewController.h"
#import "OrderAddressTableViewCell.h"
#import "OrderDetailProductTableViewCell.h"
#import "O2OOrderOperationTableViewCell.h"
#import "OrderInfoTableViewCell.h"
#import "UIColor+TPCategory.h"
#import "BCNetWorkTool.h"
#import "OrderPayViewController.h"
#import "RefundReasonViewController.h"
#import "OrderRefundReasonTableViewCell.h"
#import "RTXReadyPayAlertView.h"
#import "NewEvaluateViewController.h"
#import "MySpaceDetailAddressCell.h"
#import "MuSpaceOrderInfoTableViewCell.h"


static  NSString* OrderAddressTableViewCellIdentifier = @"OrderAddressTableViewCellIdentifier";

static  NSString* OrderDetailProductTableViewCellIdentifier = @"OrderDetailProductTableViewCellIdentifier";

static  NSString* O2OOrderOperationTableViewCellIdentifier = @"O2OOrderOperationTableViewCellIdentifier";

static  NSString* OrderInfoTableViewCellIdentifier = @"OrderInfoTableViewCellIdentifier";

static NSString* OrderRefundReasonTableViewCellIdentifier = @"OrderRefundReasonTableViewCellIdentifier";

@interface SpaceOrderDetailViewController ()

@end

@implementation SpaceOrderDetailViewController

- (void)loadOrderData{
    
    [self vs_showLoading];
    
    NSDictionary *dic = @{@"userLoginId":[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.username,//用户id
                          @"orderId":self.orderId,//	订单号
                          @"userLoginType":@"customer"
                          };
    
    
    [BCNetWorkTool executeGETNetworkWithParameter:dic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.order/get-order-view" withSuccess:^(id callBackData) {
        
        NSDictionary *dic = (NSDictionary *)callBackData;
        
        
        self.order = [[Order alloc] initWithDictionary:dic error:nil];
        
        [self.tableView headerEndRefreshing];
        
        [self.tableView reloadData];
        
        [self vs_hideLoadingWithCompleteBlock:nil];
        
    } orFail:^(id callBackData) {
        
        [self.tableView headerEndRefreshing];
        [self vs_hideLoadingWithCompleteBlock:nil];
    }];
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self vs_setTitleText:@"订单详情"];
    
    
    [self.tableView registerClass:[MySpaceDetailAddressCell class] forCellReuseIdentifier:OrderAddressTableViewCellIdentifier];
    [self.tableView registerClass:[OrderDetailProductTableViewCell class] forCellReuseIdentifier:OrderDetailProductTableViewCellIdentifier];
    [self.tableView registerClass:[O2OOrderOperationTableViewCell class] forCellReuseIdentifier:O2OOrderOperationTableViewCellIdentifier];
    [self.tableView registerClass:[MuSpaceOrderInfoTableViewCell class] forCellReuseIdentifier:OrderInfoTableViewCellIdentifier];
    [self.tableView registerClass:[OrderRefundReasonTableViewCell class] forCellReuseIdentifier:OrderRefundReasonTableViewCellIdentifier];
    
    __weak typeof(&*self) weakSelf = self;
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view);
    }];
    
    [self.tableView addHeaderWithCallback:^{
        [weakSelf loadOrderData];
    }];
    
    [self vs_showLoading];
    
    [self.tableView headerBeginRefreshing];
}

#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    if (self.order == nil) {
        return 0;
    }
    return 3;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 2 + self.order.orderProductList.count;
        
    }else if(section == 1){
        return 1;
    }
    else{
        if ([self.order.returnReason isKindOfClass:[NSString class]] && self.order.returnReason.length != 0) {
            return 1;
        }
        return 0;
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    __weak typeof(&*self) weakSelf = self;
    
    if (indexPath.section == 0) {
        
        NSInteger num = [self tableView:tableView numberOfRowsInSection:indexPath.section];
        
        if (indexPath.row == 0) {
            
            MySpaceDetailAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderAddressTableViewCellIdentifier];
            cell.order = self.order;
            
            return cell;
            
        }else if(indexPath.row < num - 1){
            
            OrderDetailProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderDetailProductTableViewCellIdentifier];
            
            cell.prodcut = self.order.orderProductList[indexPath.row - 1];
            
            if (indexPath.row == 1) {
                cell.firstTopView.hidden = NO;
            }else{
                cell.firstTopView.hidden = YES;
            }
            
            cell.productPrice.hidden = YES;
            cell.productCount.hidden = YES;
            cell.bottomView.hidden = YES;
            cell.firstTopView.hidden = YES;
            cell.productAttributelabel.hidden = YES;
            
            return cell;
            
        }else if(indexPath.row == num - 1){
            
            return [[UITableViewCell alloc] init];
        }
        
    }else if (indexPath.section == 1) {
        
        MuSpaceOrderInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderInfoTableViewCellIdentifier];
//        OrderInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderInfoTableViewCellIdentifier];
        
        cell.order = self.order;
        
        return cell;
    }else{
        
        OrderRefundReasonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderRefundReasonTableViewCellIdentifier];
        
        cell.order = self.order;
        
        if (self.order.returnReason ==nil || self.order.returnReason.length == 0) {
            cell.hidden = YES;
        }
        
        return cell;
    }
    
    
    return nil;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        NSInteger num = [self tableView:tableView numberOfRowsInSection:indexPath.section];
        
        if (indexPath.row == 0) {
            
            return 90.0f;
            
        }else if(indexPath.row < num -1){
            
            return 93;
            
        }else if(indexPath.row == num -1){
            //modify by Thomas ［O2O预约订单展示少实际支付金额，高度调整］---start
            //            if ([self.order.orderHeader.orderTypeId isEqualToString:SALES_ORDER_O2O_SERVICE]) {
            //                return 65.0f;
            //            }
            //modify by Thomas ［O2O预约订单展示少实际支付金额，高度调整］---end
            return 0;
        }
        
        
        
    }else if(indexPath.section == 1) {
        return 270.0f;
        
        //modify by Thomas O2O预约订单无需显示备注－－－end
    }else{
        
        
        
        if (self.order.returnReason ==nil || self.order.returnReason.length == 0) {
            return 0;
        }
        
        static OrderRefundReasonTableViewCell *cell = nil;
        static dispatch_once_t onceToken;
        //只会走一次
        dispatch_once(&onceToken, ^{
            cell = (OrderRefundReasonTableViewCell*)[tableView dequeueReusableCellWithIdentifier:OrderRefundReasonTableViewCellIdentifier];
        });
        
        cell.order = self.order;
        
        cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.frame), CGRectGetHeight(cell.bounds));
        
        
        CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        
        
        return size.height+1.0f;
    }
    
    return 0;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section == 0 || section ==1) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor colorFromHexRGB:@"f1f1f1"];
        return view;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 0||section == 1) {
        return 13;
    }
    return 0;
    
}

#pragma mark -

-(void)showAlertView{
    RTXReadyPayAlertView *payAlert = [[RTXReadyPayAlertView alloc] initWithTitle:nil BaseController:self message:nil cancelButtonTitle:@"取消" confirmButtonTitle:@"确定"];
    __weak typeof(&*self) weakSelf = self;
    [payAlert setCancelBlock:^(RTXReadyPayAlertView * alertView) {
        [alertView dismiss];
    }];
    [payAlert setConfirmBlock:^(RTXReadyPayAlertView *alertView) {
        NSString *money = [alertView getMoney];
        
        //业务处理
        [weakSelf PayOrderWithorderId:weakSelf.order.orderHeader.orderId price:money];
        [alertView dismiss];
    }];
    [payAlert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 100) {
        if (buttonIndex == 1) {
            
            
            [self cancelOrder:self.order];
            
            
        }
    }
    //modify by Thomas [取消预约]－－－start
    if (alertView.tag == 99) {
        if (buttonIndex == 1) {
            [self cancelOrder:self.order];
            
        }
    }
    //modify by Thomas [取消预约]－－－end
}

//买单
- (void)PayOrderWithorderId:(NSString *)orderId price:(NSString *)price{
    __weak typeof(&*self) weakSelf = self;
    [self vs_showLoading];
    NSString *AESMoney = [SecurityUtil encryptUseDES:price key:APP_DES_PASSWORDKEY];
    NSString *MD5Money = [SecurityUtil encryptMD5String:[NSString stringWithFormat:@"%@%@",AESMoney,price]];
    
    NSLog(@"price=%@,AESMoney=%@,MD5Money=%@",price,AESMoney,MD5Money);
    
    NSDictionary *dic = @{
                          @"userLoginId":[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.username,//用户id
                          @"orderId":orderId,//	订单号
                          @"price":AESMoney,//	AES
                          @"md":MD5Money,//	md5
                          };
    [BCNetWorkTool executeGETNetworkWithParameter:dic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.order/update-order-grand-total" withSuccess:^(id callBackData) {
        NSDictionary *dic = (NSDictionary *)callBackData;
        //解析
        NSString *back_orderId = [dic objectForKey:@"orderId"];
        NSString *back_grandTotal = [dic objectForKey:@"grandTotal"];
        if (back_orderId && [back_orderId isEqualToString:weakSelf.order.orderHeader.orderId]) {
            weakSelf.order.orderHeader.grandTotal = back_grandTotal;
            [weakSelf payOrder:weakSelf.order];
        }
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        [self vs_hideLoadingWithCompleteBlock:nil];
        
    } orFail:^(id callBackData) {
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        [self vs_hideLoadingWithCompleteBlock:nil];
        if ([callBackData isKindOfClass:[NSError class]]) {
            NSError *error = (NSError *)callBackData;
            [weakSelf.view showTipsView:[error domain]];
            weakSelf.order = nil;
        }
    }];
}

- (void)cancelOrder:(Order *)order{
    
    
    [self vs_showLoading];
    
    NSDictionary *dic = @{@"userLoginId":[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.username,//用户id
                          @"orderId":order.orderHeader.orderId,//	订单号
                          };
    NSData *contentData = (NSData *)[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString* jsonContent = [[NSString alloc] initWithData:contentData encoding:NSUTF8StringEncoding];
    
    NSDictionary * contentDic = [NSDictionary dictionaryWithObjectsAndKeys:jsonContent,@"content", nil];
    
    [BCNetWorkTool executePostNetworkWithParameter:contentDic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.order/cancle-order" withSuccess:^(id callBackData) {
        
        [self.tableView headerBeginRefreshing];
        
        [self vs_hideLoadingWithCompleteBlock:nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kOrderStatusNotification object:nil];
        
        
    } orFail:^(id callBackData) {
        
        [self.view showTipsView:[callBackData domain]];
        [self vs_hideLoadingWithCompleteBlock:nil];
    }];
    
}


//支付订单
- (void)payOrder:(Order *)order{
    
    OrderPayViewController *vc = [OrderPayViewController new];
    vc.orderId = order.orderHeader.orderId;
    vc.orderType = order.orderHeader.orderTypeId;
    vc.needPayMoeny = order.orderHeader.grandTotal;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


//确认收货
- (void)confirmReceiptOrder:(Order *)order{
    
    [self vs_showLoading];
    
    NSDictionary *dic = @{@"userLoginId":[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.username,//用户id
                          @"orderId":order.orderHeader.orderId,//	订单号
                          };
    
    
    [BCNetWorkTool executeGETNetworkWithParameter:dic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.order/complete-order" withSuccess:^(id callBackData) {
        
        [self.tableView headerBeginRefreshing];
        
        [self vs_hideLoadingWithCompleteBlock:nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kOrderStatusNotification object:nil];
        
        
    } orFail:^(id callBackData) {
        [self.view showTipsView:[callBackData domain]];
        
        [self vs_hideLoadingWithCompleteBlock:nil];
    }];
}


//申请退款
- (void)refundRrder:(Order *)order{
    
    
    RefundReasonViewController *vc = [[RefundReasonViewController alloc] init];
    
    vc.order = order;
    
    __weak typeof(&*self) weakSelf = self;
    //    [vc setRefundBlock:^(BOOL isSuccess) {
    //
    //        if (isSuccess) {
    //            [weakSelf.tableView headerBeginRefreshing];
    //
    //            [[NSNotificationCenter defaultCenter] postNotificationName:kOrderStatusNotification object:nil];
    //        }
    //
    //
    //
    //    }];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)evaluteOrder:(Order *)order{
    
    
    NewEvaluateViewController   *vc = [[NewEvaluateViewController alloc] init];
    
    vc.order = order;
    
    __weak typeof(&*self) weakSelf = self;
    [vc setEvaluateBlock:^{
        [weakSelf.tableView headerBeginRefreshing];
    }];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end

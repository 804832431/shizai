//
//  OrderDetailViewController.m
//  VSProject
//
//  Created by 陈 海涛 on 15/11/20.
//  Copyright © 2015年 user. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderAddressTableViewCell.h"
#import "OrderDetailProductTableViewCell.h"
#import "O2OOrderOperationTableViewCell.h"
#import "OrderInfoTableViewCell.h"
#import "B2COrderOperationTableViewCell.h"
#import "UIColor+TPCategory.h"
#import "OrderPostStatusTableViewCell.h"
#import "BCNetWorkTool.h"
#import "OrderPayViewController.h"
#import "UIView+ShowTips.h"
#import "RefundReasonViewController.h"
#import "OrderRefundReasonTableViewCell.h"

static  NSString* OrderAddressTableViewCellIdentifier = @"OrderAddressTableViewCellIdentifier";

static  NSString* OrderDetailProductTableViewCellIdentifier = @"OrderDetailProductTableViewCellIdentifier";

static  NSString* B2COrderOperationTableViewCellIdentifier = @"B2COrderOperationTableViewCellIdentifier";

static  NSString* OrderInfoTableViewCellIdentifier = @"OrderInfoTableViewCellIdentifier";

static  NSString* OrderPastHeaderTableViewfCellIdentifier = @"OrderPastHeaderTableViewfCellIdentifier";

static  NSString* OrderPostStatusTableViewCellIdentifier = @"OrderPostStatusTableViewCellIdentifier";

static NSString* OrderRefundReasonTableViewCellIdentifier = @"OrderRefundReasonTableViewCellIdentifier";


@interface OrderDetailViewController ()

@end

@implementation OrderDetailViewController

- (void)dealloc{
    
    //    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

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
    
    
    [self.tableView registerClass:[OrderAddressTableViewCell class] forCellReuseIdentifier:OrderAddressTableViewCellIdentifier];
    [self.tableView registerClass:[OrderDetailProductTableViewCell class] forCellReuseIdentifier:OrderDetailProductTableViewCellIdentifier];
    [self.tableView registerClass:[B2COrderOperationTableViewCell class] forCellReuseIdentifier:B2COrderOperationTableViewCellIdentifier];
    [self.tableView registerClass:[OrderInfoTableViewCell class] forCellReuseIdentifier:OrderInfoTableViewCellIdentifier];
    [self.tableView registerClass:[OrderPastHeaderTableViewCell class] forCellReuseIdentifier:OrderPastHeaderTableViewfCellIdentifier];
    [self.tableView registerClass:[OrderPostStatusTableViewCell class] forCellReuseIdentifier:OrderPostStatusTableViewCellIdentifier];
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
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccess:) name:kALPaySucNotification object:nil];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccess:) name:kWXPaySucNotification object:nil];
    //    
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payFail:) name:kALPayFailNotification object:nil];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payFail:) name:kWXPayFailNotification object:nil];
}

//#pragma mark - 订单支付成功
//- (void)paySuccess:(NSNotification *)notification{
//    
//    [self.tableView headerBeginRefreshing];
//}
//
//- (void)payFail:(NSNotification *)notification{
//    
//}


#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (self.order == nil) {
        return 0;
    }else if([self.order.orderHeader.orderTypeId isEqualToString:SALES_ORDER_O2O_SERVICE_PAY]){
        
        return 3;
    }
    
    return 4;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 2 + self.order.orderProductList.count;
        
    }else if(section == 1){
        
        return 1;
    }else if(section == 2){
        if ([self.order.returnReason isKindOfClass:[NSString class]] && self.order.returnReason.length != 0) {
            return 1;
        }else{
            return 0;
        }
        
    }else{
        
        if (![self.order.completedDate isEqual:[NSNull null]] && self.order.completedDate.length > 0) {
            
            return 4;
            
        }else if(![self.order.sentDate isEqual:[NSNull null]] &&self.order.sentDate.length > 0){
            return 3;
            
        }else if(![self.order.createDate isEqual:[NSNull null]] &&self.order.createDate.length > 0){
            
            return 2;
        }
        return 0;
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    __weak typeof(&*self) weakSelf = self;
    
    if (indexPath.section == 0) {
        
        NSInteger num = [self tableView:tableView numberOfRowsInSection:indexPath.section];
        
        if (indexPath.row == 0) {
            
            OrderAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderAddressTableViewCellIdentifier];
            
            cell.order = self.order;
            
            return cell;
            
        }else if(indexPath.row == num - 1){
            
            B2COrderOperationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:B2COrderOperationTableViewCellIdentifier];
            
            cell.order = self.order;
            
            [cell setCancelOrder:^(Order *order) {
                //取消订单
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"确定要取消订单？" delegate:weakSelf cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alertView.tag = 100;
                
                [alertView show];
            }];
            
            [cell setPayOrder:^(Order *order) {
                //支付订单
                [weakSelf payOrder:order];
                
            }];
            
            [cell setConfirmReceiptOrder:^(Order *order) {
                //确认收货
                
                [weakSelf confirmReceiptOrder:order];
                
            }];
            
            [cell setRefundRrder:^(Order *order) {
                //申请退款
                
                [weakSelf refundRrder:order];
                
            }];
            
            return cell;
            
        }else if(indexPath.row < num -1){
            
            OrderDetailProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderDetailProductTableViewCellIdentifier];
            NSLog(@"xxxxx:%zi",indexPath.row);
            cell.prodcut = self.order.orderProductList[indexPath.row - 1];
            
            if (indexPath.row == 1) {
                cell.firstTopView.hidden = NO;
            }else{
                cell.firstTopView.hidden = YES;
            }
            
            return cell;
            
        }
        
        
    }else if (indexPath.section == 1) {
        
        OrderInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderInfoTableViewCellIdentifier];
        
        cell.order = self.order;
        
        return cell;
        
    }else if(indexPath.section == 2){
        
        OrderRefundReasonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderRefundReasonTableViewCellIdentifier];
        
        cell.order = self.order;
        
        return cell;
        
    }else if(indexPath.section == 3){
        
        if (indexPath.row == 0) {
            OrderPastHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderPastHeaderTableViewfCellIdentifier];
            cell.order = self.order;
            
            return cell;
            
        }else{
            
            NSInteger num = [self tableView:tableView numberOfRowsInSection:indexPath.section];
            
            OrderPostStatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderPostStatusTableViewCellIdentifier];
            
            if (indexPath.row == num -1) {
                cell.isLastCell = YES;
            }else{
                cell.isLastCell = NO;
            }
            
            if (indexPath.row == 1) {
                cell.isFirstCell = YES;
            }else{
                cell.isFirstCell = NO;
            }
            
            NSDateFormatter *dateFormatter = [NSDateFormatter new];
            [dateFormatter setDateFormat:@"yyyyMMdd HH:mm:ss"];
            
            NSDateFormatter *dateFomatter2 = [NSDateFormatter new];
            [dateFomatter2 setDateFormat:@"yyyyMMddHHmmss"];
            
            if (![self.order.completedDate isEqual:[NSNull null]] && self.order.completedDate.length > 0  ) {
                
                if (indexPath.row == 1) {
                    
                    cell.orderStatusTitle.text = @"商品已签收";
                    
                    cell.orderStatusTime.text =  [dateFormatter stringFromDate: [dateFomatter2 dateFromString:self.order.completedDate]];
                }else if (indexPath.row == 2) {
                    
                    cell.orderStatusTitle.text = @"出库";
                    cell.orderStatusTime.text = [dateFormatter stringFromDate: [dateFomatter2 dateFromString:self.order.sentDate]];
                    
                }else  if (indexPath.row == 3) {
                    
                    
                    cell.orderStatusTitle.text = @"下单";
                    cell.orderStatusTime.text = [dateFormatter stringFromDate: [dateFomatter2 dateFromString:self.order.createDate]];
                    
                }
                
            }else if(![self.order.sentDate isEqual:[NSNull null]] && self.order.sentDate.length > 0){
                
                if (indexPath.row == 1) {
                    
                    cell.orderStatusTitle.text = @"出库";
                    cell.orderStatusTime.text = [dateFormatter stringFromDate: [dateFomatter2 dateFromString:self.order.sentDate]];
                }else  if (indexPath.row == 2) {
                    
                    cell.orderStatusTitle.text = @"下单";
                    cell.orderStatusTime.text = [dateFormatter stringFromDate: [dateFomatter2 dateFromString:self.order.createDate]];
                    
                    
                }
                
            }else if(![self.order.createDate isEqual:[NSNull null]] && self.order.createDate.length > 0){
                
                if (indexPath.row == 1) {
                    
                    cell.orderStatusTitle.text = @"下单";
                    cell.orderStatusTime.text = [dateFormatter stringFromDate: [dateFomatter2 dateFromString:self.order.createDate]];
                }
                
            }
            
            
            
            return cell;
        }
        
    }
    
    
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        NSInteger num = [self tableView:tableView numberOfRowsInSection:indexPath.section];
        
        if (indexPath.row == 0) {
            
            static OrderAddressTableViewCell *cell = nil;
            static dispatch_once_t onceToken;
            //只会走一次
            dispatch_once(&onceToken, ^{
                cell = (OrderAddressTableViewCell*)[tableView dequeueReusableCellWithIdentifier:OrderAddressTableViewCellIdentifier];
            });
            
            cell.order = self.order;
            
            if (cell.order == nil) {
                return 93;
            }
            
            cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.frame), CGRectGetHeight(cell.bounds));
            
            
            CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
            
            
            return size.height+1.0f;
            
        }else if(indexPath.row < num -1){
            
            return 93;
            
        }else if(indexPath.row == num -1){
            
            return 70;
        }
        
        
        
    }else if(indexPath.section == 1){
        
        return 280;
        
    }else if(indexPath.section == 2){
        
        
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
        
    }else if(indexPath.section == 3){
        
        if (indexPath.row == 0) {
            
            if ([self.order.expressCompany isEqual:[NSNull null]]||self.order.expressCompany.length == 0 || [self.order.trackingNum isEqual:[NSNull null]]||self.order.trackingNum.length == 0) {
                
                return 48;
            }
            
            static OrderPastHeaderTableViewCell *cell = nil;
            static dispatch_once_t onceToken;
            //只会走一次
            dispatch_once(&onceToken, ^{
                cell = (OrderPastHeaderTableViewCell*)[tableView dequeueReusableCellWithIdentifier:OrderPastHeaderTableViewfCellIdentifier];
            });
            
            cell.order = self.order;
            
            cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.frame), CGRectGetHeight(cell.bounds));
            
            
            CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
            
            
            return size.height+1.0f;
            
        }else{
            
            return 70;
        }
    }
    
    return 0;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section == 0  || section == 1 ||section ==2 || section == 3) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor colorFromHexRGB:@"f1f1f1"];
        
        return view;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 0 || section == 1 ) {
        return 13;
    }
    
    if (section == 2) {
        if ([self.order.returnReason isKindOfClass:[NSString class]] && self.order.returnReason.length != 0) {
            return 13;
        }else{
            return 0;
        }
    }
    
    return 0;
    
}


#pragma mark -

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 100) {
        if (buttonIndex == 1) {
            
            
            [self cancelOrder:self.order];
            
            
        }
    }
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
        
        [self.view showTipsView:@"操作成功"];
        
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
    [vc setRefundBlock:^(BOOL isSuccess) {
        
        if (isSuccess) {
            [weakSelf.tableView headerBeginRefreshing];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kOrderStatusNotification object:nil];
            
        }
        
        
    }];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}





@end

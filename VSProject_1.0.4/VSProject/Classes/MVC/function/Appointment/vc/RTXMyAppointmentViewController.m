//
//  RTXMyAppointmentViewController.m
//  VSProject
//
//  Created by XuLiang on 15/11/28.
//  Copyright © 2015年 user. All rights reserved.
//

#import "RTXMyAppointmentViewController.h"
#import "RTXAppointmentCell.h"
#import "BCNetWorkTool.h"
#import "Order.h"
#import "OrderProduct.h"
#import "OrderHeader.h"
#import "UIColor+TPCategory.h"
#import "MyOrdersTitleTableViewCell.h"
#import "MyOrdersProductTableViewCell.h"
#import "MyOrdersInfoAndOperationTableViewCell.h"
#import "OrderDetailViewController.h"
#import "O2OOrderDetailViewController.h"

#import "RTXReadyPayAlertView.h"
#import "OrderPayViewController.h"

static NSString *MyOrdersTitleTableViewCellIdentifier = @"MyOrdersTitleTableViewCellIdentifier";
static NSString *MyOrdersProductTableViewCellIdentifier = @"MyOrdersProductTableViewCellIdentifier";
static NSString *MyOrdersInfoAndOperationTableViewCellIdentifier = @"MyOrdersInfoAndOperationTableViewCellIdentifier";

@interface RTXMyAppointmentViewController ()<UITableViewDelegate,UITableViewDataSource,RTXReadyPayAlertViewDelegate>
{
    RTXReadyPayAlertView  * payAlert;
}
@property (nonatomic,strong) NSMutableArray *dataSources;
@property (nonatomic,strong) UITableView *m_tableView;

@end

@implementation RTXMyAppointmentViewController

- (NSMutableArray *)dataSources{
    
    if (_dataSources == nil) {
        
        _dataSources = [NSMutableArray array];
    }
    
    return _dataSources;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self vs_setTitleText:@"我的预约"];
    [self _initTableViews];
////    [self vs_showLoading];
    //[NSString stringWithFormat:@"%@,%@,%@",ORDER_CREATED,ORDER_CANCELLED,ORDER_PROCESSING]
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self mrefreshOrderList:@"" type:SALES_ORDER_O2O_SERVICE page:@"1" row:@"10"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)_initTableViews{
    [self m_tableView];
    self.m_tableView.delegate = self;
    self.m_tableView.dataSource = self;
    self.m_tableView.backgroundColor = [UIColor blackColor];
//    self.m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.m_tableView.backgroundColor = [UIColor colorFromHexRGB:@"f1f1f1"];
    
    [self.m_tableView registerClass:[MyOrdersTitleTableViewCell class] forCellReuseIdentifier:MyOrdersTitleTableViewCellIdentifier];
    [self.m_tableView registerClass:[MyOrdersInfoAndOperationTableViewCell class] forCellReuseIdentifier:MyOrdersInfoAndOperationTableViewCellIdentifier];
    [self.m_tableView registerClass:[MyOrdersProductTableViewCell class] forCellReuseIdentifier:MyOrdersProductTableViewCellIdentifier];

    __weak typeof(&*self) weakSelf = self;
    __weak UITableView *weakTableView = self.m_tableView;
    [self.m_tableView addHeaderWithCallback:^{
        NSString *orderStatus = @"";
        [weakSelf mrefreshOrderList:orderStatus type:SALES_ORDER_O2O_SERVICE page:@"1" row:@"10" ];
    }];
    [self.m_tableView addFooterWithCallback:^{
        NSArray *data = weakSelf.dataSources;
        NSInteger page = data.count / 10 + 1;
        NSString *orderStatus = @"";
        [weakSelf mrefreshOrderList:orderStatus type:SALES_ORDER_O2O_SERVICE page:[NSString stringWithFormat:@"%zi",page] row:@"10"];
    }];
}
//买单
- (void)PayOrderWithorderId:(NSString *)orderId price:(NSString *)price{
    __weak typeof(&*self) weakSelf = self;
    [self vs_showLoading];
    NSString *DESMoney = [SecurityUtil encryptUseDES:price key:APP_DES_PASSWORDKEY];
    NSString *MD5Money = [SecurityUtil encryptMD5String:[NSString stringWithFormat:@"%@%@",DESMoney,price]];
    
    NSLog(@"price=%@,DESMoney=%@,MD5Money=%@",price,DESMoney,MD5Money);
    
    NSDictionary *dic = @{
                          @"userLoginId":[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.username,//用户id
                          @"orderId":orderId,//	订单号
                          @"price":DESMoney,//	AES
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
        [self.m_tableView headerEndRefreshing];
        [self.m_tableView footerEndRefreshing];
        [self vs_hideLoadingWithCompleteBlock:nil];
        
    } orFail:^(id callBackData) {
        [self.m_tableView headerEndRefreshing];
        [self.m_tableView footerEndRefreshing];
        [self vs_hideLoadingWithCompleteBlock:nil];
        if ([callBackData isKindOfClass:[NSError class]]) {
            NSError *error = (NSError *)callBackData;
            [weakSelf.view showTipsView:[error domain]];
            weakSelf.order = nil;
        }
    }];
}

//刷新订单列表
- (void)mrefreshOrderList:(NSString *)orderStatus type:(NSString *)orderType page:(NSString *)page row:(NSString *)row{
    
    [self vs_showLoading];
    
    NSDictionary *dic = @{@"userLoginId":[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.username,//用户id
                          @"orderId":@"",//	订单号
                          @"orderStatusId":orderStatus,//	订单状态
                          @"orderTypeId":orderType,//	订单类型
                          @"page":page,//	显示第几页
                          @"row":row,//	每页显示条数
                          };
    
    
    [BCNetWorkTool executeGETNetworkWithParameter:dic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.order/get-order-list" withSuccess:^(id callBackData) {
        
        NSDictionary *dic = (NSDictionary *)callBackData;
        
        NSArray *orderList = dic[@"orderList"];
        
        if (page.integerValue == 1) {
            [self.dataSources removeAllObjects];
        }
        
        for (NSDictionary *itemDic in orderList) {
            Order *order = [[Order alloc] initWithDictionary:itemDic error:nil];
            [self.dataSources addObject:order];
        }
        
        [self.m_tableView headerEndRefreshing];
        [self.m_tableView footerEndRefreshing];
        
        [self.m_tableView reloadData];
        
        if ( [dic[@"nextPage"] isEqualToString:@"Y"]) {
            [self.m_tableView setFooterHidden:NO];
        }else{
            [self.m_tableView setFooterHidden:YES];
        }
        
        [self vs_hideLoadingWithCompleteBlock:nil];
        
    } orFail:^(id callBackData) {
        
        [self.m_tableView headerEndRefreshing];
        [self.m_tableView footerEndRefreshing];
        
        [self vs_hideLoadingWithCompleteBlock:nil];
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return [(NSMutableArray *)self.dataSources count];
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSMutableArray * arr =(NSMutableArray *)self.dataSources;
    Order *order = arr[section];
    
    return 2 + order.orderProductList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger num = [self tableView:tableView numberOfRowsInSection:indexPath.section];
    if (indexPath.row == 0) {
        return 33;
    }else if(indexPath.row == num - 1){
        return 44;
    }else{
        return 77;
    }
    
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    __weak typeof(&*self) weakSelf = self;
    NSMutableArray * arr =(NSMutableArray *)self.dataSources;
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    Order *order = arr[indexPath.section];
    NSInteger num = [self tableView:tableView numberOfRowsInSection:indexPath.section];
    if (indexPath.row == 0) {
        
        MyOrdersTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyOrdersTitleTableViewCellIdentifier];
        cell.order = order;
        
        return cell;
        
    }else if(indexPath.row == num - 1){
        
        MyOrdersInfoAndOperationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyOrdersInfoAndOperationTableViewCellIdentifier];
        cell.order = order;
        [cell setReadyPayOrder:^(Order *order) {
            //买单
            weakSelf.order = order;
            [weakSelf showAlertView];
        }];
        
        [cell setCancelAppointment:^(Order *order) {
            //取消预约
            weakSelf.order = order;
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"确定要取消预约？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alertView.tag = 100;
            
            [alertView show];
        }];
        
        return cell;
        
    }else{
        
        MyOrdersProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyOrdersProductTableViewCellIdentifier];
        
        cell.orderProduct = [order.orderProductList objectAtIndex:row - 1];
        
        
        
        return cell;
        
    }
    
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableArray * arr =(NSMutableArray *)self.dataSources;
    Order *order = arr[indexPath.section];
    
    [self showOrderDetail:order];

}
- (void)showOrderDetail:(Order *)order{
//    if ([order.orderHeader.orderTypeId isEqualToString:SALES_ORDER_O2O_SERVICE]) {
    
        O2OOrderDetailViewController *vc = [O2OOrderDetailViewController new];
        
        vc.orderId = order.orderHeader.orderId;
        
        [self.navigationController pushViewController:vc animated:YES];
        
//    }
}
#pragma mark -
-(void)showAlertView{
    payAlert = [[RTXReadyPayAlertView alloc] initWithTitle:nil BaseController:self message:nil cancelButtonTitle:@"取消" confirmButtonTitle:@"确定"];
    payAlert.delegate = self;
    __weak RTXMyAppointmentViewController *weakSelf = self;
    [payAlert setCancelBlock:^(RTXReadyPayAlertView * alertView) {
        [alertView dismiss];
    }];
    [payAlert setConfirmBlock:^(RTXReadyPayAlertView *alertView) {
        __strong RTXMyAppointmentViewController *strongSelf = weakSelf;
        NSString *money = [alertView getMoney];
        //校验金额
        if (![NSString isValidateMoney:money]) {
            //提示金额输入错误
            [weakSelf.view showTipsView:@"请输入正确的金额!"];
            return ;
        }
        //业务处理
        [strongSelf PayOrderWithorderId:weakSelf.order.orderHeader.orderId price:money];
        [alertView dismiss];
    }];
    [payAlert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 100) {
        if (buttonIndex == 1) {
            //取消预约
            [self cancelAppointment:self.order];
            self.order = nil;
        }
    }
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

//取消预约
- (void)cancelAppointment:(Order *)order{
    
    
    [self vs_showLoading];
    
    NSDictionary *dic = @{@"userLoginId":[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.username,//用户id
                          @"orderId":order.orderHeader.orderId,//	订单号
                          };
    NSData *contentData = (NSData *)[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString* jsonContent = [[NSString alloc] initWithData:contentData encoding:NSUTF8StringEncoding];
    
    NSDictionary * contentDic = [NSDictionary dictionaryWithObjectsAndKeys:jsonContent,@"content", nil];
    
    [BCNetWorkTool executePostNetworkWithParameter:contentDic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.order/cancle-order" withSuccess:^(id callBackData) {
        
        
        [self.m_tableView headerBeginRefreshing];
        
        [self vs_hideLoadingWithCompleteBlock:nil];
        
    } orFail:^(id callBackData) {
        
        if ([callBackData isKindOfClass:[NSError class]]) {
            NSError *error = (NSError *)callBackData;
            [self.view showTipsView:[error domain]];
        }
        
        [self vs_hideLoadingWithCompleteBlock:nil];
    }];
    
}
#pragma mark -- getter
_GETTER_BEGIN(UITableView, m_tableView)
{
    _m_tableView = [[UITableView alloc]init];
    [self.view addSubview:_m_tableView];
    [_m_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    _CLEAR_BACKGROUND_COLOR_(_m_tableView);
    [_m_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}
_GETTER_END(m_tableView)
@end

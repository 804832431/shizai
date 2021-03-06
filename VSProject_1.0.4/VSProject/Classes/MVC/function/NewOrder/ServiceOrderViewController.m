//
//  ServiceOrderViewController.m
//  VSProject
//
//  Created by 陈 海涛 on 16/8/3.
//  Copyright © 2016年 user. All rights reserved.
//

#import "ServiceOrderViewController.h"

#import "UIColor+TPCategory.h"
#import "MyOrdersInfoAndOperationTableViewCell.h"
#import "MyOrdersProductTableViewCell.h"
#import "MyOrdersTitleTableViewCell.h"
#import "BCNetWorkTool.h"
#import "Order.h"
#import "OrderProduct.h"
#import "OrderHeader.h"
#import "O2OOrderDetailViewController.h"
#import "OrderDetailViewController.h"
#import "OrderPayViewController.h"
#import "RefundReasonViewController.h"
#import "NewEvaluateViewController.h"
#import "MeEmptyDataView.h"
#import "InvoiceApplyViewController.h"

static NSString *MyOrdersTitleTableViewCellIdentifier = @"MyOrdersTitleTableViewCellIdentifier";
static NSString *MyOrdersProductTableViewCellIdentifier = @"MyOrdersProductTableViewCellIdentifier";
static NSString *MyOrdersInfoAndOperationTableViewCellIdentifier = @"MyOrdersInfoAndOperationTableViewCellIdentifier";

@interface ServiceOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIView *orderTypeSegmentView;

@property (nonatomic,strong) UILabel *segmentTopLineView;

@property (nonatomic,strong) UILabel *segmentBottomLineView;

@property (nonatomic,strong) UIView *segmentViewWhiteContentView;

@property (nonatomic,strong) NSArray *segmentViewTitles;

@property (nonatomic,strong) NSArray *contentTaleViews;

@property (nonatomic,strong) UIScrollView *contentScrollView;

@property (nonatomic,strong) NSArray *dataSources;

@property (nonatomic, strong) UIView *headBottomLine; // 头部下划线

@end

@implementation ServiceOrderViewController

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (NSArray *)dataSources{
    
    if (_dataSources == nil) {
        
        _dataSources = @[[NSMutableArray array],[NSMutableArray array],[NSMutableArray array],[NSMutableArray array],[NSMutableArray array],[NSMutableArray array]];
    }
    
    return _dataSources;
    
}

- (NSArray *)segmentViewTitles{
    
    if (_segmentViewTitles == nil) {
        _segmentViewTitles = @[@"待支付",@"待受理",@"已受理",@"待服务",@"已完成"];
    }
    return _segmentViewTitles;
}

- (NSArray *)contentTaleViews{
    
    if (_contentTaleViews == nil) {
        _contentTaleViews  = @[[UITableView new],[UITableView new],[UITableView new],[UITableView new],[UITableView new],[UITableView new]];
    }
    
    return _contentTaleViews;
}

- (UIScrollView *)contentScrollView{
    
    if (_contentScrollView == nil) {
        _contentScrollView = [UIScrollView new];
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.scrollEnabled = NO;
    }
    
    return _contentScrollView;
}

- (UIView *)orderTypeSegmentView{
    
    if (_orderTypeSegmentView == nil) {
        
        _orderTypeSegmentView = [UIView new];
        _orderTypeSegmentView.backgroundColor = [UIColor colorFromHexRGB:@"f1f1f1"];
        
    }
    
    return _orderTypeSegmentView;
    
}

- (UILabel *)segmentTopLineView{
    
    if (_segmentTopLineView == nil) {
        _segmentTopLineView = [UILabel new];
        _segmentTopLineView.backgroundColor = [UIColor colorFromHexRGB:@"dbdbdb"];
        
    }
    
    return _segmentTopLineView;
}

- (UILabel *)segmentBottomLineView{
    
    if (_segmentBottomLineView == nil) {
        _segmentBottomLineView = [UILabel new];
        _segmentBottomLineView.backgroundColor = [UIColor colorFromHexRGB:@"dbdbdb"];
        
    }
    
    return _segmentBottomLineView;
}

- (UIView *)headBottomLine {
    
    if (!_headBottomLine) {
        _headBottomLine = [[UIView alloc] initWithFrame:CGRectZero];
        _headBottomLine.backgroundColor = _COLOR_HEX(0x5bddb1);
        _headBottomLine.hidden = YES;
    }
    return _headBottomLine;
}

- (UIView *)segmentViewWhiteContentView{
    
    if (_segmentViewWhiteContentView == nil) {
        _segmentViewWhiteContentView = [UIView new];
        _segmentViewWhiteContentView.backgroundColor = [UIColor whiteColor];
    }
    
    return _segmentViewWhiteContentView;
}

- (void)_initOrderTypeSegmentView{
    
    __weak typeof(&*self) weakSelf = self;
    
    [self.view addSubview:self.orderTypeSegmentView];
    
    [self.segmentViewWhiteContentView addSubview:self.segmentTopLineView];
    [self.segmentViewWhiteContentView addSubview:self.segmentBottomLineView];
    [self.segmentViewWhiteContentView addSubview:self.headBottomLine];
    [self.orderTypeSegmentView addSubview:self.segmentViewWhiteContentView];
    
    [self.segmentTopLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(weakSelf.orderTypeSegmentView);
        make.top.equalTo(weakSelf.segmentViewWhiteContentView);
        make.height.mas_equalTo(RETINA_1PX);
    }];
    
    [self.segmentViewWhiteContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(weakSelf.orderTypeSegmentView);
        make.top.equalTo(weakSelf.orderTypeSegmentView).offset(0);
        make.height.equalTo(@45);
    }];
    
    [self.segmentBottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(weakSelf.segmentViewWhiteContentView);
        make.height.mas_equalTo(RETINA_1PX);
    }];
    
    [self.headBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(weakSelf.segmentViewWhiteContentView);
        make.height.mas_equalTo(4.0f);
    }];
    
    [self.orderTypeSegmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.equalTo(weakSelf.view);
        make.height.mas_equalTo(47);
    }];
    
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 33- 28)/5;
    
    for (NSInteger i = 0; i < self.segmentViewTitles.count; i++) {
        
        NSString *title = self.segmentViewTitles[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorFromHexRGB:@"949494"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorFromHexRGB:@"ffffff"] forState:UIControlStateSelected];
        [button.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [button setBackgroundColor:[UIColor whiteColor]];
        //button.layer.cornerRadius = 2;
        //button.layer.borderColor = [[UIColor colorFromHexRGB:@"b2b2b2"] CGColor];
        //button.layer.borderWidth = 0.5;
        button.tag = 101 + i ;
        //button.layer.masksToBounds = NO;
        
        [self.segmentViewWhiteContentView addSubview:button];
        [button addTarget:self action:@selector(segmentViewAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.segmentViewWhiteContentView);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(41);
            
            if (i == 0) {
                make.leading.equalTo(weakSelf.segmentViewWhiteContentView).offset(16);
            }else{
                make.leading.equalTo(weakSelf.segmentViewWhiteContentView).offset(16 + (width + 7) * i  );
            }
        }];
        
    }
}

- (void)segmentViewAction:(UIButton *)sender{
    
    self.index = sender.tag - 100;
    
    for (UIView *view  in self.segmentViewWhiteContentView.subviews) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            view.backgroundColor = [UIColor whiteColor];
            [(UIButton *)view  setSelected:NO];
            view.layer.borderColor = [[UIColor colorFromHexRGB:@"ffffff"] CGColor];
        }
        
    }
    
    UIButton *button = (UIButton *)sender;
    //[button setBackgroundColor:[UIColor colorFromHexRGB:@"35b38d"]];
    //button.selected = YES;
    //button.layer.borderColor = [[UIColor clearColor] CGColor];
    
    self.contentScrollView.contentOffset = CGPointMake([UIScreen mainScreen].bounds.size.width * (button.tag - 101 + 1), 0);
    
    NSMutableArray *dataSource = self.dataSources[sender.tag -100];
    UITableView *tableView = [self.contentTaleViews  objectAtIndex:sender.tag - 100];
    if (dataSource.count == 0) {
        
        [tableView headerBeginRefreshing];
    }
    
    self.headBottomLine.hidden = NO;
    self.headBottomLine.frame = CGRectMake(button.frame.origin.x, 41.0f, button.frame.size.width, 4.0f);
    self.headBottomLine.backgroundColor = _COLOR_HEX(0x5bddb1);
}



- (void)_initContentScrollView{
    
    [self.view addSubview:self.contentScrollView];
    
    __weak typeof(&*self) weakSelf = self;
    
    [self.contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.orderTypeSegmentView.mas_bottom);
    }];
    
    UIView *containerView = [UIView new];
    [self.contentScrollView addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(weakSelf.contentScrollView);
        make.height.equalTo(weakSelf.contentScrollView);
        make.leading.trailing.equalTo(weakSelf.contentScrollView);
        
    }];
    
    UIView *preView = nil;
    for (NSInteger i =0 ; i < self.contentTaleViews.count ; i++) {
        
        [containerView addSubview:self.contentTaleViews[i]];
        
        [self.contentTaleViews[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(containerView);
            make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
            
            if (preView) {
                
                make.leading.equalTo(preView.mas_trailing);
                
            }else{
                
                make.leading.equalTo(containerView);
                
            }
        }];
        
        
        preView = self.contentTaleViews[i];
        
    }
    
    if (preView) {
        [preView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(containerView);
        }];
    }
    
}

- (void)_initTableViews{
    
    for (UITableView *tableView in self.contentTaleViews) {
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor colorFromHexRGB:@"f1f1f1"];
        
        [tableView registerClass:[MyOrdersTitleTableViewCell class] forCellReuseIdentifier:MyOrdersTitleTableViewCellIdentifier];
        [tableView registerClass:[MyOrdersProductTableViewCell class] forCellReuseIdentifier:MyOrdersProductTableViewCellIdentifier];
        [tableView registerClass:[MyOrdersInfoAndOperationTableViewCell class] forCellReuseIdentifier:MyOrdersInfoAndOperationTableViewCellIdentifier];
        
        __weak typeof(&*self) weakSelf = self;
        __weak UITableView *weakTableView = tableView;
        
        [tableView addHeaderWithCallback:^{
            NSInteger index = [weakSelf.contentTaleViews indexOfObject:weakTableView];
            NSString *orderStatus = [NSString stringWithFormat:@"%@,%@,%@,%@,%@",SZ_ORDER_CREATED,SZ_ORDER_APPROVED,SZ_ORDER_PROCESSING,SZ_ORDER_SENT,ORDER_COMPLETED];
            //@[@"待支付",@"待受理",@"已受理",@"待服务",@"已完成"];
            if (index == 0 || index == 1) {
                orderStatus = SZ_ORDER_CREATED;
            }else if(index == 2){
                orderStatus = ORDER_APPROVED;
            }else if(index == 3){
                orderStatus = ORDER_PROCESSING;
            }else if(index == 4){
                orderStatus = SZ_ORDER_SENT;
            }else if(index == 5){
                orderStatus = ORDER_COMPLETED;
            }
            
            
            [weakSelf refreshOrderList:orderStatus type:SZ_SALES_ORDER_O2O_SERVICE_PAY page:@"1" row:@"10" dataSource:weakSelf.dataSources[index] tableView:weakTableView];
        }];
        
        [tableView addFooterWithCallback:^{
            NSInteger index = [weakSelf.contentTaleViews indexOfObject:weakTableView];
            
            NSString *orderStatus = [NSString stringWithFormat:@"%@,%@,%@,%@,%@",SZ_ORDER_CREATED,SZ_ORDER_APPROVED,SZ_ORDER_PROCESSING,SZ_ORDER_SENT,ORDER_COMPLETED];
            
            if (index == 0 || index == 1) {
                orderStatus = SZ_ORDER_CREATED;
            }else if(index == 2){
                orderStatus = ORDER_APPROVED;
            }else if(index == 3){
                orderStatus = ORDER_PROCESSING;
            }else if(index == 4){
                orderStatus = SZ_ORDER_SENT;
            }else if(index == 5){
                orderStatus = ORDER_COMPLETED;
            }
            
            NSArray *data = weakSelf.dataSources[index];
            NSInteger page = data.count / 10 + 1;
            
            [weakSelf refreshOrderList:orderStatus type:SZ_SALES_ORDER_O2O_SERVICE_PAY page:[NSString stringWithFormat:@"%zi",page] row:@"10" dataSource:weakSelf.dataSources[index] tableView:weakTableView];
        }];
    }
}

//刷新订单列表
- (void)refreshOrderList:(NSString *)orderStatus type:(NSString *)orderType page:(NSString *)page row:(NSString *)row dataSource:(NSMutableArray *)datasource tableView:(UITableView *)tableView{
    
//    [self vs_showLoading];
    
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
            [datasource removeAllObjects];
        }
        
        for (NSDictionary *itemDic in orderList) {
            Order *order = [[Order alloc] initWithDictionary:itemDic error:nil];
            [datasource addObject:order];
        }
        
        [tableView headerEndRefreshing];
        [tableView footerEndRefreshing];
        
        [tableView reloadData];
        
        if ( [dic[@"nextPage"] isEqualToString:@"Y"]) {
            [tableView setFooterHidden:NO];
        }else{
            [tableView setFooterHidden:YES];
        }
        
        [self vs_hideLoadingWithCompleteBlock:nil];
        
    } orFail:^(id callBackData) {
        
        [tableView headerEndRefreshing];
        [tableView footerEndRefreshing];
        
        [self vs_hideLoadingWithCompleteBlock:nil];
    }];
    
}

#pragma mark -

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self vs_setTitleText:@"服务订单"];
    
    [self _initOrderTypeSegmentView];
    
    [self _initTableViews];
    
    [self _initContentScrollView];
    
//    [self vs_showLoading];
    
    
    
    
    [self performSelector:@selector(changeSegmentView) withObject:nil afterDelay:0.3];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccess:) name:kALPaySucNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccess:) name:kWXPaySucNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payFail:) name:kALPayFailNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payFail:) name:kWXPayFailNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orderStatusChanged:) name:kOrderStatusNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    UITableView *tableView = [self.contentTaleViews  objectAtIndex:self.index];
    [tableView headerBeginRefreshing];
}

#pragma mark - 订单支付成功

- (void)orderStatusChanged:(NSNotification *)notification{
    
    UITableView *tableView = [self.contentTaleViews  objectAtIndex:self.index];
    
    [tableView headerBeginRefreshing];
    
    NSInteger index = [self.contentTaleViews indexOfObject:tableView];
    
    for (NSInteger i = 0; i < self.dataSources.count; i++) {
        
        if (i != index) {
            [self.dataSources[i] removeAllObjects];
        }
    }
    
}

- (void)paySuccess:(NSNotification *)notification{
    
    UITableView *tableView = [self.contentTaleViews  objectAtIndex:self.index];
    
    [tableView headerBeginRefreshing];
}

- (void)payFail:(NSNotification *)notification{
    
}

#pragma mark -

- (void) changeSegmentView{
    
    [self.contentTaleViews.firstObject headerBeginRefreshing];
    UIButton *button = (UIButton *)[self.segmentViewWhiteContentView viewWithTag:101];
    [self segmentViewAction:button];
}

#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    NSInteger index = [self.contentTaleViews indexOfObject:tableView];
    
    NSInteger count = [(NSMutableArray *)self.dataSources[index] count];
    if (count <= 0) {
        MeEmptyDataView *noDataView = [tableView viewWithTag:1011];
        if (noDataView == nil) {
            noDataView = [[MeEmptyDataView alloc] init];
        }
        
        [tableView addSubview:noDataView];
        noDataView.tag = 1011;
        noDataView.frame = self.view.bounds;
    }
    else{
        
        MeEmptyDataView *noDataView = [tableView viewWithTag:1011];
        if (noDataView) {
            [noDataView removeFromSuperview];
        }
    }
    
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger index = [self.contentTaleViews indexOfObject:tableView];
    NSMutableArray * arr =(NSMutableArray *)self.dataSources[index];
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
    NSInteger index = [self.contentTaleViews indexOfObject:tableView];
    NSMutableArray * arr =(NSMutableArray *)self.dataSources[index];
    Order *order = arr[indexPath.section];
    NSInteger num = [self tableView:tableView numberOfRowsInSection:indexPath.section];
    if (indexPath.row == 0) {
        
        MyOrdersTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyOrdersTitleTableViewCellIdentifier];
        cell.order = order;
        
        return cell;
        
    }else if(indexPath.row == num - 1){
        
        MyOrdersInfoAndOperationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyOrdersInfoAndOperationTableViewCellIdentifier];
        cell.order = order;
        
        [cell setCancelOrder:^(Order *order) {
            //取消订单
            weakSelf.cancelOrder = order;
            
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
        
        [cell setShowPostInfo:^(Order *order) {
            //查看订单信息
            [weakSelf showOrderDetail:order];
        }];
        
        [cell setEvaluateOrder:^(Order *order) {
            [weakSelf evaluteOrder:order];
        }];
        
        [cell setApplyInvoice:^(Order *order) {
            //发票申请
            InvoiceApplyViewController *vc = [[InvoiceApplyViewController alloc] init];
            vc.order = order;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
        
        return cell;
        
    }else{
        
        MyOrdersProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyOrdersProductTableViewCellIdentifier];
        
        cell.orderProduct = order.orderProductList[indexPath.row - 1];
        
        
        
        return cell;
        
    }
    
    return nil;
}


//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//
//    UIView *view = [UIView new];
//    view.backgroundColor = [UIColor colorFromHexRGB:@"f1f1f1"];
//
//    return view;
//
//
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//
//    NSInteger num = [self numberOfSectionsInTableView:tableView];
//    if (section == num -1) {
//        return 0;
//    }else{
//        return 13;
//    }
//
//
//
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger index = [self.contentTaleViews indexOfObject:tableView];
    NSMutableArray * arr =(NSMutableArray *)self.dataSources[index];
    Order *order = arr[indexPath.section];
    
    [self showOrderDetail:order];
}

#pragma mark -

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 100) {
        if (buttonIndex == 1) {
            
            
            [self cancelOrder:self.cancelOrder];
            
            self.cancelOrder = nil;
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
        
        
        [(UITableView *)self.contentTaleViews[self.index] headerBeginRefreshing];
        
        [self vs_hideLoadingWithCompleteBlock:nil];
        
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
        
        [(UITableView *)self.contentTaleViews[self.index] headerBeginRefreshing];
        
        [self vs_hideLoadingWithCompleteBlock:nil];
        
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
            [(UITableView *)self.contentTaleViews[weakSelf.index] headerBeginRefreshing];
        }
        
    }];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}


- (void)evaluteOrder:(Order *)order{
    
    
    NewEvaluateViewController   *vc = [[NewEvaluateViewController alloc] init];
    
    vc.order = order;
    
    __weak typeof(&*self) weakSelf = self;
    [vc setEvaluateBlock:^{
        [(UITableView *)weakSelf.contentTaleViews[weakSelf.index] headerBeginRefreshing];
    }];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}

//查看物流

- (void)showOrderDetail:(Order *)order{
    
    
    O2OOrderDetailViewController *vc = [O2OOrderDetailViewController new];
    
    vc.orderId = order.orderHeader.orderId;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}

@end

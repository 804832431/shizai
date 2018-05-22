//
//  RefundViewController.m
//  VSProject
//
//  Created by 陈 海涛 on 16/8/3.
//  Copyright © 2016年 user. All rights reserved.
//

#import "RefundViewController.h"
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
#import "RefundOrdersTitleTableViewCell.h"
#import "RefundOrdersProductTableViewCell.h"
#import "RefundOrderInfoViewController.h"
#import "MeEmptyDataView.h"


static NSString *RefundOrdersTitleTableViewCellIdentifier = @"RefundOrdersTitleTableViewCellIdentifier";
static NSString *RefundOrdersProductTableViewCellIdentifier = @"RefundOrdersProductTableViewCellIdentifier";


@interface RefundViewController ()<UITableViewDelegate,UITableViewDataSource>

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

@implementation RefundViewController

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (NSArray *)dataSources{
    
    if (_dataSources == nil) {
        
        _dataSources = @[[NSMutableArray array],[NSMutableArray array],[NSMutableArray array],[NSMutableArray array],[NSMutableArray array]];
    }
    
    return _dataSources;
    
}

- (NSArray *)segmentViewTitles{
    
    if (_segmentViewTitles == nil) {
        _segmentViewTitles = @[@"全部",@"申请中",@"已同意",@"已退款",@"已拒绝"];
    }
    return _segmentViewTitles;
}

- (NSArray *)contentTaleViews{
    
    if (_contentTaleViews == nil) {
        _contentTaleViews  = @[[UITableView new],[UITableView new],[UITableView new],[UITableView new],[UITableView new]];
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


- (UIView *)segmentViewWhiteContentView{
    
    if (_segmentViewWhiteContentView == nil) {
        _segmentViewWhiteContentView = [UIView new];
        _segmentViewWhiteContentView.backgroundColor = [UIColor whiteColor];
    }
    
    return _segmentViewWhiteContentView;
}

- (UIView *)headBottomLine {
    
    if (!_headBottomLine) {
        _headBottomLine = [[UIView alloc] initWithFrame:CGRectZero];
        _headBottomLine.backgroundColor = _COLOR_HEX(0x5bddb1);
        _headBottomLine.hidden = YES;
    }
    return _headBottomLine;
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
    
    [self.orderTypeSegmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.equalTo(weakSelf.view);
        make.height.mas_equalTo(47);
    }];
    
    [self.headBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(weakSelf.segmentViewWhiteContentView);
        make.height.mas_equalTo(4.0f);
    }];
    
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - (self.segmentViewTitles.count +1) * 10 )/ self.segmentViewTitles.count;
    
    CGFloat sepWidth = 10;
    
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
        button.tag = 100 + i ;
        
        [self.segmentViewWhiteContentView addSubview:button];
        [button addTarget:self action:@selector(segmentViewAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.segmentViewWhiteContentView);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(41);
            
            if (i == 0) {
                make.leading.equalTo(weakSelf.segmentViewWhiteContentView).offset(sepWidth);
            }else{
                make.leading.equalTo(weakSelf.segmentViewWhiteContentView).offset((sepWidth + width)  * i + sepWidth  );
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
            view.layer.borderColor = [[UIColor colorFromHexRGB:@"b2b2b2"] CGColor];
        }
        
    }
    
    UIButton *button = (UIButton *)sender;
    //[button setBackgroundColor:[UIColor colorFromHexRGB:@"35b38d"]];
    //button.selected = YES;
    //button.layer.borderColor = [[UIColor clearColor] CGColor];
    
    self.contentScrollView.contentOffset = CGPointMake([UIScreen mainScreen].bounds.size.width * (button.tag - 100), 0);
    
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
        
        [tableView registerClass:[RefundOrdersTitleTableViewCell class] forCellReuseIdentifier:RefundOrdersTitleTableViewCellIdentifier];
        [tableView registerClass:[RefundOrdersProductTableViewCell  class] forCellReuseIdentifier:RefundOrdersProductTableViewCellIdentifier];
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"defaultCell"];
        
        __weak typeof(&*self) weakSelf = self;
        __weak UITableView *weakTableView = tableView;
        [tableView addHeaderWithCallback:^{
            NSInteger index = [weakSelf.contentTaleViews indexOfObject:weakTableView];
            NSString *orderStatus = nil;
            // @[@"全部",@"申请中",@"已同意",@"已退款",@"已拒绝"];
            if(index == 0){
                orderStatus = [NSString stringWithFormat:@"%@,%@,%@,%@", SZ_RETURN_REQUESTED,SZ_RETURN_ACCEPTED,SZ_RETURN_MAN_REFUND,SZ_RETURN_COMPLETED];
            }else if(index == 1){
                orderStatus = SZ_RETURN_REQUESTED;
            }else if(index == 2){
                orderStatus = SZ_RETURN_ACCEPTED;
            }else if(index == 3){
                orderStatus = RETURN_COMPLETED;
            }else if(index == 4){
                orderStatus = RETURN_MAN_REFUND;
            }
            
            
            [weakSelf refreshOrderList:orderStatus type:@"SALES_ORDER_O2O_SALE,SALES_ORDER_O2O_SERVICE_PAY" page:@"1" row:@"10" dataSource:weakSelf.dataSources[index] tableView:weakTableView];
        }];
        
        [tableView addFooterWithCallback:^{
            NSInteger index = [weakSelf.contentTaleViews indexOfObject:weakTableView];
            NSString *orderStatus = nil;
            
            if(index == 0){
                orderStatus = [NSString stringWithFormat:@"%@,%@,%@,%@", SZ_RETURN_REQUESTED,SZ_RETURN_ACCEPTED,SZ_RETURN_MAN_REFUND,SZ_RETURN_COMPLETED];
            }else if(index == 1){
                orderStatus = SZ_RETURN_REQUESTED;
            }else if(index == 2){
                orderStatus = SZ_RETURN_ACCEPTED;
            }else if(index == 3){
                orderStatus = RETURN_COMPLETED;
            }else if(index == 4){
                orderStatus = RETURN_MAN_REFUND;
            }
            
            NSArray *data = weakSelf.dataSources[index];
            NSInteger page = data.count / 10 + 1;
            
            [weakSelf refreshOrderList:orderStatus type:@"SALES_ORDER_O2O_SALE,SALES_ORDER_O2O_SERVICE_PAY" page:[NSString stringWithFormat:@"%zi",page] row:@"10" dataSource:weakSelf.dataSources[index] tableView:weakTableView];
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
    
    
    [BCNetWorkTool executeGETNetworkWithParameter:dic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.order/get-return-order-list" withSuccess:^(id callBackData) {
        
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
    
    [self vs_setTitleText:@"订单退款"];
    
    
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
    
    UIButton *button = (UIButton *)[self.segmentViewWhiteContentView viewWithTag:100];
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
        return 30;
    }else if(indexPath.row == num - 1){
        return 44;
    }else{
        return 100;
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
        
        RefundOrdersTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RefundOrdersTitleTableViewCellIdentifier];
        cell.order = order;
        
        return cell;
        
    }else if(indexPath.row == num - 1){
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"defaultCell"];
        
        UIView *view =  [cell viewWithTag:101];
        
        if (view == nil) {
            UIView *lineView = [UIView new];
            lineView.tag = 101;
            lineView.backgroundColor = _Colorhex(0xdbdbdb);
            
            [cell.contentView addSubview:lineView];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.trailing.bottom.equalTo(cell.contentView);
                make.height.mas_equalTo(0.5);
            }];
        }
        
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        
        cell.backgroundColor = _Colorhex(0xf1f1f1);
        
        return cell;
        
    }else{
        
        RefundOrdersProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RefundOrdersProductTableViewCellIdentifier];
        
        cell.order = order;
        
        
        
        return cell;
        
    }
    
    return nil;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger index = [self.contentTaleViews indexOfObject:tableView];
    NSMutableArray * arr =(NSMutableArray *)self.dataSources[index];
    Order *order = arr[indexPath.section];
    
    [self showOrderDetail:order];
}

#pragma mark -



- (void)showOrderDetail:(Order *)order{
    
    
    RefundOrderInfoViewController *vc = [RefundOrderInfoViewController new];
    
    vc.order = order;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}




@end

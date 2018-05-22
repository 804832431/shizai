//
//  OrderPayViewController.m
//  VSProject
//
//  Created by 陈 海涛 on 15/11/15.
//  Copyright © 2015年 user. All rights reserved.
//

#import "OrderPayViewController.h"
#import "UIColor+TPCategory.h"
#import "BCNetWorkTool.h"
#import <AlipaySDK/AlipaySDK.h>
#import "AlixPayResult.h"
#import "WXApiObject.h"
#import "WXApi.h"
#import "UIView+ShowTips.h"
#import "O2OOrderDetailViewController.h"
#import "OrderDetailViewController.h"
#import "MyOrdersViewController.h"
#import "CheckOrderViewController.h"

#import "RTXUnionPayWebViewController.h"




@implementation OrderPayViewController

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    NSLog(@"OrderPayViewController");
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    [self vs_setTitleText:@"订单支付"];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor colorFromHexRGB:@"f1f1f1"];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccess:) name:kALPaySucNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccess:) name:kWXPaySucNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payFail:) name:kALPayFailNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payFail:) name:kWXPayFailNotification object:nil];
    
    [self loadSubviews];
}

- (void)paySuccess:(NSNotification *)notification{
    
    
    [self showOrderDetail:self.orderId];
    
    
    NSArray *arr = self.navigationController.viewControllers;
    NSMutableArray *tmpArr = [NSMutableArray arrayWithArray:arr];
    
    UIViewController *lastVC = tmpArr.lastObject;
    
    [tmpArr removeObject:tmpArr.lastObject];
    
    NSMutableArray *deleteArr = [NSMutableArray array];
    
    for (UIViewController *vc in tmpArr) {
        
        if ([vc isKindOfClass:[OrderPayViewController class]]) {
            [deleteArr addObject:vc];
        }
        
        if ([vc isKindOfClass:[OrderDetailViewController class]]) {
            [deleteArr addObject:vc];
        }
        
        if ([vc isKindOfClass:[O2OOrderDetailViewController class]]) {
            [deleteArr addObject:vc];
        }
        
        if ([vc isKindOfClass:[CheckOrderViewController class]]) {
            [deleteArr addObject:vc];
        }
    }
    
    if (deleteArr.count > 0) {
        [tmpArr removeObjectsInArray:deleteArr];
    }
    
    [tmpArr addObject:lastVC];
    self.navigationController.viewControllers = [NSArray arrayWithArray:tmpArr];
    
    
}

- (void)payFail:(NSNotification *)notification{
    
    
    
    
}


//查看物流

- (void)showOrderDetail:(NSString *)orderId{
    
    O2OOrderDetailViewController *vc = [O2OOrderDetailViewController new];
    
    vc.orderId = orderId;
    
    [self.navigationController pushViewController:vc animated:YES];
    
//    if ([self.orderType isEqualToString:SALES_ORDER_B2C]) {
//        
//        OrderDetailViewController *vc = [OrderDetailViewController new];
//        
//        vc.orderId = orderId;
//        
//        [self.navigationController pushViewController:vc animated:YES];
//        
//    }else if([self.orderType isEqualToString:SALES_ORDER_O2O_SALE]){
//        
//        O2OOrderDetailViewController *vc = [O2OOrderDetailViewController new];
//        
//        vc.orderId = orderId;
//        
//        [self.navigationController pushViewController:vc animated:YES];
//    }else if([self.orderType isEqualToString:SALES_ORDER_O2O_SERVICE]){
//        
//        O2OOrderDetailViewController *vc = [O2OOrderDetailViewController new];
//        
//        vc.orderId = orderId;
//        
//        [self.navigationController pushViewController:vc animated:YES];
//    }else if([self.orderType isEqualToString:SALES_ORDER_O2O_SERVICE_PAY]){
//        
//        OrderDetailViewController *vc = [OrderDetailViewController new];
//        
//        vc.orderId = orderId;
//        
//        [self.navigationController pushViewController:vc animated:YES];
//    }
}

//初始化数据
- (void) loadSubviews{
    
    __weak typeof(&*self) weakSelf = self;
    
    //分割线
    UILabel *topSepLineView = [UILabel new];
    topSepLineView.backgroundColor = [UIColor colorFromHexRGB:@"dbdbdb"];
    [self.view addSubview:topSepLineView];
    [topSepLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view.mas_top).offset(16);
        make.height.equalTo(@1);
    }];
    
    UIView *orderView = [UIView new];
    orderView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:orderView];
    [orderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(weakSelf.view);
        make.top.equalTo(topSepLineView.mas_bottom);
        make.height.mas_equalTo(90);
    }];
    
    
    UILabel *orderID = [UILabel new];
    orderID.font = [UIFont systemFontOfSize:15];
    orderID.textColor = [UIColor colorFromHexRGB:@"222222"];
    orderID.text = [NSString stringWithFormat:@"订单编号：%@",self.orderId];
    [orderView addSubview:orderID];
    [orderID mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(orderView).offset(18);
        make.top.equalTo(orderView).offset(15);
    }];
    
    
    //分割线
    UIImageView *sepImageView = [UIImageView new];
    sepImageView.image = [UIImage imageNamed:@"虚线分割线1"];
    [orderView addSubview:sepImageView];
    [sepImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(orderView).offset(16);
        make.trailing.equalTo(orderView).offset(-16);
        make.centerY.equalTo(orderView);
        make.height.equalTo(@1);
    }];
    
    //需支付金额
    UILabel *orderMoney = [UILabel new];
    orderMoney.font = [UIFont systemFontOfSize:12];
    orderMoney.textColor = [UIColor colorFromHexRGB:@"666666"];
    orderMoney.text = @"需支付金额";
    [orderView addSubview:orderMoney];
    [orderMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(orderView).offset(18);
        make.top.equalTo(sepImageView).offset(15);
    }];
    
    //需支付金额
    UILabel *orderMoneyValue = [UILabel new];
    orderMoneyValue.font = [UIFont systemFontOfSize:12];
    orderMoneyValue.textColor = [UIColor colorFromHexRGB:@"f15353"];
    orderMoneyValue.text = [NSString stringWithFormat:@"¥ %.2f",self.needPayMoeny.doubleValue];
    [orderView addSubview:orderMoneyValue];
    [orderMoneyValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(orderView).offset(-16);
        make.top.equalTo(sepImageView).offset(15);
    }];
    
    //分割线
    UILabel *middleOnesepLineView = [UILabel new];
    middleOnesepLineView.backgroundColor = [UIColor colorFromHexRGB:@"dbdbdb"];
    [self.view addSubview:middleOnesepLineView];
    [middleOnesepLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(weakSelf.view);
        make.top.equalTo(orderView.mas_bottom);
        make.height.equalTo(@1);
    }];
    
    //请选择支付方式
    UILabel *payType = [UILabel new];
    payType.font = [UIFont systemFontOfSize:12];
    payType.textColor = [UIColor colorFromHexRGB:@"999999"];
    payType.text = @"请选择支付方式：";
    [self.view addSubview:payType];
    [payType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.view).offset(16);
        make.top.equalTo(middleOnesepLineView).offset(15);
    }];
    
    //分割线
    UILabel *middleTwosepLineView = [UILabel new];
    middleTwosepLineView.backgroundColor = [UIColor colorFromHexRGB:@"dbdbdb"];
    [self.view addSubview:middleTwosepLineView];
    [middleTwosepLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(weakSelf.view);
        make.top.equalTo(middleOnesepLineView.mas_bottom).offset(32);
        make.height.equalTo(@1);
    }];
    
    
    UIView *payView = [UIView new];
    payView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:payView];
    [payView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(weakSelf.view);
        make.top.equalTo(middleTwosepLineView.mas_bottom);
        make.height.mas_equalTo(140);
    }];
    
    
    //微信支付
    UIImageView *wxImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"微信"]];
    [payView addSubview:wxImageView];
    [wxImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(payView).offset(16);
        make.top.equalTo(payView).offset(18);
        
    }];
    
    UIImageView *wxDetailImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"修改"]];
    [payView addSubview:wxDetailImageView];
    [wxDetailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(payView).offset(-16);
        make.centerY.equalTo(wxImageView);
        
    }];
    
    UILabel *wxLabel = [UILabel new];
    wxLabel.font = [UIFont systemFontOfSize:15];
    wxLabel.textColor = [UIColor colorFromHexRGB:@"222222"];
    wxLabel.text = @"微信支付";
    [payView addSubview:wxLabel];
    [wxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(wxImageView.mas_trailing).offset(15);
        make.top.equalTo(wxImageView);
    }];
    
    
    UILabel *subWXLabel = [UILabel new];
    subWXLabel.font = [UIFont systemFontOfSize:10];
    subWXLabel.textColor = [UIColor colorFromHexRGB:@"999999"];
    subWXLabel.text = @"微信安全支付";
    [payView addSubview:subWXLabel];
    [subWXLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(wxLabel);
        make.bottom.equalTo(wxImageView);
    }];
    
    
    
    
    //分割线
    UILabel *middlethreesepLineView = [UILabel new];
    middlethreesepLineView.backgroundColor = [UIColor colorFromHexRGB:@"dbdbdb"];
    [payView addSubview:middlethreesepLineView];
    [middlethreesepLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(payView);
        make.top.equalTo(payView).offset(70);
        make.height.equalTo(@1);
    }];
    
    
    //分割线
    UILabel *middlefoursepLineView = [UILabel new];
    middlefoursepLineView.backgroundColor = [UIColor colorFromHexRGB:@"dbdbdb"];
    [payView addSubview:middlefoursepLineView];
    [middlefoursepLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(payView);
        make.top.equalTo(payView).offset(140);
        make.height.equalTo(@1);
    }];
     
    /**
     支付宝支付UI
     */
    UIImageView *alImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"支付宝"]];
    [payView addSubview:alImageView];
    [alImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(payView).offset(16);
        make.bottom.equalTo(middlefoursepLineView).offset(-18);
        
    }];
    
    UIImageView *alDetailImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"修改"]];
    [payView addSubview:alDetailImageView];
    [alDetailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(payView).offset(-16);
        make.centerY.equalTo(alImageView);
        
    }];
    
    UILabel *alLabel = [UILabel new];
    alLabel.font = [UIFont systemFontOfSize:15];
    alLabel.textColor = [UIColor colorFromHexRGB:@"222222"];
    alLabel.text = @"支付宝支付";
    [payView addSubview:alLabel];
    [alLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(alImageView.mas_trailing).offset(15);
        make.top.equalTo(alImageView);
    }];
    
    
    UILabel *subALLabel = [UILabel new];
    subALLabel.font = [UIFont systemFontOfSize:10];
    subALLabel.textColor = [UIColor colorFromHexRGB:@"999999"];
    subALLabel.text = @"支付宝安全支付";
    [payView addSubview:subALLabel];
    [subALLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(alLabel);
        make.bottom.equalTo(alImageView);
    }];
    
    //分割线
    UILabel *middleFivesepLineView = [UILabel new];
    middleFivesepLineView.backgroundColor = [UIColor colorFromHexRGB:@"dbdbdb"];
    [self.view addSubview:middleFivesepLineView];
    [middleFivesepLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(weakSelf.view);
        make.top.equalTo(payView.mas_bottom);
        make.height.equalTo(@1);
    }];
    
    /**
     *  银联支付UI－－－start
     */
    /*
    UIImageView *ylImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"银联支付_"]];
    [payView addSubview:ylImageView];
    [ylImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(payView).offset(16);
        make.bottom.equalTo(middleFivesepLineView).offset(-18);
        
    }];
    
    UIImageView *ylDetailImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"修改"]];
    [payView addSubview:ylDetailImageView];
    [ylDetailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(payView).offset(-16);
        make.centerY.equalTo(ylImageView);
        
    }];
    
    UILabel *ylLabel = [UILabel new];
    ylLabel.font = [UIFont systemFontOfSize:15];
    ylLabel.textColor = [UIColor colorFromHexRGB:@"222222"];
    ylLabel.text = @"银联支付";
    [payView addSubview:ylLabel];
    [ylLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(ylImageView.mas_trailing).offset(15);
        make.top.equalTo(ylImageView);
    }];
    
    UILabel *subYLLabel = [UILabel new];
    subYLLabel.font = [UIFont systemFontOfSize:10];
    subYLLabel.textColor = [UIColor colorFromHexRGB:@"999999"];
    subYLLabel.text = @"银联安全支付";
    [payView addSubview:subYLLabel];
    [subYLLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(ylLabel);
        make.bottom.equalTo(ylImageView);
    }];
     */
    /**
     *  银联支付UI－－－end
     */
    
    UIButton *wxButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [payView addSubview:wxButton];
    [wxButton addTarget:self action:@selector(wxButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [wxButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(payView);
        make.bottom.equalTo(middlethreesepLineView.mas_top);
    }];
    
    UIButton *alButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [payView addSubview:alButton];
    [alButton addTarget:self action:@selector(alButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [alButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(middlethreesepLineView);
        make.bottom.equalTo(middlefoursepLineView.mas_top);
    }];
    
    UIButton *ylButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [payView addSubview:ylButton];
    [ylButton addTarget:self action:@selector(ylButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [ylButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(middlefoursepLineView);
        make.bottom.equalTo(middleFivesepLineView.mas_top);
    }];
    
    
    //    UIButton *payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [payButton setBackgroundColor:[UIColor colorFromHexRGB:@"f15353"]];
    //    [payButton setTitle:@"去支付" forState:UIControlStateNormal];
    //    [payButton setTitleColor:[UIColor colorFromHexRGB:@"ffffff"] forState:UIControlStateNormal];
    //    payButton.titleLabel.font = [UIFont systemFontOfSize:15];
    //    [payButton addTarget:self action:@selector(payButtonAction) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:payButton];
    //    [payButton mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.leading.trailing.bottom.equalTo(weakSelf.view);
    //        make.height.mas_equalTo(50);
    //    }];
}


/**
 *  银联支付
 */
- (void)ylButtonAction{
    NSLog(@"ylButtonAction");
    [self vs_showLoading];
    NSDictionary *dic = @{@"userLoginId":[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.username,//用户id
                          @"orderId":self.orderId//	订单号
                          };
    [BCNetWorkTool executeGETNetworkWithParameter:dic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.payment/pay-order-by-union-pay-wap" withSuccess:^(id callBackData) {
        
        NSDictionary *dic = (NSDictionary *)callBackData;
        
        NSLog(@"%@",dic);
        
        [self yinlianPay:dic[@"payInfo"]];
        
        [self vs_hideLoadingWithCompleteBlock:nil];
        
    } orFail:^(id callBackData) {
        if ([callBackData isKindOfClass:[NSError class]]) {
            NSError *error = (NSError *)callBackData;
            [self.view showTipsView:[error domain]];
        }else{
            [self.view showTipsView:[callBackData domain]];
        }
        [self vs_hideLoadingWithCompleteBlock:nil];
    }];
}

- (void)alButtonAction{
    
    NSLog(@"alButtonAction");
    
    
    [self vs_showLoading];
    
    NSDictionary *dic = @{@"userLoginId":[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.username,//用户id
                          @"orderId":self.orderId//	订单号
                          };
    
    
    [BCNetWorkTool executeGETNetworkWithParameter:dic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.payment/pay-order-by-alipay-app" withSuccess:^(id callBackData) {
        
        NSDictionary *dic = (NSDictionary *)callBackData;
        
        NSLog(@"%@",dic);
        
        [self aliPay:dic[@"payInfo"]];
        
        [self vs_hideLoadingWithCompleteBlock:nil];
        
    } orFail:^(id callBackData) {
        [self.view showTipsView:[callBackData domain]];
        
        [self vs_hideLoadingWithCompleteBlock:nil];
    }];
}

/**
 *  银联支付
 *  by Thomas
 *  @param htmlString 网页的字符串
 */
- (void)yinlianPay:(NSString *)htmlString {
    //打开网页
    RTXUnionPayWebViewController *payweb = [[RTXUnionPayWebViewController alloc] init];
    payweb.htmlStr = htmlString;
    [self.navigationController pushViewController:payweb animated:YES];
}

- (void)aliPay:(NSString *)orderString {
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"ruiAlipay";
    
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        
        NSLog(@"111 = %@",resultDic);
        
        
        AlixPayResult* result = [[AlixPayResult alloc] initWithDict:resultDic];
        
        if (result)
        {
            
            if (result.statusCode == 9000)
            {
                /*
                 *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
                 */
                
                //交易成功
                [self.view showTipsView:@"支付成功"];
                //验证签名成功，交易结果无篡改
                NSNotification *notification = [NSNotification notificationWithName:kALPaySucNotification object:@"success"];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                
                
                
            }
            else if(result.statusCode == 6001)
            {
                
                
                [self.view showTipsView:@"支付失败"];
                NSNotification *notification = [NSNotification notificationWithName:kALPayFailNotification object:@"fail"];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                
                
            }
            else
            {
                [self.view showTipsView:@"支付失败"];
                //交易失败
                NSNotification *notification = [NSNotification notificationWithName:kALPayFailNotification object:@"fail"];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                
                
            }
        }
        else
        {
            [self.view showTipsView:@"支付失败"];
            //失败
            NSNotification *notification = [NSNotification notificationWithName:kALPayFailNotification object:@"fail"];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
        }
        
    }];
    
}

- (void)wxButtonAction{
    
    NSLog(@"wxButtonAction");
    
    [self vs_showLoading];
    
    NSDictionary *dic = @{@"userLoginId":[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.username,//用户id
                          @"orderId":self.orderId//	订单号
                          };
    
    
    [BCNetWorkTool executeGETNetworkWithParameter:dic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet/weixin/pay" withSuccess:^(id callBackData) {
        
        NSDictionary *dic = (NSDictionary *)callBackData;
        
        NSLog(@"%@",dic);
        
        NSString *payInfo = dic[@"payInfo"];
        
        
        NSError *error = nil;
        NSDictionary *string2dic = [NSJSONSerialization JSONObjectWithData: [payInfo dataUsingEncoding:NSUTF8StringEncoding]
                                                                   options: NSJSONReadingMutableContainers
                                                                     error: &error];
        
        [self wxPay:string2dic];
        
        [self vs_hideLoadingWithCompleteBlock:nil];
        
    } orFail:^(id callBackData) {
        
        [self.view showTipsView:[callBackData domain]];
        
        [self vs_hideLoadingWithCompleteBlock:nil];
    }];
    
}

- (void)wxPay:(NSDictionary *)dic{
    
    if (![WXApi isWXAppInstalled] ) {
        
        [self.view showTipsView:@"此设备未安装微信"];
        
        
        return;
    }
    
    
    
    PayReq *request = [[PayReq alloc] init];
    
    request.openID = dic[@"appid"];
    
    request.partnerId = dic[@"partnerid"];
    
    request.prepayId= dic[@"prepayid"];
    
    request.package = dic[@"packageValue"];
    
    request.nonceStr= dic[@"noncestr"];
    
    request.timeStamp= (UInt32)[dic[@"timestamp"] longLongValue];
    
    request.sign= dic[@"sign"];
    
    
    BOOL falg =  [WXApi sendReq:request];
    
    NSLog(@"hello%zi",falg);
}

@end

















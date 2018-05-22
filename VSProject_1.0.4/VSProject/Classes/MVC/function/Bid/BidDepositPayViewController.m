//
//  BidDepositPayViewController.m
//  VSProject
//
//  Created by 陈 海涛 on 16/10/31.
//  Copyright © 2016年 user. All rights reserved.
//

#import "BidDepositPayViewController.h"
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
#import "BidDepositInfoViewController.h"
#import "BidWebViewController.h"



@interface BidDepositPayViewController ()

@end

@implementation BidDepositPayViewController

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    NSLog(@"OrderPayViewController");
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    [self vs_setTitleText:@"立即支付"];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor colorFromHexRGB:@"f1f1f1"];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccess:) name:kALPaySucNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccess:) name:kWXPaySucNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payFail:) name:kALPayFailNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payFail:) name:kWXPayFailNotification object:nil];
    
    [self loadSubviews];
}

- (void)paySuccess:(NSNotification *)notification{
    
    
    NSArray *arr = self.navigationController.viewControllers;
   
    BidWebViewController *webVC = nil;
    
    for (UIViewController *vc in arr ) {
        
        if ([vc isKindOfClass:[BidWebViewController class]]) {
            webVC = (BidWebViewController *)vc;
            break;
        }
    }
    
    [self.navigationController popToViewController:webVC animated:YES];
    
    
}

- (void)payFail:(NSNotification *)notification{
    
    
    
    
}



- (void)showOrderDetail:(NSString *)orderId{
    
    
}

//初始化数据
- (void) loadSubviews{
    
    __weak typeof(&*self) weakSelf = self;
    
    //请选择支付方式
    UILabel *payType = [UILabel new];
    payType.font = [UIFont systemFontOfSize:12];
    payType.textColor = [UIColor colorFromHexRGB:@"999999"];
    payType.text = @"选择支付方式";
    [self.view addSubview:payType];
    [payType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.view).offset(10);
        make.top.equalTo(weakSelf.view).offset(10);
    }];
    

    
    UIView *payView = [UIView new];
    payView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:payView];
    [payView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(weakSelf.view);
        make.top.equalTo(payType.mas_bottom).offset(10);
        make.height.mas_equalTo(122);
    }];
    
    
    
    /**
     支付宝支付UI
     */
    UIImageView *alImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"支付宝"]];
    [payView addSubview:alImageView];
    [alImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(payView).offset(10);
        make.top.equalTo(payView).offset(11);
        make.width.height.equalTo(@38);
    }];
    
    UIImageView *alDetailImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"修改"]];
    [payView addSubview:alDetailImageView];
    [alDetailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(payView).offset(-10);
        make.centerY.equalTo(alImageView);
        
    }];
    
    UILabel *alLabel = [UILabel new];
    alLabel.font = [UIFont systemFontOfSize:15];
    alLabel.textColor = [UIColor colorFromHexRGB:@"222222"];
    alLabel.text = @"支付宝支付";
    [payView addSubview:alLabel];
    [alLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(alImageView.mas_trailing).offset(15);
        make.centerY.equalTo(alImageView);
    }];

    
    //分割线
    UILabel *middlethreesepLineView = [UILabel new];
    middlethreesepLineView.backgroundColor = [UIColor colorFromHexRGB:@"dbdbdb"];
    [payView addSubview:middlethreesepLineView];
    [middlethreesepLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(payView).offset(50);
        make.top.equalTo(payView).offset(61);
        make.height.equalTo(@1);
    }];
    
    
    //微信支付UI
    UIImageView *wxImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"微信"]];
    [payView addSubview:wxImageView];
    [wxImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(payView).offset(10);
        make.bottom.equalTo(payView).offset(-10);
        make.width.height.equalTo(@38);
        
    }];
    
    UIImageView *wxDetailImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"修改"]];
    [payView addSubview:wxDetailImageView];
    [wxDetailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(payView).offset(-10);
        make.centerY.equalTo(wxImageView);
        
    }];
    
    UILabel *wxLabel = [UILabel new];
    wxLabel.font = [UIFont systemFontOfSize:15];
    wxLabel.textColor = [UIColor colorFromHexRGB:@"222222"];
    wxLabel.text = @"微信支付";
    [payView addSubview:wxLabel];
    [wxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(wxImageView.mas_trailing).offset(15);
        make.centerY.equalTo(wxImageView);
    }];
    

    
    UIButton *alButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [payView addSubview:alButton];
    [alButton addTarget:self action:@selector(alButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [alButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(payView);
        make.bottom.equalTo(middlethreesepLineView.mas_top);
       
    }];
    
    
    UIButton *wxButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [payView addSubview:wxButton];
    [wxButton addTarget:self action:@selector(wxButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [wxButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.leading.trailing.equalTo(payView);
        make.top.equalTo(middlethreesepLineView.mas_bottom);
    }];
    
  
}




- (void)alButtonAction{
    
    NSLog(@"alButtonAction");
    
    
    [self vs_showLoading];
    
    NSDictionary *dic = @{@"userLoginId":
                              [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.username?:@"",//用户id
                          @"orderId":self.orderId?:@""//	订单号
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
    
    NSDictionary *dic = @{@"userLoginId":
                              [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.username?:@"",//用户id
                          @"orderId":self.orderId?:@""//	订单号
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

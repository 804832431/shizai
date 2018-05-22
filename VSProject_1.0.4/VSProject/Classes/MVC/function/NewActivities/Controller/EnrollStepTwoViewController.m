//
//  EnrollStepTwoViewController.m
//  VSProject
//
//  Created by apple on 10/17/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "EnrollStepTwoViewController.h"
#import "BCNetWorkTool.h"
#import <AlipaySDK/AlipaySDK.h>
#import "AlixPayResult.h"
#import "WXApiObject.h"
#import "WXApi.h"
#import "CompleteEnrollInfoViewController.h"

@interface EnrollStepTwoViewController ()

_PROPERTY_NONATOMIC_STRONG(NSString, payMethod)

@end

@implementation EnrollStepTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self vs_setTitleText:@"立即支付"];
    
    [self.totalChargeLabel setText:[NSString stringWithFormat:@"合计：￥%@",self.a_model.charge]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccess:) name:kALPaySucNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccess:) name:kWXPaySucNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payFail:) name:kALPayFailNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payFail:) name:kWXPayFailNotification object:nil];
}

- (void)paySuccess:(NSNotification *)notification{
    //支付成功，跳到完善信息页
    CompleteEnrollInfoViewController *vc = [[CompleteEnrollInfoViewController alloc] initWithNibName:@"CompleteEnrollInfoViewController" bundle:nil];
    vc.a_model = self.a_model;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)payFail:(NSNotification *)notification{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)ZFBAction:(id)sender {
    [self.ZFBImageView setImage:__IMAGENAMED__(@"icon_choice_h")];
    [self.WXImageView setImage:__IMAGENAMED__(@"icon_choice_n")];
    self.payMethod = @"ZFB";
    
    [self.payRightNowButton setTitleColor:ColorWithHex(0xffffff, 1.0) forState:UIControlStateNormal];
    [self.payRightNowButton setBackgroundColor:ColorWithHex(0xffb94a, 1.0)];
    [self.payRightNowButton setEnabled:YES];
}
- (IBAction)WXAction:(id)sender {
    [self.ZFBImageView setImage:__IMAGENAMED__(@"icon_choice_n")];
    [self.WXImageView setImage:__IMAGENAMED__(@"icon_choice_h")];
    self.payMethod = @"WX";
    
    [self.payRightNowButton setTitleColor:ColorWithHex(0xffffff, 1.0) forState:UIControlStateNormal];
    [self.payRightNowButton setBackgroundColor:ColorWithHex(0xffb94a, 1.0)];
    [self.payRightNowButton setEnabled:YES];
}
- (IBAction)payRightNow:(id)sender {
    if ([self.payMethod isEqualToString:@"ZFB"]) {
        //支付宝支付
        NSLog(@"alButtonAction");
        
        
        [self vs_showLoading];
        
        NSDictionary *dic = @{@"userLoginId":[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.username,//用户id
                              @"orderId":self.a_model.orderId//	订单号
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
    } else if ([self.payMethod isEqualToString:@"WX"]) {
        //微信支付
        NSLog(@"wxButtonAction");
        
        [self vs_showLoading];
        
        NSDictionary *dic = @{@"userLoginId":[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.username,//用户id
                              @"orderId":self.a_model.orderId//	订单号
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

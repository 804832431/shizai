//
//  BidWebViewController.m
//  VSProject
//
//  Created by 陈 海涛 on 16/9/22.
//  Copyright © 2016年 user. All rights reserved.
//

#import "BidWebViewController.h"
#import "ProductShareView.h"
#import "RTXShareContextView.h"
#import "VSBaseViewController.h"
#import "JSWebView.h"
#import "VSConst.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "PXAlertView.h"
#import "TelPhoneCallAlertView.h"
#import "BCNetWorkTool.h"
#import "BidderManager.h"
#import "MJExtension.h"
#import "AuthedEnterprise.h"
#import "AuthEnterpriseViewController.h"
#import "AuthStatusUnReslovedViewController.h"
#import "BidDepositInfoViewController.h"

@interface BidWebViewController ()

@property (nonatomic,strong) NSDictionary *shareData;

@property (nonatomic,strong) UIButton *collectButton;

@end

@implementation BidWebViewController

@synthesize vm_shareContextView = _vm_shareContextView;

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UIButton *)collectButton {
    if (!_collectButton) {
        _collectButton = [[UIButton alloc] initWithFrame:CGRectMake(__SCREEN_WIDTH__ - 65, 7, 30, 30)];
        [_collectButton setImage:__IMAGENAMED__(@"nav_btn_Collection_n") forState:UIControlStateNormal];
        [_collectButton addTarget:self action:@selector(collectionAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectButton;
}

- (BidWebOperationView *)operationView{
    if (_operationView == nil) {
        _operationView = [[[NSBundle mainBundle] loadNibNamed:@"BidWebOperationView" owner:nil options:nil] firstObject];
    }
    return _operationView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(webViewDidStartLoad:) name:NoticeName_WebViewDidBeginLoadMsg object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(webViewDidLoad:) name:NoticeName_WebViewDidLoadMsg object:nil];
    
    [self.navigationController.navigationBar addSubview:self.collectButton];
    
    [self vs_showRightButton:NO];
    
//    [self prepareNavigationBar];
    
    __weak typeof(self) weakSelf = self;
    
    [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view).offset(-50);
    }];
    
    [self.view addSubview:self.operationView];
    [self.operationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(weakSelf.view);
        make.height.equalTo(@50);
    }];
    
    self.operationView.telPhontNumLabel.text = @"400 8320 087";
    
    self.operationView.data = self.dto;
    
    
    
    [self.operationView setBidButtonActionBlock:^(id data,NSString *title) {
        
        
        if ([title isEqualToString:@"立即投标"]||[title isEqualToString:@"申请中"]) {
            
            [weakSelf checkEnterpriseStatus];
            
        }
        
        
        
        
        
    }];
    
    [self.operationView setTelPhoneCallBlock:^(NSString *telPhone) {
        [TelPhoneCallAlertView showWithTelPHoneNum:telPhone];
    }];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccess:) name:kALPaySucNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccess:) name:kWXPaySucNotification object:nil];
}

- (void)checkEnterpriseStatus {
    [self vs_showLoading];
    
    NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    
    NSDictionary *dic = @{
                          @"partyId" : partyId
                          };
    
    [BCNetWorkTool executeGETNetworkWithParameter:dic  andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.enterprise/get-authed-enterprise/version/1.2.0" withSuccess:^(id callBackData) {
        
        [self vs_hideLoadingWithCompleteBlock:nil];
        
        [BidderManager shareInstance].authedEnterPrise = [AuthedEnterprise mj_objectWithKeyValues:callBackData];
        
        
        NSString *status = [BidderManager shareInstance].authedEnterPrise.authStatus;
        
        if ([status isEqualToString:@"UNAPPLY"]) {
            AuthEnterpriseViewController *vc = [AuthEnterpriseViewController new];
            [vc setDataSource:[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.bidder];
            [self.navigationController pushViewController:vc animated:YES];
        }else if([status isEqualToString:@"UNRESOLVED"]){
            
            [self.view showTipsView:@"您的企业信息还在认证中，请耐心等待"];
            
        }else if([status isEqualToString:@"PASS"]){
            
            //去投标
            [self sendBid];
            
        }else if([status isEqualToString:@"REJECT"]){
            AuthStatusUnReslovedViewController *vc = [[AuthStatusUnReslovedViewController alloc] initWithNibName:@"AuthStatusUnReslovedViewController" bundle:nil];
            
            [self.navigationController pushViewController:vc animated:YES ];
        }
    } orFail:^(id callBackData) {
        [self vs_hideLoadingWithCompleteBlock:nil];
    }];
}

- (void)paySuccess:(NSNotification *)notification{
    
    
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor colorWithRed:0/255.0 green:174/255.0 blue:147/255.0 alpha:1];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"投标成功！";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:titleLabel];
    titleLabel.frame = CGRectMake(0, 0, 200, 40);
    
    UILabel *descLabel = [UILabel new];
    descLabel.font = [UIFont systemFontOfSize:10];
    descLabel.textColor = [UIColor whiteColor];
    descLabel.text = @"招标保证金在招标结束后";
    descLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:descLabel];
    descLabel.frame = CGRectMake(0, 40, 200, 11);
    
    UILabel *descLabel2 = [UILabel new];
    descLabel2.font = [UIFont systemFontOfSize:10];
    descLabel2.textColor = [UIColor whiteColor];
    
  
    descLabel2.text = @"可通过个人中心申请退还";
    descLabel2.textAlignment = NSTextAlignmentCenter;
    [view addSubview:descLabel2];
    descLabel2.frame = CGRectMake(0, 51, 200, 11);
    
    
    
    view.frame = CGRectMake(0, 0, 200, 85);
    
    __weak typeof(self) weakSelf = self;
    
    MBProgressHUD *hud = [self.view showTipsCustomView:view  afterDelay:3 completeBlock:^{
        
        weakSelf.dto.bidderProjectStatus = @"NOT_OPEN";
        
        [weakSelf.operationView setData:self.dto];
        
    }];
    
    hud.color = [UIColor colorWithRed:0/255.0 green:174/255.0 blue:147/255.0 alpha:1];



}

//申请投标
- (void)sendBid {
    
    
    //    party-id	用户id
    //    bidderId	投标企业id
    //    bidProjectId	项目id
    NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    
    NSDictionary *dic = @{
                          @"partyId":partyId,
                          @"bidderId":[BidderManager shareInstance].authedEnterPrise.bidder.id?:@"",
                          @"bidProjectId":self.dto.bidProjectId
                          };
    [self vs_showLoading];
    [BCNetWorkTool executeGETNetworkWithParameter:dic  andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.enterprise/bid-project/version/1.2.0" withSuccess:^(id callBackData) {
        [self vs_hideLoadingWithCompleteBlock:nil];
        
        NSDictionary *dic = (NSDictionary *)callBackData;
        
        NSString *needPay = [dic objectForKey:@"needPay"];

        if (dic && [needPay isEqualToString:@"Y"]) {
            
            BidDepositInfoViewController *infoVC = [[BidDepositInfoViewController alloc] init];
            
            BidProject *bidPro = [BidProject mj_objectWithKeyValues:dic[@"bidProject"]];
            
            infoVC.bidPro = bidPro;
            
            [self.navigationController pushViewController:infoVC animated:YES];
            
        }else{
            
            UIView *view = [UIView new];
            
            view.backgroundColor = [UIColor colorWithRed:0/255.0 green:174/255.0 blue:147/255.0 alpha:1];
            
            UILabel *titleLabel = [UILabel new];
            titleLabel.font = [UIFont systemFontOfSize:15];
            titleLabel.textColor = [UIColor whiteColor];
            titleLabel.text = @"投标成功！";
            titleLabel.textAlignment = NSTextAlignmentCenter;
            [view addSubview:titleLabel];
            titleLabel.frame = CGRectMake(0, 0, 200, 40);
            
            UILabel *descLabel = [UILabel new];
            descLabel.font = [UIFont systemFontOfSize:10];
            descLabel.textColor = [UIColor whiteColor];
            descLabel.text = @"你已投标成功，该项目将在";
            descLabel.textAlignment = NSTextAlignmentCenter;
            [view addSubview:descLabel];
            descLabel.frame = CGRectMake(0, 40, 200, 11);
            
            UILabel *descLabel2 = [UILabel new];
            descLabel2.font = [UIFont systemFontOfSize:10];
            descLabel2.textColor = [UIColor whiteColor];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSDate *endDate = [formatter dateFromString:self.dto.bidEndTime];
            formatter.dateFormat = @"yyyy年MM月dd日";
            NSString *str = [formatter stringFromDate:endDate];
            descLabel2.text = [NSString stringWithFormat:@"%@公开公布结果",str];
            descLabel2.textAlignment = NSTextAlignmentCenter;
            [view addSubview:descLabel2];
            descLabel2.frame = CGRectMake(0, 51, 200, 11);
            
            
            
            view.frame = CGRectMake(0, 0, 200, 85);
            
            __weak typeof(self) weakSelf = self;
            
            MBProgressHUD *hud = [self.view showTipsCustomView:view  afterDelay:3 completeBlock:^{
                
                weakSelf.dto.bidderProjectStatus = @"NOT_OPEN";
                
                [weakSelf.operationView setData:self.dto];
                
            }];
            
            hud.color = [UIColor colorWithRed:0/255.0 green:174/255.0 blue:147/255.0 alpha:1];
        }
        
        
    } orFail:^(id callBackData) {
        [self vs_hideLoadingWithCompleteBlock:nil];
        [self.view showTipsView:[callBackData domain]];
    }];
    
}


- (void)getAuthedEnterprise{
    
    [self vs_showLoading];
    
    NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    
    NSDictionary *dic = @{
                          @"partyId" : partyId
                          };
    
    [BCNetWorkTool executeGETNetworkWithParameter:dic  andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.enterprise/get-authed-enterprise/version/1.2.0" withSuccess:^(id callBackData) {
        
        [self vs_hideLoadingWithCompleteBlock:nil];
        
        [BidderManager shareInstance].authedEnterPrise = [AuthedEnterprise mj_objectWithKeyValues:callBackData];
        
        
        if ([[BidderManager shareInstance].authedEnterPrise.authStatus isEqualToString:@"PASS"]) {
            [self sendBid];
        }else{
            
            if ([[BidderManager shareInstance].authedEnterPrise.authStatus isEqualToString:@"UNAPPLY"]||
                [[BidderManager shareInstance].authedEnterPrise.authStatus isEqualToString:@"REJECT"]) {
                
                AuthEnterpriseViewController *vc = [AuthEnterpriseViewController new];
                [self.navigationController pushViewController:vc animated:YES];
                
            }else if ([[BidderManager shareInstance].authedEnterPrise.authStatus isEqualToString:@"UNRESOLVED"]){
                
                AuthStatusUnReslovedViewController *vc = [[AuthStatusUnReslovedViewController alloc] initWithNibName:@"AuthStatusUnReslovedViewController" bundle:nil];
                
                [self.navigationController pushViewController:vc animated:YES ];
                
            }
            
            
        }
        
        
    } orFail:^(id callBackData) {
        [self vs_hideLoadingWithCompleteBlock:nil];
    }];
    
}


- (void)setIsHomeList:(BOOL)isHomeList{
    _isHomeList = isHomeList;
    self.operationView.isHomeList = isHomeList;
}

- (void)setIsCollectionList:(BOOL)isCollectionList{
    _isCollectionList = isCollectionList;
    self.operationView.isCollectionList
    = isCollectionList;
}

- (void)setIsMyBidList:(BOOL)isMyBidList{
    _isMyBidList = isMyBidList;
    self.operationView.isMyBidList = isMyBidList;
}


- (void)webViewDidStartLoad:(NSNotification *)notification{
}

- (void)webViewDidLoad:(NSNotification *)notification{
}

-(void)recoverRightButton {
    
    
    
}

- (void)toShare:(id)data{
    
    self.shareData = data;
}


- (void)prepareNavigationBar{
    
    UIView *view = [UIView new];
    
    view.frame = CGRectMake(0, 0, 90, 44);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self prepareNavigationBar];
    [self.collectButton setHidden:NO];
    [self vs_showRightButton:YES];
    [self.vm_rightButton setImage:[UIImage imageNamed:@"btn_nav_share_n"] forState:UIControlStateNormal];
    [self.vm_rightButton setImage:[UIImage imageNamed:@"btn_nav_share_h"] forState:UIControlStateHighlighted];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationItem.rightBarButtonItem = nil;
    
    [self.collectButton setHidden:YES];
    [self.collectButton removeFromSuperview];
    [self vs_showRightButton:NO];
}


- (void)shareButton:(id)sender
{
    
    NSString *url = self.webView.request.URL.absoluteString;
    
    
    VSShareDataSource *dataSource = _ALLOC_OBJ_(VSShareDataSource);
    
    dataSource.contentType      = SHARECONTENT_TYPE_PAGE;
    
    
    [self.webView stringByEvaluatingJavaScriptFromString:@"getShareInfo();"];
    
    
    
    
    dataSource.shareImage       = [UIImage imageNamed:@"myAPPicon"];
    dataSource.shareImageUrl    = self.shareData[@"productPic"];
    dataSource.shareContent     = self.shareData[@"description"];
    dataSource.shareTitle       = self.shareData[@"productTitle"];
    dataSource.shareInviteUrl   = [NSString stringWithFormat:@"%@&isShare=1",url];
    
    
    [self.vm_shareContextView shareArray:[ProductShareView rtxShare] shareDataSource:dataSource];
    [self.vm_viewPop newqb_show:self.vm_shareContextView toUIViewController:self];
    
    
}

- (void)setDto:(BidProject *)dto{
    _dto = dto;
    if ([dto.isCollected isEqualToString:@"Y"]) {
        [self.collectButton setImage:[UIImage imageNamed:@"nav_btn_Collection_h"] forState:UIControlStateNormal];
    }else{
        [self.collectButton setImage:[UIImage imageNamed:@"nav_btn_Collection_n"] forState:UIControlStateNormal];
    }
}

- (void)collectionAction{
    
    NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    
    NSString *bidProjectId = self.dto.bidProjectId;
    NSString *action = @"";
    if ([self.dto.isCollected isEqualToString:@"Y"]) {
        action = @"0";
    }else{
        action = @"1";
    }
    
    NSDictionary *dic = @{
                          @"partyId":partyId,
                          @"bidProjectId":bidProjectId,
                          @"action":action
                          };
    
    [BCNetWorkTool executeGETNetworkWithParameter:dic  andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.enterprise/collect-project/version/1.2.0" withSuccess:^(id callBackData) {
        
        if ([self.dto.isCollected isEqualToString:@"Y"]) {
            self.dto.isCollected = @"N";
        }else{
            self.dto.isCollected = @"Y";
        }
        
        if ([self.dto.isCollected isEqualToString:@"Y"]) {
            [self.collectButton setImage:[UIImage imageNamed:@"nav_btn_Collection_h"] forState:UIControlStateNormal];
        }else{
            [self.collectButton setImage:[UIImage imageNamed:@"nav_btn_Collection_n"] forState:UIControlStateNormal];
        }
        NSString *tittle = [action isEqualToString:@"1"] ? @"收藏成功！":@"取消收藏成功！";
        [self.view showTipsView:tittle];
        
    } orFail:^(id callBackData) {
        [self.view showTipsView:callBackData];
    }];
}

- (RTXShareContextView *)vm_shareContextView{
    
    NSString *url = self.webView.request.URL.absoluteString;
    
    
    if (_vm_shareContextView == nil ) {
        SHARETYPE array                         = [ProductShareView rtxShare];
        _vm_shareContextView                   = [[ProductShareView alloc] initWithHeight:[RTXShareContextView heightWithShareType:array]];
        _vm_shareContextView.delegate          = self;
        _vm_shareContextView.viewController    = self;
        _vm_shareContextView.backgroundColor = ColorWithHex(0xe7e7e7, 1);
    }
    
    
    return _vm_shareContextView;
    
}

@end

//
//  NewNearWebViewController.m
//  VSProject
//
//  Created by 陈 海涛 on 16/8/30.
//  Copyright © 2016年 user. All rights reserved.
//

#import "NewShareWebViewController.h"
#import "ProductShareView.h"
#import "RTXShareContextView.h"
#import "VSBaseViewController.h"
#import "JSWebView.h"
#import "VSConst.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface NewShareWebViewController ()

@property (nonatomic,strong) NSDictionary *shareData;

@end

@implementation NewShareWebViewController

@synthesize vm_shareContextView = _vm_shareContextView;

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = 0;
    
    if ([[self.webUrl absoluteString] hasSuffix:@"newsEnterpriseClub"]) {
        //企业家俱乐部不展示
        self.shouldShowOneKeyConsign = NO;
        self.shouldShouContactCustomService  = NO;
    } else {
        self.shouldShowOneKeyConsign = YES;
        self.shouldShouContactCustomService  = YES;
    }
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(webViewDidStartLoad:) name:NoticeName_WebViewDidBeginLoadMsg object:nil];
    
    [self vs_showRightButton:NO];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self vs_showRightButton:NO];
    [self recoverRightButton];
}

- (void)webViewDidStartLoad:(NSNotification *)notification{
    [self vs_showRightButton:NO];
}

-(void)recoverRightButton {
    
    
    
    NSString *url = self.webView.request.URL.absoluteString;
    
    if ([url rangeOfString:@"canShare=1"].location!=NSNotFound) {
        self.navigationItem.rightBarButtonItem =nil;
        
        [self vs_showRightButton:YES];
        
        
        [self.vm_rightButton setImage:[UIImage imageNamed:@"btn_nav_share_n"] forState:0];
    }else{
        // [super recoverRightButton];
    }
    
    
    
}

- (void)toShare:(id)data{
    
    self.shareData = data;
}

- (void)vs_rightButtonAction:(id)sender
{
    
    
    
    NSString *url = self.webView.request.URL.absoluteString;
    
    if ([url rangeOfString:@"canShare=1"].location!=NSNotFound) {
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
    }else{
        [super vs_rightButtonAction:sender];
    }
    
    
    
}

- (RTXShareContextView *)vm_shareContextView{
    
    NSString *url = self.webView.request.URL.absoluteString;
    
    if ([url rangeOfString:@"canShare=1"].location!=NSNotFound) {
        if (_vm_shareContextView == nil ) {
            SHARETYPE array                         = [ProductShareView rtxShare];
            _vm_shareContextView                   = [[ProductShareView alloc] initWithHeight:[RTXShareContextView heightWithShareType:array]];
            _vm_shareContextView.delegate          = self;
            _vm_shareContextView.viewController    = self;
            _vm_shareContextView.backgroundColor = ColorWithHex(0xe7e7e7, 1);
        }
        return _vm_shareContextView;
    }else{
        return  [super vm_shareContextView];
    }
    
    
}


@end

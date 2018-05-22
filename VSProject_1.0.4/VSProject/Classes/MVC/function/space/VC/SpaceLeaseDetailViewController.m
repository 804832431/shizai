//
//  SpaceLeaseDetailViewController.m
//  VSProject
//
//  Created by pangchao on 2017/10/30.
//  Copyright © 2017年 user. All rights reserved.
//

#import "SpaceLeaseDetailViewController.h"
#import "SpaceProjectModel.h"
#import "BCNetWorkTool.h"
#import "CooperateViewController.h"
#import "JSWebView.h"

@interface SpaceLeaseDetailViewController ()
{
    dispatch_group_t requestGroup;
}

@property (nonatomic, strong) UIButton *collectButton;

@property (nonatomic, strong) UIButton *cooperateButton;

@end

@interface SpaceLeaseDetailViewController ()

@end

@implementation SpaceLeaseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    requestGroup = dispatch_group_create();
    
    [self vs_showRightButton:YES];
    [self.navigationController.navigationBar addSubview:self.collectButton];
//    [self.navigationController.navigationBar addSubview:self.cooperateButton];
    
    if ([self.model.isCollected isEqualToString:@"Y"]) {
        self.collectButton.selected = YES;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cooperateGoBack) name:@"COOPERATE_GOBACK" object:nil];
}

- (void)cooperateGoBack {
    
//    [self.collectButton setHidden:YES];
//    [self vs_showRightButton:NO];
//    [self.cooperateButton setHidden:NO];
//    NSString *theTitle = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
//    [self vs_setTitleText:theTitle];
//    [self.labelTitle sizeToFit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.collectButton setHidden:YES];
    [self.cooperateButton setHidden:YES];
}

- (void)WebViewDidFinishLoad {
    
    // 是否收藏
    NSString *paraUrl = self.webView.request.URL.absoluteString;
    NSMutableDictionary *paraDic = [self getURLParameters:paraUrl];
    NSString *isCollected = [paraDic strValue:@"isCollected"];
    if ([isCollected isEqualToString:@"1"]) {
        self.collectButton.selected = YES;
    }
    else {
        self.collectButton.selected = NO;
    }
    
    NSString *canShare = [paraDic strValue:@"canShare"];
    if ([canShare isEqualToString:@"1"]) {
        [self vs_showRightButton:YES];
    }
    else {
        [self vs_showRightButton:NO];
    }
    
    NSString *theTitle = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self vs_setTitleText:theTitle];
    [self.labelTitle sizeToFit];
}

- (void)vs_leftButtonActon
{
    BOOL canGoBack = [self webViewCanGoBack];
    if (canGoBack)
    {
        for (int i =0; i <= 10; i++)
        {
            [self goBack];
        }
        
        // 是否展示分享
        NSString *paraUrl = self.webView.request.URL.absoluteString;
        NSMutableDictionary *paraDic = [self getURLParameters:paraUrl];
        NSString *canShare = [paraDic strValue:@"canShare"];
        if ([canShare isEqualToString:@"1"]) {
            [self vs_showRightButton:YES];
        }
        else {
            [self vs_showRightButton:NO];
        }
        
        // 是否展示收藏
//        NSString *isCollected = [paraDic strValue:@"isCollected"];
//        if ([isCollected isEqualToString:@""]) {
//            [self.collectButton setHidden:YES];
//        }
//        else if ([isCollected isEqualToString:@"0"] || [isCollected isEqualToString:@"1"]) {
//            [self.collectButton setHidden:NO];
//        }
    }else
    {
        [self.collectButton setHidden:NO];
        [self vs_showRightButton:YES];
        [self.cooperateButton setHidden:YES];
        [self vs_setTitleText:@"项目空间出租"];
        
        [self vs_back];
    }
    
    NSString *theTitle = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self vs_setTitleText:theTitle];
    [self.labelTitle sizeToFit];
}

- (UIButton *)collectButton {
    if (!_collectButton) {
        _collectButton = [[UIButton alloc] initWithFrame:CGRectMake(__SCREEN_WIDTH__ - 65, 7, 30, 30)];
        [_collectButton setImage:__IMAGENAMED__(@"nav_btn_Collection_n") forState:UIControlStateNormal];
        [_collectButton setImage:__IMAGENAMED__(@"nav_btn_Collection_h") forState:UIControlStateSelected];
        [_collectButton addTarget:self action:@selector(collectionAction:) forControlEvents:UIControlEventTouchUpInside];
        _collectButton.hidden = YES;
        _collectButton.selected = NO;
    }
    return _collectButton;
}

- (void)recoverRightButton {
    
    NSString *url = self.webView.request.URL.absoluteString;
    if ([url rangeOfString:@"canShare=1"].location!=NSNotFound) {
        self.navigationItem.rightBarButtonItem =nil;
        
        [self vs_showRightButton:YES];
        [self.vm_rightButton setFrame:_CGR(self.collectButton.frame.origin.x + self.collectButton.frame.size.width, 7, 30, 30)];
        [self.vm_rightButton setImage:[UIImage imageNamed:@"btn_nav_share_n"] forState:0];
    }
}

- (UIButton *)cooperateButton {
    
    if (!_cooperateButton) {
        _cooperateButton = [[UIButton alloc] initWithFrame:CGRectMake(__SCREEN_WIDTH__ - 80, 10, 70, 30)];
        _cooperateButton.titleLabel.textAlignment = NSTextAlignmentRight;
        [_cooperateButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_cooperateButton setTitleColor:kColor_222222 forState:UIControlStateNormal];
        [_cooperateButton setTitle:@"我要合作" forState:UIControlStateNormal];
        _cooperateButton.hidden = YES;
        [_cooperateButton addTarget:self action:@selector(cooperateAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cooperateButton;
}

- (void)cooperateAction:(UIButton *)button {

    [self userlogin:LOGIN_BACK_DEFAULT popVc:self animated:YES LoginSucceed:^{
        CooperateViewController *controller = [[CooperateViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    } cancel:^{

    }];
}

- (void)collectionAction:(UIButton *)button {
    
    button.selected = !button.selected;
    
    NSString *action = @"";
    if ([self.model.isCollected isEqualToString:@"Y"]) {
        action = @"0";
    }
    else {
        action = @"1";
    }
    
    dispatch_group_enter(requestGroup);
    
    NSString *paraUrl = self.webView.request.URL.absoluteString;
    // 截取参数
    NSMutableDictionary *paraDic = [self getURLParameters:paraUrl];
    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    NSString *objectId = [paraDic strValue:@"spaceId"];
    NSDictionary *dic = @{
                          @"partyId" : partyId,
                          @"objectType" : @"space",
                          @"objectId" : objectId,
                          @"action" : action,
                          };
    
    __weak typeof(self)weakself = self;
    [self vs_showLoading];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *url = [NSString stringWithFormat:@"/RUI-CustomerJSONWebService-portlet.collect/collect-object/version/%@", [infoDictionary objectForKey:@"CFBundleShortVersionString"]];
    [BCNetWorkTool executeGETNetworkWithParameter:dic andUrlIdentifier:url withSuccess:^(id callBackData) {
        NSLog(@"%@",callBackData );
        
        
        if ([action isEqualToString:@"0"]) {
            [self.view showTipsView:@"取消收藏成功"];
            self.model.isCollected = @"N";
        }
        else {
            [self.view showTipsView:@"收藏成功"];
            self.model.isCollected = @"Y";
        }
        [weakself vs_hideLoadingWithCompleteBlock:nil];
        dispatch_group_leave(requestGroup);
        
    } orFail:^(id callBackData) {
        
        [self.view showTipsView:[callBackData domain]];
        dispatch_group_leave(requestGroup);
    }];
}

/**
 *  截取URL中的参数
 *
 *  @return NSMutableDictionary parameters
 */
- (NSMutableDictionary *)getURLParameters:(NSString *)urlStr {
    
    // 查找参数
    NSRange range = [urlStr rangeOfString:@"?"];
    if (range.location == NSNotFound) {
        return nil;
    }
    
    // 以字典形式将参数返回
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    // 截取参数
    NSString *parametersString = [urlStr substringFromIndex:range.location + 1];
    
    // 判断参数是单个参数还是多个参数
    if ([parametersString containsString:@"&"]) {
        
        // 多个参数，分割参数
        NSArray *urlComponents = [parametersString componentsSeparatedByString:@"&"];
        
        for (NSString *keyValuePair in urlComponents) {
            // 生成Key/Value
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
            NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
            
            // Key不能为nil
            if (key == nil || value == nil) {
                continue;
            }
            
            id existValue = [params valueForKey:key];
            
            if (existValue != nil) {
                
                // 已存在的值，生成数组
                if ([existValue isKindOfClass:[NSArray class]]) {
                    // 已存在的值生成数组
                    NSMutableArray *items = [NSMutableArray arrayWithArray:existValue];
                    [items addObject:value];
                    
                    [params setValue:items forKey:key];
                } else {
                    
                    // 非数组
                    [params setValue:@[existValue, value] forKey:key];
                }
                
            } else {
                
                // 设置值
                [params setValue:value forKey:key];
            }
        }
    } else {
        // 单个参数
        
        // 生成Key/Value
        NSArray *pairComponents = [parametersString componentsSeparatedByString:@"="];
        
        // 只有一个参数，没有值
        if (pairComponents.count == 1) {
            return nil;
        }
        
        // 分隔值
        NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
        NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
        
        // Key不能为nil
        if (key == nil || value == nil) {
            return nil;
        }
        
        // 设置值
        [params setValue:value forKey:key];
    }
    
    return params;
}

@end

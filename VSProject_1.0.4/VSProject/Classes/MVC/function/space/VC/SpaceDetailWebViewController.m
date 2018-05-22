//
//  SpaceDetailWebViewController.m
//  VSProject
//
//  Created by pangchao on 17/1/9.
//  Copyright © 2017年 user. All rights reserved.
//

#import "SpaceDetailWebViewController.h"
#import "SpaceListModel.h"
#import "BCNetWorkTool.h"

@interface SpaceDetailWebViewController ()
{
    dispatch_group_t requestGroup;
}

@property (nonatomic, strong) UIButton *collectButton;

@end

@implementation SpaceDetailWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    requestGroup = dispatch_group_create();
    
    [self.navigationController.navigationBar addSubview:self.collectButton];
    
    if ([self.model.isCollected isEqualToString:@"Y"]) {
        self.collectButton.selected = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.collectButton setHidden:YES];
    [self.collectButton removeFromSuperview];
}

- (void)webViewFinishLoad {
    BOOL canGoBack = [self webViewCanGoBack];
    if (canGoBack) {
        [self.collectButton setHidden:YES];
        [self vs_showRightButton:NO];
        [self vs_setTitleText:@"已报名的人"];
    } else {
        [self.collectButton setHidden:NO];
        [self vs_showRightButton:YES];
        [self vs_setTitleText:@"活动详情"];
    }
}

- (UIButton *)collectButton {
    if (!_collectButton) {
        _collectButton = [[UIButton alloc] initWithFrame:CGRectMake(__SCREEN_WIDTH__ - 65, 7, 30, 30)];
        [_collectButton setImage:__IMAGENAMED__(@"nav_btn_Collection_n") forState:UIControlStateNormal];
        [_collectButton setImage:__IMAGENAMED__(@"nav_btn_Collection_h") forState:UIControlStateSelected];
        [_collectButton addTarget:self action:@selector(collectionAction:) forControlEvents:UIControlEventTouchUpInside];
        _collectButton.selected = NO;
    }
    return _collectButton;
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
    
    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    NSString *objectId = self.model.spaceId;
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

@end

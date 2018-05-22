//
//  OneKeyConsignManager.m
//  VSProject
//
//  Created by apple on 9/3/17.
//  Copyright © 2017 user. All rights reserved.
//

#import "OneKeyConsignManager.h"
#import "OneConsignView.h"
#import "BCNetWorkTool.h"
#import "OneConsignSuccessView.h"
#import "CustomServiceView.h"

#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define Get375Height(h)  (h) * kScreenWidth / 375

@interface OneKeyConsignManager ()
{
    dispatch_group_t requestGroup;
    NSTimer *timer;
}

@property (nonatomic, strong) UIButton *clearView;
@property (nonatomic, strong) OneConsignView *oneConsignView;
@property (nonatomic, strong) OneConsignSuccessView *oneConsignSuccessView;
@property (nonatomic, strong) CustomServiceView *customServiceView;

@property (nonatomic, copy) NSDictionary *labelDic;

@end

@implementation OneKeyConsignManager

+ (OneKeyConsignManager *)sharedOneKeyConsignManager {
    static OneKeyConsignManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[OneKeyConsignManager alloc] init];
    });
    return _manager;
}

- (instancetype)init {
    self = [super init];
    requestGroup = dispatch_group_create();
    return self;
}

- (UIButton *)clearView {
    if (!_clearView) {
        _clearView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_WIDTH__, __SCREEN_HEIGHT__)];
        [_clearView setBackgroundColor:_RGB_A(0, 0, 0, 0.5)];
        [_clearView addTarget:self action:@selector(removeView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clearView;
}

- (OneConsignSuccessView *)oneConsignSuccessView {
    if (!_oneConsignSuccessView) {
        _oneConsignSuccessView = [[OneConsignSuccessView alloc] init];
        [_oneConsignSuccessView.layer setCornerRadius:10.0f];
        [_oneConsignSuccessView setFrame:CGRectMake(0, 0, Get375Height(260), Get375Height(195))];
        [_oneConsignSuccessView setCenter:CGPointMake(__SCREEN_WIDTH__/2.0f, __SCREEN_HEIGHT__/2.0f)];
    }
    return _oneConsignSuccessView;
}

- (OneConsignView *)oneConsignView {
    if (!_oneConsignView) {
        _oneConsignView = [[OneConsignView alloc] init];
        [_oneConsignView.layer setCornerRadius:10.0f];
        [_oneConsignView setFrame:CGRectMake(0, 0, __SCREEN_WIDTH__ - 50, 130.0f)];
        [_oneConsignView setCenter:CGPointMake(__SCREEN_WIDTH__/2.0f, __SCREEN_HEIGHT__/2.0f)];
        
        [_oneConsignView.cancelButton addTarget:self action:@selector(removeView) forControlEvents:UIControlEventTouchUpInside];
        
        [_oneConsignView.confirmButton addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
        
        [_oneConsignView setClickBlock:^(NSDictionary *dic){
            NSLog(@"%@",dic);
            _labelDic = [NSDictionary dictionaryWithDictionary:dic];
        }];
    }
    return _oneConsignView;
}

- (CustomServiceView *)customServiceView {
    if (!_customServiceView) {
        _customServiceView = [[CustomServiceView alloc] init];
        [_customServiceView.layer setCornerRadius:10.0f];
        [_customServiceView setFrame:CGRectMake(0, 0, Get375Height(320), Get375Height(240))];
        [_customServiceView setCenter:CGPointMake(__SCREEN_WIDTH__/2.0f, __SCREEN_HEIGHT__/2.0f)];
        [_customServiceView.cancelButton addTarget:self action:@selector(removeView) forControlEvents:UIControlEventTouchUpInside];
        [_customServiceView.contactButton addTarget:self action:@selector(contact) forControlEvents:UIControlEventTouchUpInside];
    }
    return _customServiceView;
}

- (void)removeView {
    [self.oneConsignView removeFromSuperview];
    [self.oneConsignSuccessView removeFromSuperview];
    [self.customServiceView removeFromSuperview];
    [timer invalidate];
    [timer fire];
    timer = nil;
    
    [self.clearView removeFromSuperview];
}

- (void)confirmAction {
    if (!_labelDic) {
        return;
    }
    
    dispatch_group_enter(requestGroup);
    
    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    NSDictionary *dic = @{
                          @"partyId" : partyId,
                          @"appId" : [self.labelDic valueForKey:@"appId"],
                          };
    NSString *jsonString = [VSPageRoute dictionaryToJson:dic];
    dic = @{@"content":jsonString};
    
    [BCNetWorkTool executePostNetworkWithParameter:dic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.home/proxy-apply/version/1.7.0" withSuccess:^(id callBackData) {
        NSLog(@"%@",callBackData );
        
        if (![callBackData valueForKey:@"errorMessage"] || [[callBackData valueForKey:@"errorMessage"] isEqualToString:@""]) {
            [self showSuccessView];
        }
        
        dispatch_group_leave(requestGroup);
        
    } orFail:^(id callBackData) {
        
        dispatch_group_leave(requestGroup);
    }];
}

- (void)showSuccessView {
    [self.oneConsignView removeFromSuperview];
    
    _GET_APP_DELEGATE_(appDelegate);
    [appDelegate.window addSubview:self.oneConsignSuccessView];
    
    [self performSelector:@selector(removeView) withObject:nil afterDelay:5];
    
//    timer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(removeView) userInfo:nil repeats:NO];
}

- (void)showConsignView {
    self.labelDic = nil;
    
    _GET_APP_DELEGATE_(appDelegate);
    
    dispatch_group_enter(requestGroup);
    
    [BCNetWorkTool executeGETNetworkWithParameter:nil andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.home/get-proxy-type/version/1.7.0" withSuccess:^(id callBackData) {
        NSLog(@"%@",callBackData );

        NSArray *proxyTypeList = [callBackData valueForKey:@"proxyTypeList"];
        
        [self.oneConsignView setDataSource:proxyTypeList];
        
        [appDelegate.window addSubview:self.clearView];
        
        [self.clearView addSubview:self.oneConsignView];
        
        dispatch_group_leave(requestGroup);
        
    } orFail:^(id callBackData) {
       
        dispatch_group_leave(requestGroup);
    }];
}

- (void)showCustomServiceView {
    _GET_APP_DELEGATE_(appDelegate);
    [appDelegate.window addSubview:self.clearView];
    [self.clearView addSubview:self.customServiceView];
}

- (void)contact {
    [self removeView];
    
    NSString *allString = [NSString stringWithFormat:@"tel:4008320087"];
    
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:allString]];
}

@end

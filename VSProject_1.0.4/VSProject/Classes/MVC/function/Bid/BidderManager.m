//
//  BidderManager.m
//  VSProject
//
//  Created by 陈 海涛 on 16/9/25.
//  Copyright © 2016年 user. All rights reserved.
//

#import "BidderManager.h"
#import "BCNetWorkTool.h"
#import "AuthedEnterprise.h"
#import "MJExtension.h"

static BidderManager *instance;


@implementation BidderManager

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotification_name_loginSuccess object:nil];
}

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init ];
    });
    
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:kNotification_name_loginSuccess object:nil];
    }
    return self;
}


- (void)loginSuccess{
    [self getAuthedEnterprise];
}

- (void)getAuthedEnterprise{
    
    
    
    NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    
    NSDictionary *dic = @{
                          @"partyId" : partyId
                          };
    
    [BCNetWorkTool executeGETNetworkWithParameter:dic  andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.enterprise/get-authed-enterprise/version/1.2.0" withSuccess:^(id callBackData) {
        
        self.authedEnterPrise = [AuthedEnterprise mj_objectWithKeyValues:callBackData];
        
        
    } orFail:^(id callBackData) {
        
    }];
    
}

@end

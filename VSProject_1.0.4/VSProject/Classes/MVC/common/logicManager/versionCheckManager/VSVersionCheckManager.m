//
//  VSVersionCheckManager.m
//  VSProject
//
//  Created by tiezhang on 15/1/13.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSVersionCheckManager.h"

@interface VSCheckVersionParm : VSBaseParmModel

_PROPERTY_NONATOMIC_STRONG(NSString, app);

@end

@implementation VSCheckVersionParm

@end

@interface VSCheckVersionResponseData : VSBaseDataModel

_PROPERTY_NONATOMIC_ASSIGN(NSInteger, version);
_PROPERTY_NONATOMIC_STRONG(NSString, date);
_PROPERTY_NONATOMIC_STRONG(NSString, importance);
_PROPERTY_NONATOMIC_STRONG(NSString, size);
_PROPERTY_NONATOMIC_STRONG(NSString, apk);
_PROPERTY_NONATOMIC_STRONG(NSString, note);
_PROPERTY_NONATOMIC_STRONG(NSString, versionCodeName);
_PROPERTY_NONATOMIC_ASSIGN(BOOL,    forceUpdate);

@end

@implementation VSCheckVersionResponseData


@end

@interface VSVersionCheckManager ()


@end

@implementation VSVersionCheckManager
DECLARE_SINGLETON(VSVersionCheckManager)
- (CGFloat)currentAppVersion
{
    return [__APP_VERSION__ floatValue];
}

- (void)vs_checkVersion
{
    
}

- (void)vs_checkVersionCallBack:(VSMessageHandleCallBack)callBack
{
    
}

@end

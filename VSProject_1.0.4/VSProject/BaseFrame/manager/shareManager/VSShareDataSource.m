//
//  VSShareDataSource.m
//  Qianbao
//
//  Created by zhangtie on 14-1-9.
//  Copyright (c) 2014年 qianwang365. All rights reserved.
//

#import "VSShareDataSource.h"

#define QB_SHARE_DEFAULT_INVITEURL  @"http://"//默认

#define QB_SHRE_DEFAULT_TITLE       @"时在"

@implementation VSShareDataSource

- (void)dealloc
{
    RELEASE_SUPER_DEALLOC;
}

- (id)initShareData:(NSString*)shareContent imageUrl:(NSString*)imageUrl inviteUrl:(NSString*)url title:(NSString*)title
{
    self = [super init];
    if(self)
    {
        self.shareTitle     = title;
        self.shareContent   = shareContent;
        self.shareImageUrl  = imageUrl;
        self.shareInviteUrl = url;
    }
    return self;
}

+ (id)createShareData:(NSString*)shareContent imageUrl:(NSString*)imageUrl
{
    return [self createShareData:shareContent imageUrl:imageUrl inviteUrl:QB_SHARE_DEFAULT_INVITEURL];
}

+ (id)createShareData:(NSString*)shareContent imageUrl:(NSString*)imageUrl inviteUrl:(NSString*)url
{
    return [self createShareData:shareContent imageUrl:imageUrl inviteUrl:url shareTitle:QB_SHRE_DEFAULT_TITLE];
}

+ (id)createShareData:(NSString*)shareContent imageUrl:(NSString*)imageUrl inviteUrl:(NSString*)url shareTitle:(NSString*)title
{
    return [[[self class] alloc]initShareData:shareContent imageUrl:imageUrl inviteUrl:url title:title];
}

@end

@implementation VSShareRecvsDataSource

- (void)dealloc
{
}

@end

@implementation VSShareMailDataSource

- (void)dealloc
{
}

@end

@implementation VSShareWeiXinDataSource



@end

@implementation VSShareQQDataSource


@end

@implementation VSShareQQWeiBoDataSource

- (void)dealloc
{
}

@end

@implementation VSShareSinaDataSource


@end




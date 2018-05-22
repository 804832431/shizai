//
//  NewShareManager.h
//  Qianbao
//
//
//*********************************************调用示例:*********************************************
//    VSShareQQWeiBoDataSource *data = [[VSShareQQWeiBoDataSource alloc]init];
//    data.shareContent   = @"aaaaa";
//    data.shareTitle     = @"钱宝网";
//    data.shareImageUrl  = @"http://www.qianbao666.com/img/taskImage1.html?id=100636";
//    data.shareInviteUrl = @"http://www.baidu.com";
//    data.contentType    = SHARECONTENT_TYPE_PAGE;
//
//    NewShareManager *nmanager = [NewShareManager sharedManager];
//    [nmanager shareType:SHARETYPE_QQWEIBO shareData:data completeBlock:^(NewShareManager *manager, VS_ShareContentState resultCode) {
//        NSLog(@"%d", resultCode);
//        _SIMPLE_ALERT_S_C_(@"提示", @"分享成功", nil);
//    }];
//    return;
//*********************************************调用示例:*********************************************
//
//
//  Created by zhangtie on 14-1-26.
//  Copyright (c) 2014年 qianwang365. All rights reserved.
//

#define  SHARE_TENCENT 1
#define  SHARE_WX      1
#define  SHARE_TCWB    0
#define  SHARE_SINAWB  1

#import <Foundation/Foundation.h>

#if SHARE_TENCENT
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentOAuthObject.h>
#import "TencentOpenAPI/QQApiInterface.h"
#endif


#import <MessageUI/MessageUI.h>

#if SHARE_WX
#import "WXApiObject.h"
#import "WXApi.h"
#endif

#if SHARE_TCWB
#import "TCWBEngine.h"
#endif

#if SHARE_SINAWB
#import "WeiboSDK.h"
#endif


#import "VSShareDataSource.h"

typedef enum _SHARETYPE
{
    SHARETYPE_WEIXIN            = 1,   
    SHARETYPE_QQ                = 1<<1,
    SHARETYPE_SINA              = 1<<2,
    SHARETYPE_SMS               = 1<<3,
    SHARETYPE_EMAIL             = 1<<4,
    SHARETYPE_WEIXINLCIRCLE     = 1<<5,
    SHARETYPE_CONTACT           = 1<<6,
    SHARETYPE_QIANBAOCIRCLE     = 1<<7,
    SHARETYPE_MORE              = 1<<8,
    SHARETYPE_COPYMEMORY              = 1<<9
}SHARETYPE;


/**
 *	@brief	发布内容状态
 */
typedef enum _VS_ShareContentState
{
    VS_ShareContentStateBegan           = 0,                /**< 开始 */
    VS_ShareContentStateSuccess         = 1,                /**< 成功 */
    VS_ShareContentStateFail            = 2,                /**< 失败 */
    VS_ShareContentStateUnInstalled     = 3,                /**< 未安装 */
    VS_ShareContentStateCancel          = 4,                /**< 取消 */
    VS_ShareContentStateNotSupport      = 5,                /**< 设备不支持 */
    VS_ShareContentStateNoAccount       = 6,                /**< 未找到账号 */
    VS_ShareContentStateAuthFailed      = 7,                /**< 授权失败 */
    VS_ShareContentStateImageDownFailed = 8,                /**< 图片下载失败 */
    
    VS_ShareContentStateUnknown,                            /**< 未知错误 */
}VS_ShareContentState;

#define SOCIAL_PLATFORM_QQ          @"qq"
#define SOCIAL_PLATFORM_SINA        @"weibo"

#define KEY_SINA_USERID    @"sinaUserID"
#define KEY_SINA_TOKEN      @"sinaToken"

#define KEY_TENCENT_TOKEN   @"tencentToken"
#define KEY_TENCENT_OPENID  @"tencnetOpenId"


@class VSShareManager;
typedef void (^VSShareBlock)(VSShareManager *manager, VS_ShareContentState resultCode);
typedef void (^SocialSSOBlock)(BOOL success);

@interface VSShareManager : VSBaseManager

//根据分享结果状态得到提示文本
+ (NSString *)vs_shareContentState:(VS_ShareContentState)state;

- (BOOL)vs_handleOpenURL:(NSURL*)url;

//分享api
- (void)vs_shareType:(SHARETYPE)shareType shareData:(VSShareDataSource*)shareData completeBlock:(VSShareBlock)acompleteBlock;

#pragma mark -- auth
- (void)vs_queryTencentToken:(SocialSSOBlock)socialBolck;
- (void)vs_tencentLogout:(SocialSSOBlock)socialBolck;
- (void)vs_removeTencentAuthData;
- (NSDictionary*)vs_getTencentAuthData;

- (void)vs_querySinaToken:(SocialSSOBlock)socialBolck;
//- (void)sinaLogout:(SocialSSOBlock)socialBolck;
- (void)vs_removeSinaAuthData;
- (NSDictionary*)vs_getSinaAuthData;
@end




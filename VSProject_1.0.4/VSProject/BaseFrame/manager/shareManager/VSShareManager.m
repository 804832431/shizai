//
//  VSShareManager.m
//  Qianbao
//
//  Created by zhangtie on 14-1-26.
//  Copyright (c) 2014年 qianwang365. All rights reserved.
//

#import "VSShareManager.h"
#import "WeiboSDK.h"
#import <TencentOpenAPI/TencentOAuth.h>

#define KEY_SINA_TOKENDATA  @"sina_token"
#define KEY_SINA_EXPDATE    @"expadate"

#define KEY_TENCENT_TOKENDATA @"tencent_token"

#define ksinaAppKey         @"133234590"
#define kRedirectURI        @"http://"

#ifndef kWeiChatAppId
#define kWeiChatAppId       @"wx0777e0a53b64d7c3"//时在微信AppId
#endif

#ifndef kQQConnectAppKey
//#define kQQConnectAppKey    @"1105077561"//@"100537236"
#define kQQConnectAppKey    @"1104968517"
#endif

#ifndef KQQHandAppKey
#define KQQHandAppKey    @"tencent"
#endif

static VSShareManager   *shareManager;

@interface VSShareManager ()<WeiboSDKDelegate, WXApiDelegate, TencentSessionDelegate, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate, QQApiInterfaceDelegate>
{
    BOOL   _qqweiboLogined;
    
    
    VSShareBlock        _shareSinaCompleteBlock;
    
    VSShareBlock        _shareQQCompleteBlock;
    
    VSShareBlock        _shareWXCompleteBlock;
    
    VSShareBlock        _shareSMSCompleteBlock;
    
    VSShareBlock        _shareMailCompleteBlock;
    
    SocialSSOBlock      _socialBlock;
}

_PROPERTY_NONATOMIC_STRONG(NSString,    sinaToken);
_PROPERTY_NONATOMIC_STRONG(VSShareDataSource,    tmpData);  //临时数据
_PROPERTY_NONATOMIC_STRONG(TencentOAuth, tencentOAuth);

@property(nonatomic, readonly)BOOL qqweiboLogined;
@property(nonatomic, readonly)BOOL sinaweiboLogined;

@end

@implementation VSShareManager

DECLARE_SINGLETON(VSShareManager)

- (void)dealloc
{
    
    RELEASE_SAFELY(_tmpData);
    RELEASE_SAFELY(_sinaToken);
    RELEASE_SAFELY(_shareSinaCompleteBlock);
    RELEASE_SAFELY(_shareQQCompleteBlock);
    RELEASE_SAFELY(_shareWXCompleteBlock);
    RELEASE_SAFELY(_shareSMSCompleteBlock);
    RELEASE_SAFELY(_shareMailCompleteBlock);
    RELEASE_SAFELY(_tencentOAuth);
}

+ (NSString *)vs_shareContentState:(VS_ShareContentState)state
{
    //    VS_ShareContentStateBegan           = 0,                /**< 开始 */
    //	VS_ShareContentStateSuccess         = 1,                /**< 成功 */
    //	VS_ShareContentStateFail            = 2,                /**< 失败 */
    //    VS_ShareContentStateUnInstalled     = 3,                /**< 未安装 */
    //	VS_ShareContentStateCancel          = 4,                /**< 取消 */
    //    VS_ShareContentStateNotSupport      = 5,                /**< 设备不支持 */
    //    VS_ShareContentStateNoAccount       = 6,                /**< 未找到账号 */
    //    VS_ShareContentStateAuthFailed      = 7,                /**< 授权失败 */
    //    VS_ShareContentStateImageDownFailed = 8,                /**< 图片下载失败 */
    //
    //    VS_ShareContentStateUnknown,                            /**< 未知错误 */
    NSString *str = nil;
    switch (state) {
        case VS_ShareContentStateBegan:
            str = @"开始";
            break;
        case VS_ShareContentStateSuccess:
            str = @"成功";
            break;
        case VS_ShareContentStateFail:
            str = @"失败";
            break;
        case VS_ShareContentStateUnInstalled:
            str = @"未安装";
            break;
        case VS_ShareContentStateCancel:
            str = @"取消";
            break;
        case VS_ShareContentStateNotSupport:
            str = @"设备不支持";
            break;
        case VS_ShareContentStateNoAccount:
            str = @"未找到账号";
            break;
        case VS_ShareContentStateAuthFailed:
            str = @"授权失败";
            break;
        case VS_ShareContentStateImageDownFailed:
            str = @"图片下载失败";
            break;
        case VS_ShareContentStateUnknown:
            str = @"未知错误";
            break;
        default:
            break;
    }
    return str;
}

-(BOOL) vs_handleOpenURL:(NSURL *) url
{
    DBLog(@"handleOpenURL: %@",url.absoluteString);
    NSRange r = [url.absoluteString rangeOfString:kWeiChatAppId];
    if (r.location != NSNotFound) {
        return [WXApi handleOpenURL:url delegate:self];
    }
    
    NSRange rsina = [url.absoluteString rangeOfString:ksinaAppKey];
    if(rsina.location != NSNotFound)
    {
        return [WeiboSDK handleOpenURL:url delegate:self];
    }
    
    NSRange rqq = [url.absoluteString rangeOfString:KQQHandAppKey];
    if(rqq.location != NSNotFound)
    {
        if ([QQApiInterface handleOpenURL:url delegate:self]) {
            return [QQApiInterface handleOpenURL:url delegate:self];
        }
        else
            return [TencentOAuth HandleOpenURL:url];
        return NO;
    }
    
    return NO;
}

- (id)init
{
    self = [super init];
    if(self)
    {
        [self connectWeChatWithAppId:kWeiChatAppId];
        [self connectQQWithQConnectAppKey:kQQConnectAppKey];
        [self connectSinaWeibo:ksinaAppKey];
    }
    return self;
}

- (void)connectWeChatWithAppId:(NSString *)appId
{
    //    [WXApi registerApp:appId];
    
}

- (void)connectQQWithQConnectAppKey:(NSString *)qconnectAppKey
{
    _tencentOAuth = [[TencentOAuth alloc] initWithAppId:qconnectAppKey andDelegate:self];
}

- (void)connectSinaWeibo:(NSString*)appkey
{
    [WeiboSDK registerApp:appkey];//ksinaAppKey
}


//下载url的image
- (UIImage*)downShareImage:(NSString*)imageUrl finishedBlock:(SDWebImageCompletionWithFinishedBlock)complete;
{
    SDWebImageManager *webManager = [SDWebImageManager sharedManager];
    NSString *absoluteString = [webManager cacheKeyForURL:[NSURL URLWithString:imageUrl]];
    UIImage *imagePic = [webManager.imageCache imageFromDiskCacheForKey:absoluteString];
    if(nil == imagePic)
    {
        [webManager downloadImageWithURL:[NSURL URLWithString:imageUrl] options:SDWebImageRefreshCached progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if(complete)
            {
                complete(image, error, cacheType, finished, imageURL);
            }
        }];
    }
    
    return imagePic;
}

- (void)toNoteInstall
{
    //    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"您的手机未安装QQ" message:@"是否安装?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"同意", nil];
    //    alert.tag=1;
    //    [alert show];
    //    [alert release];
}

/**
 获取弹出模态视图的控制器
 @param  检索路径的根
 @return 弹出模态视图的控制器
 */
- (UIViewController *)presentedVC:(UIViewController *)vc
{
    if (nil == [vc presentedViewController])
    {
        return vc;
    }
    
    return [self presentedVC:[vc presentedViewController]];
}

- (void)vs_shareType:(SHARETYPE)shareType shareData:(VSShareDataSource*)shareData completeBlock:(VSShareBlock)acompleteBlock
{
    switch (shareType)
    {
        case SHARETYPE_EMAIL:
        {
            [self shareToMailShareData:shareData completeBlock:acompleteBlock];
        }
            break;
        case SHARETYPE_SMS:
        {
            [self shareToSMSShareData:shareData completeBlock:acompleteBlock];
        }
            break;
        case SHARETYPE_QQ:
        {
            [self shareToQQShareData:shareData completeBlock:acompleteBlock];
        }
            break;
        case SHARETYPE_WEIXIN:
        {
            [self shareToWXShareData:shareData completeBlock:acompleteBlock];
        }
            break;
        case SHARETYPE_WEIXINLCIRCLE:
        {
            [self shareToWXCIRCLEShareData:shareData completeBlock:acompleteBlock];
        }
            break;
        case SHARETYPE_SINA:
        {
            [self shareToSinaShareData:shareData completeBlock:acompleteBlock];
        }
            break;
        case SHARETYPE_COPYMEMORY:
        {
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string = shareData.shareInviteUrl;
            
            acompleteBlock(self, VS_ShareContentStateSuccess);
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"分享链接已经复制到剪切板！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark -- Sina
- (void)shareToSinaShareData:(VSShareDataSource*)shareData completeBlock:(VSShareBlock)acompleteBlock
{
    if (![WeiboSDK isWeiboAppInstalled])
    {
        acompleteBlock(self, VS_ShareContentStateUnInstalled);
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"您的手机未安装新浪微博！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        //        [self toNoteInstall];
        return;
    }
    
    if(_shareSinaCompleteBlock)
    {
        RELEASE_SAFELY(_shareSinaCompleteBlock);
    }
    _shareSinaCompleteBlock = [acompleteBlock copy];
    
    if(!self.sinaweiboLogined)
    {
        self.tmpData = shareData;
        [self sinaSSOLogin];
        return;
    }
    
    [self sendSinaRequest:(VSShareSinaDataSource*)shareData];
}

- (void)sendSinaRequest:(VSShareSinaDataSource*)shareData
{
    WBMessageObject *message    = [WBMessageObject message];
    message.text                = shareData.shareContent;
    WBImageObject *imgobj       = [WBImageObject object];
    NSDictionary *userInfo      = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                                    @"Other_Info_1": [NSNumber numberWithInt:123],
                                    @"Other_Info_2": @[@"obj1", @"obj2"],
                                    @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    if(shareData.contentType == SHARECONTENT_TYPE_IMAGE ||
       shareData.contentType == SHARECONTENT_TYPE_PAGE)
    {
        
        if (shareData.shareImageUrl.length > 0)
        {
            UIImage *shareImage = [self downShareImage:shareData.shareImageUrl finishedBlock:nil];
            if(nil == shareImage)
            {//本地还未下载过
                [self downShareImage:shareData.shareImageUrl finishedBlock:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                    if(nil != error)
                    {
                        _shareSinaCompleteBlock(self, VS_ShareContentStateImageDownFailed);
                    }
                    else
                    {
                        imgobj.imageData            = UIImagePNGRepresentation(image);
                        message.imageObject         = imgobj;
                        NSDictionary *userInfo      = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                                                        @"Other_Info_1": [NSNumber numberWithInt:123],
                                                        @"Other_Info_2": @[@"obj1", @"obj2"],
                                                        @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
                        [self sendSinaRequestForMessage:message userInfo:userInfo];
                    }
                }];
            }else if(shareData.shareImage)
            {
                imgobj.imageData            = UIImagePNGRepresentation(shareData.shareImage);
                message.imageObject         = imgobj;
                [self sendSinaRequestForMessage:message userInfo:userInfo];
            }
            else
            {//本地已经下载过
                imgobj.imageData            = UIImagePNGRepresentation(shareImage);
                message.imageObject         = imgobj;
                
                [self sendSinaRequestForMessage:message userInfo:userInfo];
            }
        }
        else
        {
            //ToDo
        }
        
    }
    else
    {
        [self sendSinaRequestForMessage:message userInfo:userInfo];
    }
}

- (void)sendSinaRequestForMessage:(WBMessageObject*)message userInfo:(NSDictionary*)userInfo
{
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message];
    request.userInfo = userInfo;
    [WeiboSDK sendRequest:request];
}

- (void)vs_querySinaToken:(SocialSSOBlock)socialBolck
{
    [self sinaSSOLogin];
    
    if (_socialBlock) {
        RELEASE_SAFELY(_socialBlock);
    }
    _socialBlock = [socialBolck copy];
}

- (void)sinaSSOLogin
{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURI;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}

- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error
{
    
    
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        if(response.statusCode == WeiboSDKResponseStatusCodeSuccess)
        {
            if(_shareSinaCompleteBlock)
            {
                _shareSinaCompleteBlock(self, VS_ShareContentStateSuccess);
                RELEASE_SAFELY(_shareSinaCompleteBlock);
            }
        }
        else
        {
            if(_shareSinaCompleteBlock)
            {
                _shareSinaCompleteBlock(self, VS_ShareContentStateFail);
                RELEASE_SAFELY(_shareSinaCompleteBlock);
            }
        }
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        NSString *token = [(WBAuthorizeResponse *)response accessToken];
        if(token.length <= 0)
        {//授权失败
            if(_shareSinaCompleteBlock)
            {
                _shareSinaCompleteBlock(self, VS_ShareContentStateAuthFailed);
                RELEASE_SAFELY(_shareSinaCompleteBlock);
            }
            if (_socialBlock) {
                _socialBlock(NO);
            }
        }
        else
        {//授权成功
            [self sendSinaRequest:(VSShareSinaDataSource*)self.tmpData];
            
            //保存token过期数据
            NSDictionary *expData = [NSDictionary dictionaryWithObjectsAndKeys:[(WBAuthorizeResponse *)response accessToken], KEY_SINA_TOKEN, [(WBAuthorizeResponse *)response userID], KEY_SINA_USERID, nil];
            [self saveSinaAuthData:expData];
            
            self.sinaToken = [(WBAuthorizeResponse *)response accessToken];
            
            if (_socialBlock) {
                _socialBlock(YES);
            }
            
            
        }
        
        
        
    }
}

- (NSDictionary*)vs_getSinaAuthData
{
    return [[VSUserDefaultManager shareInstance] vs_objectForKey:KEY_SINA_TOKENDATA];
}

- (void)saveSinaAuthData:(NSDictionary*)data
{
    [[VSUserDefaultManager shareInstance] vs_setObject:data forKey:KEY_SINA_TOKENDATA];
}

- (void)vs_removeSinaAuthData
{
    [[VSUserDefaultManager shareInstance] vs_removeObjectForKey:KEY_SINA_TOKENDATA];
}

- (BOOL)sinaweiboLogined
{
    NSDictionary *sinaInfo = [self vs_getSinaAuthData];
    NSDate *date = nil;
    if (sinaInfo != nil)
    {
        date = PUGetElemForKeyFromDict(KEY_SINA_EXPDATE, sinaInfo);
        self.sinaToken = PUGetElemForKeyFromDict(KEY_SINA_TOKEN, sinaInfo);
    }
    if (sinaInfo == nil || date == nil
        || [date compare:[NSDate dateWithTimeIntervalSinceNow:10*60]] == NSOrderedAscending) {
        
        return NO;
    }
    
    return ([self.sinaToken length] > 0);
}


#pragma mark -- weixin
- (void)shareToWXCIRCLEShareData:(VSShareDataSource*)shareData completeBlock:(VSShareBlock)acompleteBlock
{
    [self shareToWXShareData:shareData completeBlock:acompleteBlock isCricle:YES];
}

- (void)shareToWXShareData:(VSShareDataSource*)shareData completeBlock:(VSShareBlock)acompleteBlock
{
    [self shareToWXShareData:shareData completeBlock:acompleteBlock isCricle:NO];
}

- (void)shareToWXShareData:(VSShareDataSource*)shareData completeBlock:(VSShareBlock)acompleteBlock isCricle:(BOOL)isCricle
{
    if (![WXApi isWXAppInstalled])
    {
        acompleteBlock(self,VS_ShareContentStateUnInstalled);
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"您的手机未安装微信！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        //        [self toNoteInstall];
        return;
    }
    
    //设置分享模块，参照enum WXScene
    VSShareWeiXinDataSource *wxData = (VSShareWeiXinDataSource*)shareData;
    
    if(_shareWXCompleteBlock)
    {
        RELEASE_SAFELY(_shareWXCompleteBlock);
    }
    
    _shareWXCompleteBlock = [acompleteBlock copy];
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.scene = wxData.sence;
    
    if( isCricle == YES)
    {
        req.scene = WXSceneTimeline;
    }
    
    if(shareData.contentType == SHARECONTENT_TYPE_TEXT)
    {
        req.bText = YES;
        req.text  = shareData.shareContent;
        [WXApi sendReq:req];
    }
    
    else if(shareData.contentType == SHARECONTENT_TYPE_IMAGE)
    {
        req.bText = NO;
        WXMediaMessage *message     = [WXMediaMessage message];
        
        message.title           = ([shareData.shareTitle length] <= 0) ? @"分享" : shareData.shareTitle;
        message.description     = shareData.shareContent;
        
        if(shareData.shareImage)
        {
            [self setWXImage:shareData.shareImage forWXMessage:message];
            if(message)
            {
                req.message = message;
            }
            [WXApi sendReq:req];
            
        }
        else if (shareData.shareImageUrl.length > 0)
        {
            UIImage *shareImage = [self downShareImage:shareData.shareImageUrl finishedBlock:nil];
            if(nil == shareImage)
            {//本地还未下载过
                [self downShareImage:shareData.shareImageUrl finishedBlock:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                    
                    if(nil != error)
                    {
                        _shareWXCompleteBlock(self, VS_ShareContentStateImageDownFailed);
                    }
                    else
                    {
                        [self setWXImage:image forWXMessage:message];
                        if(message)
                        {
                            req.message = message;
                        }
                        [WXApi sendReq:req];
                    }
                }];
            }
            else
            {//本地已经下载过
                [self setWXImage:shareImage forWXMessage:message];
                if(message)
                {
                    req.message = message;
                }
                [WXApi sendReq:req];
            }
        }
        else
        {
            //ToDo
        }
    }
    
    else if(shareData.contentType == SHARECONTENT_TYPE_PAGE)
    {
        
        req.bText = NO;
        WXMediaMessage *message = [WXMediaMessage message];
        message.title        = shareData.shareTitle;
        message.description  = shareData.shareContent;
        WXWebpageObject *ext = [WXWebpageObject object];
        ext.webpageUrl       = shareData.shareInviteUrl;
        message.mediaObject  = ext;
        
        if (shareData.shareImageUrl.length > 0)
        {
            UIImage *shareImage = [self downShareImage:shareData.shareImageUrl finishedBlock:nil];
            if(nil == shareImage)
            {//本地还未下载过
                [self downShareImage:shareData.shareImageUrl finishedBlock:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL){
                    
                    if(nil != error)
                    {
                        _shareWXCompleteBlock(self, VS_ShareContentStateImageDownFailed);
                    }
                    else
                    {
                        [message setThumbImage:[self getWXThumbImage:image]];
                        req.message = message;
                        [WXApi sendReq:req];
                    }
                }];
            }
            else
            {//本地已经下载过
                [message setThumbImage:[self getWXThumbImage:shareImage]];
                req.message = message;
                [WXApi sendReq:req];
            }
        }else if(shareData.shareImage)
        {
            [message setThumbImage:[self getWXThumbImage:shareData.shareImage]];
            req.message = message;
            [WXApi sendReq:req];
            
        }
        else
        {
            //ToDo
            req.message = message;
            [WXApi sendReq:req];
        }
    }
    
}

- (void)setWXImage:(UIImage*)image forWXMessage:(WXMediaMessage*)message
{
    //设置缩略图
    [message setThumbImage:[self getWXThumbImage:image]];
    //设置大图
    WXImageObject *ext      = [WXImageObject object];
    ext.imageData           = UIImageJPEGRepresentation(image, 0.6);
    message.mediaObject     = ext;
}

//- (void)setWXImage:(UIImage*)image linkUrl:(NSString*)url forWXMessage:(WXMediaMessage*)message
//{
//    message.title = [title length]<=0?@"钱宝":title;
//    message.description = description;
//    [message setThumbImage:[self getWXThumbImage:image]];
//
//    WXWebpageObject *ext = [WXWebpageObject object];
//    ext.webpageUrl = linkUrl;
//
//    message.mediaObject = ext;
//}

/*
 * @param image 缩略图
 * @note 大小不能超过32K
 */
- (UIImage *)getWXThumbImage:(UIImage *)image
{
    CGFloat  size  = (image.size.width*image.size.height)/1024;
    CGFloat  scaleSize = (size<32)?1.0:(32/size);
    
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

#pragma mark -- QQ
- (void)vs_queryTencentToken:(SocialSSOBlock)socialBolck
{
    [self connectQQWithQConnectAppKey:kQQConnectAppKey];
    
    [_tencentOAuth authorize:[NSArray arrayWithObjects:
                              kOPEN_PERMISSION_GET_USER_INFO,
                              kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                              kOPEN_PERMISSION_ADD_ALBUM,
                              kOPEN_PERMISSION_ADD_IDOL,
                              kOPEN_PERMISSION_ADD_ONE_BLOG,
                              kOPEN_PERMISSION_ADD_PIC_T,
                              kOPEN_PERMISSION_ADD_SHARE,
                              kOPEN_PERMISSION_ADD_TOPIC,
                              kOPEN_PERMISSION_CHECK_PAGE_FANS,
                              kOPEN_PERMISSION_DEL_IDOL,
                              kOPEN_PERMISSION_DEL_T,
                              kOPEN_PERMISSION_GET_FANSLIST,
                              kOPEN_PERMISSION_GET_IDOLLIST,
                              kOPEN_PERMISSION_GET_INFO,
                              kOPEN_PERMISSION_GET_OTHER_INFO,
                              kOPEN_PERMISSION_GET_REPOST_LIST,
                              kOPEN_PERMISSION_LIST_ALBUM,
                              kOPEN_PERMISSION_UPLOAD_PIC,
                              kOPEN_PERMISSION_GET_VIP_INFO,
                              kOPEN_PERMISSION_GET_VIP_RICH_INFO,
                              kOPEN_PERMISSION_GET_INTIMATE_FRIENDS_WEIBO,
                              kOPEN_PERMISSION_MATCH_NICK_TIPS_WEIBO,
                              nil]
                    inSafari:NO];
    
    if(_socialBlock)
    {
        RELEASE_SAFELY(_socialBlock);
    }
    _socialBlock = [socialBolck copy];
}

- (void)vs_tencentLogout:(SocialSSOBlock)socialBolck
{
    [_tencentOAuth logout:self];
    if(_socialBlock)
    {
        RELEASE_SAFELY(_socialBlock);
    }
    _socialBlock = [socialBolck copy];
}


- (void)shareToQQShareData:(VSShareDataSource*)shareData completeBlock:(VSShareBlock)acompleteBlock
{
    if (![QQApiInterface isQQInstalled])
    {
        if (acompleteBlock)
        {
            acompleteBlock(self, VS_ShareContentStateUnInstalled);
        }
        //提示安装
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"您的手机未安装QQ！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if(_shareQQCompleteBlock)
    {
        RELEASE_SAFELY(_shareQQCompleteBlock);
    }
    _shareQQCompleteBlock = [acompleteBlock copy];
    
    QQApiObject *apiObj = nil;
    if(shareData.contentType == SHARECONTENT_TYPE_IMAGE)
    {
        if(shareData.shareImageUrl.length > 0)
        {//图片URL
            UIImage *shareImage = [self downShareImage:shareData.shareImageUrl finishedBlock:nil];
            if(nil == shareImage)
            {//本地还未下载过
                [self downShareImage:shareData.shareImageUrl finishedBlock:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                    if(nil != error)
                    {
                        _shareQQCompleteBlock(self, VS_ShareContentStateImageDownFailed);
                    }
                    else
                    {
                        NSData* data = UIImageJPEGRepresentation(image, 0.6);
                        QQApiObject *apiObj = [QQApiImageObject objectWithData:data
                                                              previewImageData:data
                                                                         title:(shareData.shareTitle) ? shareData.shareTitle : shareData.shareContent
                                                                   description:shareData.shareContent];
                        [self sendQQRequest:apiObj];
                    }
                }];
            }
            else
            {//本地已经下载过
                NSData* data = UIImageJPEGRepresentation(shareData.shareImage, 0.6);
                apiObj = [QQApiImageObject objectWithData:data previewImageData:data title:(shareData.shareTitle) ? shareData.shareTitle : shareData.shareContent description:shareData.shareContent];
                [self sendQQRequest:apiObj];
            }
            
        }
        else if (shareData.shareImage)
        {//本地图片
            NSData* data = UIImageJPEGRepresentation(shareData.shareImage, 0.6);
            apiObj = [QQApiImageObject objectWithData:data previewImageData:data title:(shareData.shareTitle) ? shareData.shareTitle : shareData.shareContent description:shareData.shareContent];
            [self sendQQRequest:apiObj];
        }
        else
        {
            _shareQQCompleteBlock(self, VS_ShareContentStateFail);
            RELEASE_SAFELY(_shareQQCompleteBlock);
            return;
        }
    }
    else if(shareData.contentType == SHARECONTENT_TYPE_TEXT)
    {//图片链接和图片都没有则是纯文本信息
        if(shareData.shareContent.length > 0)
        {
            apiObj = [QQApiTextObject objectWithText:shareData.shareContent];
            [self sendQQRequest:apiObj];
        }
        else
        {
            _shareQQCompleteBlock(self, VS_ShareContentStateFail);
            RELEASE_SAFELY(_shareQQCompleteBlock);
            return;
        }
    }
    
    else if (shareData.contentType == SHARECONTENT_TYPE_PAGE)
    {
        NSURL *previewURL = [NSURL URLWithString:shareData.shareImageUrl];
        NSURL * url = [NSURL URLWithString:shareData.shareInviteUrl];
        
        NSData *imageData = [NSData dataWithContentsOfURL:previewURL];
        if (!imageData) {
            imageData = UIImagePNGRepresentation(shareData.shareImage);
        }
        apiObj = [QQApiNewsObject objectWithURL:url
                                          title:(shareData.shareTitle) ? shareData.shareTitle : shareData.shareContent
                                    description:shareData.shareContent
                               previewImageData:imageData];
        [self sendQQRequest:apiObj];
    }
    else
    {
        //ToDo
    }
    
    
}

- (void)sendQQRequest:(QQApiObject*)apiObj
{
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:apiObj];
    
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    [self handleQQSendResult:sent];
}

#pragma mark - QQ TencentSessionDelegate
- (void)tencentDidLogin
{
    // 登录成功
    if (_tencentOAuth.accessToken && 0 != [_tencentOAuth.accessToken length])
    {
        
        NSDictionary *expData = [NSDictionary dictionaryWithObjectsAndKeys:_tencentOAuth.accessToken, KEY_TENCENT_TOKEN, _tencentOAuth.openId, KEY_TENCENT_OPENID, nil];
        [self saveTencentAuthData:expData];
        _socialBlock(YES);
    }
    else
    {
        _socialBlock(NO);
    }
}

- (void)tencentDidNotLogin:(BOOL)cancelled
{
    _socialBlock(NO);
}

- (void)tencentDidNotNetWork
{
    
}

- (void)tencentDidLogout
{
    
}

- (void)handleQQSendResult:(QQApiSendResultCode)sendResult
{
    switch (sendResult)
    {
        case EQQAPISENDSUCESS:
        {
            //            if(_shareQQCompleteBlock)
            //            {
            //                _shareQQCompleteBlock(self, VS_ShareContentStateSuccess);
            //                RELEASE_SAFELY(_shareQQCompleteBlock);
            //            }
        }break;
        case EQQAPIQQNOTINSTALLED:
        {
            if(_shareQQCompleteBlock)
            {
                _shareQQCompleteBlock(self,VS_ShareContentStateUnInstalled);
                RELEASE_SAFELY(_shareQQCompleteBlock);
            }
        }break;
        case EQQAPIAPPNOTREGISTED:
        case EQQAPIMESSAGECONTENTINVALID:
        case EQQAPIMESSAGECONTENTNULL:
        case EQQAPIMESSAGETYPEINVALID:
        case EQQAPIQQNOTSUPPORTAPI:
        case EQQAPISENDFAILD:
        {
            if(_shareQQCompleteBlock)
            {
                _shareQQCompleteBlock(self, VS_ShareContentStateFail);
                RELEASE_SAFELY(_shareQQCompleteBlock);
            }
        }break;
        default:
        {
            break;
        }
    }
    
}

- (NSDictionary*)vs_getTencentAuthData
{
    return [[VSUserDefaultManager shareInstance] vs_objectForKey:KEY_TENCENT_TOKENDATA];
}

- (void)saveTencentAuthData:(NSDictionary*)data
{
    [[VSUserDefaultManager shareInstance] vs_setObject:data forKey:KEY_TENCENT_TOKENDATA];
}

- (void)vs_removeTencentAuthData
{
    [[VSUserDefaultManager shareInstance] vs_removeObjectForKey:KEY_TENCENT_TOKENDATA];
}

#pragma mark - WXApiDelegate And QQ
-(void) onReq:(id)req
{
    
}

- (void)onResp:(id)resp
{
    if([resp isKindOfClass:[SendMessageToQQResp class]])
    {//QQ
        SendMessageToQQResp *res = (SendMessageToQQResp*)resp;
        if(res.errorDescription)
        {
            if(_shareQQCompleteBlock)
            {
                _shareQQCompleteBlock(self, VS_ShareContentStateFail);
                RELEASE_SAFELY(_shareQQCompleteBlock);
            }
        }
        else
        {
            if(_shareQQCompleteBlock)
            {
                _shareQQCompleteBlock(self, VS_ShareContentStateSuccess);
                RELEASE_SAFELY(_shareQQCompleteBlock);
            }
        }
    }
    
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {//WX
        SendMessageToWXResp *res = (SendMessageToWXResp*)resp;
        enum WXErrCode errCode = res.errCode;
        VS_ShareContentState result;
        switch (errCode)
        {
            case WXSuccess:
            {
                result = VS_ShareContentStateSuccess;
            }break;
            case WXErrCodeUserCancel:
            {
                result = VS_ShareContentStateCancel;
            }break;
            case WXErrCodeCommon:
            case WXErrCodeSentFail:
            {
                result = VS_ShareContentStateFail;
            }break;
            case WXErrCodeAuthDeny:
            {
                result = VS_ShareContentStateAuthFailed;
            }break;
            case WXErrCodeUnsupport:
            {
                result = VS_ShareContentStateNotSupport;
            }break;
                
            default:
                break;
        }
        if(_shareWXCompleteBlock)
        {
            _shareWXCompleteBlock(self, result);
            RELEASE_SAFELY(_shareWXCompleteBlock);
        }
    }
}

/**
 处理QQ在线状态的回调
 */
- (void)isOnlineResponse:(NSDictionary *)response
{
    
}

#pragma mark -- mail
- (void)shareToMailShareData:(VSShareDataSource*)shareData completeBlock:(VSShareBlock)acompleteBlock
{
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (!mailClass)
    {
        if(acompleteBlock)
        {
            acompleteBlock(self, VS_ShareContentStateNotSupport);
        }
        return;
    }
    if(![mailClass canSendMail])
    {
        if (acompleteBlock)
        {
            acompleteBlock(self, VS_ShareContentStateNoAccount);
        }
        return;
    }
    
    //正常
    if(_shareMailCompleteBlock)
    {
        RELEASE_SAFELY(_shareMailCompleteBlock);
    }
    
    _shareMailCompleteBlock = [acompleteBlock copy];
    
    UIImage *shareImage = [self downShareImage:shareData.shareImageUrl finishedBlock:nil];
    if(nil == shareImage)
    {//本地还未下载过
        [self downShareImage:shareData.shareImageUrl finishedBlock:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if(nil != error)
            {
                _shareMailCompleteBlock(self, VS_ShareContentStateImageDownFailed);
            }
            else
            {
                VSShareMailDataSource *mailData = (VSShareMailDataSource*)shareData;
                mailData.shareImage = image;
                [self sendEmail:mailData];
            }
        }];
    }
    else
    {//本地已经下载过
        shareData.shareImage = shareImage;
        [self sendEmail:(VSShareMailDataSource*)shareData];
    }
}

- (void)sendEmail:(VSShareMailDataSource*)mailDataSource
{
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
    mailPicker.mailComposeDelegate = self;
    //设置主题
    [mailPicker setSubject:mailDataSource.shareTitle];
    //添加收件人
    [mailPicker setToRecipients:mailDataSource.recvs];
    //添加抄送
    [mailPicker setCcRecipients:mailDataSource.ccrecvs];
    //添加密送
    [mailPicker setBccRecipients:mailDataSource.bccrecvs];
    
    // 添加一张图片
    if (mailDataSource.shareImage)
    {
        NSData *imageData = UIImagePNGRepresentation(mailDataSource.shareImage);            // png
        //关于mimeType：http://www.iana.org/assignments/media-types/index.html
        [mailPicker addAttachmentData: imageData mimeType: @"" fileName: @"1.png"];
    }
    
    NSString *emailBody = [NSString stringWithFormat:@"<font color='red'></font>%@", mailDataSource.shareContent];
    [mailPicker setMessageBody:emailBody isHTML:YES];
    _GET_APP_DELEGATE_(appDelegate);
    [[self presentedVC:appDelegate.window.rootViewController] presentViewController:mailPicker animated:YES completion:^{
        
    }];
}

#pragma mark - MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
    //关闭邮件发送窗口
    [controller dismissViewControllerAnimated:YES completion:^{
        
    }];
    switch (result) {
        case MFMailComposeResultCancelled:
        {
            _shareMailCompleteBlock(self, VS_ShareContentStateCancel);
            RELEASE_SAFELY(_shareMailCompleteBlock);
        }break;
        case MFMailComposeResultSaved:
            break;
        case MFMailComposeResultSent:
        {
            _shareMailCompleteBlock(self, VS_ShareContentStateSuccess);
            RELEASE_SAFELY(_shareMailCompleteBlock);
        }break;
        case MFMailComposeResultFailed:
        {
            _shareMailCompleteBlock(self, VS_ShareContentStateFail);
            RELEASE_SAFELY(_shareMailCompleteBlock);
        }break;
        default:
            break;
    }
}

#pragma mark -- sms
- (void)shareToSMSShareData:(VSShareDataSource*)shareData completeBlock:(VSShareBlock)acompleteBlock
{
    if ([MFMessageComposeViewController canSendText])
    {
        if(_shareSMSCompleteBlock)
        {
            RELEASE_SAFELY(_shareSMSCompleteBlock);
        }
        _shareSMSCompleteBlock = [acompleteBlock  copy];
        
        VSShareRecvsDataSource *smsDataSource = (VSShareRecvsDataSource*)shareData;
        MFMessageComposeViewController* controller = [[MFMessageComposeViewController alloc] init];
        controller.body =  smsDataSource.shareContent;
        if(smsDataSource.recvs)
        {
            controller.recipients = smsDataSource.recvs;
        }
        controller.messageComposeDelegate = self;
        _GET_APP_DELEGATE_(appDelegate)
        [[self presentedVC:appDelegate.window.rootViewController] presentViewController:controller animated:YES completion:^{
            
        }];
    }
    else
    {
        acompleteBlock(self, VS_ShareContentStateNotSupport);
        return;
    }
}
#pragma mark - MFMessageComposeViewControllerDelegate
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    if (result == MessageComposeResultCancelled)
    {
        _shareSMSCompleteBlock(self, VS_ShareContentStateCancel);
        RELEASE_SAFELY(_shareSMSCompleteBlock);
    }
    else if (result == MessageComposeResultSent)
    {
        _shareSMSCompleteBlock(self, VS_ShareContentStateSuccess);
        RELEASE_SAFELY(_shareSMSCompleteBlock);
    }
    else
    {
        //fail
        _shareSMSCompleteBlock(self, VS_ShareContentStateFail);
        RELEASE_SAFELY(_shareSMSCompleteBlock);
    }
    [controller dismissViewControllerAnimated:YES completion:^{
        
    }];
}


@end

//
//  VSShareDataSource.h
//  Qianbao
//
//  Created by zhangtie on 14-1-9.
//  Copyright (c) 2014年 qianwang365. All rights reserved.
//

#import "VSBaseModel.h"

//分享内容数据类型
typedef enum _SHARECONTENT_TYPE
{
    SHARECONTENT_TYPE_TEXT  = 0,
    SHARECONTENT_TYPE_IMAGE,
    SHARECONTENT_TYPE_PAGE,         
}SHARECONTENT_TYPE;


//分享数据包
@interface VSShareDataSource : VSBaseModel

_PROPERTY_NONATOMIC_COPY(NSString,              shareContent);
_PROPERTY_NONATOMIC_COPY(NSString,              shareTitle);
_PROPERTY_NONATOMIC_COPY(NSString,              shareImageUrl);
_PROPERTY_NONATOMIC_COPY(NSString,              shareInviteUrl);
_PROPERTY_NONATOMIC_STRONG(UIImage,             shareImage);
_PROPERTY_NONATOMIC_ASSIGN(SHARECONTENT_TYPE,   contentType); //default is SHARECONTENT_TYPE_TEXT

+ (id)createShareData:(NSString*)shareContent imageUrl:(NSString*)imageUrl;
+ (id)createShareData:(NSString*)shareContent imageUrl:(NSString*)imageUrl inviteUrl:(NSString*)url;

+ (id)createShareData:(NSString*)shareContent imageUrl:(NSString*)imageUrl inviteUrl:(NSString*)url shareTitle:(NSString*)title;

@end

//带有收件人数据源,例如短信
@interface VSShareRecvsDataSource : VSShareDataSource

_PROPERTY_NONATOMIC_STRONG(NSArray, recvs); //接收人

@end

//邮件数据源
@interface VSShareMailDataSource : VSShareRecvsDataSource

_PROPERTY_NONATOMIC_STRONG(NSArray, ccrecvs);   //抄送接收人
_PROPERTY_NONATOMIC_STRONG(NSArray, bccrecvs);  //密送接收人

@end

//微信数据源
@interface VSShareWeiXinDataSource : VSShareDataSource

_PROPERTY_NONATOMIC_ASSIGN(int, sence);     //see enum WXScene

@end

//QQ数据源
@interface VSShareQQDataSource : VSShareDataSource


@end

//腾讯微博数据源
@interface VSShareQQWeiBoDataSource : VSShareDataSource

_PROPERTY_NONATOMIC_STRONG(NSString, lat);  //维度
_PROPERTY_NONATOMIC_STRONG(NSString, lont); //经度

@end

//新浪微博数据源
@interface VSShareSinaDataSource : VSShareDataSource

@end








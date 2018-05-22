//
//  VSShareContextView.m
//  QianbaoIM
//
//  Created by liyan on 9/28/14.
//  Copyright (c) 2014 liu nian. All rights reserved.
//

#import "VSShareContextView.h"
#import "VSShareManager.h"

#define SHARE_ICON_COUNT 4
#define SHARE_TITLE_HEIGTH  14
#define SHARE_TITLE_OFF_Y   5
@class VSShareContextModelView;

@protocol VSShareContextModelViewDelegate<NSObject>

- (void)didClickShareBtn:(VSShareContextModelView *)view;

@end


@interface VSShareContextModelView:UIView

@property (nonatomic, strong)NSString                           *iconName;

@property (nonatomic, strong)NSString                           *iconTitle;

@property (nonatomic, assign)SHARETYPE                           type;

@property( nonatomic, strong)VSShareDataSource                  *dataSource;

@property (nonatomic, strong)UIButton                           *iconBtn;

@property (nonatomic, strong)UILabel                            *titleLabel;

@property (nonatomic, weak)id<VSShareContextModelViewDelegate>   delegate;

@end

@implementation VSShareContextModelView

- (id)init
{
    self = [super init];
    if(self)
    {
        self.iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.iconBtn];
        self.titleLabel = [[UILabel alloc]init];
        [self addSubview:self.titleLabel];
        
        [self.iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.top.equalTo(@0);
            make.right.equalTo(@0);
            make.height.equalTo(self.mas_width);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@-10);
            make.top.equalTo(self.iconBtn.mas_bottom).offset(SHARE_TITLE_OFF_Y);
            make.right.equalTo(@10);
            make.height.equalTo(@(SHARE_TITLE_HEIGTH));
        }];
        
        self.titleLabel.textColor = ColorWithHex(434343, 1.0);
        self.titleLabel.font      = FONT_TITLE(12);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        _CLEAR_BACKGROUND_COLOR_(self.titleLabel);
        self.backgroundColor = _COLOR_CLEAR;
        [self addTarget:self action:@selector(shareAction)];
    }
    return self;
}

- (void)setIconName:(NSString *)iconName
{
    if(_iconName != iconName)
    {
        _iconName = iconName;
    }
    
    NSString *highLightedImageName = [NSString stringWithFormat:@"%@_highlight",iconName];
    [self.iconBtn setBackgroundImage:__IMAGENAMED__(iconName) forState:UIControlStateNormal];
    [self.iconBtn setBackgroundImage:__IMAGENAMED__(highLightedImageName) forState:UIControlStateHighlighted];
}

- (void)setIconTitle:(NSString *)iconTitle
{
    if(_iconTitle != iconTitle)
    {
        _iconTitle = iconTitle;
    }
    
    self.titleLabel.text = iconTitle;
}

- (void)addTarget:(id)target action:(SEL)action
{
    [self.iconBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)shareAction
{
    if([_delegate respondsToSelector:@selector(didClickShareBtn:)])
    {
        [_delegate didClickShareBtn:self];
    }
}

@end


@interface VSShareContextView()<VSShareContextModelViewDelegate>
@property (nonatomic, strong)NSMutableArray *array;


@end

@implementation VSShareContextView

+ (CGFloat )height:(int)count
{
    int  lineCount = count/SHARE_ICON_COUNT;
    
    if((count%SHARE_ICON_COUNT)!= 0)
    {
        lineCount++;
    }
    CGFloat width = [UIApplication sharedApplication].keyWindow.bounds.size.width;
    CGFloat model_width = (width - (25+33+33+33+25))/4;
    
    int offHeigth = 0;
    if(count > SHARE_ICON_COUNT)
    {
        offHeigth = 40;
    }
    else
    {
        offHeigth = 35;
    }
    return ((model_width +SHARE_TITLE_OFF_Y+SHARE_TITLE_HEIGTH) + offHeigth) * lineCount + offHeigth;
    
}


- (void)shareArray:(SHARETYPE)array  shareDataSource:(VSShareDataSource *)shareDataSource;
{
    BOOL useNetModel = NO;

    if(!shareDataSource)
    {
        useNetModel = YES;
        shareDataSource = _ALLOC_OBJ_(VSShareDataSource);
        shareDataSource.contentType      = SHARECONTENT_TYPE_PAGE;
//        shareDataSource.shareImageUrl    = appDelegate.userDataInfo.myInfo.spread_codePic;
        shareDataSource.shareTitle       = @"上钱宝网，享优活人生";
        shareDataSource.shareInviteUrl   = @"http://www.baidu.com";;
    }
    
    if(array & SHARETYPE_WEIXINLCIRCLE)
    {
        if(useNetModel)
        {
            shareDataSource.shareContent     = @"分享内容";
        }
        [self _qb_addModel:@"icon_share_moments" iconTitle:@"朋友圈" type:SHARETYPE_WEIXINLCIRCLE dataSource:shareDataSource];
    }
    if(array & SHARETYPE_WEIXIN)
    {
        if(useNetModel)
        {
            shareDataSource.shareContent     = @"分享内容";
        }
        [self _qb_addModel:@"icon_share_wechat" iconTitle:@"微信" type:SHARETYPE_WEIXIN dataSource:shareDataSource];
    }
    if(array & SHARETYPE_QQ)
    {
        if(useNetModel)
        {
            shareDataSource.shareContent     = @"分享内容";
        }
        [self _qb_addModel:@"icon_share_qq" iconTitle:@"QQ" type:SHARETYPE_QQ dataSource:shareDataSource];
    }
    if(array & SHARETYPE_SINA)
    {
        
        [self _qb_addModel:@"icon_share_groupchat" iconTitle:@"新浪微博" type:SHARETYPE_SINA dataSource:shareDataSource];
        
    }
    if(array & SHARETYPE_EMAIL)
    {
        if(useNetModel)
        {
            shareDataSource.shareContent     = @"分享内容";
        }
        [self _qb_addModel:@"icon_share_sms" iconTitle:@"邮件" type:SHARETYPE_EMAIL dataSource:shareDataSource];
    }
    if(array & SHARETYPE_SMS)
    {
        if(useNetModel)
        {
            shareDataSource.shareContent     = @"分享内容";
        }
        [self _qb_addModel:@"icon_share_sms" iconTitle:@"短信" type:SHARETYPE_SMS dataSource:shareDataSource];
    }
    if(array & SHARETYPE_CONTACT)
    {

        [self _qb_addModel:@"icon_share_groupchat" iconTitle:@"好友" type:SHARETYPE_CONTACT dataSource:shareDataSource];
        
    }
    if(array & SHARETYPE_QIANBAOCIRCLE)
    {
        [self _qb_addModel:@"icon_share_qianbao" iconTitle:@"钱宝动态" type:SHARETYPE_QIANBAOCIRCLE dataSource:shareDataSource];
    }
    if(array & SHARETYPE_MORE)
    {
        [self _qb_addModel:@"icon_share_more" iconTitle:@"更多" type:SHARETYPE_MORE dataSource:shareDataSource];
    }
}


- (void)_qb_addModel:(NSString *)iconName iconTitle:(NSString *)iconTitle type:(SHARETYPE)type dataSource:(VSShareDataSource *)dataSource
{
    if(self.array == nil)
    {
        self.array = @[].mutableCopy;
    }
    
    VSShareContextModelView *model = [[VSShareContextModelView alloc]init];
    
    model.iconName      = iconName;
    model.iconTitle     = iconTitle;
    model.type          = type;
    model.dataSource    = dataSource;

    model.delegate = self;
    [self addSubview:model];
    [self.array addObject:model];
}


- (void)didClickShareBtn:(VSShareContextModelView *)view
{
    
    VSShareDataSource *dataSource =nil;
    switch (view.type) {
        case SHARETYPE_WEIXIN:
        {
            dataSource = _ALLOC_OBJ_(VSShareWeiXinDataSource);

        }
            break;
        case SHARETYPE_QQ:
        {
            dataSource = _ALLOC_OBJ_(VSShareQQDataSource);
            
        }
            break;
        case SHARETYPE_SINA:
        {
            dataSource = _ALLOC_OBJ_(VSShareSinaDataSource);
            
        }
            break;
        case SHARETYPE_EMAIL:
        {
            dataSource = _ALLOC_OBJ_(VSShareMailDataSource);
        }
            break;
        case SHARETYPE_SMS:
        {
            dataSource =_ALLOC_OBJ_(VSShareRecvsDataSource);
        }
            break;

        case SHARETYPE_WEIXINLCIRCLE:
        {
            dataSource = _ALLOC_OBJ_(VSShareWeiXinDataSource);
        }
            break;
//        case SHARETYPE_CONTACT:     //            钱宝好友
//        case SHARETYPE_QIANBAOCIRCLE://            钱宝圈
//        case SHARETYPE_MORE:        //            更多
//        {
//            if([self.delegate respondsToSelector:@selector(didSelectUpdateModel:)])
//            {
//                [self.delegate didSelectUpdateModel:@(view.type)];
//            }
//            
//        }break;

        default:
            break;
    }
    
    dataSource.contentType      = view.dataSource.contentType;
    dataSource.shareImageUrl    = view.dataSource.shareImageUrl;
    dataSource.shareContent     = view.dataSource.shareContent;
    dataSource.shareTitle       = view.dataSource.shareTitle;
    dataSource.shareInviteUrl   = view.dataSource.shareInviteUrl;
    [[VSShareManager shareInstance] vs_shareType:view.type shareData:dataSource completeBlock:^(VSShareManager *manager, VS_ShareContentState resultCode) {
        
    }];
    
}

- (void)show;
{
    if(self.array == nil)
    {
        return;
    }
    
//    return;
    CGFloat width =  self.bounds.size.width;
    
//    CGFloat heigth = self.bounds.size.height;
    
    CGFloat model_width = (width - (25+33+33+33+25))/4;
    CGFloat model_height = model_width +SHARE_TITLE_OFF_Y+SHARE_TITLE_HEIGTH;
    
    VSShareContextModelView *temp = nil;
    int lineCount = 0;
    
    int offHeigth = 0;
    if([self.array count] > SHARE_ICON_COUNT)
    {
        offHeigth = 25;
    }
    else
    {
        offHeigth = 35;
    }
    
    for (int i = 0 ; i <[self.array count]; i++)
    {
        lineCount = i/SHARE_ICON_COUNT;
        int ii =    i%SHARE_ICON_COUNT;
        VSShareContextModelView *model = [self.array objectAtIndex:i];
        if(ii == 0)
        {
            [model mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@((offHeigth + model_height)*lineCount +offHeigth));
                make.left.equalTo(@25);
                make.width.equalTo(@(model_width));
                make.height.equalTo(@(model_height));
            }];
            temp = model;
        }
        else if(ii == 1)
        {
            [model mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@((offHeigth + model_height)*lineCount+offHeigth));
                make.left.equalTo(temp.mas_right).offset(33);
                make.width.equalTo(@(model_width));
                make.height.equalTo(@(model_height));
            }];
            temp = model;
        }
        else if(ii == 2)
        {
            [model mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@((offHeigth + model_height)*lineCount+offHeigth));
                make.left.equalTo(temp.mas_right).offset(33);
                make.width.equalTo(@(model_width));
                make.height.equalTo(@(model_height));
            }];
            temp = model;
        }
        else if(ii == 3)
        {
            [model mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@((offHeigth + model_height)*lineCount+offHeigth));
                make.left.equalTo(temp.mas_right).offset(33);
                make.width.equalTo(@(model_width));
                make.height.equalTo(@(model_height));
            }];
            temp = nil;
        }

    }
}

+ (CGFloat)heightWithShareType:(SHARETYPE)array
{
    int count = 0;
    if(array & SHARETYPE_WEIXINLCIRCLE)
    {
        count++;
    }
    if(array & SHARETYPE_QQ)
    {
        count++;
    }
    if(array & SHARETYPE_WEIXIN)
    {
       count++;
    }
    if(array & SHARETYPE_SINA)
    {
        count++;
    }
    if(array & SHARETYPE_EMAIL)
    {
        count++;
    }
    if(array & SHARETYPE_SMS)
    {
        count++;
    }
    if(array & SHARETYPE_CONTACT)
    {
        count++;
    }
    if(array & SHARETYPE_QIANBAOCIRCLE)
    {
        count++;
    }
    if(array & SHARETYPE_MORE)
    {
        count++;
    }
    return [VSShareContextView height:count];
}

+ (SHARETYPE)outShare
{
    return SHARETYPE_WEIXINLCIRCLE|SHARETYPE_QQ|SHARETYPE_WEIXIN|SHARETYPE_SMS;
}
+ (SHARETYPE)allShare
{
    return SHARETYPE_WEIXINLCIRCLE|SHARETYPE_WEIXIN|SHARETYPE_QQ|SHARETYPE_SINA|SHARETYPE_SMS|SHARETYPE_EMAIL;
}


@end

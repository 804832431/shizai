//
//  ProductShareView.m
//  VSProject
//
//  Created by 陈 海涛 on 16/8/30.
//  Copyright © 2016年 user. All rights reserved.
//

#import "ProductShareView.h"
#import <Masonry.h>
#import "VSBaseViewController.h"

@class ProductShareContextModelView;
@protocol ProductShareContextModelViewDelegate<NSObject>

- (void)didClickShareBtn:(ProductShareContextModelView *)view;

@end

@interface ProductShareContextModelView:UIView

@property (nonatomic, strong)NSString                           *iconName;

@property (nonatomic, strong)NSString                           *iconTitle;

@property (nonatomic, assign)SHARETYPE                           type;

@property( nonatomic, strong)VSShareDataSource                  *dataSource;

@property (nonatomic, strong)UIButton                           *iconBtn;

@property (nonatomic, strong)UILabel                            *titleLabel;

@property (nonatomic, strong)UIButton                           *iconShareBtn;

@property (nonatomic, weak)id<ProductShareContextModelViewDelegate>   delegate;

@end

@implementation ProductShareContextModelView

- (id)init
{
    self = [super init];
    if(self)
    {
        self.iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.iconBtn];
        self.titleLabel = [[UILabel alloc]init];
        [self addSubview:self.titleLabel];
        
        __weak typeof(self) weakSelf = self;
        [self.iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.centerX.equalTo(weakSelf);
            make.height.equalTo(@45);
            make.width.equalTo(@(45));
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.iconBtn.mas_bottom).offset(9);
            //            make.leading.trailing.equalTo(weakSelf.iconBtn);
            make.centerX.equalTo(weakSelf.iconBtn);
        }];
        
        self.titleLabel.textColor = ColorWithHex(0x000000, 1.0);
        self.titleLabel.font      = FONT_TITLE(12);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        _CLEAR_BACKGROUND_COLOR_(self.titleLabel);
        self.backgroundColor = _COLOR_CLEAR;
        //        [self addTarget:self action:@selector(shareAction)];
        
        //分享点击区域
        self.iconShareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.iconShareBtn.backgroundColor = _COLOR_CLEAR;
        //        self.iconShareBtn.alpha = 0.7;
        [self addSubview:self.iconShareBtn];
        [self.iconShareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.bottom.equalTo(@(0));
            make.left.equalTo(@0);
            make.right.equalTo(@(0));
        }];
        [self.iconShareBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
        
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

@interface ProductShareView()<ProductShareContextModelViewDelegate>

@property (nonatomic, strong)NSMutableArray *array;

@property (nonatomic,strong) UIButton *cancelButton;
@end

@implementation ProductShareView

- (UIButton *)cancelButton{
    if (_cancelButton == nil) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.backgroundColor = ColorWithHex(0xfefefe, 1);
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (void)cancelButtonAction{
    
    UIResponder *responder = self.cancelButton.nextResponder;
    while (![responder isKindOfClass:[UINavigationController class]]) {
        responder = responder.nextResponder;
    }
    
    UINavigationController *naVc = (UINavigationController *)responder;
    VSBaseViewController *vc = (VSBaseViewController *)naVc.viewControllers.lastObject;
    [vc.vm_viewPop qb_hide];
}

+ (CGFloat )height:(int)count
{
    
    return  235;
    
}

- (void)shareArray:(SHARETYPE)array  shareDataSource:(VSShareDataSource *)shareDataSource{
    BOOL useNetModel = NO;
    if(!shareDataSource)
    {
        useNetModel = YES;
        shareDataSource = _ALLOC_OBJ_(VSShareDataSource);
        shareDataSource.contentType      = SHARECONTENT_TYPE_PAGE;
        //        shareDataSource.shareImageUrl    = appDelegate.userDataInfo.myInfo.spread_codePic;
        shareDataSource.shareTitle       = @"";
        shareDataSource.shareInviteUrl   = @"";;
    }
    
    [self.array removeAllObjects];
    
    
    if(array & SHARETYPE_WEIXINLCIRCLE)
    {
        if(useNetModel)
        {
            shareDataSource.shareContent     = @"分享内容";
        }
        [self _qb_addModel:@"朋友圈" iconTitle:@"朋友圈" type:SHARETYPE_WEIXINLCIRCLE dataSource:shareDataSource];
    }
    
    if(array & SHARETYPE_WEIXIN)
    {
        if(useNetModel)
        {
            shareDataSource.shareContent     = @"分享内容";
        }
        [self _qb_addModel:@"微信好友" iconTitle:@"微信好友" type:SHARETYPE_WEIXIN dataSource:shareDataSource];
    }
    
    if(array & SHARETYPE_QQ)
    {
        if(useNetModel)
        {
            shareDataSource.shareContent     = @"分享内容";
        }
        [self _qb_addModel:@"qq" iconTitle:@"QQ" type:SHARETYPE_QQ dataSource:shareDataSource];
    }
    
    
    
    if(array & SHARETYPE_SINA)
    {
        
        [self _qb_addModel:@"share_sina_blog" iconTitle:@"新浪微博" type:SHARETYPE_SINA dataSource:shareDataSource];
        
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
    
    if(array & SHARETYPE_COPYMEMORY)
    {
        [self _qb_addModel:@"urllink" iconTitle:@"复制链接" type:SHARETYPE_COPYMEMORY dataSource:shareDataSource];
    }
}

- (void)_qb_addModel:(NSString *)iconName iconTitle:(NSString *)iconTitle type:(SHARETYPE)type dataSource:(VSShareDataSource *)dataSource
{
    if(self.array == nil)
    {
        self.array = @[].mutableCopy;
    }
    
    ProductShareContextModelView *model = [[ProductShareContextModelView alloc]init];
    
    model.iconName      = iconName;
    model.iconTitle     = iconTitle;
    model.type          = type;
    model.dataSource    = dataSource;
    
    model.delegate = self;
    [self addSubview:model];
    [self.array addObject:model];
}

- (void)didClickShareBtn:(ProductShareContextModelView *)view
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
        case SHARETYPE_COPYMEMORY:
        {
            dataSource = _ALLOC_OBJ_(VSShareDataSource);
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
    dataSource.shareImage       = view.dataSource.shareImage;
    dataSource.contentType      = view.dataSource.contentType;
    dataSource.shareImageUrl    = view.dataSource.shareImageUrl;
    dataSource.shareContent     = view.dataSource.shareContent;
    dataSource.shareTitle       = view.dataSource.shareTitle;
    dataSource.shareInviteUrl   = view.dataSource.shareInviteUrl;
    [[VSShareManager shareInstance] vs_shareType:view.type shareData:dataSource completeBlock:^(VSShareManager *manager, VS_ShareContentState resultCode) {
        
    }];
    
}

- (void)show{
    if(self.array == nil)
    {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    
    
    UILabel *label = [UILabel new];
    label.text = @"分享到";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor blackColor];
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf).offset(12);
        make.top.equalTo(weakSelf).offset(13);
    }];
    
    
    UIView *preView = nil;
    for (int i = 0 ; i <[self.array count]; i++) {
        ProductShareContextModelView *model = [self.array objectAtIndex:i];
        [model mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(weakSelf).offset(65);
            if (preView) {
                make.leading.equalTo(preView.mas_trailing);
            }else{
                make.leading.equalTo(weakSelf);
            }
            
            make.width.equalTo(@([UIScreen mainScreen].bounds.size.width/4.0));
            make.height.equalTo(@(70));
        }];
        
        preView = model;
    }
    
    [self addSubview:self.cancelButton];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(weakSelf);
        make.height.equalTo(@47);
    }];
    
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
    return [RTXShareContextView height:count];
}




+ (SHARETYPE)rtxShare
{
    return SHARETYPE_WEIXINLCIRCLE|SHARETYPE_WEIXIN|SHARETYPE_QQ|SHARETYPE_COPYMEMORY;
    
}
@end

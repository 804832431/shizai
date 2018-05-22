//
//  VSNetErrorView.m
//  beautify
//
//  Created by user on 15/1/9.
//  Copyright (c) 2015年 Elephant. All rights reserved.
//

#import "VSNetErrorView.h"

@interface VSNetErrorView ()

@property(nonatomic, copy)NetErrorViewCallBack callBack;

@property(nonatomic, strong)UIImageView         *vs_imageView;

@property(nonatomic, strong)UILabel             *vs_title;

@property(nonatomic, strong)UIButton            *vs_btnAction;

@end

@implementation VSNetErrorView

- (VSNetErrorView*)initWithCallBack:(NetErrorViewCallBack)callBack
{
    self = [super init];
    if(self)
    {
        [self addSubview:self.vs_imageView];
        [self.vs_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerX.equalTo(self.mas_centerX);
            make.height.equalTo(@(self.vs_imageView.image.size.height));
            make.width.equalTo(@(self.vs_imageView.image.size.width));
            make.top.equalTo(@(0));
            
        }];
        
        [self addSubview:self.vs_title];
        [self.vs_title mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self.mas_centerX);
            make.height.equalTo(@(45));
            make.width.equalTo(self.mas_width);
            make.top.equalTo(self.vs_imageView.mas_bottom).mas_offset(25);
            
        }];
        
        [self addSubview:self.vs_btnAction];
        [self.vs_btnAction mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self.mas_centerX);
            make.height.equalTo(@(25));
            make.width.equalTo(@(60));
            make.top.equalTo(self.vs_title.mas_bottom).mas_offset(20);
            
        }];
        
        self.callBack = callBack;
    }
    
    return self;
}

+ (CGFloat)vp_height
{
    return 68  + 25 + 45 + 20 + 30;
}

- (void)doRefreshClick:(id)sender
{
    if(self.callBack)
    {
        self.callBack();
    }
}

#pragma mark -- getter
_GETTER_BEGIN(UIButton, vs_btnAction)
{
    _vs_btnAction = [UIButton buttonWithType:UIButtonTypeCustom];
    [_vs_btnAction setBackgroundColor:kColor_MainTheme];
    [_vs_btnAction setTitle:@"刷新" forState:UIControlStateNormal];
    [_vs_btnAction setTitleColor:kColor_ffffff forState:UIControlStateNormal];
    [_vs_btnAction.titleLabel setFont:kSysFont_14];
    _SETDEFAULT_VIEW_STYLE_(_vs_btnAction, kColor_Clear, 2);
    
    [_vs_btnAction addTarget:self action:@selector(doRefreshClick:) forControlEvents:UIControlEventTouchUpInside];
    
}
_GETTER_END(vs_btnAction)

_GETTER_ALLOC_BEGIN(UILabel, vs_title)
{
    _CLEAR_BACKGROUND_COLOR_(_vs_title);
    [_vs_title setText:@"哎呦，网络未连接...\r\n建议检查网络后刷新再试"];
    [_vs_title setLineBreakMode:NSLineBreakByWordWrapping];
    [_vs_title setNumberOfLines:0];
    [_vs_title setTextColor:kColor_333333];
    [_vs_title setFont:kSysFont_13];
    [_vs_title setTextAlignment:NSTextAlignmentCenter];
}
_GETTER_END(vs_title)

_GETTER_ALLOC_BEGIN(UIImageView, vs_imageView)
{
    [_vs_imageView setImage:[UIImage imageNamed:@"icon_wifi"]];
}
_GETTER_END(vs_imageView)


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

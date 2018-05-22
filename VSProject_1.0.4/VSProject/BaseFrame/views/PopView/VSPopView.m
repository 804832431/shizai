//
//  VSPopView.m
//  QianbaoIM
//
//  Created by liyan on 9/23/14.
//  Copyright (c) 2014 liu nian. All rights reserved.
//

#import "VSPopView.h"
#import "VSPopBaseContextView.h"
#import "UIImage+Effects.h"
#import "VSPopBaseContextView.h"
#import "UIImage+Ellipse.h"
#import "ProductShareView.h"

@interface VSPopView()

@property (nonatomic, weak)VSPopBaseContextView *contextView;
@property (nonatomic, strong)UIControl          *hideControl;

@property (nonatomic, strong) NSMutableArray    *animatableConstraints;

@property (nonatomic, strong) UIImageView       *imgView;//模糊

@property (nonatomic, strong) UIView            *bottomView;

@property (nonatomic, strong) UIButton          *closeBtn;

@property (nonatomic, strong) UILabel           *titleLabel;

@property (nonatomic, strong) UIView            *titleView;

@property (nonatomic, assign)float               contextHeight;

@property (nonatomic, strong) UIView            *lineView;
@property (nonatomic, assign) int                bottomTopHeigth;
@end


@implementation VSPopView



- (id)init
{
    self = [super init];
    if(self)
    {
        self.backgroundColor = _COLOR_BLACK;
        
        self.imgView = [[UIImageView alloc]initWithImage:nil];
        
        [self addSubview: self.imgView];
        
        
        UIView *bg = [[UIView alloc]init];
        bg.backgroundColor =_COLOR_BLACK;
        bg.alpha = 0.6;
        [self addSubview:bg];
        
        [bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.bottom.equalTo(@0);
        }];
        
        self.hideControl = [[UIControl alloc]init];
        _CLEAR_BACKGROUND_COLOR_(self.hideControl);
        [self addSubview:self.hideControl];
        [self.hideControl addTarget:self action:@selector(closeACtion) forControlEvents:UIControlEventTouchUpInside];
        
        self.bottomView = [[UIView alloc]init];
        self.bottomView.backgroundColor = ColorWithHex(0xf7f7f7, 1.f);
        [self addSubview:self.bottomView];
        self.bottomView.layer.cornerRadius = 5.0f;
        self.bottomView.layer.shadowColor = _COLOR_BLACK.CGColor;
        self.bottomView.layer.shadowOffset = CGSizeMake(0, -4);
        self.bottomView.layer.shadowOpacity = 0.3;//阴影透明度，默认0
        
        
        
        self.lineView =  [[UIView alloc]init];
        self.lineView.backgroundColor = ColorWithHex(0xc6c6c6, 1.f);
        [self.bottomView addSubview:self.lineView];
        
        self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.closeBtn setImage:__IMAGENAMED__(@"icon_discover_close.png") forState:UIControlStateNormal];
        [self.closeBtn addTarget:self action:@selector(closeACtion) forControlEvents:UIControlEventTouchUpInside];
        
        [self.bottomView addSubview:self.closeBtn];
        
        
        self.titleLabel = [[UILabel alloc]init];
        _CLEAR_BACKGROUND_COLOR_(self.titleLabel);
        self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        self.titleLabel.textColor = ColorWithHex(0x262626, 1.f);
        
        [self.bottomView addSubview:self.titleLabel];
        
    }
    return self;
}

+ (instancetype)popView
{
    VSPopView *view = [[VSPopView alloc]init];
    return view;
    
}

#pragma mark - public
- (void)qb_show:(VSPopBaseContextView *)contextView toUIViewController:(UIViewController *)viewController title:(NSString *)title
{
    //默认title样式
    
    self.titleLabel.hidden = NO;
    self.bottomTopHeigth = 70;
    [self.titleView removeFromSuperview];
    
    
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@69);
        make.right.equalTo(@0);
        make.height.equalTo(@1);
    }];
    
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(@15);
        make.height.equalTo(@40);
        make.right.equalTo(self.closeBtn.mas_left);
    }];
    
    [self.hideControl mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    
    [self.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@44);
        make.height.equalTo(@44);
        make.top.equalTo(@11);
        make.right.equalTo(@(-2));
    }];
    
    [self qb_show:contextView toUIViewController:viewController];
    [self.titleLabel setText:title];
    
}


- (void)qb_showUIView:(UIView *)view toUIViewController:(UIViewController *)viewController title:(NSString *)title
{
    VSPopBaseContextView *_contextV = nil;
    if(![view isKindOfClass:[VSPopBaseContextView class]])
    {
        _contextV =  [[VSPopBaseContextView alloc]initWithHeight:view.bounds.size.height];
        [_contextV addSubview:view];
        [view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(0));
            make.top.equalTo(@(0));
            make.right.equalTo(@(0));
            make.bottom.equalTo(@(0));
        }];
    }
    else
    {
        _contextV = (VSPopBaseContextView *)view;
    }
    [self qb_show:_contextV toUIViewController:viewController title:title];
}

- (void)qb_showUIView:(UIView *)view toUIViewController:(UIViewController *)viewController titleView:(UIView *)titleView
{
    [self.titleView removeFromSuperview];
    self.titleView = titleView;
    self.titleLabel.hidden = YES;
    self.bottomTopHeigth = 92;
    [self.bottomView addSubview:self.titleView];
    
    
    
    self.titleLabel.hidden = YES;
    self.titleView.hidden = NO;
    //自定义样式
    
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@91);
        make.right.equalTo(@0);
        make.height.equalTo(@1);
    }];
    
    
    [self.hideControl mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    
    [self.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@44);
        make.height.equalTo(@44);
        make.top.equalTo(@21);
        make.right.equalTo(@(-2));
    }];
    
    [self.titleView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.closeBtn.mas_left);
        make.height.equalTo(@70);
        make.top.equalTo(@11);
        make.left.equalTo(@(15));
    }];
    
    if(![view isKindOfClass:[VSPopBaseContextView class]])
    {
        VSPopBaseContextView *_contextV =  [[VSPopBaseContextView alloc]initWithFrame:view.bounds];
        [_contextV addSubview:view];
        [view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(0));
            make.top.equalTo(@(0));
            make.right.equalTo(@(0));
            make.bottom.equalTo(@(0));
        }];
        [self qb_show:_contextV toUIViewController:viewController];
    }
    else
    {
        [self qb_show:(VSPopBaseContextView *)view  toUIViewController:viewController];
    }
}

- (void)qb_show:(VSPopBaseContextView *)contextView toUIViewController:(UIViewController *)viewController
{
    
    contextView.popView = self;
    [self.contextView removeFromSuperview];
    self.contextView = contextView;
    self.contextHeight = contextView.bounds.size.height;
    NSData *imageData = UIImageJPEGRepresentation([UIImage imgWithVC:viewController], 1);
    UIImage *img= [UIImage imageWithData:imageData];
    UIImage *vcImg = [img blurredImage:.1];
    
    
    self.imgView.image = vcImg;
    
    
    _GET_APP_DELEGATE_(appDelegate);
    UIWindow *window = appDelegate.window;
    //    [window addSubview:self];
    [viewController.navigationController.view addSubview:self];
    
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    
    float k = 1;
    
    [self.imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(window.bounds.size.width *k));
        make.height.equalTo(@(window.bounds.size.height *k));
        make.centerY.equalTo(self.mas_centerY);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.hideControl mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    
    CGSize size = contextView.bounds.size;
    [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
        make.width.equalTo(@260);
        make.height.equalTo(@(size.height));
    }];
    
    [self.bottomView addSubview:contextView];
    
    [contextView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
        make.width.equalTo(@260);
        make.height.equalTo(@(size.height));
    }];
    
    [self performSelector:@selector(initContextView) withObject:nil afterDelay:.01];
}

- (void)newqb_show:(ProductShareView *)contextView toUIViewController:(UIViewController *)viewController
{
    
    contextView.popView = self;
    [self.contextView removeFromSuperview];
    self.contextView = contextView;
    self.contextHeight = contextView.bounds.size.height;
    NSData *imageData = UIImageJPEGRepresentation([UIImage imgWithVC:viewController], 1);
    UIImage *img= [UIImage imageWithData:imageData];
    UIImage *vcImg = [img blurredImage:.1];
    
    
    self.imgView.image = vcImg;
    
    
    _GET_APP_DELEGATE_(appDelegate);
    UIWindow *window = appDelegate.window;
    
    [viewController.navigationController.view addSubview:self];
    
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    
    float k = 1;
    
    [self.imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(window.bounds.size.width *k));
        make.height.equalTo(@(window.bounds.size.height *k));
        make.centerY.equalTo(self.mas_centerY);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.hideControl mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    
    CGSize size = contextView.bounds.size;
    [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self);
        make.width.equalTo(@([UIScreen mainScreen].bounds.size.width));
        make.height.equalTo(@(235));
    }];
    
    [self.bottomView addSubview:contextView];
    
    [contextView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bottomView);
        make.centerY.equalTo(self.bottomView);
        make.width.equalTo(@([UIScreen mainScreen].bounds.size.width));
        make.height.equalTo(@(235));
    }];
    
    [self performSelector:@selector(initContextView) withObject:nil afterDelay:.01];
}

- (void)qb_hide
{
    //动画
    [self animateWithEnd];
}

- (void)moveUpInset:(float)upInset
{
    MASConstraint *constraint = [self.animatableConstraints objectAtIndex:3];
    constraint.equalTo(@(-upInset));
    
    [UIView animateWithDuration:0.4 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished)
     {
     }];
}

#pragma mark - btn action

- (void)closeACtion
{
    [self animateWithEnd];
}

#pragma mark - animate

- (void)initContextView
{
    [self.contextView show];
    [self performSelector:@selector(animateWithBegin) withObject:nil afterDelay:.01];
}

- (void)animateWithBegin
{
    //    _GET_APP_DELEGATE_(appDelegate);
    //    UIWindow *window = appDelegate.window;
    //    float k =0.8;
    
    //    MASConstraint *constraint = [self.animatableConstraints objectAtIndex:0];
    //    constraint.equalTo(@(window.bounds.size.width *k)),
    //    
    //    constraint = [self.animatableConstraints objectAtIndex:1];
    //    constraint.equalTo(@(window.bounds.size.height *k)),
    //    constraint = [self.animatableConstraints objectAtIndex:2];
    //    constraint.offset(-20);
    //    
    //    constraint = [self.animatableConstraints objectAtIndex:3];
    //    constraint.equalTo(@0);
    
    
    [UIView animateWithDuration:0.4 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished)
     {
         
         if([self.delegate respondsToSelector:@selector(popViewDidShowEnd)])
         {
             [self.delegate popViewDidShowEnd];
         }
     }];
}

- (void)animateWithEnd
{
    _GET_APP_DELEGATE_(appDelegate);
    UIWindow *window = appDelegate.window;
    float k =1;
    
    if([self.animatableConstraints count] == 4)
    {
        MASConstraint *constraint = [self.animatableConstraints objectAtIndex:0];
        constraint.equalTo(@(window.bounds.size.width *k)),
        
        constraint = [self.animatableConstraints objectAtIndex:1];
        constraint.equalTo(@(window.bounds.size.height *k)),
        constraint = [self.animatableConstraints objectAtIndex:2];
        constraint.offset(0);
        
        constraint = [self.animatableConstraints objectAtIndex:3];
        constraint.equalTo(@((self.contextHeight +self.bottomTopHeigth)));
        
        
        [UIView animateWithDuration:0.2 animations:^{
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            //repeat!
            if([self.delegate respondsToSelector:@selector(popViewDidCloseEnd)])
            {
                [self.delegate popViewDidCloseEnd];
            }
            
            [self removeFromSuperview];
        }];
    }
    else
    {
        [self removeFromSuperview];
    }
}

#pragma mark - private api


@end

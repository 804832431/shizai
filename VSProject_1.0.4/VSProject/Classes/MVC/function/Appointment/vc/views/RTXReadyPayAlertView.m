//
//  RTXReadyPayAlertView.m
//  VSProject
//
//  Created by XuLiang on 16/1/20.
//  Copyright © 2016年 user. All rights reserved.
//

#import "RTXReadyPayAlertView.h"

#define AlertHeight 100
#define AlertWidth  275//(__SCREEN_WIDTH__ - 50)
#define BOTTEMHeight 33
#define SPACE    13
#define TIPWIDTH    160

@interface RTXReadyPayAlertView ()
{
    UILabel *tipLbl;
    UITextField *payTxt;
    UILabel *yuanLbl;

}

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *cancelButtonTitle;
@property (nonatomic, strong) NSString *confirmButtonTitle;

@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *confirmBtn;

@end

@implementation RTXReadyPayAlertView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message{
    self = [super init];
    if (self) {
        [self buildViews];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title BaseController:(UIViewController *)viewController message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle confirmButtonTitle:(NSString *)confirmButtonTitle{
    self = [super init];
    if (self) {
        self.title = title;
        self.message = message;
        self.cancelButtonTitle = cancelButtonTitle;
        self.confirmButtonTitle = confirmButtonTitle;
        self.viewController = viewController;
        [self buildViews];
        return self;
    }
    return nil;
}

#pragma mark --subViews
-(void)buildViews{
    self.frame = [self screenBounds];
    //    蒙板
    _coverView = [[UIView alloc] initWithFrame:_viewController.view.bounds];
    _coverView.backgroundColor = [UIColor blackColor];
    _coverView.alpha = 0.2;
    _coverView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [_viewController.view addSubview:_coverView];
    
    //    弹出框
    _alertView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, AlertWidth, AlertHeight)];
    _alertView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    _alertView.layer.cornerRadius = 8;
    _alertView.layer.masksToBounds = YES;
    _alertView.backgroundColor = [UIColor lightTextColor];
    [self addSubview:_alertView];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AlertWidth, AlertHeight -BOTTEMHeight)];
    titleView.backgroundColor = [UIColor whiteColor];
    //tipLbl
    tipLbl = [[UILabel alloc] init];
    tipLbl.frame = CGRectMake(SPACE, 0, TIPWIDTH, AlertHeight -BOTTEMHeight);
    tipLbl.text = @"请填写需支付的金额：";
    tipLbl.font = kSysFont_15;
    [titleView addSubview:tipLbl];
    //text
    payTxt = [[UITextField alloc] init];
    payTxt.delegate = (id<UITextFieldDelegate>)self;
    payTxt.keyboardType = UIKeyboardTypeDecimalPad;
    payTxt.textAlignment = NSTextAlignmentRight;
    payTxt.frame = CGRectMake(TIPWIDTH, (AlertHeight -BOTTEMHeight - 33)/2, AlertWidth - SPACE*2 -TIPWIDTH, 33);
    payTxt.layer.cornerRadius = 5.0f;
    payTxt.layer.borderColor = kColor_b5b5b5.CGColor;
    payTxt.layer.borderWidth = 0.5f;
    [titleView addSubview:payTxt];
    //yuanLbl
    yuanLbl = [[UILabel alloc] init];
    yuanLbl.frame = CGRectMake(payTxt.frame.origin.x+payTxt.frame.size.width+5, 0, 30, AlertHeight -BOTTEMHeight);
    yuanLbl.text = @"元";
    yuanLbl.font = kSysFont_15;
    [titleView addSubview:yuanLbl];

    [_alertView addSubview:titleView];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, AlertHeight -BOTTEMHeight - 1, AlertWidth, 0.5)];
    line.backgroundColor = kColor_b5b5b5;
    [_alertView addSubview:line];
    
    if (self.cancelButtonTitle.length && self.confirmButtonTitle.length) {
        CGRect cancelBtnFrame = CGRectMake(0, AlertHeight - BOTTEMHeight, AlertWidth/2.0 - 0.5, BOTTEMHeight);
        self.cancelBtn = [[UIButton alloc] initWithFrame:cancelBtnFrame];
        [self.cancelBtn setTitle:self.cancelButtonTitle forState:UIControlStateNormal];
        [self.cancelBtn.titleLabel setFont:kSysFont_14];
        [self.cancelBtn setTitleColor:kColor_008ffe forState:UIControlStateNormal];
        [self.cancelBtn setTitleColor:kColor_b5b5b5 forState:UIControlStateHighlighted];
        [self.cancelBtn setBackgroundColor:[UIColor whiteColor]];
        [self.cancelBtn addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
        [_alertView addSubview:self.cancelBtn];
        
        CGRect confirmBtnFrame = CGRectMake(AlertWidth/2.0 + 0.5, AlertHeight - BOTTEMHeight, AlertWidth/2.0 - 0.5, BOTTEMHeight);
        self.confirmBtn = [[UIButton alloc] initWithFrame:confirmBtnFrame];
        [self.confirmBtn setTitle:self.confirmButtonTitle forState:UIControlStateNormal];
        [self.confirmBtn.titleLabel setFont:kSysFont_14];
        [self.confirmBtn setTitleColor:kColor_008ffe forState:UIControlStateNormal];
        [self.confirmBtn setTitleColor:kColor_b5b5b5 forState:UIControlStateHighlighted];
        [self.confirmBtn setBackgroundColor:[UIColor whiteColor]];
        [self.confirmBtn addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
        [_alertView addSubview:self.confirmBtn];
    }
}

-(CGRect)screenBounds{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    // On iOS7, screen width and height doesn't automatically follow orientation
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
        UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
        if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
            CGFloat tmp = screenWidth;
            screenWidth = screenHeight;
            screenHeight = tmp;
        }
    }
    
    return CGRectMake(0, 0, screenWidth, screenHeight);
}

- (NSString *)getMoney{
    return payTxt.text;
}

- (void)show{
    [UIView animateWithDuration:0.5 animations:^{
        _coverView.alpha = 0.5;
        
    } completion:^(BOOL finished) {
        
    }];
    
    [_viewController.view addSubview:self];
    [self showAnimation];
}
- (void)dismiss{
    [self hideAnimation];
}

- (void)showAnimation {
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [_alertView.layer addAnimation:popAnimation forKey:nil];
}

- (void)hideAnimation{
    [UIView animateWithDuration:0.4 animations:^{
        _coverView.alpha = 0.0;
        _alertView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    
}

#pragma mark - Action

- (void)dismiss:(id)sender {
    UIButton * btn = (UIButton *)sender;
    if (btn == self.cancelBtn && self.cancelBlock) {
        self.cancelBlock(self);
    }else if (btn == self.confirmBtn && self.confirmBlock) {
        self.confirmBlock(self);
    }else {
        [self dismiss];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    if (string.length > 0) {
        if ([string isEqualToString:@"."]) {
            if ( textField.text.length == 0) {
                return NO;
            }
            if ([textField.text hasString:@"."]) {
                return NO;
            }
        }
        NSInteger indexpoint = [textField.text indexOf:@"."];
        if (textField.text.length > 0 && indexpoint > 0) {
            if ([textField.text substringFromIndex:indexpoint].length >2) {
                return NO;
            }
        }
        if (textField.text.length > 8) {
            return NO;
        }
        if ([textField.text hasPrefix:@"0"]) {
            if ([string isEqualToString:@"."]) {
                return YES;
            }else {
                if ([textField.text hasPrefix:@"0."]) {
                    return YES;
                }else {
                    return NO;
                }
            }
        }

    }
    return YES;
}
@end

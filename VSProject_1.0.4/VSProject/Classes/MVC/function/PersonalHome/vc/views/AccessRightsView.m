//
//  AccessRightsView.m
//  VSProject
//
//  Created by certus on 15/11/26.
//  Copyright © 2015年 user. All rights reserved.
//

#import "AccessRightsView.h"

@implementation AccessRightsView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)vp_setInit {
    
    [self addSubview:self.mainImageView];
    [_mainImageView addSubview:self.titleLabel];
    [_mainImageView addSubview:self.subTitleLabel];
    [_mainImageView addSubview:self.cancelButton];
    
}
- (void)actonCancelButton {
    
    [self hide];
}
#pragma mark -- public

- (void)show {
    
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:.5f];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.window addSubview:self];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CATransition *transition = [CATransition animation];
        transition.duration = 0.4f;
        transition.type = kCATransitionFade;
        transition.subtype = kCATransitionFromLeft;
        [self vp_setInit];
        [self.layer addAnimation:transition forKey:@"changeHome"];
    });
    
}

- (void)hide {
    
    self.backgroundColor = [UIColor clearColor];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.4f;
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFromLeft;
    [_mainImageView removeFromSuperview];
    [self.layer addAnimation:transition forKey:@"changeHome"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
    
}
#pragma mark -- getter


_GETTER_ALLOC_BEGIN(UILabel, titleLabel)
{
    _titleLabel.frame = CGRectMake(0, CGRectGetHeight(_mainImageView.frame)-145, CGRectGetWidth(_mainImageView.frame), 100);
    _titleLabel.textAlignment =NSTextAlignmentCenter;
    _titleLabel.textColor = _COLOR_HEX(0x35b38d);
    _titleLabel.font = FONT_TITLE(13);
    _titleLabel.numberOfLines = 0;
    NSString *alltitle = @"请将您所在公司的企业营业执照、\n企业税务登记证、企业组织机构代码证\n以及个人联系方式邮件发送到\n\n客户服务：service@rtianxia.com\n商务合作：business@rtianxia.com";
    NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithString:alltitle];
    [str addAttribute:NSForegroundColorAttributeName value:_COLOR_HEX(0x144f3d) range:NSMakeRange(8,25)];
    _titleLabel.attributedText = str;
}
_GETTER_END(titleLabel)

_GETTER_ALLOC_BEGIN(UILabel, subTitleLabel)
{
    _subTitleLabel.frame = CGRectMake(0, CGRectGetHeight(_mainImageView.frame)-45, CGRectGetWidth(_mainImageView.frame), 30);
    _subTitleLabel.textAlignment =NSTextAlignmentCenter;
    _subTitleLabel.textColor = _COLOR_HEX(0x144f3d);
    _subTitleLabel.font = FONT_TITLE(17);
    _subTitleLabel.numberOfLines = 0;
    _subTitleLabel.text = @"电话：400-832-0087";
}
_GETTER_END(subTitleLabel)

_GETTER_ALLOC_BEGIN(UIButton, cancelButton)
{
    _cancelButton.frame = CGRectMake(CGRectGetWidth(_mainImageView.frame)-80, 0, 80, 80);
    [_cancelButton addTarget:self action:@selector(actonCancelButton) forControlEvents:UIControlEventTouchUpInside];
}
_GETTER_END(cancelButton)


_GETTER_ALLOC_BEGIN(UIImageView, mainImageView)
{
    _mainImageView.frame = CGRectMake((MainWidth-311)/2, (MainHeight-367)/2, 311, 367);
    _mainImageView.contentMode = UIViewContentModeScaleAspectFit;
    _mainImageView.userInteractionEnabled = YES;
    _mainImageView.image = [UIImage imageNamed:@"access"];
    _mainImageView.backgroundColor = [UIColor clearColor];
}
_GETTER_END(mainImageView)

@end

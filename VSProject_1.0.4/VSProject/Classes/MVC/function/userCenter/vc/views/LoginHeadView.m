//
//  LoginHeadView.m
//  VSProject
//
//  Created by XuLiang on 15/10/28.
//  Copyright © 2015年 user. All rights reserved.
//

#import "LoginHeadView.h"
@interface LoginHeadView ()

@property (strong, nonatomic) UIImageView *m_headImg;
@property (strong, nonatomic) UIImageView *m_lineImg;
@end
@implementation LoginHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//设置ui样式
- (void)vp_setInit{
    self.m_headImg = [[UIImageView alloc] init];
    self.m_headImg.translatesAutoresizingMaskIntoConstraints = NO;
    [self.m_headImg setImage:[UIImage imageNamed:@"me_icon"]];
    [self addSubview:self.m_headImg];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.m_headImg attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.m_headImg attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:-7.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.m_headImg attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:87.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.m_headImg attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:104.0]];
    
    self.m_lineImg = [[UIImageView alloc] init];
    self.m_lineImg.translatesAutoresizingMaskIntoConstraints = NO;
    self.m_lineImg.backgroundColor = kColor_dbdbdb;
    [self addSubview:self.m_lineImg];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.m_lineImg attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.m_lineImg attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.m_lineImg attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.m_lineImg attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:-0.5]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.m_lineImg attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:0.5]];
}
//返回UI高度
+ (CGFloat)vp_height{
    return 130;
}
//根据数据模型更新ui
- (void)vp_updateUIWithModel:(id)model{
    
}

@end

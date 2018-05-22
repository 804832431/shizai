//
//  EFItemView.m
//  HomeVIewCircle
//
//  Created by XuLiang on 15/11/7.
//  Copyright © 2015年 XuLiang. All rights reserved.
//

#import "EFItemView.h"

@interface EFItemView ()

@property (nonatomic, strong) NSString *normal;
@property (nonatomic, strong) NSString *highlighted_;
@property (nonatomic, assign) NSInteger tag_;
//@property (nonatomic, strong) NSString *title;

//@property (nonatomic, strong) UILabel *titleLbl;

//@property (nonatomic, strong) UIImageView *btnImageView;

@end

@implementation EFItemView

- (instancetype)initWithNormalImage:(NSString *)normal highlightedImage:(NSString *)highlighted tag:(NSInteger)tag title:(NSString *)title {
    
    self = [super init];
    if (self) {
        _normal = normal;
        _highlighted_ = highlighted;
        _tag_ = tag;
//        _title = title;
        self.imageView.backgroundColor = [UIColor brownColor];
        [self configViews];
    }
    return self;
}

#pragma mark - configViews

- (void)configViews {
    
    self.tag = _tag_;
//    self.btnImageView = [[UIImageView alloc] init];
//    [self addSubview:self.btnImageView];
//    [self.btnImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self);
//    }];
    NSString *urlStrN = [_normal stringByAppendingString:@"_ios_focus.png"];
    NSString *urlStrH = [_normal stringByAppendingString:@"_ios_normal.png"];
    [self sd_setBackgroundImageWithURL:[NSURL URLWithString:urlStrN] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"syjz_ios_l"]];
    [self sd_setBackgroundImageWithURL:[NSURL URLWithString:urlStrH] forState:UIControlStateHighlighted placeholderImage:[UIImage imageNamed:@"syjz_ios_l"]];
//    [self.btnImageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"shake_gift"]];
//    [self setBackgroundImage:[UIImage imageNamed:_normal] forState:UIControlStateNormal];
//    [self setBackgroundImage:[UIImage imageNamed:_highlighted_] forState:UIControlStateHighlighted];
    [self addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:self.titleLbl];
//    [self.titleLbl setText:_title];
    
}

- (void)btnTapped:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didTapped:)]) {
        [self.delegate didTapped:sender.tag];
    }
}

//-(UILabel *)titleLbl{
//    if (!_titleLbl) {
//        self.titleLbl = [[UILabel alloc] init];
//        [self.titleLbl setText:_title];
//        [self.titleLbl setTextColor:[UIColor whiteColor]];
//        [self.titleLbl setTextAlignment:NSTextAlignmentCenter];
//        [self.titleLbl setFont:[UIFont systemFontOfSize:18.0]];
//        self.titleLbl.translatesAutoresizingMaskIntoConstraints = NO;
//        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLbl attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:22.0]];
//        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLbl attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0.0]];
//        
//    }
//    return _titleLbl;
//}

@end

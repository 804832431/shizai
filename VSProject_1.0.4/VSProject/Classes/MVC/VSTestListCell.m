//
//  VSTestListCell.m
//  VSProject
//
//  Created by tiezhang on 15/10/6.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSTestListCell.h"

@interface VSTestListCell ()

_PROPERTY_NONATOMIC_STRONG(UILabel, testLabel);

@end

@implementation VSTestListCell


- (void)vp_setInit
{
    [super vp_setInit];
    //TODO：设置样式
    
    [self.contentView addSubview:self.testLabel];
    [self.testLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(@(20));
        make.right.equalTo(@(-20));
        make.top.equalTo(@(10));
        make.bottom.equalTo(@(-10));
        
    }];
}

+ (CGFloat)vp_height
{
    return 100.f;
}

- (void)vp_updateUIWithModel:(NSString*)model
{
    //TODO：更新UI
    
    
    self.testLabel.text = model;
}

#pragma mark -- getter

_GETTER_ALLOC_BEGIN(UILabel, testLabel)
{
    _testLabel.textColor = [UIColor blackColor];
    _testLabel.font = [UIFont systemFontOfSize:14];
}
_GETTER_END(testLabel)

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

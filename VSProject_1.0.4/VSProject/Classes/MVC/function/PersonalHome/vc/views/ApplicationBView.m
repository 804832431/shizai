//
//  ApplicationBView.m
//  VSProject
//
//  Created by certus on 15/11/28.
//  Copyright © 2015年 user. All rights reserved.
//

#import "ApplicationBView.h"

@implementation ApplicationBView


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        
        _appBgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _appBgImageView.backgroundColor = [UIColor clearColor];
        [self addSubview:_appBgImageView];
        
    }
    
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

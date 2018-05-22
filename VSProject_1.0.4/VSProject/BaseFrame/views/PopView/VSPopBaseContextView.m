//
//  VSPopBaseContextView.m
//  QianbaoIM
//
//  Created by liyan on 9/23/14.
//  Copyright (c) 2014 liu nian. All rights reserved.
//

#import "VSPopBaseContextView.h"

@implementation VSPopBaseContextView

- (id)initWithFrame:(CGRect)frame
{
    NSAssert(0,@"Use `initWithHeight:`");
    return nil;
}

- (id)initWithHeight:(CGFloat)height
{
    self = [super initWithFrame:_CGR(0, 0, __SCREEN_WIDTH__, height)];
    if(self)
    {
        
    }
    return self;
}


- (void)updateUIWithModel:(id)data
{
    self.model = data;
}
- (void)show
{
    
}
@end

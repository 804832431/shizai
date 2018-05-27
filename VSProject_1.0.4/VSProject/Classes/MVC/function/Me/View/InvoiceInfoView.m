//
//  InvoiceInfoView.m
//  VSProject
//
//  Created by apple on 5/26/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "InvoiceInfoView.h"

@implementation InvoiceInfoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setAutoresizesSubviews:NO];
}

+ (UIView *)view {
    UIView *view = nil;
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"InvoiceInfoView"
                                                 owner:self
                                               options:nil];
    for(id obj in nib)
        if([obj isKindOfClass:NSClassFromString(@"InvoiceInfoView")])
            view = obj;
    [view setAutoresizesSubviews:NO];
    return view;
}

@end

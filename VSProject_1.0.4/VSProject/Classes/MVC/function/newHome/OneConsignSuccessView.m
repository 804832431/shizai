//
//  OneConsignSuccessView.m
//  VSProject
//
//  Created by apple on 9/3/17.
//  Copyright © 2017 user. All rights reserved.
//

#import "OneConsignSuccessView.h"

@implementation OneConsignSuccessView

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"OneConsignSuccessView" owner:nil options:nil];
        self = [nibView firstObject];
    }
    return self;
}

@end

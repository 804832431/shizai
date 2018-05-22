//
//  CustomServiceView.m
//  VSProject
//
//  Created by apple on 9/4/17.
//  Copyright © 2017 user. All rights reserved.
//

#import "CustomServiceView.h"

@implementation CustomServiceView

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"CustomServiceView" owner:nil options:nil];
        self = [nibView firstObject];
    }
    return self;
}

@end

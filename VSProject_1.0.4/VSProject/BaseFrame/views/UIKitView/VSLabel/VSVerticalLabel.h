//
//  VSVerticalLabel.h
//  VSProject
//
//  Created by tiezhang on 15/2/26.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSLabel.h"

typedef enum
{
    VS_VerticalAlignmentTop = 0, // default
    VS_VerticalAlignmentMiddle,
    VS_VerticalAlignmentBottom,
} VS_VerticalAlignment;

@interface VSVerticalLabel : VSLabel

@property (nonatomic) VS_VerticalAlignment verticalAlignment;

@end

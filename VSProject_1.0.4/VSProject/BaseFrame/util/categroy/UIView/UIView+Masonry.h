//
//  UIView+Masonry.h
//  VSProject
//
//  Created by bestjoy on 15/1/23.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Masonry)
- (void) distributeSpacingHorizontallyWith:(NSArray*)views;
- (void) distributeSpacingVerticallyWith:(NSArray*)views;
- (void) distributeSpacingHorizontallyWith:(NSArray*)views andgaplength:(CGFloat)gap;
@end

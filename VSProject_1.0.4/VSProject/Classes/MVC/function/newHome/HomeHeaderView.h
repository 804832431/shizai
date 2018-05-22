//
//  HomeHeaderView.h
//  VSProject
//
//  Created by apple on 12/27/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MoreActionBlock) ();

@interface HomeHeaderView : UIView

@property (nonatomic, strong) MoreActionBlock moreActionBlock;

- (void)setTitle:(NSString *)title
        withMore:(BOOL)shouldHaveMoreButton;

@end

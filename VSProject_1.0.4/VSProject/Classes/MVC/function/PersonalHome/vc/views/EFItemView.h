//
//  EFItemView.h
//  HomeVIewCircle
//
//  Created by XuLiang on 15/11/7.
//  Copyright © 2015年 XuLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EFItemViewDelegate <NSObject>

- (void)didTapped:(NSInteger)index;

@end

@interface EFItemView : UIButton

@property (nonatomic, weak) id <EFItemViewDelegate>delegate;

- (instancetype)initWithNormalImage:(NSString *)normal highlightedImage:(NSString *)highlighted tag:(NSInteger)tag title:(NSString *)title;

@end

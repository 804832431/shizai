//
//  ServerButtonView.h
//  VSProject
//
//  Created by pangchao on 17/6/25.
//  Copyright © 2017年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ServerButtonViewDelegate <NSObject>

- (void)clickedButtonAction:(RTXBapplicationInfoModel *)model;

@end

@interface ServerButtonView : UIView

@property (nonatomic, strong) NSArray *dataList;

@property (nonatomic, weak) id<ServerButtonViewDelegate> clickedDelegate;

- (void)setDataSource:(NSArray *)dataList;

+ (CGFloat)getHeighWithIconCount:(NSInteger)iconCount;

@end

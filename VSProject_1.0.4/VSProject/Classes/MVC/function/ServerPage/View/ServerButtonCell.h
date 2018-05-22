//
//  ServerButtonCell.h
//  VSProject
//
//  Created by pangchao on 17/6/25.
//  Copyright © 2017年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ServerButtonDelegate <NSObject>

- (void)clickedButtonAction:(RTXBapplicationInfoModel *)model;

@end

@interface ServerButtonCell : UITableViewCell

@property (nonatomic, strong) NSArray *dataList;

@property (nonatomic, strong) id<ServerButtonDelegate> delegate;

- (void)setDataSource:(NSArray *)dataList;

+ (CGFloat)getHeightWithIconCount:(NSInteger)iconCount;

@end

//
//  PassScale.h
//  safekeeping
//
//  Created by Minr on 14-11-25.
//  Copyright (c) 2014年 Minr. All rights reserved.
//

#import <UIKit/UIKit.h>
#define  APPCENTER     CGPointMake(MainWidth, MainHeight)
#define  APPRADIUS     (MainWidth-50)
#define  APPRICON_W     50

// 轮盘的代理
@protocol PassDelegate <NSObject>

- (void)setAppHightlight:(RTXBapplicationInfoModel *)model index:(NSUInteger)index;
- (void)didSelectApp:(RTXBapplicationInfoModel *)model index:(NSUInteger)index;

@end

@interface PassScale : UIView

// 轮盘代理对象
@property(nonatomic , assign) id<PassDelegate> delegate;
@property(nonatomic , strong) NSArray *dataList;

- (void)buildApplications;

@end


// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 

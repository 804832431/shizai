//
//  EnterpriseHomeView.h
//  VSProject
//
//  Created by 姚君 on 15/11/2.
//  Copyright © 2015年 user. All rights reserved.
//

#import "VSView.h"
#import "NavigationBar.h"

@class EnterpriseHomeView;
@protocol EnterpriseHomeViewDelegate <NSObject>

- (void)homeB:(EnterpriseHomeView *)view didTappApp:(RTXBapplicationInfoModel *)model;

@end
@interface EnterpriseHomeView : VSView

@property (nonatomic,assign)id<EnterpriseHomeViewDelegate> delegate;

@end

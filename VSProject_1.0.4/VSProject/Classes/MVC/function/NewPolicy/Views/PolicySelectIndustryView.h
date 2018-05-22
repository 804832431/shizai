//
//  PolicySelectIndustryView.h
//  VSProject
//
//  Created by apple on 7/3/17.
//  Copyright © 2017 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndustryModel.h"

typedef void(^OnSelectedIndustyBlock)(IndustryModel *industyModel);

@interface PolicySelectIndustryView : UIView <UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

_PROPERTY_NONATOMIC_STRONG(NSArray , industryList);
_PROPERTY_NONATOMIC_STRONG(UITableView, industryTableView);
_PROPERTY_NONATOMIC_STRONG(IndustryModel , selectedIndustry);

@property (nonatomic, strong) OnSelectedIndustyBlock onSelectedIndustyBlock;

- (void)onSetIndustyList:(NSArray *)industyList;

@end

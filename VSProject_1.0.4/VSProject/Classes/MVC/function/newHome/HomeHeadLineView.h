//
//  HomeHeadLineView.h
//  VSProject
//
//  Created by apple on 12/27/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PolicyModel.h"

typedef void(^OnClickHeadLineBlock) (PolicyModel *dto);

@interface HomeHeadLineView : UIView

@property (nonatomic, strong) OnClickHeadLineBlock onClickHeadLineBlock;

- (void)setDataSource:(NSArray *)headLineList;

@end

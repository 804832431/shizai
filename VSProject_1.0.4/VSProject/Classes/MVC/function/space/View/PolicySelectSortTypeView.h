//
//  PolicySelectSortTypeView.h
//  VSProject
//
//  Created by pangchao on 2017/10/23.
//  Copyright © 2017年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OnSelectedSortTypeBlock)(NSString *SortTypeString, NSInteger selectIndex);

@interface PolicySelectSortTypeView : UIView <UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITableView *sortTypeTableView;

@property (nonatomic, copy) NSString *selectedSortType;

@property (nonatomic, strong) OnSelectedSortTypeBlock onSelectedSortTypeBlock;

@end

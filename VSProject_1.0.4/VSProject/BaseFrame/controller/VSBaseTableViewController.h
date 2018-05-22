//
//  VMBaseTableViewController.h
//  beautify
//
//  Created by xiangying on 14-11-12.
//  Copyright (c) 2014年 Elephant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VSBaseViewController.h"

@protocol VSBaseTableViewControllerProtocol <NSObject>

@optional
- (void)vp_refresh;

- (void)vp_loadMore;

#pragma mark -- action
@optional
- (void)vp_deleteAtIndexPath:(NSIndexPath*)indexPath;


@end

@interface VSBaseTableViewController : VSBaseViewController<VSBaseTableViewControllerProtocol, UITableViewDataSource, UITableViewDelegate>
{
    NSArray *_sectionNameClasses;
    NSArray *_cellNameClasses;
    NSArray *_sectionViewDataSource;
}

@property(strong, nonatomic) IBOutlet UITableView *tableView;

/**
 *  @desc  tableview数据源
 *  @note  tableviewCell数据源
 */
@property(nonatomic, strong) NSArray *__dataitem_typeof__(NSArray)dataSource;   //table数据源,format:@[ @[sectionCellItem,...], ...]

/**
 *  @desc  tableview数据源
 *  @note  sectionHeaderView数据源
 */
@property(nonatomic, strong) NSArray *__dataitem_typeof__(NSArray)sectionViewDataSource;

/**
 *  @desc  所有section中的CellClass容器
 *  @note  靠派生类对象自己去组装实现
 */
@property(nonatomic, strong) NSArray *__dataitem_typeof__(Class)cellNameClasses;


/**
 *  @desc  所有section中的sectionViewClass容器
 *  @note  靠派生类对象自己去组装实现,与cellNameClasses类似
 */
@property(nonatomic, strong) NSArray *__dataitem_typeof__(Class)sectionNameClasses;

/**
 *  @desc  是否需要右侧索引提示
 *  @note  A-Z这样的缩影
 */
@property(nonatomic, assign) BOOL    isNeedSearchIndex;

/**
 *  @desc  isNeedSearchIndex 为YES时候有效
 *  @note  A-Z这样的缩影
 */
@property(nonatomic, strong) NSArray *arrayOfCharacters;

/**
 *  @desc  是否需要可编辑，如滑动删除等
 *  @note  default is NO
 */
@property(nonatomic, assign) BOOL    isCanEdit;

#pragma mark -- action
/**
 *  @desc  刷新tableview
 */
- (void)vs_reloadData;

#pragma mark -- 上拉下拉
- (void)vs_showRefreshHead:(BOOL)bshow;

- (void)vs_showRefreshFoot:(BOOL)bshow;

//隐藏多余分割线
- (void)vs_setExtraCellLineHidden;

/**
 *  @desc  结束tableview刷新状态
 */
- (void)vs_endLoadingState;

- (NSString*)wm_cellIndentifyAtIndexPath:(NSIndexPath*)indexPath;

@end

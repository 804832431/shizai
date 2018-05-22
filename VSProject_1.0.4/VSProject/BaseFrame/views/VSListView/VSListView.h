//
//  VSListView.h
//  VSProject
//
//  Created by user on 15/1/30.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VSListView;
@protocol VSListViewProtocol <NSObject>

@optional
- (Class)vp_cellClass;

- (NSArray* __dataitem_typeof__([VSBaseTableViewCell class]))vp_mutCellClasses;

- (Class)vp_sectionClass;

- (NSArray* __dataitem_typeof__([VSBaseTableViewCell class]))vp_mutSectionClasses;

@optional
- (void)vp_refresh;

- (void)vp_loadMore;

#pragma mark -- action
@optional
- (void)vp_deleteAtIndexPath:(NSIndexPath*)indexPath;

@end

@protocol VSListViewDelegate <NSObject>

@optional
- (void)didSelectedRowWithData:(id)data atIndexPath:(NSIndexPath*)indexPath;

- (void)listView:(VSListView*)sender deleteRowAtIndex:(NSIndexPath*)indexPath;

@end

@interface VSListView : UIView<VSListViewProtocol, UITableViewDataSource, UITableViewDelegate>
{
    NSArray *_cellNameClasses;
    NSArray *_sectionViewDataSource;
}

@property(strong, nonatomic) IBOutlet UITableView *tableView;

@property(weak, nonatomic) id<VSListViewDelegate> delegate;

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
- (void)vs_reloadData;

#pragma mark -- 上拉下拉
- (void)vs_showRefreshHead:(BOOL)bshow;

- (void)vs_showRefreshFoot:(BOOL)bshow;

- (NSString*)wm_cellIndentifyAtIndexPath:(NSIndexPath*)indexPath;

@end

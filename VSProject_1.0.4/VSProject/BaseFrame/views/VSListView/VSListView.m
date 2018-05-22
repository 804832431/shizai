//
//  VSListView.m
//  VSProject
//
//  Created by user on 15/1/30.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSListView.h"
#import "UIScrollView+MJRefresh.h"
#import "VSBaseSectionView.h"
#import "UIView+InitUI.h"
#import "VSFileHelper.h"


@interface VSListView ()
{
        VSImageView             *_tableIndexTitleView;
        VSLabel                 *_tableIndexTitleLabel;
        NSTimer                 *_tableIndexTitleTimer;
}

@property(nonatomic, strong)NSMutableArray *wm_sectionViews;   //存放sectionViews

- (VSBaseSectionView*)vs_findHeaderViewForSection:(NSInteger)section;

@end

@implementation VSListView

- (void)dealloc
{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}


- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self vp_setInit];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self vp_setInit];
}

- (void)vp_setInit
{
    if(!_tableView)
    {
        [self addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(self);
            
        }];
    }
    
    self.isNeedSearchIndex      = NO;
    self.arrayOfCharacters      = [[NSMutableArray alloc] initWithObjects:
                                   @"A", @"B", @"C", @"D", @"E", @"F", @"G",
                                   @"H", @"I", @"J", @"K", @"L", @"M", @"N",
                                   @"O", @"P", @"Q",       @"R", @"S", @"T",
                                   @"U", @"V", @"W",       @"X", @"Y", @"Z",
                                   nil];
    
    
    self.tableView.delegate     = self;
    self.tableView.dataSource   = self;
}

#pragma mark -- 上拉下拉
- (void)vs_showRefreshHead:(BOOL)bshow
{
    if(bshow)
    {
        typeof(self) __weak t_self = self;
        [self.tableView addHeaderWithCallback:^{
            
            if([t_self respondsToSelector:@selector(vp_refresh)])
            {
                [t_self performSelector:@selector(vp_refresh)];
            }
            
        }];
    }
    else
    {
        [self.tableView removeHeader];
    }
}

- (void)vs_showRefreshFoot:(BOOL)bshow
{
    if(bshow)
    {
        typeof(self) __weak t_self = self;
        [self.tableView addFooterWithCallback:^{
            
            if([t_self respondsToSelector:@selector(vp_loadMore)])
            {
                [t_self performSelector:@selector(vp_loadMore)];
            }
            
        }];
    }
    else
    {
        [self.tableView removeFooter];
    }
}

#pragma mark -- action
- (void)vs_reloadData
{
    [self.tableView reloadData];
}

#pragma mark -- VMBaseViewControllerProtocol
- (void)vp_reloadNetData
{
    if([self respondsToSelector:@selector(vp_refresh)])
    {
        [self vp_refresh];
    }
}

#pragma mark -- VMBaseTableViewControllerProtocol
- (NSString*)wm_cellIndentifyAtIndexPath:(NSIndexPath*)indexPath
{
    if([self respondsToSelector:@selector(vp_cellClass)])
    {
        return NSStringFromClass([self vp_cellClass]);
    }
    
    else if ([self respondsToSelector:@selector(vp_mutCellClasses)])
    {
        NSArray *t_cellClasses  = [self vp_mutCellClasses];
        return NSStringFromClass( t_cellClasses[indexPath.section] );
    }
    else
    {
        return nil;
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.dataSource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    NSArray *t_sectionDatas     = [self.dataSource objectAtIndex:section];
    if([t_sectionDatas isKindOfClass:[NSArray class]])
    {
        return [t_sectionDatas count];
    }
    else
    {
        return 0;
    }
}

- (CGFloat)heightForClass:(Class)cellClass indexPath:(NSIndexPath*)indexPath
{
    SEL selector = @selector(vp_height);
    
    BOOL flag = [((id)cellClass) respondsToSelector:selector];
    
    if(flag)
    {
        return [cellClass vp_height];
    }
    else
    {
        
        SEL selector2 = @selector(vp_cellHeightWithModel:withSuperWidth:);
        
        BOOL flag2 = [((id)cellClass) respondsToSelector:selector2];
        if(flag2)
        {
            NSInteger t_currentSection  = indexPath.section;
            NSInteger t_currentRow      = indexPath.row;
            NSArray *sectionInfos       = self.dataSource[t_currentSection];
            return [cellClass vp_cellHeightWithModel:sectionInfos[t_currentRow] withSuperWidth:CGRectGetWidth(self.tableView.frame)];
        }
        else
        {
            return 0;
        }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger t_rowNum = [tableView.dataSource tableView:tableView numberOfRowsInSection:indexPath.section];
    if(t_rowNum <= 0)
    {
        return 0;
    }
    else
    {
        if([self respondsToSelector:@selector(vp_cellClass)])
        {
            Class cls = [self vp_cellClass];
            
            return [self heightForClass:cls indexPath:indexPath];
            
        }
        
        else if ([self respondsToSelector:@selector(vp_mutCellClasses)])
        {
            NSArray *t_cellClasses = [self vp_mutCellClasses];
            
            Class cellClass = t_cellClasses[indexPath.section];
            
            return [self heightForClass:cellClass indexPath:indexPath];
            
        }
        else
        {
            return 0;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(_delegate && [_delegate respondsToSelector:@selector(didSelectedRowWithData:atIndexPath:)])
    {
        NSInteger sectionIndex = indexPath.section;
        
        id retData = nil;
        if(sectionIndex <= [self.dataSource count])
        {
            NSArray *rowDatas  = self.dataSource[sectionIndex];
            NSInteger rowIndex = indexPath.row;
            if(rowIndex <= [rowDatas count])
            {
                retData = rowDatas[rowIndex];
            }
            else
            {
                retData = nil;
            }
        }
        else
        {
            retData = nil;
        }
        
        [_delegate didSelectedRowWithData:retData atIndexPath:indexPath];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    //    if([tableView respondsToSelector:@selector(dequeueReusableCellWithIdentifier:forIndexPath:)])
    //    {
    //        cell = [tableView dequeueReusableCellWithIdentifier:[self wy_cellIndentifyAtIndexPath:indexPath]
    //                                                                forIndexPath:indexPath];
    //    }
    //    else if ([tableView respondsToSelector:@selector(dequeueReusableCellWithIdentifier:)])
    {
        cell = [tableView dequeueReusableCellWithIdentifier:[self wm_cellIndentifyAtIndexPath:indexPath]];
    }
    //    else
    //    {
    //        cell = nil;
    //    }
    
    if(!cell)
    {
        Class t_cellClass   = nil;
        if([self respondsToSelector:@selector(vp_cellClass)])
        {
            t_cellClass     = [self vp_cellClass];
        }
        else if ([self respondsToSelector:@selector(vp_mutCellClasses)])
        {
            NSArray *t_cellClasses  = [self vp_mutCellClasses];
            if(indexPath.section >= [t_cellClasses count])
            {
                return nil;
            }
            else
            {
                t_cellClass             = t_cellClasses[indexPath.section];
            }
        }
        else
        {
            return nil;
        }
        
        NSString *t_xibPath = [[NSBundle mainBundle] pathForResource:NSStringFromClass(t_cellClass) ofType:@"nib"];
        if(t_xibPath && [[VSFileHelper shareIntance] fileExistsAtPath:t_xibPath])
        {
            NSArray *cells = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(t_cellClass) owner:nil options:nil];
            if([cells count] <= 0)
            {
                cell = [[[self vp_cellClass] alloc]initWithStyle:UITableViewCellStyleDefault
                                                 reuseIdentifier:[self wm_cellIndentifyAtIndexPath:indexPath]];
            }
            else
            {
                cell = cells[0];
            }
        }
        else
        {
            cell = [[t_cellClass alloc]initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:[self wm_cellIndentifyAtIndexPath:indexPath]];
        }
    }
    
    NSInteger t_currentSection  = indexPath.section;
    NSInteger t_currentRow      = indexPath.row;
    NSArray *sectionInfos       = self.dataSource[t_currentSection];
    if([sectionInfos isKindOfClass:[NSArray class]])
    {
        if([cell isKindOfClass:[VSBaseTableViewCell class]])
        {
            VSBaseTableViewCell *qb_cell = (VSBaseTableViewCell*)cell;
            if(t_currentRow < [sectionInfos count])
            {
                if([cell respondsToSelector:@selector(vp_updateUIWithModel:)])
                {
                    [qb_cell vp_updateUIWithModel:sectionInfos[t_currentRow]];
                }
                
                else if ([cell respondsToSelector:@selector(vp_updateCellInfoWithModel: indexPath:)])
                {
                    [qb_cell vp_updateCellInfoWithModel:sectionInfos[t_currentRow] indexPath:indexPath];
                }
                else if ([cell respondsToSelector:@selector(vp_updateCellInfoWithModel:withSuperWidth:)])
                {
                    [qb_cell vp_updateCellInfoWithModel:sectionInfos[t_currentRow] withSuperWidth:CGRectGetWidth(self.tableView.frame)];
                }
                else
                {
                    //Nothing
                }
            }
            else
            {
                NSAssert(0, @"数组越界");
            }
        }
        else
        {
            //TODO: other cell update
        }
    }
    else
    {
        NSAssert(0, @"datasource中的元素必须为数组");
    }
    
    if([cell respondsToSelector:@selector(setDelegate:)])
    {
        [cell performSelector:@selector(setDelegate:) withObject:self];
    }
    
    return cell;
}

- (VSBaseSectionView*)vs_findHeaderViewForSection:(NSInteger)section
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"sectionIndex == %@", @(section)];
    NSArray *filteredArray = [self.wm_sectionViews filteredArrayUsingPredicate:predicate];
    
    return (filteredArray.count > 0) ? [filteredArray firstObject] : 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    Class t_sectionClass = nil;
    if([self respondsToSelector:@selector(vp_sectionClass)])
    {
        t_sectionClass = [self vp_sectionClass];
    }
    else if ([self respondsToSelector:@selector(vp_mutSectionClasses)])
    {
        NSArray *t_cellClasses  = [self vp_mutSectionClasses];
        t_sectionClass          = t_cellClasses[section];
    }
    else
    {
        
    }
    
    if(!t_sectionClass)
    {
        return 0.f;
    }
    
    SEL selector = @selector(vp_height);
    
    BOOL flag = [((id)t_sectionClass) respondsToSelector:selector];
    
    if(flag)
    {
        return [t_sectionClass vp_height];
    }
    else
    {
        
        SEL selector2 = @selector(vp_viewHeightWithModel:);
        
        BOOL flag2 = [((id)t_sectionClass) respondsToSelector:selector2];
        if(flag2)
        {
            if([self.sectionViewDataSource count] > 0)
            {
                return [t_sectionClass vp_viewHeightWithModel:self.sectionViewDataSource[section]];
            }
            else
            {
                return 0.f;
            }
        }
        else
        {
            return 0;
        }
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    VSBaseSectionView *t_sectionView = [self vs_findHeaderViewForSection:section];
    
    if(!t_sectionView)
    {
        Class t_sectionClass = nil;
        if([self respondsToSelector:@selector(vp_sectionClass)])
        {
            t_sectionClass = [self vp_sectionClass];
        }
        else if ([self respondsToSelector:@selector(vp_mutSectionClasses)])
        {
            NSArray *t_cellClasses  = [self vp_mutSectionClasses];
            t_sectionClass          = t_cellClasses[section];
        }
        else
        {
            return nil;
        }
        
        //去加载本地xib文件
        //        @try {
        NSString *t_xibPath = [[NSBundle mainBundle] pathForResource:NSStringFromClass(t_sectionClass) ofType:@"nib"];
        if(t_xibPath && [[VSFileHelper shareIntance] fileExistsAtPath:t_xibPath])
        {
            t_sectionView = (VSBaseSectionView*)[[UIView class] wm_loadViewXib:t_sectionClass];
        }
        //        }
        //        @catch (NSException *exception) {
        //
        //        }
        //        @finally {
        //
        //        }
        
        if(!t_sectionView)
        {//若不存在则去alloc
            t_sectionView = [[t_sectionClass alloc]init];
        }
        
        t_sectionView.sectionIndex  = section;
        [self.wm_sectionViews addObject:t_sectionView];
        
    }
    
    if([t_sectionView respondsToSelector:@selector(vp_updateUIWithModel:)])
    {
        [t_sectionView vp_updateUIWithModel:([self.sectionViewDataSource count] > section) ? self.sectionViewDataSource[section] : nil];
    }
    
    if([t_sectionView respondsToSelector:@selector(setDelegate:)])
    {
        [t_sectionView performSelector:@selector(setDelegate:) withObject:self];
    }
    
    return t_sectionView;
}


#pragma mark -- tableTitleIndexs
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if(self.isNeedSearchIndex)
    {
        return self.arrayOfCharacters;
    }
    else
    {
        return nil;
    }
}


- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    
    NSInteger retPos = -1; /*无效的位置*/
    if(!self.isNeedSearchIndex)
    {
        return retPos;
    }
    
    if (title == UITableViewIndexSearch)
    {
        [tableView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
    else
    {
        [self showIndexTitles:title index:index];
        
        NSInteger count = 0;
        
        for(NSString *character in self.arrayOfCharacters)
        {
            
            if([character isEqualToString:title])
            {
                
                return count;
                
            }
            
            count ++;
            
        }
        return  count;
        
        
    }
    
    return retPos;
}

- (void)showIndexTitles:(NSString *)title index:(NSInteger)index
{
    if (_tableIndexTitleTimer != nil && [_tableIndexTitleTimer isValid])
    {
        [_tableIndexTitleTimer invalidate];
        _tableIndexTitleTimer = nil;
    }
    
    if (_tableIndexTitleView == nil)
    {
        UIImage * image      = [UIImage imageNamed:@"bg_table_searchIndex"];
        _tableIndexTitleView = [[VSImageView alloc] initWithImage:image];
        _CLEAR_BACKGROUND_COLOR_(_tableIndexTitleView);
        CGSize superSize     = self.bounds.size;
        float x = (superSize.width  - image.size.width) / 2;
        float y = (superSize.height - image.size.height) / 2;
        [_tableIndexTitleView setFrame:CGRectMake(x, y, image.size.width, image.size.height)];
        [self addSubview:_tableIndexTitleView];
        
        VSLabel * label = [[VSLabel alloc] initWithFrame:_tableIndexTitleView.bounds];
        _CLEAR_BACKGROUND_COLOR_(label);
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setTextColor:[UIColor whiteColor]];
        [label setFont:[UIFont systemFontOfSize:64]];
        [_tableIndexTitleView addSubview:label];
        _tableIndexTitleLabel = label;
    }
    
    [_tableIndexTitleView setHidden:NO];
    [_tableIndexTitleView setAlpha:1.0f];
    if(title == nil)
    {
        [_tableIndexTitleLabel setText:@""];
    }
    else
    {
       	[_tableIndexTitleLabel setText:title];
    }
    
    
    if (_tableIndexTitleTimer == nil)
    {
        _tableIndexTitleTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(hideTheIndexTitle:) userInfo:nil repeats:NO];
    }
}

- (void)hideTheIndexTitle:(id)params
{
    [_tableIndexTitleTimer invalidate];
    _tableIndexTitleTimer = nil;
    
    void (^animation)(void) = ^(void){
        [_tableIndexTitleView setAlpha:0.0f];
    };
    void (^animationEnd)(BOOL finished) = ^(BOOL finished){
        [_tableIndexTitleView setHidden:YES];
    };
    [UIView animateWithDuration:0.2 animations:animation completion:animationEnd];
}

#pragma mark -- edit
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.isCanEdit;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.isCanEdit)
    {
        return @"删除";
    }
    else
    {
        return nil;
    }
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCellEditingStyle result = UITableViewCellEditingStyleNone;//默认没有编辑风格
    {
        result = UITableViewCellEditingStyleDelete;//设置编辑风格为删除风格
    }
    return result;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        if(self.isCanEdit)
        {
            if(self && [self respondsToSelector:@selector(vp_deleteAtIndexPath:)])
            {
                [self vp_deleteAtIndexPath:indexPath];
            }
        }
        
    }
    else
    {
        //if (editingStyle == UITableViewCellEditingStyleInsert)
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

#pragma mark -- getter
_GETTER_BEGIN(UITableView, tableView)
{
    _tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
    _CLEAR_BACKGROUND_COLOR_(_tableView);
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}
_GETTER_END(tableView)

_GETTER_ALLOC_BEGIN(NSMutableArray, wm_sectionViews)
{
}
_GETTER_END(wm_sectionViews)

@end

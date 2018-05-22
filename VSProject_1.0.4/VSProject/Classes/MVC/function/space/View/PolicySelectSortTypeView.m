//
//  PolicySelectSortTypeView.m
//  VSProject
//
//  Created by pangchao on 2017/10/23.
//  Copyright © 2017年 user. All rights reserved.
//

#import "PolicySelectSortTypeView.h"
#import "SelectCityAndAreaCell.h"

@implementation PolicySelectSortTypeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self addSubview:self.sortTypeTableView];
    
    self.selectedSortType = @"默认排序";
    
    return self;
}

- (UITableView *)sortTypeTableView {
    if (!_sortTypeTableView) {
        _sortTypeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_WIDTH__, self.frame.size.height)];
        [_sortTypeTableView setBackgroundColor:ColorWithHex(0xefeff4, 0.0)];
        [_sortTypeTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _sortTypeTableView.delegate = self;
        _sortTypeTableView.dataSource = self;
        _sortTypeTableView.estimatedRowHeight = 0;
        _sortTypeTableView.estimatedSectionHeaderHeight = 0;
        _sortTypeTableView.estimatedSectionFooterHeight = 0;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackGround)];
        tap.delegate = self;
        [_sortTypeTableView addGestureRecognizer:tap];
    }
    return _sortTypeTableView;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[UITableView class]]) {
        return YES;
    }
    
    return  NO;
}

- (void)tapBackGround {
    if (self.onSelectedSortTypeBlock) {
        self.onSelectedSortTypeBlock(nil, 0);
    }
}

#pragma mark - UITableViewDelegate && UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"SelectCityAndAreaCell";
    SelectCityAndAreaCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SelectCityAndAreaCell" owner:nil options:nil] lastObject];
    }
    
    if (indexPath.row == 0) {
        [cell.nameLabel setText:@"默认排序"];
    } else if (indexPath.row == 1) {
        [cell.nameLabel setText:@"发布 新->旧"];
    } else if (indexPath.row == 2) {
        [cell.nameLabel setText:@"价格 低->高"];
    } else if (indexPath.row == 3) {
        [cell.nameLabel setText:@"价格 高->低"];
    }
    
    if ([cell.nameLabel.text isEqualToString:self.selectedSortType]) {
        [cell.nameLabel setTextColor:ColorWithHex(0x00c88c, 1.0)];
        [cell.chooseImageView setHidden:NO];
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        self.selectedSortType = @"默认排序";
    } else if (indexPath.row == 1) {
        self.selectedSortType = @"发布 新->旧";
    } else if (indexPath.row == 2) {
        self.selectedSortType = @"价格 低->高";
    } else if (indexPath.row == 3) {
        self.selectedSortType = @"价格 高->低";
    }
    
    [self.sortTypeTableView reloadData];
    
    if (self.onSelectedSortTypeBlock) {
        self.onSelectedSortTypeBlock(self.selectedSortType, indexPath.row);
    }
}

@end

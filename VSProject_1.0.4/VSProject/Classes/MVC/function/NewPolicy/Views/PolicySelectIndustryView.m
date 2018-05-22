//
//  PolicySelectIndustryView.m
//  VSProject
//
//  Created by apple on 7/3/17.
//  Copyright © 2017 user. All rights reserved.
//

#import "PolicySelectIndustryView.h"
#import "SelectCityAndAreaCell.h"

@implementation PolicySelectIndustryView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self addSubview:self.industryTableView];
    return self;
}

- (UITableView *)industryTableView {
    if (!_industryTableView) {
        _industryTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_WIDTH__, self.frame.size.height)];
        [_industryTableView setBackgroundColor:ColorWithHex(0xefeff4, 0.0)];
        [_industryTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _industryTableView.delegate = self;
        _industryTableView.dataSource = self;
        
        _industryTableView.estimatedRowHeight = 0;
        _industryTableView.estimatedSectionHeaderHeight = 0;
        _industryTableView.estimatedSectionFooterHeight = 0;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackGround)];
        tap.delegate = self;
        [_industryTableView addGestureRecognizer:tap];
    }
    return _industryTableView;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[UITableView class]]) {
        return YES;
    }
    
    return  NO;
}

- (void)tapBackGround {
    if (self.onSelectedIndustyBlock) {
        self.onSelectedIndustyBlock(nil);
    }
}

- (void)onSetIndustyList:(NSArray *)industyList {
    IndustryModel *allModel = [[IndustryModel alloc] init];
    allModel.industryName = @"全部";
    allModel.industryCode = @"";
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:industyList];
    [tempArray insertObject:allModel atIndex:0];
    self.industryList = [NSArray arrayWithArray:tempArray];
    
    //默认全部
    self.selectedIndustry = allModel;
    
    [self.industryTableView reloadData];
}

#pragma mark - UITableViewDelegate && UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.industryList count];
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
    IndustryModel *i_model = [self.industryList objectAtIndex:[indexPath row]];
    [cell.nameLabel setText:i_model.industryName];
    if ([i_model isEqual:self.selectedIndustry]) {
        [cell.nameLabel setTextColor:ColorWithHex(0x00c88c, 1.0)];
        [cell.chooseImageView setHidden:NO];
    }
    
    return cell;
    

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    IndustryModel *i_model = [self.industryList objectAtIndex:[indexPath row]];
    self.selectedIndustry = i_model;
    
    [self.industryTableView reloadData];
    
    if (self.onSelectedIndustyBlock) {
        self.onSelectedIndustyBlock(self.selectedIndustry);
    }
}

@end

//
//  PolicySelectTimeView.m
//  VSProject
//
//  Created by apple on 7/3/17.
//  Copyright © 2017 user. All rights reserved.
//

#import "PolicySelectTimeView.h"
#import "SelectCityAndAreaCell.h"

@implementation PolicySelectTimeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self addSubview:self.timeTableView];
    
    self.selectedTime = @"当前政策未公示";
    
    return self;
}

- (UITableView *)timeTableView {
    if (!_timeTableView) {
        _timeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_WIDTH__, self.frame.size.height)];
        [_timeTableView setBackgroundColor:ColorWithHex(0xefeff4, 0.0)];
        [_timeTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _timeTableView.delegate = self;
        _timeTableView.dataSource = self;
        
        _timeTableView.estimatedRowHeight = 0;
        _timeTableView.estimatedSectionHeaderHeight = 0;
        _timeTableView.estimatedSectionFooterHeight = 0;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackGround)];
        tap.delegate = self;
        [_timeTableView addGestureRecognizer:tap];
    }
    return _timeTableView;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[UITableView class]]) {
        return YES;
    }
    
    return  NO;
}

- (void)tapBackGround {
    if (self.onSelectedTimeBlock) {
        self.onSelectedTimeBlock(nil);
    }
}

#pragma mark - UITableViewDelegate && UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
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
        [cell.nameLabel setText:@"当前政策未公示"];
    } else {
        [cell.nameLabel setText:@"历史政策已公示"];
    }
    
    if ([cell.nameLabel.text isEqualToString:self.selectedTime]) {
        [cell.nameLabel setTextColor:ColorWithHex(0x00c88c, 1.0)];
        [cell.chooseImageView setHidden:NO];
    }
    
    return cell;
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        self.selectedTime = @"当前政策未公示";
    } else {
        self.selectedTime = @"历史政策已公示";
    }
    
    [self.timeTableView reloadData];
    
    if (self.onSelectedTimeBlock) {
        self.onSelectedTimeBlock(self.selectedTime);
    }
}

@end

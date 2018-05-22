//
//  MyPolicyViewController.m
//  VSProject
//
//  Created by apple on 11/7/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "MyPolicyViewController.h"
#import "MyCollectedPolicyViewController.h"
#import "MyAppliedPolicyViewController.h"

@interface MyPolicyViewController ()

@end

@implementation MyPolicyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    [self vs_setTitleText:@"我的政策"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        //我的政策";
        MyAppliedPolicyViewController *vc = [[MyAppliedPolicyViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 1) {
        //我收藏的政策";
        MyCollectedPolicyViewController *vc = [[MyCollectedPolicyViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:identifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.textLabel.text = @"我的政策";
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5, __SCREEN_WIDTH__, 0.5)];
        [line setBackgroundColor:ColorWithHex(0xeeeeee, 1.0)];
        [cell addSubview:line];
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"我的收藏";
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5, __SCREEN_WIDTH__, 0.5)];
        [line setBackgroundColor:ColorWithHex(0xeeeeee, 1.0)];
        [cell addSubview:line];
    }
    
    return cell;
}

_GETTER_ALLOC_BEGIN(UITableView, tableView) {
    
    _tableView.frame = CGRectMake(0, 0, GetWidth(self.view), GetHeight(self.view));
    _tableView.backgroundColor = _COLOR_HEX(0xf1f1f1);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = (id<UITableViewDelegate>)self;
    _tableView.dataSource = (id<UITableViewDataSource>)self;
}
_GETTER_END(tableView)

@end

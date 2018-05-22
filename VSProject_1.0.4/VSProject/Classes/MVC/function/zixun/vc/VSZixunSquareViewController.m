//
//  VSZixunSquareViewController.m
//  VSProject
//
//  Created by tiezhang on 15/4/12.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSZixunSquareViewController.h"
#import "VSZixunSquareListCell.h"
#import "VSUIManager.h"

@interface VSZixunSquareViewController ()

_PROPERTY_NONATOMIC_STRONG(NSArray, vm_cellNameClasses);

@end

@implementation VSZixunSquareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self vs_setTitleText:@"资讯广场"];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];

    self.cellNameClasses = @[ [VSZixunSquareListCell class] ];
    
    self.dataSource = @[@[@"", @""]];
    
    [self vs_setExtraCellLineHidden];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [[VSUIManager shareInstance] vs_pushToZiXunDetail:@"http://news.sina.com.cn/c/2015-04-19/151231735179.shtml"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

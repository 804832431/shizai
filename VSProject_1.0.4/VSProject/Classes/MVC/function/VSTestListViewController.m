//
//  VSTestListViewController.m
//  VSProject
//
//  Created by tiezhang on 15/10/6.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSTestListViewController.h"
#import "VSTestListCell.h"


@interface VSTestListViewController ()

@end

@implementation VSTestListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.cellNameClasses = @[ [VSTestListCell class] ];
    
    self.dataSource = @[ @[@"njljlkl", @"jnnlklln"] ];
    [self vs_reloadData];
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

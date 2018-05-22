//
//  VSVisitListViewController.m
//  VSProject
//
//  Created by user on 15/3/2.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSVisitListViewController.h"

@interface VSVisitListViewController ()

@end

@implementation VSVisitListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self vs_setTitleText:@"他的访客"];
    
    self.dataSource = @[ @[@"", @"", @"", @"",@"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @""] ];
    
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

//
//  VSBaseAccountViewController.m
//  VSProject
//
//  Created by user on 15/3/1.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseAccountViewController.h"

@interface VSBaseAccountViewController ()<VSAccountBtnActionCellDelegate>

@end

@implementation VSBaseAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    VSView *headView = _ALLOC_OBJ_WITHFRAME_(VSView, _CGR(0, 0, GetWidth(self.tableView), 30));
    self.tableView.tableHeaderView = headView;
    
    [self vs_addTapGuesture];
}

- (void)vp_doTap:(UITapGestureRecognizer *)sender
{
    [self.view endEditing:YES];
}

#pragma mark -- TableViewControllerProtocol
- (NSArray*)vp_mutCellClasses
{
    return self.cellNameClasses;
}

#pragma mark -- VSAccountBtnActionCellDelegate
- (void)vp_btnActionClicked:(VSAccountBtnActionCell*)sender;
{
    if(self.vm_submitType == ACCOUNT_SUBMIT_LOGIN)
    {
        //TODO:发送登陆请求
        
    }
    else
    {
        //TODO:发送注册请求
    }
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

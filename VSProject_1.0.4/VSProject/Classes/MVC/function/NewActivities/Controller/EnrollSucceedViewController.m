//
//  EnrollSucceedViewController.m
//  VSProject
//
//  Created by apple on 10/17/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "EnrollSucceedViewController.h"
#import "SmallNewActivityCell.h"
#import "NewActivityDetailViewController.h"
#import "GreatActivityListViewController.h"
#import "NewMyActivityViewController.h"


@interface EnrollSucceedViewController ()

@end

@implementation EnrollSucceedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self vs_setTitleText:@"报名成功"];
    
    [self useLeftBarItem:YES back:^{
        [self vs_back];
    }];
    
    [self.nameLabel setText:[self.enrollment valueForKey:@"name"]];
    [self.phoneLabel setText:[self.enrollment valueForKey:@"number"]];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    SmallNewActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SmallNewActivityCell" owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setDataSource:self.a_model];
    return cell;
}

- (void)vs_back {
    NSLog(@"back action");
    
    NSArray *vcArray = self.navigationController.viewControllers;
    for (NSInteger i = 0; i < vcArray.count; i++) {
        VSBaseViewController *vc = [vcArray objectAtIndex:i];
        if ([vc isKindOfClass:[NewActivityDetailViewController class]]) {
             [self.navigationController popToViewController:vc animated:YES];
            break;
        }
    }
    
//    //返回发现页要刷新
//    VSBaseViewController *vcFx = [self.navigationController.viewControllers objectAtIndex:0];
//    if ([vcFx isKindOfClass:[GreatActivityListViewController class]]) {
//        ((GreatActivityListViewController *)vcFx).ifNeedRefresh = YES;
//    }
//    
//    VSBaseViewController *vc = [self.navigationController.viewControllers objectAtIndex:1];
//    if ([vc isKindOfClass:[NewActivityDetailViewController class]]) {
//        ((NewActivityDetailViewController *)vc).a_model = self.a_model;
//        [self.navigationController popToViewController:vc animated:YES];
//    } else if ([vc isKindOfClass:[NewMyActivityViewController class]]){
//        VSBaseViewController *vc2 = [self.navigationController.viewControllers objectAtIndex:3];
//        if ([vc2 isKindOfClass:[NewActivityDetailViewController class]]) {
//            ((NewActivityDetailViewController *)vc2).a_model = self.a_model;
//            [self.navigationController popToViewController:vc2 animated:YES];
//        }
//    }
}

@end

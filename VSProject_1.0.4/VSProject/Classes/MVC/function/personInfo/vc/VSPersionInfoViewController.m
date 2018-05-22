//
//  VSPersionInfoViewController.m
//  VSProject
//
//  Created by user on 15/2/26.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSPersionInfoViewController.h"
#import "UINavigationController+PersonPushVC.h"
#import "VSPersonHeadInfoCell.h"
#import "VSPersonInfoTitleCell.h"
#import "VSPersonInfoTitleWithButtonCell.h"
#import "VSPersonInfoSectionTitleView.h"
#import "VSMemberDataInfo.h"
#import "VSPersonInfoManager.h"
#import "VSPersonInfoItem.h"

@interface VSPersionInfoViewController ()<VSPersonInfoTitleWithButtonCellDelegate>

_PROPERTY_NONATOMIC_STRONG(NSArray, vm_cellNameClasses);

_PROPERTY_NONATOMIC_STRONG(NSArray, vm_sectionNameClasses);

_PROPERTY_NONATOMIC_STRONG(VSButton, vm_sendMessageButton);

@end

@implementation VSPersionInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self vs_setTitleText:@"个人信息"];
    
    CGFloat buttonHeight = 40.f;

    [self.view addSubview:self.tableView];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(-1 * buttonHeight));
        make.top.equalTo(@(0));
        
    }];
    
    [self.view addSubview:self.vm_sendMessageButton];
    [self.vm_sendMessageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(0));
        make.height.equalTo(@(buttonHeight));
        
    }];
    
    [self.vm_rightButton setTitle:@"关注" forState:UIControlStateNormal];
    [self vs_showRightButton:YES];
    
    VSPersonInfoItem *item0 = [[VSPersonInfoItem alloc]initWithTitle:@"身       高" value:@"175cm"];
    VSPersonInfoItem *item1 = [[VSPersonInfoItem alloc]initWithTitle:@"体       重" value:@"56kg"];
    VSPersonInfoItem *item2 = [[VSPersonInfoItem alloc]initWithTitle:@"学       历" value:@"本科"];
    VSPersonInfoItem *item3 = [[VSPersonInfoItem alloc]initWithTitle:@"职       业" value:nil];
    VSPersonInfoItem *item4 = [[VSPersonInfoItem alloc]initWithTitle:@"是否已婚" value:@"未婚"];

    
    NSArray *titles = @[ item0, item1, item2, item3 , item4 ];
    
    VSPersonInfoItem *item10 = [[VSPersonInfoItem alloc]initWithTitle:@"电       话" value:@"13337388887"];
    VSPersonInfoItem *item11 = [[VSPersonInfoItem alloc]initWithTitle:@"Q        Q" value:@"544832897"];
    VSPersonInfoItem *item12 = [[VSPersonInfoItem alloc]initWithTitle:@"微       信" value:nil];
    item12.vm_hasValue = NO;
    VSPersonInfoItem *item13 = [[VSPersonInfoItem alloc]initWithTitle:@"邮       箱" value:@"544832897@qq.com"];
    NSArray *title1s = @[ item10, item11, item12, item13  ];
    
    VSPersonInfoItem *item20 = [[VSPersonInfoItem alloc]initWithTitle:@"星       座" value:@"双鱼"];
    VSPersonInfoItem *item21 = [[VSPersonInfoItem alloc]initWithTitle:@"爱       好" value:@"暂无"];
    NSArray *title2s = @[ item20, item21 ];
    
    self.dataSource = @[ @[_ALLOC_OBJ_(VSMemberDataInfo)], titles, title1s, title2s];
    
    self.sectionViewDataSource = @[ @"", @"基本信息", @"联系方式", @"其他信息"];
    
}

- (void)vs_rightButtonAction:(id)sender
{
    //TODO:关注
    
//    //TODO:去访客列表
//    [self.navigationController vs_pushToVisitListVC];
}

- (void)vs_sendMessage:(id)sender
{
    [self.navigationController vs_pushToChatVC];
}

#pragma mark -- TableViewControllerProtocol
- (NSArray*)vp_mutCellClasses
{
    return self.vm_cellNameClasses;
}

- (NSArray*)vp_mutSectionClasses
{
    return self.vm_sectionNameClasses;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -- VSPersonInfoTitleWithButtonCellDelegate
- (void)personInfoCellCheckClicked:(VSPersonInfoTitleWithButtonCell *)sender
{
    RIButtonItem * okItem = [RIButtonItem itemWithLabel:@"认定她" action:^{
        
    }];
    
    RIButtonItem * cancelItem = [RIButtonItem itemWithLabel:@"再想想" action:^{
        
    }];
    
    UIAlertView  *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定需要消耗情豆查看吗？" cancelButtonItem:cancelItem otherButtonItems:okItem, nil];
    [alert show];
}

#pragma mark -- getter
_GETTER_BEGIN(NSArray, vm_cellNameClasses)
{
    _vm_cellNameClasses = @[
                            [VSPersonHeadInfoCell class],
                            [VSPersonInfoTitleCell class],
                            [VSPersonInfoTitleWithButtonCell class],
                            [VSPersonInfoTitleCell class]
                            ];
}
_GETTER_END(vm_cellNameClasses)

_GETTER_BEGIN(NSArray, vm_sectionNameClasses)
{
    _vm_sectionNameClasses = @[
                               [NSNull class],
                               [VSPersonInfoSectionTitleView class],
                               [VSPersonInfoSectionTitleView class],
                               [VSPersonInfoSectionTitleView class]
                               ];
}
_GETTER_END(vm_sectionNameClasses)

_GETTER_BEGIN(VSButton, vm_sendMessageButton)
{
    _vm_sendMessageButton = [VSButton buttonWithType:UIButtonTypeCustom];
    [_vm_sendMessageButton addTarget:self action:@selector(vs_sendMessage:) forControlEvents:UIControlEventTouchUpInside];
    [_vm_sendMessageButton setBackgroundColor:_RGB_A(253.f, 142.0f, 20.f, 1.f)];
    [_vm_sendMessageButton setTitleColor:kColor_ffffff forState:UIControlStateNormal];
    [_vm_sendMessageButton setTitle:@"聊天" forState:UIControlStateNormal];
    [_vm_sendMessageButton.titleLabel setFont:kSysFont_14];
}
_GETTER_END(vm_sendMessageButton)

- (void)didReceiveMemoryWarning
{
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

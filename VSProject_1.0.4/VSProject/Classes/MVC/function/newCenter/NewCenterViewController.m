//
//  NewCenterViewController.m
//  VSProject
//
//  Created by 陈 海涛 on 16/7/29.
//  Copyright © 2016年 user. All rights reserved.
//

#import "NewCenterViewController.h"
#import "CenterCell.h"
#import "PersonalInformationViewController.h"
#import "CenterManger.h"
#import "SettingViewController.h"
#import "ReceivingAddressViewController.h"
#import "ShoppingCartViewController.h"
#import "MyOrdersViewController.h"
#import "RTXMyAppointmentViewController.h"
#import "RTXUbanLeaseViewController.h"
#import "MyActivityViewController.h"
#import "MessageViewController.h"
#import "MessageManager.h"
#import "CouponViewController.h"
#import "NewCenterCell.h"
#import "NewCenterOrderViewController.h"
#import "NewEvaluateViewController.h"
#import "ManagementViewController.h"
#import "LDResisterManger.h"
#import "EnterpriseInfoViewController.h"
#import "NewMoreViewController.h"
#import "MyBidCenterViewController.h"
#import "NewMyActivityViewController.h"
#import "MyPolicyViewController.h"

@interface  NewCenterViewController ()
{
    
    NSArray *topPicArray;
    NSArray *topNameArray;
    NSArray *topSubNameArray;
    NSArray *superscriptArray;
    NSMutableArray *centerCellPicArray;
    NSMutableArray *centerCellNameArray;
    NSDictionary *personalDic;
    CenterManger *manger;
    dispatch_group_t requestGroup;
    
}

_PROPERTY_NONATOMIC_STRONG(UITableView, tableView)
_PROPERTY_NONATOMIC_STRONG(UIImageView, headImageView)
_PROPERTY_NONATOMIC_STRONG(UILabel, nickNameLabel)

@end

@implementation NewCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    requestGroup = dispatch_group_create();
    
    [self vs_showRightButton:YES];
    [self recoverRightButton];
    
    manger = [[CenterManger alloc]init];
    [self vs_setTitleText:@"我的"];
    
    topPicArray = @[@"订单中心－icon",@"我的购物车－icon",@"企业管理－icon",@"企业设置－icon",@"我的活动－icon",@"user_list_icon_red_n",@"icon_btn_green_n",@"我的优惠券－icon",@"我的收货地址－icon",@"更多－icon"];
    topNameArray = @[@"订单中心",@"我的购物车",@"企业管理",@"企业设置",@"我的活动",@"我的招投标",@"我的政策",@"我的优惠券",@"我的收货地址",@"更多"];
    topSubNameArray = @[@"查看全部订单",@"",@"",@"",@"",@"",@"",@"",@"",@""];
    //    centerCellPicArray = [NSMutableArray arrayWithObject:@[@"usercenter_16",@"usercenter_19",@"usercenter_freight",@"usercenter_13"]];
    //    [centerCellPicArray addObject:@[@""]];
    //    [centerCellPicArray addObject:@[@"0"]];
    //    
    //    centerCellNameArray = [NSMutableArray arrayWithObject:@[@"待付款",@"待发货",@"待收货",@"待退款"]];
    //    superscriptArray = @[];
    //    [centerCellNameArray addObject:@[@""]];
    //    [centerCellNameArray addObject:@[@"预约中"]];
    //    [centerCellNameArray addObject:@[@"已选5件商品"]];
    //    [centerCellNameArray addObject:@[@"南京市栖霞区紫金创意大厦"]];
    
    [self.view addSubview:self.tableView];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self requestCustomerInfo];
    [self requesthaveNewMessage];
    [self vs_showLoading];
    dispatch_group_notify(requestGroup, dispatch_get_main_queue(), ^{
        [self vs_hideLoadingWithCompleteBlock:nil];
    });
    
}
#define mark -- Private
-(void)recoverRightButton {
    
    self.navigationItem.rightBarButtonItem =nil;
    [self vs_showRightButton:YES];
    
    //    BOOL havNewMessage = [VSUserLogicManager shareInstance].userDataInfo.vm_haveNewMessage;
    //    if (havNewMessage) {
    //        [self.vm_rightButton setImage:[UIImage imageNamed:@"more_red"] forState:0];
    //    }else {
    //        [self.vm_rightButton setImage:[UIImage imageNamed:@"more"] forState:0];
    //    }
    
    [self.vm_rightButton setImage:[UIImage imageNamed:@"个人中心－设置－icon"] forState:0];
    
}
#pragma mark -- request

- (void)requestCustomerInfo {
    
    [_headImageView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"defaultHeadPic"] options:SDWebImageUnCached];
    
    dispatch_group_enter(requestGroup);
    [manger requestCustomerInfo:nil success:^(NSDictionary *responseObj) {
        dispatch_group_leave(requestGroup);
        //
        personalDic= [NSDictionary dictionaryWithDictionary:[responseObj vs_filterDictionary:responseObj]];
        NSString *headIconPath = [[personalDic objectForKey:@"headIconPath"] isEqual:[NSNull null]]?@"":[personalDic objectForKey:@"headIconPath"];
        NSString *nickName = [[personalDic objectForKey:@"nickName"] isEqual:[NSNull null]]?@"":[personalDic objectForKey:@"nickName"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_headImageView sd_setImageWithURL:[NSURL URLWithString:headIconPath] placeholderImage:[UIImage imageNamed:@"defaultHeadPic"] options:SDWebImageUnCached];
            _nickNameLabel.text = nickName?:nickName;
        });
        NSLog(@"personalDic---%@",personalDic);
    } failure:^(NSError *error) {
        dispatch_group_leave(requestGroup);
        //
        [self.view showTipsView:[error domain]];
    }];
}


- (void)requestCustomerMainData {
    
    dispatch_group_enter(requestGroup);
    
    [manger requestCustomerMainData:nil success:^(NSDictionary *responseObj) {
        dispatch_group_leave(requestGroup);
        //
        superscriptArray = @[[NSString stringWithFormat:@"%@",[responseObj objectForKey:@"noPayCount"]?:@"0"],[NSString stringWithFormat:@"%@",[responseObj objectForKey:@"processingCount"]?:@"0"],[NSString stringWithFormat:@"%@",[responseObj objectForKey:@"orderSentCount"]?:@"0"],[NSString stringWithFormat:@"%@",[responseObj objectForKey:@"refundProcessingCount"]?:@"0"]];
        centerCellPicArray[centerCellPicArray.count-1] = @[[NSString stringWithFormat:@"%@",[responseObj objectForKey:@"reservationCount"]?:@"0"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [_tableView reloadData];
        });
        
    } failure:^(NSError *error) {
        dispatch_group_leave(requestGroup);
        //
        [self.view showTipsView:[error domain]];
    }];
}

- (void)requesthaveNewMessage {
    
    MessageManager *messageManager = [[MessageManager alloc]init];
    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    
    if ([partyId isEmptyString]) {
        return;
    }
    [messageManager requesthaveNewMessage:nil success:^(NSDictionary *responseObj) {
        
        NSNumber *hasNewMessage = [responseObj objectForKey:@"hasNewMessage"];
        [self vs_showRightButton:YES];
        [VSUserLogicManager shareInstance].userDataInfo.vm_haveNewMessage = hasNewMessage.boolValue;
        [self recoverRightButton];
    } failure:^(NSError *error) {
        //
    }];
    
}
#pragma mark -- Action

- (void)vs_rightButtonAction:(id)sender
{
    NSArray *titles = @[@"设置",@"消息"];
    NSArray *images = @[@"usercenter_setting",@"message_icon"];
    BOOL havNewMessage = [VSUserLogicManager shareInstance].userDataInfo.vm_haveNewMessage;
    if (havNewMessage) {
        images = @[@"usercenter_setting",@"message_icon_red"];
    }else {
        images = @[@"usercenter_setting",@"message_icon"];
    }
    
    PopoverView *tmppopoverView = [[PopoverView alloc] initWithPoint:CGPointMake(MainWidth - self.vm_rightButton.frame.size.width, self.navigationController.navigationBar.frame.origin.y + self.vm_rightButton.frame.origin.y + self.vm_rightButton.frame.size.height - 1.0f) titles:titles images:images];
    tmppopoverView.selectRowAtIndex = ^(NSInteger index){
        if (index == 0) {
            [self actionSetting];
        }else if(index == 1){
            //消息
            [self message];
        }else {
            NSLog(@"have no action");
        }
        
    };
    [tmppopoverView show];
}

- (void)message {
    
    MessageViewController *controller = [[MessageViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}
- (void)vs_back {
    
    
    //    if (self.navigationController) {
    //        if (_className) {
    //            Class backClass = NSClassFromString(_className);
    //            for (UIViewController *temp in self.navigationController.viewControllers) {
    //                if ([temp isKindOfClass:[backClass class]]) {
    //                    [self.navigationController popToViewController:temp animated:YES];
    //                    break;
    //                }
    //            }
    //        }else if (_backWhere == CENTER_BACK_DEFAULT) {
    //            [self.navigationController popViewControllerAnimated:YES];
    //        }else {
    //            [self.navigationController popToRootViewControllerAnimated:YES];
    //        }
    //    }
    //    
    
    
}


- (void)actionSetting {
    
    SettingViewController *controller = [[SettingViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)actionHeadButton {
    
    PersonalInformationViewController *controller = [[PersonalInformationViewController alloc]init];
    controller.personalDic = personalDic;
    [self.navigationController pushViewController:controller animated:YES];
}

/*
 - (void)actionClickCell:(UIButton *)sender {
 
 switch (sender.tag) {
 case 0://我的订单
 {
 MyOrdersViewController *vc = [MyOrdersViewController new];
 
 vc.orderType = kOrderStatusAll;
 
 [self.navigationController pushViewController:vc animated:YES];
 }
 break;
 case 1://我的缴费
 {
 [self.view showTipsView:@"功能正在开发中……"];
 }
 break;
 case 2://我的预约
 {
 RTXMyAppointmentViewController *appointmentvc = [RTXMyAppointmentViewController new];
 [self.navigationController pushViewController:appointmentvc animated:YES];
 }
 break;
 
 case 3://购物车-查看全部
 {
 ShoppingCartViewController *vc = [[ShoppingCartViewController alloc] init];
 [self.navigationController pushViewController:vc animated:YES];
 }
 break;
 case 4://我的活动
 {
 MyActivityViewController *vc = [[MyActivityViewController alloc]init];
 [self.navigationController pushViewController:vc animated:YES];
 }
 break;
 case 5://我的优惠券
 {
 CouponViewController *vc = [[CouponViewController alloc]init];
 vc.titleName = @"我的优惠券";
 vc.key = @"all";
 [self.navigationController pushViewController:vc animated:YES];
 
 }
 break;
 case 6://收货地址-查看全部
 {
 ReceivingAddressViewController *controller = [[ReceivingAddressViewController alloc]init];
 [self.navigationController pushViewController:controller animated:YES];
 }
 break;
 
 case 100://待付款
 {
 MyOrdersViewController *vc = [MyOrdersViewController new];
 
 vc.orderType = kOrderStatusPaymentsDue;
 
 [self.navigationController pushViewController:vc animated:YES];
 }
 break;
 
 case 200://待发货
 {
 MyOrdersViewController *vc = [MyOrdersViewController new];
 
 vc.orderType = kOrderStatusPostGoodsDue;
 
 [self.navigationController pushViewController:vc animated:YES];
 }
 break;
 
 case 300://待收货
 {
 MyOrdersViewController *vc = [MyOrdersViewController new];
 
 vc.orderType = kOrderStatusReceiveGoodsDue;
 
 [self.navigationController pushViewController:vc animated:YES];
 }
 break;
 
 case 400://待退款
 {
 MyOrdersViewController *vc = [MyOrdersViewController new];
 
 vc.orderType = kOrderStatusRefundDue;
 
 [self.navigationController pushViewController:vc animated:YES];
 }
 break;
 
 case 102://预约中
 {
 //modify by Thomas [睿天下RUI-867][IOS用户端个人中心，预约中没有实现跳转功能]---start
 RTXMyAppointmentViewController *appointmentvc = [RTXMyAppointmentViewController new];
 [self.navigationController pushViewController:appointmentvc animated:YES];
 //modify by Thomas [睿天下RUI-867]---end
 }
 break;
 
 case 202://待评价
 {
 
 }
 break;
 
 default:
 break;
 }
 }
 */

#pragma mark -- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return topNameArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 49;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NewCenterCell class])];
    
    cell.flagImageView.image = [UIImage imageNamed:topPicArray[indexPath.row]];
    
    cell.contentTitleLabel.text = topNameArray[indexPath.row];
    
    cell.contentDescLabel.text = topSubNameArray[indexPath.row];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [UIView new];
    view.backgroundColor = _Colorhex(0xf1f1f1);
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = _Colorhex(0xdedede);
    lineView.frame = CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width, 0.5);
    
    [view addSubview:lineView];
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *title = topNameArray[indexPath.row];
    
    //[@"订单中心",@"我的购物车",@"企业管理",@"企业设置",@"我的活动",@"我的优惠券",@"我的收货地址",@"更多"]
    if ([title isEqualToString:@"订单中心"]) {
        NewCenterOrderViewController  *vc = [NewCenterOrderViewController new];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([title isEqualToString:@"我的购物车"]) {
        
        ShoppingCartViewController *vc  = [ShoppingCartViewController new];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([title isEqualToString:@"企业管理"]) {
        
        NSString *partyId =[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId;
        
        NSDictionary *dic = @{@"partyId":partyId};
        LDResisterManger *ldmanger = [[LDResisterManger alloc]init];
        [self vs_showLoading];
        [ldmanger requestInviaterRole:dic success:^(NSDictionary *responseObj) {
            [self vs_hideLoadingWithCompleteBlock:nil];
            
            if ([[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.roleInCompany isEqualToString:@"admin"]) {
                ManagementViewController *vc = [[ManagementViewController alloc] init];
                
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                [self.view showTipsView:@"对不起，您没有管理员权限"];
            }
            
        } failure:^(NSError *error) {
            [self vs_hideLoadingWithCompleteBlock:nil];
            [self.view showTipsView:@"对不起，您没有管理员权限"];
        }];
        
        
        
        
    }else if ([title isEqualToString:@"企业设置"]) {
        
        NSString *partyId =[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId;
        
        NSDictionary *dic = @{@"partyId":partyId};
        LDResisterManger *ldmanger = [[LDResisterManger alloc]init];
        [self vs_showLoading];
        [ldmanger requestInviaterRole:dic success:^(NSDictionary *responseObj) {
            [self vs_hideLoadingWithCompleteBlock:nil];
            
            if ([[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.roleInCompany isEqualToString:@"admin"]) {
                EnterpriseInfoViewController *vc = [[EnterpriseInfoViewController alloc] init];
                [self.navigationController pushViewController:vc  animated:YES];
            }else{
                [self.view showTipsView:@"对不起，您没有管理员权限"];
            }
            
        } failure:^(NSError *error) {
            [self vs_hideLoadingWithCompleteBlock:nil];
            [self.view showTipsView:@"对不起，您没有管理员权限"];
        }];
        
        
        
    }else if ([title isEqualToString:@"我的活动"]) {
        NewMyActivityViewController *vc = [[NewMyActivityViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([title isEqualToString:@"我的招投标"]) {
        
        MyBidCenterViewController *vc = [[MyBidCenterViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([title isEqualToString:@"我的政策"]) {
        
        MyPolicyViewController *vc = [[MyPolicyViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([title isEqualToString:@"我的优惠券"]) {
        
        CouponViewController *vc = [[CouponViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([title isEqualToString:@"我的收货地址"]) {
        
        ReceivingAddressViewController *vc = [[ReceivingAddressViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([title isEqualToString:@"更多"]) {
        NewMoreViewController *vc = [[NewMoreViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}


_GETTER_ALLOC_BEGIN(UITableView, tableView) {
    
    UIButton *headButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [headButton setBackgroundImage:[UIImage imageNamed:@"usercenter_02"] forState:0];
    [headButton setBackgroundImage:[UIImage imageNamed:@"usercenter_02"] forState:1];
    headButton.frame = CGRectMake(0, 0, MainWidth, 135);
    [headButton addTarget:self action:@selector(actionHeadButton) forControlEvents:UIControlEventTouchUpInside];
    
    _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake((MainWidth-60)/2, 20, 60, 60)];
    _headImageView.layer.cornerRadius = 30;
    _headImageView.layer.borderWidth = 1.5f;
    _headImageView.layer.borderColor = _COLOR_HEX(0x76d9b3).CGColor;
    _headImageView.backgroundColor = _COLOR_CLEAR;
    _headImageView.clipsToBounds = YES;
    [_headImageView sd_setImageWithString:@"" placeholderImage:[UIImage imageNamed:@"defaultHeadPic"]];
    [headButton addSubview:_headImageView];
    
    _nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, OffSetY(_headImageView)+8.5, MainWidth-40, 16)];
    _nickNameLabel.backgroundColor = [UIColor clearColor];
    _nickNameLabel.textAlignment = NSTextAlignmentCenter;
    _nickNameLabel.textColor = _COLOR_WHITE;
    _nickNameLabel.font = FONT_TITLE(16);
    _nickNameLabel.numberOfLines = 1;
    [headButton addSubview:_nickNameLabel];
    
    
    UIView *topView = [UIView new];
    topView.backgroundColor = _Colorhex(0x6bc7ab);
    topView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.5);
    [headButton addSubview:topView];
    
    
    UIImageView *detailImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"用户详情－icon"]];
    detailImageView.frame = CGRectMake(MainWidth - 12 - 8, 45, 8, 16);
    [headButton addSubview:detailImageView];
    
    _tableView.frame = CGRectMake(0, 0, GetWidth(self.view), GetHeight(self.view));
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = (id<UITableViewDelegate>)self;
    _tableView.dataSource = (id<UITableViewDataSource>)self;
    _tableView.tableHeaderView = headButton;
    _tableView.backgroundColor = _Colorhex(0xf1f1f1);
    
    [_tableView registerClass:[NewCenterCell class] forCellReuseIdentifier:NSStringFromClass([NewCenterCell class])];
    
}
_GETTER_END(tableView)


@end

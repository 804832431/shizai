//
//  NewActivityDetailViewController.m
//  VSProject
//
//  Created by apple on 10/17/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "NewActivityDetailViewController.h"
#import "EnrollStepOneViewController.h"
#import "NewActivitiesManager.h"
#import "CompleteEnrollInfoViewController.h"

@interface NewActivityDetailViewController ()
{
    dispatch_group_t requestGroup;
    NewActivitiesManager *manager;
}

_PROPERTY_NONATOMIC_STRONG(UIButton, collectButton);
_PROPERTY_NONATOMIC_STRONG(UIButton, enrollButton);

@end

@implementation NewActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.webTitle = @"活动详情";
    [self vs_setTitleText:self.webTitle];
    
    [self.navigationController.navigationBar addSubview:self.collectButton];
    
    [self.view addSubview:self.enrollButton];
    requestGroup = dispatch_group_create();
    manager = [[NewActivitiesManager alloc] init];
}

- (void)webViewFinishLoad {
    BOOL canGoBack = [self webViewCanGoBack];
    if (canGoBack) {
        [self.enrollButton setHidden:YES];
        [self.collectButton setHidden:YES];
        [self vs_showRightButton:NO];
        [self vs_setTitleText:@"已报名的人"];
    } else {
        [self.enrollButton setHidden:NO];
        [self.collectButton setHidden:NO];
        [self vs_showRightButton:YES];
        [self vs_setTitleText:@"活动详情"];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(webViewFinishLoad) name:NoticeName_WebViewDidLoadMsg object:nil];
    [self.collectButton setHidden:NO];
    [self.enrollButton setHidden:NO];
    [self vs_showRightButton:YES];
    [self.vm_rightButton setImage:[UIImage imageNamed:@"btn_nav_share_n"] forState:UIControlStateNormal];
    [self.vm_rightButton setImage:[UIImage imageNamed:@"btn_nav_share_h"] forState:UIControlStateHighlighted];
    
    [self refresh];
    [self loadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.collectButton setHidden:YES];
    [self.collectButton removeFromSuperview];
    [self.enrollButton setHidden:YES];
    [self vs_showRightButton:NO];
}

//@property (nonatomic,copy)NSString <Optional>*userEncrollStatus;	//用户报名状态	"HAS_ENCROLL:已报名 NOT_ENCROLL:未报名"
//@property (nonatomic,copy)NSString <Optional>*encrollStatus;	//活动报名状态	NOT_START：即将报名，STARTED：报名中，COMPLETED：报名结束'
//@property (nonatomic,copy)NSString <Optional>*activityStatus;	//活动状态	DELETED，已删除，NOT_START：未开始，STARTED：已开始，COMPLETED：已结束',
//@property (nonatomic,copy)NSString <Optional>*isCollected;	//"是否已收藏 Y:是 N:否
//@property (nonatomic,copy)NSString <Optional>*isCompleteEncrollInfo;	 //是否已完善报名信息	"Y:是 N:否"
- (void)loadData {
    //判断是否收藏
    if ([self.a_model.isCollected isEqualToString:@"Y"]) {
        [_collectButton setImage:__IMAGENAMED__(@"nav_btn_Collection_h") forState:UIControlStateNormal];
    } else if ([self.a_model.isCollected isEqualToString:@"N"]) {
        [_collectButton setImage:__IMAGENAMED__(@"nav_btn_Collection_n") forState:UIControlStateNormal];
    }
    
    if ([self.a_model.activityStatus isEqualToString:@"STARTED"]) {
        //活动进行中，只提示未报名和已报名.
        if ([self.a_model.userEncrollStatus isEqualToString:@"HAS_ENCROLL"]) {
            [self.enrollButton setTitle:@"已报名" forState:UIControlStateNormal];
            [self.enrollButton setTitleColor:ColorWithHex(0x999999, 1.0) forState:UIControlStateNormal];
            [self.enrollButton setBackgroundColor:ColorWithHex(0xe0e0e0, 1.0)];
            [self.enrollButton setEnabled:NO];
        } else if ([self.a_model.userEncrollStatus isEqualToString:@"NOT_ENCROLL"]) {
            [self.enrollButton setTitle:@"未报名" forState:UIControlStateNormal];
            [self.enrollButton setTitleColor:ColorWithHex(0x999999, 1.0) forState:UIControlStateNormal];
            [self.enrollButton setBackgroundColor:ColorWithHex(0xe0e0e0, 1.0)];
            [self.enrollButton setEnabled:NO];
        }
    } else if ([self.a_model.activityStatus isEqualToString:@"NOT_START"]) {
        //活动还未开始，先判断活动的报名状态，再判断用户自己的报名状态
        if ([self.a_model.encrollStatus isEqualToString:@"NOT_START"]) {
            //还未开始报名
            [self.enrollButton setTitle:@"即将开始报名" forState:UIControlStateNormal];
            [self.enrollButton setTitleColor:ColorWithHex(0x999999, 1.0) forState:UIControlStateNormal];
            [self.enrollButton setBackgroundColor:ColorWithHex(0xe0e0e0, 1.0)];
            [self.enrollButton setEnabled:NO];
        } else if ([self.a_model.encrollStatus isEqualToString:@"STARTED"]) {
            //报名中,判断用户是否报名
            if ([self.a_model.userEncrollStatus isEqualToString:@"HAS_ENCROLL"]) {
                //用户已报名，判断用户是否完善了信息
                if ([self.a_model.isCompleteEncrollInfo isEqualToString:@"Y"]) {
                    [self.enrollButton setTitle:@"已报名" forState:UIControlStateNormal];
                    [self.enrollButton setTitleColor:ColorWithHex(0x999999, 1.0) forState:UIControlStateNormal];
                    [self.enrollButton setBackgroundColor:ColorWithHex(0xe0e0e0, 1.0)];
                    [self.enrollButton setEnabled:NO];
                } else if ([self.a_model.isCompleteEncrollInfo isEqualToString:@"N"]) {
                    [self.enrollButton setTitle:@"完善信息" forState:UIControlStateNormal];
                    [self.enrollButton setTitleColor:ColorWithHex(0xffffff, 1.0) forState:UIControlStateNormal];
                    [self.enrollButton setBackgroundColor:ColorWithHex(0x01c78c, 1.0)];
                    [self.enrollButton addTarget:self action:@selector(completeEnrollInfo) forControlEvents:UIControlEventTouchUpInside];
                    [self.enrollButton setEnabled:YES];
                }
            } else if ([self.a_model.userEncrollStatus isEqualToString:@"NOT_ENCROLL"]) {
                //用户还未报名
                [self.enrollButton setTitle:@"立即报名" forState:UIControlStateNormal];
                [self.enrollButton setTitleColor:ColorWithHex(0xffffff, 1.0) forState:UIControlStateNormal];
                [self.enrollButton setBackgroundColor:ColorWithHex(0x01c78c, 1.0)];
                [self.enrollButton addTarget:self action:@selector(enrollRightNow) forControlEvents:UIControlEventTouchUpInside];
                [self.enrollButton setEnabled:YES];
            }
        } else if ([self.a_model.encrollStatus isEqualToString:@"COMPLETED"]) {
            //报名已结束，判断用户是否报名
            if ([self.a_model.userEncrollStatus isEqualToString:@"HAS_ENCROLL"]) {
                [self.enrollButton setTitle:@"已报名" forState:UIControlStateNormal];
                [self.enrollButton setTitleColor:ColorWithHex(0x999999, 1.0) forState:UIControlStateNormal];
                [self.enrollButton setBackgroundColor:ColorWithHex(0xe0e0e0, 1.0)];
                [self.enrollButton setEnabled:NO];
            } else if ([self.a_model.userEncrollStatus isEqualToString:@"NOT_ENCROLL"]) {
                [self.enrollButton setTitle:@"未报名" forState:UIControlStateNormal];
                [self.enrollButton setTitleColor:ColorWithHex(0x999999, 1.0) forState:UIControlStateNormal];
                [self.enrollButton setBackgroundColor:ColorWithHex(0xe0e0e0, 1.0)];
                [self.enrollButton setEnabled:NO];
            }
        }
    } else if ([self.a_model.activityStatus isEqualToString:@"COMPLETED"]) {
        if ([self.a_model.userEncrollStatus isEqualToString:@"HAS_ENCROLL"]) {
            [self.enrollButton setTitle:@"已报名" forState:UIControlStateNormal];
            [self.enrollButton setTitleColor:ColorWithHex(0x999999, 1.0) forState:UIControlStateNormal];
            [self.enrollButton setBackgroundColor:ColorWithHex(0xe0e0e0, 1.0)];
            [self.enrollButton setEnabled:NO];
        } else if ([self.a_model.userEncrollStatus isEqualToString:@"NOT_ENCROLL"]) {
            [self.enrollButton setTitle:@"未报名" forState:UIControlStateNormal];
            [self.enrollButton setTitleColor:ColorWithHex(0x999999, 1.0) forState:UIControlStateNormal];
            [self.enrollButton setBackgroundColor:ColorWithHex(0xe0e0e0, 1.0)];
            [self.enrollButton setEnabled:NO];
        }
    }
    
//    //test
//    [self.enrollButton addTarget:self action:@selector(completeEnrollInfo) forControlEvents:UIControlEventTouchUpInside];
//    [self.enrollButton setEnabled:YES];
}

- (void)startRequest {
    
    dispatch_group_enter(requestGroup);
    
}
- (void)endRequest {
    
    dispatch_group_leave(requestGroup);
    
}

- (void)enrollRightNow {
    [self.enrollButton setEnabled:NO];
    
    //调报名接口，获取订单号
    [self startRequest];
    
    [manager onEnrollRightNow:[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"" activityId:self.a_model.activityId success:^(NSDictionary *responseObj) {
        NSError *err;
        NewActivityModel *actModel;
        actModel = [[NewActivityModel alloc] initWithDictionary:[responseObj objectForKey:@"activity"] error:&err];
        self.a_model.orderId = actModel.orderId;
        
        [self endRequest];
        
        //立即报名成功
        if ([actModel.chargeType isEqualToString:@"free"]) {
            //免费活动报名成功，去完善信息
            CompleteEnrollInfoViewController *vc = [[CompleteEnrollInfoViewController alloc] initWithNibName:@"CompleteEnrollInfoViewController" bundle:nil];
            vc.a_model = actModel;
            [self.navigationController pushViewController:vc animated:YES];
        } else if ([actModel.chargeType isEqualToString:@"charge"]) {
            //收费活动报名成功，去下一步支付页面
            EnrollStepOneViewController * stepOneVC = [[EnrollStepOneViewController alloc] initWithNibName:@"EnrollStepOneViewController" bundle:nil];
            stepOneVC.a_model = self.a_model;
            [self.navigationController pushViewController:stepOneVC animated:YES];
        }
        
        [self.enrollButton setEnabled:YES];
        
    } failure:^(NSError *error) {
        [self endRequest];
        
        [self.view showTipsView:[error domain]];
        
        [self.enrollButton setEnabled:YES];
    }];
}

- (void)completeEnrollInfo {
    //跳转完善信息
    CompleteEnrollInfoViewController *vc = [[CompleteEnrollInfoViewController alloc] initWithNibName:@"CompleteEnrollInfoViewController" bundle:nil];
    vc.a_model = self.a_model;
    [self.navigationController pushViewController:vc animated:YES];
}

- (UIButton *)enrollButton {
    if (!_enrollButton) {
        _enrollButton = [[UIButton alloc] initWithFrame:CGRectMake(0, GetHeight(self.view) -49 - 64, __SCREEN_WIDTH__, 49)];
        [_enrollButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [_enrollButton setTitleColor:ColorWithHex(0xffffff, 1.0) forState:UIControlStateNormal];
        [_enrollButton setBackgroundColor:[UIColor redColor]];
    }
    return _enrollButton;
}

- (UIButton *)collectButton {
    if (!_collectButton) {
        _collectButton = [[UIButton alloc] initWithFrame:CGRectMake(__SCREEN_WIDTH__ - 65, 7, 30, 30)];
        [_collectButton setImage:__IMAGENAMED__(@"nav_btn_Collection_n") forState:UIControlStateNormal];
        [_collectButton addTarget:self action:@selector(collectionAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectButton;
}

- (void)collectionAction {
    //收藏动作
    [self startRequest];
    NSString *action;
    if ([self.a_model.isCollected isEqualToString:@"Y"]) {
        action = @"0";
    } else if ([self.a_model.isCollected isEqualToString:@"N"]) {
        action = @"1";
    }

    [manager onCollectActivity:[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"" activityId:self.a_model.activityId action:action success:^(NSDictionary *responseObj) {
        if ([self.a_model.isCollected isEqualToString:@"Y"]) {
            self.a_model.isCollected = @"N";
        }else{
            self.a_model.isCollected = @"Y";
        }
        
        if ([self.a_model.isCollected isEqualToString:@"Y"]) {
            [self.collectButton setImage:[UIImage imageNamed:@"nav_btn_Collection_h"] forState:UIControlStateNormal];
        }else{
            [self.collectButton setImage:[UIImage imageNamed:@"nav_btn_Collection_n"] forState:UIControlStateNormal];
        }
        NSString *tittle = [action isEqualToString:@"1"] ? @"收藏成功！":@"取消收藏成功！";
        [self.view showTipsView:tittle];
        [self endRequest];
    } failure:^(NSError *error) {
        [self endRequest];
        [self.view showTipsView:[error domain]];
    }];
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

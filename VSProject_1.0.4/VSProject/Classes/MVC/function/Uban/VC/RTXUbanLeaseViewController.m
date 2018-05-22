

//
//  RTXUbanLeaseViewController.m
//  VSProject
//
//  Created by certus on 16/4/14.
//  Copyright © 2016年 user. All rights reserved.
//

#import "RTXUbanLeaseViewController.h"
#import "RTXLeaseListViewController.h"
#import "RTXMyUbanViewController.h"
#import "MessageManager.h"
#import "MessageViewController.h"

@interface RTXUbanLeaseViewController () {

    RTXLeaseListViewController *vc1;
    RTXMyUbanViewController *vc2;
}

@property (strong, nonatomic) IBOutlet UISegmentedControl *segment;
@property (strong, nonatomic) IBOutlet UIButton *redBtn;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation RTXUbanLeaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self vs_setTitleText:@"租赁"];

    [self readjust];
    [self recoverRightButton];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)readjust {

    self.redBtn.clipsToBounds = YES;
    self.redBtn.layer.cornerRadius = 5;
    BOOL hasUnreadFWZL=[VSUserLogicManager shareInstance].userDataInfo.vm_hasUnreadFWZL;
    [self.redBtn setHidden:!hasUnreadFWZL];

    [self.segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    _segment.selectedSegmentIndex = 0;

    self.scrollView.contentSize = CGSizeMake(MainWidth*2, 0);
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.delegate = (id<UIScrollViewDelegate>)self;
    self.scrollView.autoresizesSubviews = NO;

    vc1 = [[RTXLeaseListViewController alloc]init];
    vc1.view.frame = CGRectMake(0, 0, MainWidth, self.scrollView.bounds.size.height);
    vc1.nav = self.navigationController;
    [self.scrollView addSubview:vc1.view];

    vc2 = [[RTXMyUbanViewController alloc]init];
    vc2.delegate = (id<RTXMyUbanViewControllerDelegate>)self;
    vc2.view.frame = CGRectMake(MainWidth, 0, MainWidth, self.view.bounds.size.height);
    vc2.nav = self.navigationController;
    [self.scrollView addSubview:vc2.view];
    
    [vc1.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView.mas_right);
        make.top.equalTo(self.scrollView.mas_top);
        make.width.equalTo(self.scrollView.mas_width);
        make.height.equalTo(self.scrollView.mas_height);
    }];
    [vc2.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView.mas_right).offset(MainWidth);
        make.top.equalTo(self.scrollView.mas_top);
        make.width.equalTo(self.scrollView.mas_width);
        make.height.equalTo(self.scrollView.mas_height);
    }];

}

- (void)segmentAction:(UISegmentedControl *)sctrl {
    
    NSInteger index = sctrl.selectedSegmentIndex;

    CGPoint offsetPoint = CGPointMake(MainWidth*index, 0);
    [self.scrollView setContentOffset:offsetPoint animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    NSInteger index = 0;
    float offsetx = scrollView.contentOffset.x/MainWidth;
    if (offsetx > 0.5) {
        index = 1;
    }else {
        index = 0;
    }
    
    _segment.selectedSegmentIndex = index;
    
    CGPoint offsetPoint = CGPointMake(MainWidth*index, 0);
    [_scrollView setContentOffset:offsetPoint animated:YES];
    
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    
    NSInteger index = 0;
    float offsetx = scrollView.contentOffset.x/MainWidth;
    if (offsetx > 0.5) {
        index = 1;
    }else {
        index = 0;
    }
    
    CGPoint offsetPoint = CGPointMake(MainWidth*index, 0);
    [_scrollView setContentOffset:offsetPoint animated:YES];
    
}

- (void)refreshRedPoint {

    BOOL hasUnreadFWZL=[VSUserLogicManager shareInstance].userDataInfo.vm_hasUnreadFWZL;
    [self.redBtn setHidden:!hasUnreadFWZL];

}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self requesthaveNewMessage];
    [vc1 refresh];
    [vc2 refresh];
}

#pragma mark -- 右上角消息

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

- (void)message {
    
    MessageViewController *controller = [[MessageViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)recoverRightButton {
    
    self.navigationItem.rightBarButtonItem =nil;
    [self vs_showRightButton:YES];
    
    BOOL havNewMessage = [VSUserLogicManager shareInstance].userDataInfo.vm_haveNewMessage;
    if (havNewMessage) {
        [self.vm_rightButton setImage:[UIImage imageNamed:@"more_red"] forState:0];
    }else {
        [self.vm_rightButton setImage:[UIImage imageNamed:@"more"] forState:0];
    }
}

//重写右侧按钮点击事件
- (void)vs_rightButtonAction:(id)sender
{
    NSArray *titles = @[@"个人首页",@"消息"];
    NSArray *images = @[@"home_icon",@"message_icon"];
    BOOL havNewMessage = [VSUserLogicManager shareInstance].userDataInfo.vm_haveNewMessage;
    if (havNewMessage) {
        images = @[@"home_icon",@"message_icon_red"];
    }else {
        images = @[@"home_icon",@"message_icon"];
    }
    
    PopoverView *tmppopoverView = [[PopoverView alloc] initWithPoint:CGPointMake(MainWidth - self.vm_rightButton.frame.size.width, self.navigationController.navigationBar.frame.origin.y + self.vm_rightButton.frame.origin.y + self.vm_rightButton.frame.size.height - 1.0f) titles:titles images:images];
    tmppopoverView.selectRowAtIndex = ^(NSInteger index){
        if (index == 0) {
            //返回首页
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else if(index == 1){
            //消息
            [self message];
        }else {
            NSLog(@"have no action");
        }
        
    };
    [tmppopoverView show];
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

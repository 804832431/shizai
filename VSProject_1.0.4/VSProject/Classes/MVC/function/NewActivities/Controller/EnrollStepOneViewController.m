//
//  EnrollStepOneViewController.m
//  VSProject
//
//  Created by apple on 10/17/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "EnrollStepOneViewController.h"
#import "EnrollStepTwoViewController.h"

@interface EnrollStepOneViewController ()

@end

@implementation EnrollStepOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self vs_setTitleText:@"立即报名"];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData {
    [self.titleLabel setText:self.a_model.title];
    [self.addressLabel setText:self.a_model.activityLocation];
    [self.activityImageView sd_setImageWithString:self.a_model.smallImage placeholderImage:[UIImage imageNamed:@"activity_list_default"]];
    
    //时间处理
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    //转化string到date
    NSDate *date = [dateFormatter dateFromString:self.a_model.activityStartTime];
    //输出格式为：09.14 14:00
    NSDateFormatter *displayFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [displayFormatter setDateFormat:@"MM.dd HH:mm"];
    NSString *dateString = [displayFormatter stringFromDate:date];
    NSLog(@"%@",dateString);
    [self.timeLabel setText:dateString];
    
    //费用状态逻辑 //费用类型	"free：免费 charge：收费"  费用（元/人）
    if ([self.a_model.chargeType isEqualToString:@"free"]) {
        [self.chargeLabel setText:@"免费"];
        [self.totalChargeLabel setText:@"合计：免费"];
    } else if ([self.a_model.chargeType isEqualToString:@"charge"]) {
        [self.chargeLabel setText:[NSString stringWithFormat:@"￥%@",self.a_model.charge]];
        [self.totalChargeLabel setText:[NSString stringWithFormat:@"合计：￥%@",self.a_model.charge]];
    }
}

- (IBAction)nextStepAction:(id)sender {
    if ([self.a_model.chargeType isEqualToString:@"charge"]) {
        //去第二步选择支付方式的页面
        EnrollStepTwoViewController *enrollStepTwoViewController = [[EnrollStepTwoViewController alloc] initWithNibName:@"EnrollStepTwoViewController" bundle:nil];
        enrollStepTwoViewController.a_model = self.a_model;
        [self.navigationController pushViewController:enrollStepTwoViewController animated:YES];
    } else if ([self.a_model.chargeType isEqualToString:@"free"]) {
        //免费活动直接调用接口进行报名
    }
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

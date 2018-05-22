//
//  GreatActivityDetailViewController.m
//  VSProject
//
//  Created by certus on 16/1/20.
//  Copyright © 2016年 user. All rights reserved.
//

#import "GreatActivityDetailViewController.h"
#import "GreatActivityDetailView.h"
#import "SignupViewController.h"
#import "ActivitiesManager.h"
#import "GreatActivityCell.h"
#import "VSUserLoginViewController.h"

@interface GreatActivityDetailViewController () {
    
    ActivitiesManager *manger;
    
}

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UIImageView *angleImageView;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) IBOutlet UIImageView *headImageView;

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) IBOutlet UILabel *adressLabel;

@property (strong, nonatomic) IBOutlet UILabel *limiteCountLabel;

@property (strong, nonatomic) IBOutlet UILabel *chargeLabel;

@property (strong, nonatomic) IBOutlet UILabel *contactLabel;

@property (strong, nonatomic) IBOutlet UILabel *contactPersonLabel;

@property (strong, nonatomic) IBOutlet UILabel *endTimeLabel;

@property (strong, nonatomic) IBOutlet UILabel *detailLabel;

@property (strong, nonatomic) IBOutlet UIButton *commitBtn;

@end

@implementation GreatActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GreatActivityDetailView *gaview = [[GreatActivityDetailView alloc]initWithFrame:CGRectMake(0, 64, MainWidth, MainHeight-84)];
    gaview.backgroundColor = [UIColor whiteColor];
    //    [self.view addSubview:gaview];
    // Do any additional setup after loading the view from its nib.
    manger = [[ActivitiesManager alloc]init];
    
    [self vs_setTitleText:@"活动详情"];
    //    [self vs_showRightButton:YES];
    //    [self.vm_rightButton setImage:[UIImage imageNamed:@"nav_share"] forState:UIControlStateNormal];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [_commitBtn setHidden:YES];
    [_commitBtn addTarget:self action:@selector(actionCommit) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self requestGreatActivityDetail];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)actionCommit {
    [self userlogin:LOGIN_BACK_DEFAULT popVc:self animated:YES LoginSucceed:^{
        SignupViewController *vc = [[SignupViewController alloc]init];
        vc.a_model = _a_model;
        [self.navigationController pushViewController:vc animated:YES];
    } cancel:^{
        
    }];
}

- (void)requestGreatActivityDetail {
    
    [self vs_showLoading];
    NSDictionary *para = @{@"activityId":_a_model.id};
    [manger requestGreatActivityDetail:para success:^(NSDictionary *responseObj) {
        //
        [self vs_hideLoadingWithCompleteBlock:nil];
        [self loadContent:responseObj];
        
    } failure:^(NSError *error) {
        //
        [self vs_hideLoadingWithCompleteBlock:nil];
        [self.view showTipsView:[error domain]];
    }];
    
}

- (void)loadContent:(NSDictionary *)dic {
    
    if ([dic isKindOfClass:[NSDictionary class]]) {
        
        NSNumber *allowEnroll = [dic objectForKey:@"allowEnroll"];
        if (allowEnroll.intValue == 0) {
            [_commitBtn setHidden:YES];
        }else {
            [_commitBtn setHidden:NO];
        }
        
        ActivityModel *a_model = [[ActivityModel alloc]initWithDictionary:[dic objectForKey:@"activity"] error:nil];
        //        NSString *imagePath = [NSString stringWithFormat:@"%@%@",[dic objectForKey:@"imagePrefix"],a_model.detailImage];
        NSString *imagePath = a_model.detailImage;
        [_headImageView sd_setImageWithString:imagePath placeholderImage:[UIImage imageNamed:@""]];
        
        _nameLabel.text = a_model.title;
        _timeLabel.text = a_model.description;
        self.timeLabel.text = [NSString stringWithFormat:@"活动时间：%@",[NSDate timeMinutes:a_model.eventTime.longLongValue]];
        _adressLabel.text = [NSString stringWithFormat:@"活动地点：%@",a_model.eventLocation];
        
        NSNumber *enrollmentNumber = [dic objectForKey:@"enrollmentNumber"];
        NSString *limiteS = @"";
        if (a_model.personMax.intValue == 0) {
            limiteS = [NSString stringWithFormat:@"限制人数：不限（%d人已报名）",enrollmentNumber.intValue];
        }else {
            limiteS = [NSString stringWithFormat:@"限制人数：%@人（%d人已报名）",a_model.personMax,enrollmentNumber.intValue];
        }
        
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:limiteS];
        [attString beginEditing];
        NSRange rangeL = [limiteS rangeOfString:@"（"];
        NSRange rangeR = [limiteS rangeOfString:@"）"];
        [attString addAttribute:NSForegroundColorAttributeName value:_COLOR_HEX(0xf15353) range:NSMakeRange(rangeL.location+1,rangeR.location-rangeL.location-1)];
        _limiteCountLabel.attributedText = attString;
        [attString endEditing];
        
        _chargeLabel.text = [NSString stringWithFormat:@"活动费用：￥%@元/人",a_model.charge];
        _contactLabel.text = [NSString stringWithFormat:@"联系方式：%@",a_model.contactNumber];
        _contactPersonLabel.text = [NSString stringWithFormat:@"联系人：%@",a_model.contact];
        _endTimeLabel.text = [NSString stringWithFormat:@"报名截止时间：%@",[NSDate timeMinutes:a_model.enrollmentTime.longLongValue]];
        _detailLabel.text = a_model.a_description;
        
        NSString *status = a_model.status;
        switch (status.intValue) {
            case PRE_PUBLISH:
                _angleImageView.image = [UIImage imageNamed:@"content_signup"];
                break;
                
            case PRE_START:
                _angleImageView.image = [UIImage imageNamed:@"content_signup"];
                break;
                
            case START:
                _angleImageView.image = [UIImage imageNamed:@"content_carriedout"];
                break;
                
            case END:
                _angleImageView.image = [UIImage imageNamed:@"content_ended"];
                break;
                
            default:
                _angleImageView.image = [UIImage imageNamed:@"content_ended"];
                break;
        }
        
    }
}
//重写右侧按钮点击事件
//- (void)vs_rightButtonAction:(id)sender{
//    [self shareClicked];
//}

@end

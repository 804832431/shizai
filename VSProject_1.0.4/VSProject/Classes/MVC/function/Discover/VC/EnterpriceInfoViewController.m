//
//  EnterpriceInfoViewController.m
//  VSProject
//
//  Created by pch_tiger on 17/1/7.
//  Copyright © 2017年 user. All rights reserved.
//

#import "EnterpriceInfoViewController.h"
#import "JoinEntrepreneurClubViewController.h"
#import "UIColor+TPCategory.h"

@interface EnterpriceInfoViewController ()

@property (nonatomic, strong) UIButton *flowButton;

@end

@implementation EnterpriceInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.shouldShowOneKeyConsign = YES;
    self.shouldShouContactCustomService = YES;
    self.edgesForExtendedLayout = 0;
    
    [self.view addSubview:self.flowButton];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self setNavBarBackggroupImageWithColor:self.barColorStr];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage imageNamed:@"bg_nav_white"] stretchableImageWithLeftCapWidth:1 topCapHeight:1] forBarMetrics:UIBarMetricsDefault];
    
}

- (void)setNavBarBackggroupImageWithColor:(NSString *)colorStr {
    
    if (colorStr) {
        UIImage *navBarBackgroupImage = [self createImageWithColor:[UIColor colorWithHexString:colorStr]];
        
        [self.navigationController.navigationBar setBackgroundImage:[navBarBackgroupImage stretchableImageWithLeftCapWidth:1 topCapHeight:1] forBarMetrics:UIBarMetricsDefault];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)hideFlow {
    
    self.flowButton.hidden = YES;
    [self.flowButton removeFromSuperview];
}

- (UIButton *)flowButton {
    
    if (!_flowButton) {
        _flowButton = [[UIButton alloc]initWithFrame:CGRectMake(MainWidth - 76.0f, MainHeight - 44.0f - 75.0f, 75.0f, 75.0f)];
        _flowButton.backgroundColor = [UIColor clearColor];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(0, 0, 75.0f, 75.0f);
        imageView.image = [UIImage imageNamed:@"btn_round"];
        [_flowButton addSubview:imageView];
        
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.frame = CGRectMake(10.0f, 10.0f, 55.0f, 55.0f);
        textLabel.font = [UIFont systemFontOfSize:18.0f];
        textLabel.textColor = [UIColor whiteColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.numberOfLines = 0;
        textLabel.text = @"我要\n加入";
        [_flowButton addSubview:textLabel];
        
        [_flowButton addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _flowButton.hidden = NO;
    }
    return _flowButton;
}

- (void)addAction:(UIButton *)button {
    [self userlogin:LOGIN_BACK_DEFAULT popVc:self animated:YES LoginSucceed:^{
        JoinEntrepreneurClubViewController *vc = [[JoinEntrepreneurClubViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } cancel:^{
        
    }];
}

- (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, MainWidth, 64.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *myImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGContextClearRect(context, rect);
    
    return myImage;
}

@end

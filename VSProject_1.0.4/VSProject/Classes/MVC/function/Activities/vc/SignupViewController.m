//
//  SignupViewController.m
//  VSProject
//
//  Created by certus on 16/1/20.
//  Copyright © 2016年 user. All rights reserved.
//

#import "SignupViewController.h"
#import "ActivitiesManager.h"
#import "CompleteSignupViewController.h"


@interface SignupViewController () {
    
    ActivitiesManager *manger;
    
}

@property (strong, nonatomic) IBOutlet UITextField *textField1;

@property (strong, nonatomic) IBOutlet UITextField *textField2;

@property (strong, nonatomic) IBOutlet UITextField *textField3;

@property (strong, nonatomic) IBOutlet UITextView *textView;

@property (strong, nonatomic) IBOutlet UIButton *commitBtn;

@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self vs_setTitleText:@"活动报名"];
    manger = [[ActivitiesManager alloc]init];
    
    [self readjust];
}

- (void)readjust {
    
    _textField1.layer.cornerRadius = 5.f;
    _textField1.layer.borderWidth = 1.f;
    _textField1.layer.borderColor = _Colorhex(0xd0d2d2).CGColor;
    
    _textField2.layer.cornerRadius = 5.f;
    _textField2.layer.borderWidth = 1.f;
    _textField2.layer.borderColor = _Colorhex(0xd0d2d2).CGColor;
    _textField2.text = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.username;
    
    _textField3.layer.cornerRadius = 5.f;
    _textField3.layer.borderWidth = 1.f;
    _textField3.layer.borderColor = _Colorhex(0xd0d2d2).CGColor;
    
    _textView.layer.cornerRadius = 5.f;
    _textView.layer.borderWidth = 1.f;
    _textView.layer.borderColor = _Colorhex(0xd0d2d2).CGColor;
    
    [_commitBtn addTarget:self action:@selector(actionCommit) forControlEvents:UIControlEventTouchUpInside];
}

- (void)actionCommit {
    
    NSString *name = _textField1.text;
    NSString *phoneNumber = _textField2.text;
    NSString *personCount = _textField3.text;
    NSString *comment = _textView.text;
    float charge = _a_model.charge.floatValue;
    float amount  = charge *personCount.intValue;
    
    if ([name isEmptyString]) {
        [self.view showTipsView:@"请填写您的姓名！"];
        return;
    }
    if ([phoneNumber isEmptyString]) {
        [self.view showTipsView:@"请填写您的电话！"];
        return;
    }
    if ([personCount isEmptyString]) {
        [self.view showTipsView:@"请填写参加人数！"];
        return;
    }
    int nameCount = 0;
    for (int i = 0; i < name.length; i++) {
        unichar c = [name characterAtIndex:i];
        if (c >=0x4E00 && c <=0x9FFF) {//汉字
            nameCount = nameCount + 2;
        }else {
            nameCount = nameCount + 1;
        }
    }
    if (nameCount > 40) {
        [self.view showTipsView:@"姓名不能超过40个字符！"];
        return;
    }
    if (phoneNumber.length > 11) {
        [self.view showTipsView:@"手机号超出限制长度！"];
        return;
    }
    if (personCount.integerValue > 999) {
        [self.view showTipsView:@"人数超出限制！"];
        return;
    }
    if (![JudgmentUtil validateInteger:personCount]) {
        [self.view showTipsView:@"请输入正整数！"];
        return;
    }
    int commentCount = 0;
    for (int i = 0; i < comment.length; i++) {
        unichar c = [comment characterAtIndex:i];
        if (c >=0x4E00 && c <=0x9FFF) {//汉字
            commentCount = commentCount + 2;
        }else {
            commentCount = commentCount + 1;
        }
    }
    if (commentCount > 200) {
        [self.view showTipsView:@"备注不能超过100个汉字！"];
        return;
    }
    
    NSDictionary *dic = @{@"activityId":_a_model.id,@"name":name,@"number":phoneNumber,@"person":personCount,@"amount":[NSString stringWithFormat:@"%.2f",amount],@"comment":comment};
    [self requestSignUp:dic];
    
}

- (void)requestSignUp:(NSDictionary *)dic {
    
    [self vs_showLoading];
    [manger requestSignupActivity:dic success:^(NSDictionary *responseObj) {
        //
        [self vs_hideLoadingWithCompleteBlock:nil];
        NSString *resultCode = [responseObj objectForKey:@"resultCode"];
        if (![resultCode isEqual:[NSNull null]] && resultCode && [resultCode isEqualToString:@"CODE-00000"]) {
            [self pushToCompleteSignup];
        }
        
    } failure:^(NSError *error) {
        //
        [self vs_hideLoadingWithCompleteBlock:nil];
        [self.view showTipsView:[error domain]];
    }];
    
}

- (void)pushToCompleteSignup {
    
    CompleteSignupViewController *vc = [[CompleteSignupViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
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

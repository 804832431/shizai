//
//  LDResisterViewController.m
//  VSProject
//
//  Created by YaoJun on 15/10/28.
//  Copyright © 2015年 user. All rights reserved.
//

#import "LDResisterViewController.h"
#import "PicPlaceholerView.h"
#import "LDCompleteRegisterViewController.h"
#import "LDResisterManger.h"
#import "AgreementViewController.h"
#import "TagsSelectViewController.h"

@interface LDResisterViewController () {

    LDResisterManger *manger;
    UIButton *sendButton;
    int timecount;
}


@end

@implementation LDResisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _checked = YES;
    [self vs_setTitleText:@"注册"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *navBarBackgroupImage = [self createImageWithColor:ColorWithHex(0xf9f9f9, 1.0)];
    [self.navigationController.navigationBar setBackgroundImage:[navBarBackgroupImage stretchableImageWithLeftCapWidth:1 topCapHeight:1] forBarMetrics:UIBarMetricsDefault];
    
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
//    [imageView setImage:__IMAGENAMED__(@"me_login_bg")];
//    [self.view insertSubview:imageView aboveSubview:self.view];

    manger = [[LDResisterManger alloc]init];
    NSNotificationCenter * animation = [NSNotificationCenter defaultCenter];
    [animation addObserver:self selector:@selector(isArrivedTime) name:@"YZMTIMER" object:nil];

    [self addHeaderView];
//    [self.view addSubview:self.backButton];
    [self.view addSubview:self.phoneTextfield];
    [self.view addSubview:self.verificationCodeTextfield];
    [self.view addSubview:self.passwordTextfield];
    [self.view addSubview:self.surePasswordTextfield];
    [self.view addSubview:self.enterpriceTextfield];
    [self.view addSubview:self.checkButton];
    [self.view addSubview:self.agreementButton];
    [self.view addSubview:self.registerButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [self.view endEditing:YES];
}

- (void)addHeaderView {
    UIView *headView = [[UIView alloc] init];
    headView.frame = CGRectMake(0, 0, MainWidth, 145.0f);
    headView.backgroundColor = [UIColor clearColor];
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.frame = CGRectMake((MainWidth - 125.0f)/2, 38.0f, 125.0f, 47.0f);
    iconImageView.image = [UIImage imageNamed:@"logo-"];
    [headView addSubview:iconImageView];
    
    [self.view addSubview:headView];
}

#pragma mark -- Public

- (void)pushToComplete {

    LDCompleteRegisterViewController *crc = [[LDCompleteRegisterViewController alloc]init];
    [self.navigationController pushViewController:crc animated:YES];

}
#pragma mark -- action
-(BOOL)isArrivedTime{
    NSUserDefaults *timeDefaults = [NSUserDefaults standardUserDefaults];
    NSDate *OldData = nil;
    if ([[timeDefaults objectForKey:@"YZMtimer"] isKindOfClass:[NSDate class]])
    {
        OldData = (NSDate *)[timeDefaults objectForKey:@"YZMtimer"];
        NSTimeInterval  timeInterval = [OldData timeIntervalSinceNow];
        timeInterval = -timeInterval;
        NSLog(@"%d",(int)timeInterval);
        if ((int)timeInterval >= 60) {
            timecount = 1;
            return YES;
        }
        else{
            return NO;
        }
    }
    return NO;
}

- (void)timerFired
{
    [sendButton setTitle:[NSString stringWithFormat:@"%ds重新获取",timecount--] forState:0];
    if (timecount==1||timecount<1) {
        [_timer invalidate];
        _timer = nil;
        
        [sendButton setTitle:@"获取验证码" forState:0];
        sendButton.userInteractionEnabled = YES;
    }else{
        sendButton.userInteractionEnabled = NO;
    }
}

- (void)actionSender {
    

    NSString *phoneNumber = _phoneTextfield.textField.text;
    if (![JudgmentUtil validateMobile:phoneNumber]) {
        [self.view showTipsView:@"请填写正确的手机号" afterDelay:1.5];
    }else {
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:phoneNumber,@"cellphone", nil];
        [self vs_showLoading];
        [manger requestSendCaptcha:dic success:^(NSDictionary *responseObj) {
            //
            [self vs_hideLoadingWithCompleteBlock:^{
                [self.view showTipsView:@"发送成功"];
            }];
        } failure:^(NSError *error) {
            
            [self vs_hideLoadingWithCompleteBlock:^{
                [self.view showTipsView:[error domain]];
                [_timer invalidate];
                _timer = nil;

                [sendButton setTitle:@"获取验证码" forState:0];
                sendButton.userInteractionEnabled = YES;
            }];
        }];

    }
    timecount=60;
    NSUserDefaults *timeDefaults = [NSUserDefaults standardUserDefaults];
    NSDate * olddate=[NSDate date];
    [timeDefaults setObject:olddate forKey:@"YZMtimer"];
    [timeDefaults synchronize];
    [self.timer fire];

}

- (void)actionCheck {
    
    if (!_checked) {
        _checked = YES;
        [_checkButton setImage:[UIImage imageNamed:@"register_agree"] forState:UIControlStateNormal];
    }else {
        _checked = NO;
        [_checkButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    [self canRegister];

}

- (void)actionRegister {
    [MobClick event:@"register"];

    if (![JudgmentUtil validateMobile:_phoneTextfield.textField.text]){//手机号
        [self.view showTipsView:@"请填写正确的手机号"];
    }else if (![JudgmentUtil validatePassword:_passwordTextfield.textField.text]){//密码
        [self.view showTipsView:@"请输入6-15位字母或数字组合"];
    }else if (![_passwordTextfield.textField.text isEqualToString:_surePasswordTextfield.textField.text]) {//确认密码
        [self.view showTipsView:@"密码输入不一致"];
    }else if (_verificationCodeTextfield.textField.text.length == 0) {//验证码
        [self.view showTipsView:@"请输入验证码"];
    }else if (!_checked) {
        [self.view showTipsView:@"同意《时在APP注册协议才可注册》"];//勾选
    }else {
        [manger requestRegister:self];
    }
    
}

- (BOOL)canRegister{

    BOOL havePhone = ![_phoneTextfield.textField.text isEmptyString];
    BOOL havePassword = ![_passwordTextfield.textField.text isEmptyString];
    BOOL haveSurePassword = ![_surePasswordTextfield.textField.text isEmptyString];
    BOOL haveVerification = ![_verificationCodeTextfield.textField.text isEmptyString];
    BOOL haveCheck = _checked;

    if (havePhone && havePassword && haveSurePassword && haveVerification && haveCheck) {
        _registerButton.alpha = 1.0;
        [_registerButton setEnabled:YES];
        _registerButton.layer.borderColor = _COLOR_HEX(0x09aa89).CGColor;

        return YES;
    }else {
        _registerButton.alpha = 0.4;
        [_registerButton setEnabled:NO];
        _registerButton.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
        
        return NO;
    }
}

- (void)actionAgreement {

    AgreementViewController *controller = [[AgreementViewController alloc]init];
    controller.titleName = @"用户服务条款";
    controller.resourceName = @"Agreement";
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark -- UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    // 改变图标
    switch (textField.tag) {
        case 101:

                self.phoneTextfield.leftImageView.image = [UIImage imageNamed:@"login_icon_phone_h"];
            
            break;
            
        case 102:

                self.verificationCodeTextfield.leftImageView.image = [UIImage imageNamed:@"login_icon_-verification_h"];
            
            break;
            
        case 103:

                self.passwordTextfield.leftImageView.image = [UIImage imageNamed:@"login_icon_--password_h"];
            
            break;
            
        case 104:

                self.surePasswordTextfield.leftImageView.image = [UIImage imageNamed:@"login_icon_--password_h"];
            
            break;
            
        case 105:

                self.enterpriceTextfield.leftImageView.image = [UIImage imageNamed:@"login_icon_-qy_h"];
            
            break;
            
        default:
            break;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    // 改变图标
    switch (textField.tag) {
        case 101:
            if ([textField.text length] == range.length && [string length] < 1) {
                self.phoneTextfield.leftImageView.image = [UIImage imageNamed:@"login_icon_phone_n"];
            }
            else {
                self.phoneTextfield.leftImageView.image = [UIImage imageNamed:@"login_icon_phone_h"];
            }
            break;
            
        case 102:
            if ([textField.text length] == range.length && [string length] < 1) {
                self.verificationCodeTextfield.leftImageView.image = [UIImage imageNamed:@"login_icon_-verification_n"];
            }
            else {
                self.verificationCodeTextfield.leftImageView.image = [UIImage imageNamed:@"login_icon_-verification_h"];
            }
            break;
            
        case 103:
            if ([textField.text length] == range.length && [string length] < 1) {
                self.passwordTextfield.leftImageView.image = [UIImage imageNamed:@"login_icon_--password_n"];
            }
            else {
                self.passwordTextfield.leftImageView.image = [UIImage imageNamed:@"login_icon_--password_h"];
            }
            break;
            
        case 104:
            if ([textField.text length] == range.length && [string length] < 1) {
                self.surePasswordTextfield.leftImageView.image = [UIImage imageNamed:@"login_icon_--password_n"];
            }
            else {
                self.surePasswordTextfield.leftImageView.image = [UIImage imageNamed:@"login_icon_--password_h"];
            }
            break;
            
        case 105:
            if ([textField.text length] == range.length && [string length] < 1) {
                self.enterpriceTextfield.leftImageView.image = [UIImage imageNamed:@"login_icon_-qy_n"];
            }
            else {
                self.enterpriceTextfield.leftImageView.image = [UIImage imageNamed:@"login_icon_-qy_h"];
            }
            break;
            
        default:
            break;
    }

    if (textField.tag == 101) {//判断手机号码
        NSString *phoneNumber = [NSString stringWithFormat:@"%@%@",textField.text,string];
        if ([JudgmentUtil validateMobile:phoneNumber]) {
            [sendButton setEnabled:YES];
            sendButton.alpha = 1.0;
            return YES;
        }else if ([JudgmentUtil validateMobile:textField.text] && string.length>0) {
            return NO;
        }else{
            sendButton.alpha = 0.4;
            [sendButton setEnabled:NO];
            return YES;
        }
    }else {
        return YES;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {

    // 改变图标
    switch (textField.tag) {
        case 101:
            self.phoneTextfield.leftImageView.image = [UIImage imageNamed:@"login_icon_phone_n"];
            break;
            
        case 102:
            self.verificationCodeTextfield.leftImageView.image = [UIImage imageNamed:@"login_icon_-verification_n"];
            break;
            
        case 103:
            self.passwordTextfield.leftImageView.image = [UIImage imageNamed:@"login_icon_--password_n"];
            break;
            
        case 104:
            self.surePasswordTextfield.leftImageView.image = [UIImage imageNamed:@"login_icon_--password_n"];
            break;
            
        case 105:
            self.enterpriceTextfield.leftImageView.image = [UIImage imageNamed:@"login_icon_-qy_n"];
            break;
            
        default:
            break;
    }
    
    [self canRegister];
    if (![JudgmentUtil validateMobile:textField.text] && textField.tag == 101){//手机号
        [self.view showTipsView:@"请填写正确的手机号"];
    }else if (![JudgmentUtil validatePassword:textField.text] && textField.tag == 102){//密码
        [self.view showTipsView:@"请输入6-15位字母或数字组合"];
    }else if (![_passwordTextfield.textField.text isEqualToString:textField.text] && textField.tag == 103) {//确认密码
        [self.view showTipsView:@"密码输入不一致"];
    }
}
#pragma mark -- getter


_GETTER_ALLOC_BEGIN(NSTimer, timer){
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
    //        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    //        [[NSRunLoop currentRunLoop] run];
    }
    
_GETTER_END(timer)

_GETTER_ALLOC_BEGIN(UIButton, backButton){
    
    _backButton = [[UIButton alloc] init];
    _backButton.frame = CGRectMake(25.0f, 30.0f, 12.0f, 20.0f);
    [_backButton setBackgroundImage:[UIImage imageNamed:@"login_back_bg"] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
}
_GETTER_END(backButton)

_GETTER_ALLOC_BEGIN(PicPlaceholerView, phoneTextfield){

    _phoneTextfield.frame = CGRectMake(25.0f, 145.0f, MainWidth - 25.0f*2, 55);
    _phoneTextfield.backgroundColor = [UIColor clearColor];
    NSString *holderText = @"请输入11位手机号";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:_COLOR_HEX(0x999999)
                        range:NSMakeRange(0, holderText.length)];
    [placeholder addAttribute:NSFontAttributeName
                        value:[UIFont boldSystemFontOfSize:15]
                        range:NSMakeRange(0, holderText.length)];
    _phoneTextfield.textField.attributedPlaceholder = placeholder;
    [_phoneTextfield.textField setTextAlignment:NSTextAlignmentLeft];
    _phoneTextfield.textField.delegate = (id<UITextFieldDelegate>)self;
    _phoneTextfield.textField.tag = 101;
    _phoneTextfield.textField.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTextfield.leftImageView.image = [UIImage imageNamed:@"login_icon_phone_n"];

}
_GETTER_END(phoneTextfield)

_GETTER_ALLOC_BEGIN(PicPlaceholerView, verificationCodeTextfield){
    
    _verificationCodeTextfield.frame = CGRectMake(25.0f, OffSetY(self.phoneTextfield), MainWidth - 25.0f*2, 55);
    _verificationCodeTextfield.backgroundColor = [UIColor clearColor];
    NSString *holderText = @"请输入验证码";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:_COLOR_HEX(0x999999)
                        range:NSMakeRange(0, holderText.length)];
    [placeholder addAttribute:NSFontAttributeName
                        value:[UIFont boldSystemFontOfSize:15]
                        range:NSMakeRange(0, holderText.length)];
    _verificationCodeTextfield.textField.attributedPlaceholder = placeholder;
    [_verificationCodeTextfield.textField setTextAlignment:NSTextAlignmentLeft];
    _verificationCodeTextfield.leftImageView.image = [UIImage imageNamed:@"login_icon_-verification_n"];
    _verificationCodeTextfield.textField.delegate = (id<UITextFieldDelegate>)self;
    _verificationCodeTextfield.textField.tag = 102;
    _verificationCodeTextfield.textField.keyboardType = UIKeyboardTypeNumberPad;
    sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.backgroundColor = [UIColor clearColor];
    sendButton.frame = CGRectMake(MainWidth - 25.0f*2 - 75.0f, GetHeight(_verificationCodeTextfield)/2-15, 75.0f, 29);
    sendButton.layer.cornerRadius = 5.f;
    [sendButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [sendButton setTitleColor:_COLOR_HEX(0x212121) forState:UIControlStateNormal];
    sendButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
    sendButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    [sendButton addTarget:self action:@selector(actionSender) forControlEvents:UIControlEventTouchUpInside];
    [_verificationCodeTextfield addSubview:sendButton];
    sendButton.alpha = 0.4;
    [sendButton setEnabled:NO];

}
_GETTER_END(verificationCodeTextfield)

_GETTER_ALLOC_BEGIN(PicPlaceholerView, passwordTextfield){
    
    _passwordTextfield.frame = CGRectMake(25.0f, OffSetY(self.verificationCodeTextfield), MainWidth - 25.0f*2, 55);
    _passwordTextfield.backgroundColor = [UIColor clearColor];
    NSString *holderText = @"请输入密码";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:_COLOR_HEX(0x999999)
                        range:NSMakeRange(0, holderText.length)];
    [placeholder addAttribute:NSFontAttributeName
                        value:[UIFont boldSystemFontOfSize:15]
                        range:NSMakeRange(0, holderText.length)];
    _passwordTextfield.textField.attributedPlaceholder = placeholder;
    [_passwordTextfield.textField setTextAlignment:NSTextAlignmentLeft];
    _passwordTextfield.textField.delegate = (id<UITextFieldDelegate>)self;
    _passwordTextfield.textField.tag = 103;
    _passwordTextfield.textField.keyboardType = UIKeyboardTypeAlphabet;
    _passwordTextfield.textField.secureTextEntry = YES;
    _passwordTextfield.leftImageView.image = [UIImage imageNamed:@"login_icon_--password_n"];
}
_GETTER_END(passwordTextfield)


_GETTER_ALLOC_BEGIN(PicPlaceholerView, surePasswordTextfield){
    
    _surePasswordTextfield.frame = CGRectMake(25.0f, OffSetY(self.passwordTextfield), MainWidth - 25.0f*2, 55);
    _surePasswordTextfield.backgroundColor = [UIColor clearColor];
    NSString *holderText = @"确认密码";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:_COLOR_HEX(0x999999)
                        range:NSMakeRange(0, holderText.length)];
    [placeholder addAttribute:NSFontAttributeName
                        value:[UIFont boldSystemFontOfSize:15]
                        range:NSMakeRange(0, holderText.length)];
    _surePasswordTextfield.textField.attributedPlaceholder = placeholder;
    [_surePasswordTextfield.textField setTextAlignment:NSTextAlignmentLeft];
    _surePasswordTextfield.textField.delegate = (id<UITextFieldDelegate>)self;
    _surePasswordTextfield.textField.tag = 104;
    _surePasswordTextfield.textField.keyboardType = UIKeyboardTypeAlphabet;
    _surePasswordTextfield.textField.secureTextEntry = YES;
    _surePasswordTextfield.leftImageView.image = [UIImage imageNamed:@"login_icon_--password_n"];
}
_GETTER_END(surePasswordTextfield)

_GETTER_ALLOC_BEGIN(PicPlaceholerView, enterpriceTextfield) {
    _enterpriceTextfield.frame = CGRectMake(25.0f, OffSetY(self.surePasswordTextfield), MainWidth - 25.0f*2, 55);
    _enterpriceTextfield.backgroundColor = [UIColor clearColor];
    NSString *holderText = @"请输入企业名称，仅企业应用";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:_COLOR_HEX(0x999999)
                        range:NSMakeRange(0, holderText.length)];
    [placeholder addAttribute:NSFontAttributeName
                        value:[UIFont boldSystemFontOfSize:15]
                        range:NSMakeRange(0, holderText.length)];
    _enterpriceTextfield.textField.attributedPlaceholder = placeholder;
    [_enterpriceTextfield.textField setTextAlignment:NSTextAlignmentLeft];
    _enterpriceTextfield.textField.delegate = (id<UITextFieldDelegate>)self;
    _enterpriceTextfield.textField.tag = 105;
    _enterpriceTextfield.textField.keyboardType = UIKeyboardTypeDefault;
    _enterpriceTextfield.textField.secureTextEntry = NO;
    _enterpriceTextfield.leftImageView.image = [UIImage imageNamed:@"login_icon_-qy_n"];
}
_GETTER_END(enterpriceTextfield)

_GETTER_ALLOC_BEGIN(UIButton, checkButton){
    
    _checkButton.frame = CGRectMake(25.0f, OffSetY(self.enterpriceTextfield)+14.0f, 14, 14);
    _checkButton.layer.masksToBounds = YES;
    _checkButton.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
    _checkButton.layer.borderWidth = 0.5f;
    _checkButton.layer.cornerRadius = 2.0f;
    [_checkButton setImage:[UIImage imageNamed:@"register_agree"] forState:UIControlStateNormal];
    [_checkButton addTarget:self action:@selector(actionCheck) forControlEvents:UIControlEventTouchUpInside];
}
_GETTER_END(checkButton)

_GETTER_ALLOC_BEGIN(UIButton, agreementButton){
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"同意《时在APP注册协议》"];
    NSRange strRange2 = {0,2};
    NSRange strRange = {2,[str length]-2};
    [str addAttribute:NSForegroundColorAttributeName value:_COLOR_HEX(0x212121) range:strRange2];
    [str addAttribute:NSForegroundColorAttributeName value:_COLOR_HEX(0x09aa89) range:strRange];
    
    _agreementButton.frame = CGRectMake(40, OffSetY(self.enterpriceTextfield)+14.0f, 160, 13);
    _agreementButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
    _agreementButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    [_agreementButton setTitleColor:_COLOR_HEX(0x09aa89) forState:0];
    [_agreementButton setAttributedTitle:str forState:0];
    [_agreementButton addTarget:self action:@selector(actionAgreement) forControlEvents:UIControlEventTouchUpInside];
}
_GETTER_END(agreementButton)

_GETTER_ALLOC_BEGIN(UIButton, registerButton){
    
    _registerButton.frame = CGRectMake(25, OffSetY(self.agreementButton)+37.0f, __SCREEN_WIDTH__ - 50, 44);

    [_registerButton setBackgroundColor:[UIColor clearColor]];
    [_registerButton setBackgroundImage:[self createImageWithColor:_Colorhex(0x8aebcc)] forState:UIControlStateNormal];
    [_registerButton setBackgroundImage:[self createImageWithColor:_Colorhex(0x3cdeaa)] forState:UIControlStateHighlighted];
    [_registerButton setTitleColor:_COLOR_HEX(0x333333) forState:UIControlStateNormal];
    [_registerButton setTitleColor:_COLOR_HEX(0x333333) forState:UIControlStateDisabled];

    [_registerButton.titleLabel setFont:[UIFont systemFontOfSize:18.0f]];
    _registerButton.layer.masksToBounds = YES;
//    _registerButton.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
    _registerButton.layer.borderWidth = 0.0f;
    _registerButton.layer.cornerRadius = 4.0f;
    
    [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
    _registerButton.titleLabel.font = [UIFont systemFontOfSize:18.f];
    [_registerButton addTarget:self action:@selector(actionRegister) forControlEvents:UIControlEventTouchUpInside];
    
    [_registerButton setEnabled:NO];

}
_GETTER_END(registerButton)

- (void)backAction:(UIButton *)button {
    
    [self vs_back];
}

- (void)pushTagsSelect {
    
    TagsSelectViewController *vc = [[TagsSelectViewController alloc] init];
    vc.tagsFrom = TAGS_FROM_REGISTER;
//    __weak typeof(self)weakself = self;
//    [vc setSkipBlock:^() {
//        [weakself pushToComplete];
//    }];
    [self.navigationController pushViewController:vc animated:YES];
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

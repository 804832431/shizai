//
//  VSUserHeadCell.m
//  VSProject
//
//  Created by user on 15/2/27.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSUserHeadCell.h"
#import "VSMemberDataInfo.h"

@interface VSUserHeadCell ()

@property (weak, nonatomic) IBOutlet UIImageView *vm_headAvar;
@property (weak, nonatomic) IBOutlet UILabel *vm_name;
@property (weak, nonatomic) IBOutlet UILabel *vm_accountPre;
@property (weak, nonatomic) IBOutlet UILabel *vm_accountText;

_PROPERTY_NONATOMIC_STRONG(VSView, vm_gbLoginView);
_PROPERTY_NONATOMIC_STRONG(VSButton, vm_btnLogin);
_PROPERTY_NONATOMIC_STRONG(VSButton, vm_btnRegister);

//钱包view
_PROPERTY_NONATOMIC_STRONG(VSView, vm_lineTop);
_PROPERTY_NONATOMIC_STRONG(VSView, vm_walletView);
_PROPERTY_NONATOMIC_STRONG(VSLabel, vm_douTitleLabel);
_PROPERTY_NONATOMIC_STRONG(VSView, vm_lineSp);
_PROPERTY_NONATOMIC_STRONG(VSLabel, vm_huaTitleLabel);

@end

@implementation VSUserHeadCell

- (void)vp_setInit
{
    [super vp_setInit];
    //TODO：设置样式
    [self.contentView setBackgroundColor:kColor_ffffff];
    
    UIColor *fontColor = kColor_333333;

    [self.vm_name           setFont:kSysFont_14];
    [self.vm_name           setTextColor:fontColor];
    [self.vm_accountPre     setTextColor:fontColor];
    [self.vm_accountPre     setFont:kSysFont_14];
    [self.vm_accountText    setTextColor:fontColor];
    [self.vm_accountText    setFont:kSysFont_14];
    
    [self vm_showBottonLine:YES];
}

+ (CGFloat)vp_cellHeightWithModel:(id)model withSuperWidth:(CGFloat)t_superWidth
{
    BOOL bloginFlag = [model boolValue];
    return (!bloginFlag) ? 100.f : 144.f;
}

- (void)vp_updateUIWithModel:(id)model
{
    //TODO：更新UI
    
    BOOL bloginFlag = [model boolValue];
    
    if(!bloginFlag)
    {
        [self vs_showLoginView:YES];
        [self vs_showWalletView:NO];
    }
    else
    {
        [self vs_showLoginView:NO];
        [self vs_showWalletView:YES];
        [self.vm_headAvar sd_setImageWithString:@"" placeholderImage:kDefaultHeadImage];
    }
}

#pragma mark -- action
- (void)vs_showLoginView:(BOOL)bshow
{
    if(bshow)
    {
        [self.contentView addSubview:self.vm_gbLoginView];
        [self.vm_gbLoginView mas_remakeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(@(0));
            make.right.equalTo(@(0));
            make.top.equalTo(@(0));
            make.bottom.equalTo(@(-1));
            
        }];
        
        [self.vm_gbLoginView addSubview:self.vm_btnLogin];
        [self.vm_btnLogin mas_remakeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(@(50));
            make.width.equalTo(@(90));
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.height.equalTo(@(30));
            
        }];
        
        [self.vm_gbLoginView addSubview:self.vm_btnRegister];
        [self.vm_btnRegister mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(@(-50));
            make.width.equalTo(@(90));
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.height.equalTo(@(30));
            
        }];
        
    }
    else
    {
        [_vm_gbLoginView removeFromSuperview];
    }
}

- (void)vs_showWalletView:(BOOL)bshow
{
    if(bshow)
    {
        [self.contentView addSubview:self.vm_walletView];
        [self.vm_walletView mas_remakeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(@(0));
            make.top.equalTo(self.vm_headAvar.mas_bottom).mas_offset(10);
            make.right.equalTo(@(0));
            make.bottom.equalTo(@(0));
            
        }];
    }
    else
    {
        [_vm_walletView removeFromSuperview];
    }
}

- (void)loginClicked
{
    if([self.delegate respondsToSelector:@selector(vp_userHeadCellLoginClicked:)])
    {
        [self.delegate vp_userHeadCellLoginClicked:self];
    }
}

- (void)registerClicked
{
    if([self.delegate respondsToSelector:@selector(vp_userHeadCellRegisterClicked:)])
    {
        [self.delegate vp_userHeadCellRegisterClicked:self];
    }
}

#pragma mark -- getter
_GETTER_ALLOC_BEGIN(VSView, vm_gbLoginView)
{
    [_vm_gbLoginView setBackgroundColor:kColor_ffffff];
}
_GETTER_END(vm_gbLoginView)

_GETTER_BEGIN(VSButton, vm_btnLogin)
{
    _vm_btnLogin = [VSButton buttonWithType:UIButtonTypeCustom];
    [_vm_btnLogin setTitle:@"登录" forState:UIControlStateNormal];
    [_vm_btnLogin setTitleColor:kColor_666666 forState:UIControlStateNormal];
    [_vm_btnLogin.titleLabel setFont:kSysFont_12];
    [_vm_btnLogin addTarget:self action:@selector(loginClicked) forControlEvents:UIControlEventTouchUpInside];
    _SETDEFAULT_VIEW_STYLE_(_vm_btnLogin, kColor_808080, 4);
}
_GETTER_END(vm_btnLogin)

_GETTER_BEGIN(VSButton, vm_btnRegister)
{
    _vm_btnRegister = [VSButton buttonWithType:UIButtonTypeCustom];
    [_vm_btnRegister setTitle:@"注册" forState:UIControlStateNormal];
    [_vm_btnRegister setTitleColor:kColor_666666 forState:UIControlStateNormal];
    [_vm_btnRegister.titleLabel setFont:kSysFont_12];
    [_vm_btnRegister addTarget:self action:@selector(registerClicked) forControlEvents:UIControlEventTouchUpInside];
    _SETDEFAULT_VIEW_STYLE_(_vm_btnRegister, kColor_808080, 4);
}
_GETTER_END(vm_btnRegister)

#pragma mark -- walletview
_GETTER_ALLOC_BEGIN(VSView, vm_walletView)
{
    [_vm_walletView setBackgroundColor:kColor_ffffff];
    
    [_vm_walletView addSubview:self.vm_lineTop];
    [self.vm_lineTop mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(@(0));
        make.height.equalTo(@(RETINA_1PX));
        make.right.equalTo(@(0));
        make.top.equalTo(@(0));
        
    }];
    
    [_vm_walletView addSubview:self.vm_douTitleLabel];
    [self.vm_douTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(@(15));
        make.width.equalTo(@(35));
        make.bottom.equalTo(@(0));
        make.top.equalTo(@(0));
        
    }];
    
    [_vm_walletView addSubview:self.vm_lineSp];
    [self.vm_lineSp mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(_vm_walletView.mas_centerX);
        make.width.equalTo(@(RETINA_1PX));
        make.bottom.equalTo(@(0));
        make.top.equalTo(@(0));
        
    }];
    
    [_vm_walletView addSubview:self.vm_huaTitleLabel];
    [self.vm_huaTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.vm_lineSp.mas_right).mas_offset(7);
        make.width.equalTo(@(35));
        make.bottom.equalTo(@(0));
        make.top.equalTo(@(0));
        
    }];
}
_GETTER_END(vm_walletView)

_GETTER_ALLOC_BEGIN(VSView, vm_lineTop)
{
    [_vm_lineTop setBackgroundColor:kColor_d9d9d9];
}
_GETTER_END(vm_lineTop)

_GETTER_ALLOC_BEGIN(VSLabel, vm_douTitleLabel)
{
    [_vm_douTitleLabel setFont:kSysFont_13];
    [_vm_douTitleLabel setTextColor:kColor_333333];
    [_vm_douTitleLabel setText:@"情豆"];
}
_GETTER_END(vm_douTitleLabel)

_GETTER_ALLOC_BEGIN(VSView, vm_lineSp)
{
    [_vm_lineSp setBackgroundColor:kColor_d9d9d9];
}
_GETTER_END(vm_lineSp)

_GETTER_ALLOC_BEGIN(VSLabel, vm_huaTitleLabel)
{
    [_vm_huaTitleLabel setFont:kSysFont_13];
    [_vm_huaTitleLabel setTextColor:kColor_333333];
    [_vm_huaTitleLabel setText:@"情花"];
}
_GETTER_END(vm_huaTitleLabel)

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  DetaileAdressViewController.m
//  VSProject
//
//  Created by certus on 15/11/17.
//  Copyright © 2015年 user. All rights reserved.
//

#import "DetaileAdressViewController.h"

@interface DetaileAdressViewController ()

@end

@implementation DetaileAdressViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self vs_setTitleText:_titleLabel];
    // Do any additional setup after loading the view from its nib.
    
    _textView.text = _adreess;
    _textView.delegate = (id<UITextViewDelegate>)self;
    [_textView becomeFirstResponder];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    if (![_titleLabel isEqualToString:@"详细地址"]) {
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(sureDataBack)];
        self.navigationItem.rightBarButtonItem= rightItem;
    }

    [self recoverRightButton];
}

- (void)recoverRightButton {
    
    self.navigationItem.rightBarButtonItem = nil;
    [self vs_showRightButton:YES];
    
    [self.vm_rightButton setFrame:_CGR(0, 0, 40, 28)];
    self.vm_rightButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [self.vm_rightButton setTitleColor:_COLOR_HEX(0x000000) forState:UIControlStateNormal];
    [self.vm_rightButton setTitle:@"保存" forState:UIControlStateNormal];
}

- (void)vs_rightButtonAction:(id)sender
{
    [self sureDataBack];
}

- (void)vs_back {
    
    if ([_titleLabel isEqualToString:@"详细地址"]) {
        [self sureDataBack];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)sureDataBack {

    _adreess = _textView.text;
    int nameCount = 0;
    for (int i = 0; i < _adreess.length; i++) {
        unichar c = [_adreess characterAtIndex:i];
        if (c >=0x4E00 && c <=0x9FFF) {//汉字
            nameCount = nameCount + 2;
        }else {
            nameCount = nameCount + 1;
        }
    }
    if (nameCount > 100) {
        [self.view showTipsView:@"地址长度超过50字"];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
        _adrtessBlock(_adreess);
    }

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

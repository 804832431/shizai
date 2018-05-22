//
//  NewMoreViewController.m
//  VSProject
//
//  Created by 陈 海涛 on 16/8/4.
//  Copyright © 2016年 user. All rights reserved.
//

#import "NewMoreViewController.h"
#import "NewMoreTableViewCell.h"
#import "PXAlertView.h"
#import "PXAlertView+Customization.h"
#import "VSWebViewController.h"
#import "VSJsWebViewController.h"

@interface NewMoreViewController ()
{
    
    NSArray *topNameArray;
    
}

_PROPERTY_NONATOMIC_STRONG(UITableView, tableView)


@end

@implementation NewMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    
    
    [self vs_showRightButton:NO];
    
    
    [self vs_setTitleText:@"更多"];
    
    
    topNameArray = @[@"联系客服",@"我要合作"];
    
    
    [self.view addSubview:self.tableView];
    
    
}





#pragma mark -- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return topNameArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 49;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewMoreTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NewMoreTableViewCell class])];
    
    
    
    cell.contentTitleLabel.text = topNameArray[indexPath.row];
    
    
    
    return cell;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *title = topNameArray[indexPath.row];
    
    
    if ([title isEqualToString:@"联系客服"]) {
        
        PXAlertView *alertView = [PXAlertView showAlertWithTitle:@"提示" message:@"您确定要拨打客服电话吗？" cancelTitle:@"取消" otherTitle:@"确定" completion:^(BOOL cancelled, NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4008230087"]];
            }
        }];
        
        [alertView setBackgroundColor:[UIColor whiteColor]];
        [alertView setTitleColor:[UIColor grayColor]];
        [alertView setMessageColor:[UIColor grayColor]];
        [alertView setCancelButtonTextColor:[UIColor grayColor]];
        [alertView setOtherButtonTextColor:[UIColor grayColor]];
        
    }else if ([title isEqualToString:@"我要合作"]) {
        NSString *url = [NSString stringWithFormat:@"%@%@", SERVER_IP_H5 ,@"/api/page/emailView.jsp"];
        VSJsWebViewController *vc = [[VSJsWebViewController alloc] initWithUrl:[NSURL URLWithString:url]];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


_GETTER_ALLOC_BEGIN(UITableView, tableView) {
    
    _tableView.frame = CGRectMake(0, 0, GetWidth(self.view), GetHeight(self.view));
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = (id<UITableViewDelegate>)self;
    _tableView.dataSource = (id<UITableViewDataSource>)self;
    
    _tableView.backgroundColor = _COLOR_WHITE;
    
    [_tableView registerClass:[NewMoreTableViewCell class] forCellReuseIdentifier:NSStringFromClass([NewMoreTableViewCell class])];
    
}
_GETTER_END(tableView)

@end

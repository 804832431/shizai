//
//  AuthEnterpriseViewController.m
//  VSProject
//
//  Created by 陈 海涛 on 16/9/25.
//  Copyright © 2016年 user. All rights reserved.
//

#import "AuthEnterpriseViewController.h"
#import "AuthEnterpriseTableViewCell.h"
#import "BCNetWorkTool.h"
#import "BidderManager.h"
#import "AuthStatusUnReslovedViewController.h"
#import "MyAuthHistoryViewController.h"

@interface AuthEnterpriseViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *titles;

@property (nonatomic,strong) UIButton *commitButton;

@end

@implementation AuthEnterpriseViewController

- (UIButton *)commitButton{
    if (_commitButton == nil) {
        _commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_commitButton setTitle:@"提交" forState:UIControlStateNormal];
        _commitButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_commitButton addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        [_commitButton setBackgroundColor:ColorWithHex(0x00C88D, 1.0)];
        _commitButton.layer.cornerRadius = 5;
        _commitButton.layer.masksToBounds = YES;
    }
    return _commitButton;
}

- (void)buttonAction{
    
    
    for (NSDictionary *dic in self.titles) {
        
        NSString *title = dic.allKeys.firstObject;
        
        NSString *value = ((NSString *)[dic objectForKey:title]);
        
        if (value.isEmptyString) {
            
//            [self.view showTipsView:[NSString stringWithFormat:@"请完善%@数据",title]];
            [self.view showTipsView:[NSString stringWithFormat:@"亲~你还有信息未填写哦~"]];
            return;
        }
    }
    
    NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    
    NSDictionary *dic = @{
                          @"enterpriseName":[self.titles[0] objectForKey:@"企业名称"],
                          @"enterpriseIdentity":[self.titles[1] objectForKey:@"企业工商注册号"],
                          @"enterpriseLegalPerson":[self.titles[2] objectForKey:@"法人姓名"],
                          @"contactName":[self.titles[3] objectForKey:@"联系人"],
                          @"contactNumber":[self.titles[4] objectForKey:@"联系方式"],
                          @"partyId":partyId
                          
                          };
    
    
    NSData *contentData = (NSData *)[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString* jsonContent = [[NSString alloc] initWithData:contentData encoding:NSUTF8StringEncoding];
    
    NSDictionary * contentDic = [NSDictionary dictionaryWithObjectsAndKeys:jsonContent,@"content", nil];
    
    [self vs_showLoading];
    
    
    [BCNetWorkTool executePostNetworkWithParameter:contentDic  andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.enterprise/register-enterprise/version/1.2.0" withSuccess:^(id callBackData) {
        
        [BidderManager shareInstance].authedEnterPrise.authStatus = @"UNRESOLVED";
        [BidderManager shareInstance].authedEnterPrise.bidder.enterpriseName = [self.titles[0] objectForKey:@"企业名称"];
        [BidderManager shareInstance].authedEnterPrise.bidder.enterpriseIdentity = [self.titles[1] objectForKey:@"企业工商注册号"];
        [BidderManager shareInstance].authedEnterPrise.bidder.enterpriseLegalPerson = [self.titles[2] objectForKey:@"法人姓名"];
        [BidderManager shareInstance].authedEnterPrise.bidder.contactName = [self.titles[3] objectForKey:@"联系人"];
        [BidderManager shareInstance].authedEnterPrise.bidder.contactNumber = [self.titles[4] objectForKey:@"联系方式"];
        
        
        [self vs_hideLoadingWithCompleteBlock:nil];
        
        [self.view showTipsView:@"申请成功！请耐心等待认证结果。"];
        
        [self vs_hideLoadingWithCompleteBlock:^{
            if (self.isModify) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
//                    AuthStatusUnReslovedViewController *vc = [[AuthStatusUnReslovedViewController alloc] initWithNibName:@"AuthStatusUnReslovedViewController" bundle:nil];
//                    [self.navigationController pushViewController:vc animated:YES ];
//                    [self performSelector:@selector(removeVC) withObject:nil afterDelay:0.2];
                });
            } else {
                [self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:[NSNumber numberWithBool:YES] afterDelay:1];
            }
        }];
        
    } orFail:^(id callBackData) {
        [self vs_hideLoadingWithCompleteBlock:nil];
        
        [self.view showTipsView:[callBackData domain]];
        
    }];
    
    
}

- (void)removeVC{
    NSMutableArray *tmp =[NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    
    [tmp removeObjectAtIndex:tmp.count - 2];
    
    self.navigationController.viewControllers = [NSArray arrayWithArray:tmp];
}

- (void)setDataSource:(Bidder *)bidder {
    for (NSInteger i = 0; i < self.titles.count; i++) {
        NSMutableDictionary *dic = [_titles objectAtIndex:i];
        if (i == 0) {
            [dic setValue:bidder.enterpriseName?bidder.enterpriseName:@"" forKey:[[dic allKeys] firstObject]];
        } else if (i == 1) {
            [dic setValue:bidder.enterpriseIdentity?bidder.enterpriseIdentity:@"" forKey:[[dic allKeys] firstObject]];
        } else if (i == 2) {
            [dic setValue:bidder.enterpriseLegalPerson?bidder.enterpriseLegalPerson:@"" forKey:[[dic allKeys] firstObject]];
        } else if (i == 3) {
            [dic setValue:bidder.contactName?bidder.contactName:@"" forKey:[[dic allKeys] firstObject]];
        } else if (i == 4) {
            [dic setValue:bidder.contactNumber?bidder.contactNumber:@"" forKey:[[dic allKeys] firstObject]];
        }
    }
}

- (NSMutableArray *)titles{
    if (_titles == nil) {
        
        NSArray *tmpArr = @[
                            [NSMutableDictionary dictionaryWithDictionary:@{@"企业名称":@""}],
                            [NSMutableDictionary dictionaryWithDictionary:@{@"企业工商注册号":@""}],
                            [NSMutableDictionary dictionaryWithDictionary:@{@"法人姓名":@""}],
                            [NSMutableDictionary dictionaryWithDictionary:@{@"联系人":@""}],
                            [NSMutableDictionary dictionaryWithDictionary:@{@"联系方式":@""}]
                            ];
        
        _titles = [NSMutableArray arrayWithArray:tmpArr];
        
    }
    return _titles;
}




- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        
        
        UINib *nib = [UINib nibWithNibName:@"AuthEnterpriseTableViewCell" bundle:nil];
        [_tableView registerNib:nib  forCellReuseIdentifier:NSStringFromClass([AuthEnterpriseTableViewCell class])];
        
        
    }
    
    return _tableView;
}




- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self vs_setTitleText:@"企业信息填写"];
    
    
    self.view.backgroundColor = _COLOR_HEX(0xf1f1f1);
    
    __weak typeof(self) weakSelf = self;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.leading.trailing.equalTo(weakSelf.view);
    }];
    
    NSString *status = [BidderManager shareInstance].authedEnterPrise.authStatus;
    
    if ([status isEqualToString:@"REJECT"]) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"申请历史" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, 0, 80, 44);
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
        
    }
    
}

- (void)rightButtonAction{
    MyAuthHistoryViewController *vc = [MyAuthHistoryViewController new];
    [self.navigationController pushViewController:vc  animated:YES];
}


#pragma mark -  tableView delegate and dataSource method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section < 5) {
        return 2;
    }
    return 1;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section < 5) {
        
        if (indexPath.row == 0) {
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            UILabel *contentlabel = [UILabel new];
            
            contentlabel.frame = CGRectMake(20, 0, 200, 40);
            
            contentlabel.font = [UIFont systemFontOfSize:14];
            
            contentlabel.text = [NSString stringWithFormat:@"%@",[((NSMutableDictionary *)[self.titles objectAtIndex:indexPath.section]).allKeys firstObject]];
            
            contentlabel.textColor = _Colorhex(0x333333);
            
            [cell.contentView addSubview:contentlabel];
            
            return cell;
            
        } else {
            AuthEnterpriseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AuthEnterpriseTableViewCell class])];
            
            cell.dic = self.titles[indexPath.section];
            
            return cell;
        }
        
        
    }else{
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        
        [cell.contentView addSubview:self.commitButton];
        
        [self.commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(cell.contentView).offset(15);
            make.trailing.equalTo(cell.contentView).offset(-15);
            make.top.bottom.equalTo(cell.contentView);
        }];
        
        return cell;
        
    }
    
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section < 5) {
        if (indexPath.row == 0) {
            return 40;
        } else {
            return 50;
        }
    }else{
        return 50;
    }
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    if (section < 5) {
//        
//        UILabel *contentlabel = [UILabel new];
//        
//        contentlabel.frame = CGRectMake(20, 0, 200, 40);
//        
//        contentlabel.font = [UIFont systemFontOfSize:14];
//        
//        contentlabel.text = [NSString stringWithFormat:@"    %@",[((NSMutableDictionary *)[_titles objectAtIndex:section]).allKeys firstObject]];
//        
//        contentlabel.textColor = _Colorhex(0x333333);
//        
//        return contentlabel;
//    }
//    
//    return nil;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section != 5) {
        return 0.01;
    }
    
    return 30;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}








@end

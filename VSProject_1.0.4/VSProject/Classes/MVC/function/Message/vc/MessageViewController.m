//
//  MessageViewController.m
//  VSProject
//
//  Created by certus on 16/1/19.
//  Copyright © 2016年 user. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageCell.h"
#import "MessageManager.h"
#import "MessageModel.h"
#import "MessageListModel.h"
#import "MessageContentViewController.h"

@interface MessageViewController () {
    
    MessageManager *manger;
    int page;
    int row;
    MessageListModel *listModel;
    UILabel *noMessageImageView;
}

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self vs_showRightButton:YES];
    [self.vm_rightButton setFrame:_CGR(0, 0, 40, 28)];
    [self.vm_rightButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.vm_rightButton setTitle:@"清空" forState:UIControlStateNormal];
    [self vs_setTitleText:@"消息中心"];
    
    page = 1;
    row = 10;
    manger = [[MessageManager alloc]init];
    _datalist = [NSMutableArray array];
    
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [_tableView headerBeginRefreshing];
    
}

#pragma mark -- Action


- (void)deleteMessage:(NSUInteger)tag {
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"确定要删除此条消息？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = tag + 100;
    [alert show];
    
    
}

- (void)vs_rightButtonAction:(id)sender {
    [self clearALLMessages];
}

- (void)clearALLMessages {
    
    if (_datalist.count > 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"确定要清空全部消息？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = 50;
        [alert show];
    }else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"暂无消息！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}


- (void)refresh {
    page = 1;
    [self requestMessages];
    
}

- (void)getmore {
    page ++;
    [self requestMessages];
    
}
#pragma mark -- Private

- (void)showNoList {
    
    if (!noMessageImageView) {
        noMessageImageView = [[UILabel alloc]initWithFrame:CGRectMake(MainWidth/2-100, MainHeight/2-40, 200, 80)];
        noMessageImageView.backgroundColor = [UIColor clearColor];
        noMessageImageView.text = @"暂无消息";
        noMessageImageView.textAlignment = NSTextAlignmentCenter;
        noMessageImageView.font = [UIFont systemFontOfSize:18.];
        noMessageImageView.textColor = [UIColor lightGrayColor];
    }
    [self.view addSubview:noMessageImageView];
}

- (void)hideNoList {
    
    [noMessageImageView removeFromSuperview];
}

- (void)refreshTableView {
    
    [self.tableView reloadData];
    if ([_datalist isKindOfClass:[NSArray class]] && _datalist.count > 0) {
        [self hideNoList];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }else {
        [self showNoList];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
}
#pragma mark -- request

- (void)requestMessages {
    
//    [self vs_showLoading];
    NSDictionary *para = @{@"page":[NSNumber numberWithInt:page],@"row":[NSNumber numberWithInt:row]};
    [manger requestMessages:para success:^(NSDictionary *responseObj) {
        //停止刷新
        if (page == 1) {
            [_datalist removeAllObjects];
            [_tableView headerEndRefreshing];
        }else {
            [_tableView footerEndRefreshing];
        }
        [self vs_hideLoadingWithCompleteBlock:nil];
        
        //数据
        NSError *err;
        listModel = [[MessageListModel alloc]initWithDictionary:responseObj error:&err];
        NSArray *list = [MessageModel arrayOfModelsFromDictionaries:[responseObj objectForKey:@"messageList"] error:nil];
        NSLog(@"err--%@",err);
        
        if (list && [list isKindOfClass:[NSArray class]] && list.count > 0) {
            [_datalist addObjectsFromArray:list];
        }
        
        BOOL hasUnread = NO;
        for (MessageModel *msg in list) {
            if ([msg.isRead isEqualToString:@"N"]) {
                hasUnread = YES;
            }
        }
        
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:hasUnread] forKey:@"hasUnreadMsg"];
        
        [self refreshTableView];
    } failure:^(NSError *error) {
        //
        [self refreshTableView];
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];
        [self vs_hideLoadingWithCompleteBlock:nil];
        [self.view showTipsView:[error domain]];
    }];
}

- (void)requestDeleteMessage:(NSUInteger)index {
    
    [self vs_showLoading];
    MessageModel *m_model = [_datalist objectAtIndex:index];
    
    NSDictionary *para = @{@"messageId":m_model.id};
    [manger requestDeleteMessage:para success:^(NSDictionary *responseObj) {
        //
        [self vs_hideLoadingWithCompleteBlock:nil];
        NSString *resultCode = [responseObj objectForKey:@"resultCode"];
        
        if (resultCode && [resultCode isEqualToString:@"CODE-00000"]) {
            [_datalist removeObjectAtIndex:index];
            [self refreshTableView];
        }else {
            [self.view showTipsView:@"删除失败"];
        }
        
    } failure:^(NSError *error) {
        //
        [self vs_hideLoadingWithCompleteBlock:nil];
        [self.view showTipsView:[error domain]];
    }];
    
}

- (void)requestClearALLMessages{
    
    [self vs_showLoading];
    [manger requestclearALLMessages:nil success:^(NSDictionary *responseObj) {
        //
        [self vs_hideLoadingWithCompleteBlock:nil];
        NSString *resultCode = [responseObj objectForKey:@"resultCode"];
        
        if (resultCode && [resultCode isEqualToString:@"CODE-00000"]) {
            [_datalist removeAllObjects];
            [self refreshTableView];
        }else {
            [self.view showTipsView:@"删除失败"];
        }
        
    } failure:^(NSError *error) {
        //
        [self vs_hideLoadingWithCompleteBlock:nil];
        [self.view showTipsView:[error domain]];
    }];
    
}

#pragma mark -- UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 50 && buttonIndex == 1) {
        
        [self requestClearALLMessages];
        
    }else if (alertView.tag >= 100 && buttonIndex == 1) {
        
        [self requestDeleteMessage:alertView.tag-100];
        
    }
    
}

#pragma mark -- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MessageContentViewController *vc = [[MessageContentViewController alloc]init];
    vc.m_model = [_datalist objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteMessage:indexPath.row];
    }
}


#pragma mark -- UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _datalist.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 90;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MessageCell" owner:nil options:nil] lastObject];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MessageModel *m_model = [_datalist objectAtIndex:indexPath.row];
    [cell vp_updateUIWithModel:m_model];
    
    return cell;
}

_GETTER_ALLOC_BEGIN(UITableView, tableView) {
    
    _tableView.frame = CGRectMake(0, 0, GetWidth(self.view), GetHeight(self.view) - 64);
    _tableView.backgroundColor = _COLOR_HEX(0xf1f1f1);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = (id<UITableViewDelegate>)self;
    _tableView.dataSource = (id<UITableViewDataSource>)self;
    __weak typeof(self)weakself = self;
    [_tableView addHeaderWithCallback:^{
        [weakself refresh];
    }];
    [_tableView addFooterWithCallback:^{
        [weakself getmore];
    }];
}
_GETTER_END(tableView)

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

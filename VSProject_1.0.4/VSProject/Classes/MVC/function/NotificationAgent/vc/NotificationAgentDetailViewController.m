//
//  NotificationAgentDetailViewController.m
//  VSProject
//
//  Created by certus on 16/4/18.
//  Copyright © 2016年 user. All rights reserved.
//

#import "NotificationAgentDetailViewController.h"
#import "NotificationAgentDetailCell.h"
#import "NotificationAgentManger.h"

@interface NotificationAgentDetailViewController () {

    NotificationAgentManger *manger;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *datalist;
@property (strong, nonatomic) NSMutableDictionary *dataDic;

@end

@implementation NotificationAgentDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self vs_setTitleText:@"通知待办详情"];
    manger = [[NotificationAgentManger alloc]init];
    _dataDic = [NSMutableDictionary dictionary];
    
    [self requestGetReservationDetail];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- request

- (void)requestGetReservationDetail {
    [self vs_showLoading];
    
    NSMutableDictionary *submitDic = [NSMutableDictionary dictionary];
    [submitDic setObject:_reservationId?:@"" forKey:@"reservationId"];
    
    [manger requestGetReservationDetail:submitDic success:^(NSDictionary *responseObj) {
        [self vs_hideLoadingWithCompleteBlock:nil];
        _dataDic = [responseObj objectForKey:@"reservationDetail"];
        NSString *appJson = [_dataDic objectForKey:@"appJson"];
        NSData *appJsonData = [appJson dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        _datalist = [NSJSONSerialization JSONObjectWithData:appJsonData options:NSJSONReadingAllowFragments error:&error];
        [_tableView reloadData];
        
    } failure:^(NSError *error) {
        [self vs_hideLoadingWithCompleteBlock:nil];
        [self.view showTipsView:[error domain]];
    }];
}


#pragma mark -- UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return 4;
            break;
            
        case 1:
            return _datalist.count;
            break;

        default:
            return 0;
            break;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"NotificationAgentDetailCell";
    NotificationAgentDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"NotificationAgentDetailCell" owner:nil options:nil] lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {

        switch (indexPath.row) {
            case 0:{
                cell.leftLabel.text = @"预约单号";
                cell.rightLabel.text = [NSString stringWithFormat:@"%@",[_dataDic objectForKey:@"id"]];
            }
                break;
               
            case 1:{
                cell.leftLabel.text = @"提交时间";
                NSString *createTime = [_dataDic objectForKey:@"createTime"];
                cell.rightLabel.text = [NSDate timeMinutes:createTime.longLongValue];
            }
                break;

            case 2:{
                cell.leftLabel.text = @"预约类型";
                cell.rightLabel.text = [_dataDic objectForKey:@"appName"];
            }
                break;

            case 3:{
                cell.leftLabel.text = @"预约状态";
                NSString *appState = [_dataDic objectForKey:@"appState"];
                if ([appState isEqualToString:NAGENT_SUBMIT]) {
                    cell.rightLabel.text = @"待处理";
                }else if ([appState isEqualToString:NAGENT_CANCELED]) {
                    cell.rightLabel.text = @"已取消";
                }else if ([appState isEqualToString:NAGENT_PROCESSING]) {
                    cell.rightLabel.text = @"处理中";
                }else if ([appState isEqualToString:NAGENT_REJECT]) {
                    cell.rightLabel.text = @"预约失败";
                }else if ([appState isEqualToString:NAGENT_CONFIRM]) {
                    cell.rightLabel.text = @"预约成功";
                }

            }
                break;

            default:
                break;
        }

    }else {
        NSDictionary *dic = _datalist[indexPath.row];
        
        cell.leftLabel.text = [NSString stringWithFormat:@"%@:",[dic objectForKey:@"name"]];
        cell.rightLabel.text = [dic objectForKey:@"value"];
    }

    return cell;
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

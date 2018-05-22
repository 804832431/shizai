//
//  RTXUbanRentalDetailViewController.m
//  VSProject
//
//  Created by certus on 16/4/15.
//  Copyright © 2016年 user. All rights reserved.
//

#import "RTXUbanRentalDetailViewController.h"
#import "RTXUbanFormCell.h"
#import "RTXUbanManger.h"
#import "RentalModel.h"

@interface RTXUbanRentalDetailViewController () {

    RTXUbanManger *manger;

}

@end

@implementation RTXUbanRentalDetailViewController

- (id)init {

    self = [super init];
    
    if (self) {
        manger = [[RTXUbanManger alloc]init];
        
    }
    
    return self;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- Request
- (void)getUbanRentalDetail {
    [self userlogin:LOGIN_BACK_DEFAULT popVc:self animated:YES LoginSucceed:^{
        NSMutableDictionary *submitDic = [NSMutableDictionary dictionary];
        [submitDic setObject:_m_id?:@"" forKey:@"ubanRentalId"];
        [self vs_showLoading];
        [manger getUbanRentalDetail:submitDic success:^(NSDictionary *responseObj) {
            //
            [self vs_hideLoadingWithCompleteBlock:nil];
            NSDictionary *rentalDic = [responseObj objectForKey:@"rentalDetail"];
            RentalModel *model = [[RentalModel alloc]initWithDictionary:rentalDic error:nil];
            [self reloadTable:model];
            
        } failure:^(NSError *error) {
            //
            [self vs_hideLoadingWithCompleteBlock:nil];
            [self.view showTipsView:[error domain]];
        }];
    } cancel:^{
        
    }];
}

- (void)rejuestDatasources {

    [super rejuestDatasources];
    
    [self vs_setTitleText:@"租赁详情"];
    self.rightArray = [NSMutableArray arrayWithArray:@[@[@"楼盘名称:",@""],@[@"业主姓名:",@""],@[@"业主电话:",@""],@[@"楼号:",@""],@[@"楼层:",@""],@[@"房号:",@""],@[@"面积:",@""],@[@"价格:",@""],@[@"起租时间:",@""],@[@"免租期:",@""],@[@"付款方式:",@""],@[@"备注:",@""]]];
    [self getUbanRentalDetail];
}

- (void)reloadTable:(RentalModel *)model {
    self.rightArray = [NSMutableArray arrayWithArray:@[@[@"楼盘名称:",model.buildingName?:@""],@[@"业主姓名:",model.contact?:@""],@[@"业主电话:",model.contactNumber?:@""],@[@"楼号:",model.buildingNumber?:@""],@[@"楼层:",model.floorNumber?:@""],@[@"房号:",model.roomNumber?:@""],@[@"面积:",model.roomArea?:@""],@[@"价格:",model.price?:@""],@[@"起租时间:",[NSDate timeSeconds:model.beginTime.longLongValue]?:@""],@[@"免租期:",model.rentFreePeriod?:@""],@[@"付款方式:",model.paymentMethod?:@""],@[@"备注:",model.remarks?:@""]]];
    [self.table reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
#pragma mark -- UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"RTXUbanFormCell";
    RTXUbanFormCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"RTXUbanFormCell" owner:nil options:nil] lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.m_contentTxt setEnabled:NO];

    
    switch (indexPath.section) {
        case 0:
        {
            cell.m_titleLbl.text = self.rightArray[indexPath.row][0];
            cell.m_contentTxt.text = self.rightArray[indexPath.row][1];
            
        }
            break;
            
        case 1:
        {
            cell.m_titleLbl.text = self.rightArray[indexPath.row+rowSection0][0];
            cell.m_contentTxt.text = self.rightArray[indexPath.row+rowSection0][1];
            
            if (indexPath.row == 3) {
                cell.m_contentTxt.keyboardType = UIKeyboardTypeDecimalPad;
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
                label.text = @"平米";
                label.textAlignment = NSTextAlignmentRight;
                label.font = [UIFont systemFontOfSize:15.];
                label.textColor = _COLOR_HEX(0x222222);
                cell.m_contentTxt.rightView = label;
                cell.m_contentTxt.rightViewMode = UITextFieldViewModeAlways;
            }
            if (indexPath.row == 4) {
                cell.m_contentTxt.keyboardType = UIKeyboardTypeDecimalPad;
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
                label.text = @"元/月";
                label.font = [UIFont systemFontOfSize:15.];
                label.textColor = _COLOR_HEX(0x222222);
                label.textAlignment = NSTextAlignmentRight;
                cell.m_contentTxt.rightView = label;
                cell.m_contentTxt.rightViewMode = UITextFieldViewModeAlways;
            }
            
        }
            break;
            
        case 2:
        {
            cell.m_titleLbl.text = self.rightArray[indexPath.row+rowSection0+rowSection1][0];
            cell.m_contentTxt.text = self.rightArray[indexPath.row+rowSection0+rowSection1][1];
            
        }
            break;
            
        default:
            break;
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

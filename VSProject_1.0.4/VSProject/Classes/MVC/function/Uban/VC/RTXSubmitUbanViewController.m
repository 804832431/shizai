//
//  RTXSubmitUbanViewController.m
//  VSProject
//
//  Created by certus on 16/4/3.
//  Copyright © 2016年 user. All rights reserved.
//

#import "RTXSubmitUbanViewController.h"
#import "RTXUbanFormCell.h"
#import "RTXBottomBtnActionCell.h"
#import "RTXUbanManger.h"
#import "SinglePickerView.h"


@interface RTXSubmitUbanViewController (){
    
    NSMutableDictionary *submitDic;
    RTXUbanManger *manger;
    NSArray *rentFreePeriodArray;
    NSArray *paymentMethodArray;
    RENTFREE_PREID rentFreePeriod;
    PAY_MENTH paymentMethod;
    
    NSArray *placeHolderArray;

}


@end

@implementation RTXSubmitUbanViewController
@synthesize rightArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self vs_setTitleText:@"业主出租"];
    rentFreePeriodArray = @[@"无",@"半个月",@"一个月"];
    paymentMethodArray = @[@"无",@"押一付一",@"押一付三",@"押一付六",@"押三付一",@"押三付三",@"押三付六",@"押三付年",@"押二付三",@"押二付六"];
    placeHolderArray = @[@"请填写",@"请输入业主姓名",@"只许填写手机号和固定电话",@"请填写",@"请填写",@"请填写",@"请填写",@"请填写",@"请填写",@"请填写",@"请填写",@"请填写"];
    submitDic = [NSMutableDictionary dictionary];
    
    [self rejuestDatasources];
    if (!self.table) {
        self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64) style:UITableViewStyleGrouped];
        [self.view addSubview:self.table];
    }
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.dataSource = (id<UITableViewDataSource>)self;
    self.table.delegate = (id<UITableViewDelegate>)self;
    
    manger = [[RTXUbanManger alloc]init];
    [_submitButton addTarget:self action:@selector(requestSubmitRental) forControlEvents:UIControlEventTouchUpInside];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rejuestDatasources {
    rightArray = [NSMutableArray arrayWithArray:@[@[@"楼盘名称:",@""],@[@"业主姓名:",@""],@[@"业主电话:",@""],@[@"楼号:",@""],@[@"楼层:",@""],@[@"房号:",@""],@[@"面积:",@""],@[@"价格:",@""],@[@"起租时间:",@""],@[@"免租期:",@""],@[@"付款方式:",@""],@[@"备注:",@""]]];

}

#pragma mark -- Request
- (void)requestSubmitRental {
    [self userlogin:LOGIN_BACK_DEFAULT popVc:self animated:YES LoginSucceed:^{
        NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
        [submitDic setObject:partyId forKey:@"partyId"];
        [self vs_showLoading];
        [manger requestSubmitRental:submitDic success:^(NSDictionary *responseObj) {
            //
            [self vs_hideLoadingWithCompleteBlock:nil];
            [self.view showTipsView:@"提交成功" afterDelay:0.4f completeBlock:^{
                [self vs_back];
            }];
            
        } failure:^(NSError *error) {
            //
            [self vs_hideLoadingWithCompleteBlock:nil];
            [self.view showTipsView:[error domain]];
        }];
    } cancel:^{
        
    }];
}


- (void)actionPicker:(NSIndexPath *)indexPath {

    if (indexPath.row == 0 && indexPath.section == 2) {
        
        SinglePickerView *pickerView = [[SinglePickerView alloc]initWithFrame:self.view.bounds pickerViewType:PICKER_DATE];
        pickerView.tag = indexPath.section*100+indexPath.row;
        pickerView.delegate = (id<SinglePickerViewDelegate>)self;
        [pickerView show];
    }else if (indexPath.row == 1 && indexPath.section == 2){
    
        SinglePickerView *pickerView = [[SinglePickerView alloc]initWithFrame:self.view.bounds pickerViewType:PICKER_NORMAL];
        pickerView.tag = indexPath.section*100+indexPath.row;
        pickerView.dataList = [NSArray arrayWithArray:rentFreePeriodArray];
        pickerView.delegate = (id<SinglePickerViewDelegate>)self;
        [pickerView show];

    }else if (indexPath.row == 2 && indexPath.section == 2){
     
        SinglePickerView *pickerView = [[SinglePickerView alloc]initWithFrame:self.view.bounds pickerViewType:PICKER_NORMAL];
        pickerView.tag = indexPath.section*100+indexPath.row;
        pickerView.dataList = [NSArray arrayWithArray:paymentMethodArray];
        pickerView.delegate = (id<SinglePickerViewDelegate>)self;
        [pickerView show];

    }

}
#pragma mark -- UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {

    NSUInteger section = textField.tag/100;
    NSUInteger row = textField.tag%100;
    if (section == 0) {
        switch (row) {
                
            case 0:{
                NSString *textString = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                if (![textString isEmptyString]) {
                    [submitDic setObject:textString forKey:@"buildingName"];
                    rightArray[row] = @[@"楼盘名称:",textString];
                }else {
                    [self.view showTipsView:@"请填写楼盘名称！"];
                }
            }
                break;

            case 1:{
                NSString *textString = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                if (textString.length >= 2 && textString.length <= 4) {
                    [submitDic setObject:textString forKey:@"contact"];
                    rightArray[row] = @[@"业主姓名:",textString];
                }else {
                    [self.view showTipsView:@"业主姓名只能输入2-4个字，请重新输入！"];
                }

                
            }
                break;

            case 2:{
                NSString *textString = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                if ([textString isPhone] || [textString containsString:@"-"]) {
                    [submitDic setObject:textString forKey:@"contactNumber"];
                    rightArray[row] = @[@"业主电话:",textString];
                }else {
                    [self.view showTipsView:@"请填写业主号码！"];
                }
            }
                break;
                
                
            default:
                break;

        }
    }else if (section == 1) {
        switch (row) {
            case 0:{
                NSString *textString = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                if (![textString isEmptyString]) {
                    [submitDic setObject:textString forKey:@"buildingNumber"];
                    rightArray[row+rowSection0] = @[@"楼号:",textString];
                }else {
                    [self.view showTipsView:@"请填写楼号！"];
                }
            }
                break;
                
            case 1:{
                NSString *textString = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                if ([JudgmentUtil validateInteger:textString]) {
                    [submitDic setObject:[NSNumber numberWithInt:textString.intValue] forKey:@"floorNumber"];
                    rightArray[row+rowSection0] = @[@"楼层:",textString];
                }else {
                    [self.view showTipsView:@"请填写正确的楼层！"];
                }
                
            }
                break;
                
            case 2:{
                NSString *textString = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                if (![textString isEmptyString]) {
                    [submitDic setObject:textString forKey:@"roomNumber"];
                    rightArray[row+rowSection0] = @[@"房号:",textString];
                }else {
                    [self.view showTipsView:@"请填写房号！"];
                }

            }
                break;
                
            case 3:{
                NSString *textString = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                if ([JudgmentUtil validateIntegerPoint:textString]) {
                    [submitDic setObject:textString forKey:@"roomArea"];
                    rightArray[row+rowSection0] = @[@"面积:",textString];
                }else {
                    [self.view showTipsView:@"请填写正确的面积！"];
                }
                
            }
                break;
                
            case 4:{
                NSString *textString = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                if ([JudgmentUtil validateIntegerPoint:textString]) {
                    [submitDic setObject:textString forKey:@"price"];
                    rightArray[row+rowSection0] = @[@"价格:",textString];
                }else {
                    [self.view showTipsView:@"请填写正确的价格！"];
                }
                
            }
                break;
                
            default:
                break;
        }
    }else if (section == 2) {
        switch (row) {
            case 3:{
                NSString *textString = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                [submitDic setObject:textString forKey:@"remarks"];
                rightArray[row+rowSection0+rowSection1] = @[@"备注:",textString];
            }
                
                break;
                
            default:
                break;
        }
    }

}
#pragma mark -- SinglePickerViewDelegate

- (void)SinglePickerView:(SinglePickerView *)pickerView selectedValue:(NSString *)selectedValue {
    
    NSUInteger row = pickerView.tag%100;

    if (row == 0) {
        NSString *sendTime = [NSString stringWithFormat:@"%@ 00:00:00",selectedValue];
        [submitDic setObject:sendTime forKey:@"beginTime"];
        rightArray[row+rowSection0+rowSection1] = @[@"起租时间:",selectedValue];
    }else if (row == 1) {
        NSInteger index = [rentFreePeriodArray indexOfObject:selectedValue];
        NSString *textString = [NSString stringWithFormat:@"%ld",(long)index];
        [submitDic setObject:[NSNumber numberWithInt:textString.intValue] forKey:@"rentFreePeriod"];
        rightArray[row+rowSection0+rowSection1] = @[@"免租期:",selectedValue];
    }else if (row == 2) {
        [submitDic setObject:selectedValue forKey:@"paymentMethod"];
        rightArray[row+rowSection0+rowSection1] = @[@"付款方式:",selectedValue];
    }
    [self.table reloadData];
}

#pragma mark -- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self actionPicker:indexPath];
    
}


#pragma mark -- UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return rowSection0;
            break;
            
        case 1:
            return rowSection1;
            break;

        case 2:
            return rowSection2;
            break;

        default:
            return 0;
            break;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 51;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0.1f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 13;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"RTXUbanFormCell";
    RTXUbanFormCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"RTXUbanFormCell" owner:nil options:nil] lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.m_contentTxt.delegate = (id<UITextFieldDelegate>)self;
    cell.m_contentTxt.tag = indexPath.section*100+indexPath.row;

    
    switch (indexPath.section) {
        case 0:
        {
            cell.m_contentTxt.placeholder = placeHolderArray[indexPath.row];
            cell.m_titleLbl.text = rightArray[indexPath.row][0];
            cell.m_contentTxt.text = rightArray[indexPath.row][1];
            if (indexPath.row == 3) {
                cell.m_contentTxt.keyboardType = UIKeyboardTypeNumberPad;
            }

        }
            break;
            
        case 1:
        {
            cell.m_contentTxt.placeholder = placeHolderArray[indexPath.row+rowSection0];
            cell.m_titleLbl.text = rightArray[indexPath.row+rowSection0][0];
            cell.m_contentTxt.text = rightArray[indexPath.row+rowSection0][1];

            if (indexPath.row == 1) {
                cell.m_contentTxt.keyboardType = UIKeyboardTypeNumberPad;
            }
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
                label.text = @"元/平/天";
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
            cell.m_contentTxt.placeholder = placeHolderArray[indexPath.row+rowSection0+rowSection1];
            cell.m_titleLbl.text = rightArray[indexPath.row+rowSection0+rowSection1][0];
            cell.m_contentTxt.text = rightArray[indexPath.row+rowSection0+rowSection1][1];


            if (indexPath.row >= 0 &&indexPath.row < 3) {
                [cell.m_contentTxt setEnabled:NO];
            }
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

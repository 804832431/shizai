//
//  AddAdressViewController.m
//  VSProject
//
//  Created by certus on 15/11/9.
//  Copyright © 2015年 user. All rights reserved.
//

#import "AddAdressViewController.h"
#import "InformationCell.h"
#import "AdressManger.h"
#import "EditNameView.h"
#import "AdressModel.h"
#import "MultiPickerView.h"
#import "DetaileAdressViewController.h"

@interface AddAdressViewController (){
    
    NSArray *leftArray;
    AdressManger *manger;
    AdressModel *paraModel;
    
}

_PROPERTY_NONATOMIC_STRONG(UITableView, tableView)
_PROPERTY_NONATOMIC_STRONG(UIButton, saveButton)

@end

@implementation AddAdressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = _COLOR_HEX(0xf1f1f1);
    manger = [[AdressManger alloc]init];
    paraModel = [[AdressModel alloc]init];
    
    leftArray = @[@"收货人",@"联系方式",@"所在地区",@"详细地址"];
    [self vs_setTitleText:_titleName];
    [self.view addSubview:self.tableView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)canSave{
    
    InformationCell *cell0 = (InformationCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    InformationCell *cell1 = (InformationCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    InformationCell *cell2 = (InformationCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    InformationCell *cell3 = (InformationCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];

    BOOL havePhone = ![cell0.rightLabel.text isEmptyString];
    BOOL havePassword = ![cell1.rightLabel.text isEmptyString];
    BOOL haveSurePassword = ![cell2.rightLabel.text isEmptyString];
    BOOL haveVerification = ![cell3.rightLabel.text isEmptyString];
    
    if (havePhone && havePassword && haveSurePassword && haveVerification) {
        _saveButton.alpha = 1.0;
        [_saveButton setEnabled:YES];
        
        return YES;
    }else {
        _saveButton.alpha = 0.4;
        [_saveButton setEnabled:NO];
        
        return NO;
    }
}


#pragma mark -- Action

- (void)actionSave {
    InformationCell *cell0 = (InformationCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    InformationCell *cell1 = (InformationCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    InformationCell *cell2 = (InformationCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    InformationCell *cell3 = (InformationCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];

    paraModel.recipient = cell0.rightLabel.text;
    paraModel.contactNumber = cell1.rightLabel.text;
    paraModel.zipCode = cell2.rightLabel.text;
    paraModel.address = cell3.rightLabel.text;

    if (!paraModel.recipient || [paraModel.recipient isEmptyString]) {
        [self.view showTipsView:@"请填写收货人"];
    }else if (paraModel.contactNumber.length > 15 && paraModel.contactNumber.length ==0) {
        [self.view showTipsView:@"请填写正确的手机号"];
    }else if (!paraModel.zipCode || [paraModel.zipCode isEmptyString]){
        [self.view showTipsView:@"请选择地区"];
    }else if (!paraModel.address || [paraModel.address isEmptyString]){
        [self.view showTipsView:@"请填写详细地址"];
    }else {
        if (_paraDict) {
            [self updateAdress];
        }else {
            [self addAdress];
        }
    }

}
- (void)addAdress {
    [self vs_showLoading];
    [manger requestAddAddress:paraModel success:^(NSDictionary *responseObj) {
        //
        [self vs_hideLoadingWithCompleteBlock:nil];
        if (responseObj && [[responseObj objectForKey:@"resultCode"] isEqualToString:@"CODE-00000"]) {
            
            [self vs_back];
        }else {
            [self.view showTipsView:@"请求失败"];
        }
    } failure:^(NSError *error) {
        //
        [self vs_hideLoadingWithCompleteBlock:nil];
        [self.view showTipsView:[error domain]];
    }];

}
- (void)updateAdress {

    paraModel.contactMechId = [_paraDict objectForKey:@"contactMechId"];

    [self vs_showLoading];
    [manger requestUpdateAddress:paraModel success:^(NSDictionary *responseObj) {
        //
        [self vs_hideLoadingWithCompleteBlock:nil];
        if (responseObj && [[responseObj objectForKey:@"resultCode"] isEqualToString:@"CODE-00000"]) {
            
            [self vs_back];
        }else {
            [self.view showTipsView:@"请求失败"];
        }
    } failure:^(NSError *error) {
        //
        [self vs_hideLoadingWithCompleteBlock:nil];
        [self.view showTipsView:[error domain]];
    }];

}

#pragma mark -- UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40/3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 200;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    UIView *footerview = [[UIView alloc]initWithFrame:CGRectMake(0, 200, GetWidth(self.view), GetHeight(self.view))];
    [footerview addSubview:self.saveButton];
    
    return footerview;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    InformationCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[InformationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.leftLabel.text = [leftArray objectAtIndex:indexPath.row];
    NSString *rightValue = @"";
    
    if (_paraDict) {
        
        switch (indexPath.row) {
            case 0:
            {
                if (![[_paraDict objectForKey:@"recipient"] isEqual:[NSNull null]] && [_paraDict objectForKey:@"recipient"]) {
                    rightValue = [_paraDict objectForKey:@"recipient"];
                }
            }
                break;
                
            case 1:
            {
                if (![[_paraDict objectForKey:@"contactNumber"] isEqual:[NSNull null]] && [_paraDict objectForKey:@"contactNumber"]) {
                    rightValue = [_paraDict objectForKey:@"contactNumber"];
                }
            }
                break;

            case 2:
            {
                if (![[_paraDict objectForKey:@"zipCode"] isEqual:[NSNull null]] && [_paraDict objectForKey:@"zipCode"]) {
                    rightValue = [_paraDict objectForKey:@"zipCode"];
                }
            }
                break;

            case 3:
            {
                if (![[_paraDict objectForKey:@"address"] isEqual:[NSNull null]] && [_paraDict objectForKey:@"address"]) {
                    rightValue = [_paraDict objectForKey:@"address"];
                }
            }
                break;


            default:
                break;
        }
    }
    cell.rightLabel.text = rightValue;
    if (indexPath.row == leftArray.count-1) {
        [cell.bottomline setHidden:NO];
    }
    
    return cell;
}

#pragma mark -- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0 && indexPath.row == 0) {

        EditNameView *editView = [[EditNameView alloc]initWithFrame:self.view.bounds];
        editView.tag = indexPath.row + 100;
        editView.titleLabel.text = @"编辑姓名";
        editView.delegate = (id<EditNameDelegate>)self;
        [editView show];

    }else if (indexPath.section == 0 && indexPath.row == 1) {
        
        EditNameView *editView = [[EditNameView alloc]initWithFrame:self.view.bounds];
        editView.tag = indexPath.row + 100;
        editView.titleLabel.text = @"编辑联系方式";
        editView.textField.keyboardType = UIKeyboardTypeNumberPad;
        editView.delegate = (id<EditNameDelegate>)self;
        [editView show];
    }else if (indexPath.section == 0 && indexPath.row == 2) {

        MultiPickerView *pickerView = [[MultiPickerView alloc]initWithFrame:self.view.bounds];
        pickerView.delegate = (id<MultiPickerViewDelegate>)self;
        [pickerView show];
        
    }else if (indexPath.section == 0 && indexPath.row == 3) {
        InformationCell *cell = (InformationCell *)[_tableView cellForRowAtIndexPath:indexPath];

        __weak typeof(self) weakself = self;
        DetaileAdressViewController *controller = [[DetaileAdressViewController alloc]init];
        controller.titleLabel = @"详细地址";
        controller.adreess = cell.rightLabel.text;
        controller.adrtessBlock = ^(NSString *adress){
            cell.rightLabel.text = adress;
            paraModel.address =adress;
            [weakself canSave];
        };
        [self.navigationController pushViewController:controller animated:YES];
    }
}


#pragma mark -- EditNameDelegate

- (void)EditNameView:(EditNameView *)editNameView sureEditName:(NSString *)name {
    
    
    switch (editNameView.tag-100) {
        case 0:
        {
            int nameCount = 0;
            for (int i = 0; i < name.length; i++) {
                unichar c = [name characterAtIndex:i];
                if (c >=0x4E00 && c <=0x9FFF) {//汉字
                    nameCount = nameCount + 2;
                }else {
                    nameCount = nameCount + 1;
                }
            }
            if (nameCount > 60) {
                [self.view showTipsView:@"长度超过限制"];
                return;
            }else if (name.length == 0){
                [self.view showTipsView:@"请填写收货人"];
                return;
            }
        }
            break;
            
        case 1:{
        
            if (name.length > 15) {
                [self.view showTipsView:@"最多能输入15位数字"];
                return;
            }else if (name.length == 0){
                [self.view showTipsView:@"请填写联系方式"];
                return;
            }
        }
            break;

        default:
            break;
    }
    InformationCell *cell = (InformationCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:editNameView.tag-100 inSection:0]];
    cell.rightLabel.text = name;
    [self canSave];
}

#pragma mark -- MultiPickerViewDelegate

- (void)MultiPickerView:(MultiPickerView *)pickerView leftValue:(NSString *)leftValue middleValue:(NSString *)middleValue rightValue:(NSString *)rightValue {

    if (leftValue && middleValue && rightValue) {
        InformationCell *cell = (InformationCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        if ([middleValue isEqualToString:@"市辖区"]||[middleValue isEqualToString:@"县"]) {
            cell.rightLabel.text = [NSString stringWithFormat:@"%@%@",leftValue,rightValue];
        }else {
            cell.rightLabel.text = [NSString stringWithFormat:@"%@%@%@",leftValue,middleValue,rightValue];
        }
    }else {
        [self.view showTipsView:@"请选择地区"];
    }
    [self canSave];
}

//请求省市区
- (void)MultiPickerView:(MultiPickerView *)pickerView requestLocations:(NSString *)type dataId:(NSString *)dataId{
    
    NSDictionary *paraDic = [NSDictionary dictionaryWithObjectsAndKeys:type,@"type",dataId,@"dataId", nil];
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.postaladdress/get-locations-data"];
    [self vs_showLoading];
    [RequestService requesturl:url paraDic:paraDic success:^(NSDictionary *responseObj) {
        
        [self vs_hideLoadingWithCompleteBlock:nil];

        if ([type isEqualToString:@"province"]) {
            
            pickerView.leftArray = [NSArray arrayWithArray:[responseObj objectForKey:@"provinces"]];
            [pickerView.pickerView reloadComponent:0];
            [pickerView pickerView:pickerView.pickerView didSelectRow:0 inComponent:0];
            
        }else if ([type isEqualToString:@"city"]) {
            
            pickerView.middleArray = [NSArray arrayWithArray:[responseObj objectForKey:@"cities"]];
            [pickerView.pickerView reloadComponent:1];
            [pickerView pickerView:pickerView.pickerView didSelectRow:0 inComponent:1];

        }else if ([type isEqualToString:@"area"]) {
            
            pickerView.rightArray = [NSArray arrayWithArray:[responseObj objectForKey:@"areas"]];
            [pickerView.pickerView reloadComponent:2];
            [pickerView pickerView:pickerView.pickerView didSelectRow:0 inComponent:3];
        }
        
    } failure:^(NSError *error) {
        //
        [self vs_hideLoadingWithCompleteBlock:nil];
        [self.view showTipsView:[error domain]];
    }];
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

_GETTER_ALLOC_BEGIN(UITableView, tableView) {
    
    _tableView.frame = CGRectMake(0, 0, GetWidth(self.view), GetHeight(self.view));
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = (id<UITableViewDelegate>)self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource = (id<UITableViewDataSource>)self;
}
_GETTER_END(tableView)

_GETTER_ALLOC_BEGIN(UIButton, saveButton){
    
    _saveButton.frame = CGRectMake(20, 400/3, GetWidth(self.view)-40, 40);
    _saveButton.backgroundColor = _COLOR_HEX(0xe2a9171);
    _saveButton.layer.cornerRadius = 5.f;
    [_saveButton setTitle:@"保存并使用" forState:UIControlStateNormal];
    [_saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _saveButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
    [_saveButton addTarget:self action:@selector(actionSave) forControlEvents:UIControlEventTouchUpInside];
    _saveButton.alpha = 0.4;
    [_saveButton setEnabled:NO];

}
_GETTER_END(saveButton)


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

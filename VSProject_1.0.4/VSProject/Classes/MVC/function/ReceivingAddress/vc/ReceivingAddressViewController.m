//
//  ReceivingAddressViewController.m
//  VSProject
//
//  Created by certus on 15/11/9.
//  Copyright © 2015年 user. All rights reserved.
//

#import "ReceivingAddressViewController.h"
#import "AddressCell.h"
#import "AdressManger.h"
#import "AddAdressViewController.h"

@interface ReceivingAddressViewController () {
    
    AdressManger *manger;
    AdressModel *deleteModel;
}

@end

@implementation ReceivingAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    manger = [[AdressManger  alloc]init];
    deleteModel = [[AdressModel alloc]init];
    [self vs_setTitleText:@"收货地址"];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.addButton];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self requestReceivingAddressed];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (_selectReceiveAdress) {
        NSDictionary *dic = [_datalist objectAtIndex:indexPath.row];
        AdressModel *model = [[AdressModel alloc]initWithDictionary:dic error:nil];
        _selectReceiveAdress(model);
        [self vs_back];
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
    
    NSDictionary *dic = [_datalist objectAtIndex:indexPath.row];
    NSString *adress = [dic objectForKey:@"address"];
    
    CGRect adressRect = [adress boundingRectWithSize:CGSizeMake(MainWidth-34, 200) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]} context:nil];
    CGFloat height = adressRect.size.height;
    
    return 150 + height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"AddressCell" owner:nil options:nil] lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dic = [_datalist objectAtIndex:indexPath.row];
    cell.defaultButton.tag = 100+indexPath.row;
    cell.editButton.tag = 1000+indexPath.row;
    cell.deleteButton.tag = 10000+indexPath.row;
    
    [cell.defaultButton addTarget:self action:@selector(clickDefaultButton:) forControlEvents:UIControlEventTouchUpInside];
    [cell.editButton addTarget:self action:@selector(adressEdit:) forControlEvents:UIControlEventTouchUpInside];
    [cell.deleteButton addTarget:self action:@selector(clickDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
    [cell vp_updateUIWithModel:dic];
    
    return cell;
}


#pragma mark -- Private

//收货地址列表
- (void)requestReceivingAddressed {
    
    [self vs_showLoading];
    [manger requestReceivingAddressed:nil success:^(NSDictionary *responseObj) {
        //
        [self vs_hideLoadingWithCompleteBlock:nil];
        NSArray *postalAddresses = [responseObj objectForKey:@"postalAddresses"];
        if ([postalAddresses isKindOfClass:[NSArray class]]) {
            _datalist = [NSMutableArray arrayWithArray:postalAddresses];
            [self.tableView reloadData];
        }
        
        
    } failure:^(NSError *error) {
        //
        [self vs_hideLoadingWithCompleteBlock:nil];
        [self.view showTipsView:[error domain]];
    }];
}
//更新收货地址
- (void)editAddressIndex:(NSUInteger)index{
    
    NSDictionary *dic = [_datalist objectAtIndex:index];
    AddAdressViewController *controller = [[AddAdressViewController alloc]init];
    controller.titleName = @"编辑收货地址";
    controller.paraDict = dic;
    [self.navigationController pushViewController:controller animated:YES];
}

//置为默认收货地址
- (void)requestSetDefaultAddress:(NSUInteger)index {

    NSDictionary *dic = [_datalist objectAtIndex:index];
    
    [self vs_showLoading];
    [manger requestSetDefaultAddress:dic success:^(NSDictionary *responseObj) {
        //
        [self vs_hideLoadingWithCompleteBlock:nil];
//        [_tableView reloadData];
        [self requestReceivingAddressed];
    } failure:^(NSError *error) {
        //
        [self.view showTipsView:[error domain]];
        [self vs_hideLoadingWithCompleteBlock:nil];
    }];

}
//删除收货地址
- (void)requestDeleteAddress:(NSUInteger)index {
    NSDictionary *dic = [_datalist objectAtIndex:index];
    
    [manger requestDeleteAddress:dic success:^(NSDictionary *responseObj) {
        //
        [self vs_showLoading];
        [self vs_hideLoadingWithCompleteBlock:nil];
        if (responseObj && [[responseObj objectForKey:@"resultCode"] isEqualToString:@"CODE-00000"]) {
            [_datalist removeObjectAtIndex:index];
            [_tableView reloadData];
        }else {
            [self.view showTipsView:@"请求失败"];
        }
    } failure:^(NSError *error) {
        //
        [self.view showTipsView:[error domain]];
        [self vs_hideLoadingWithCompleteBlock:nil];
    }];

}
//验证元素
- (BOOL)validateCell:(AddressCell *)cell {
    BOOL validateSuccess = NO;
    if ([cell.nameLabel.text isEmptyString]) {
        [self.view showTipsView:@"请填写收货人"];
    }else if (![JudgmentUtil validateMobile:cell.phoneLabel.text]) {
        [self.view showTipsView:@"请填写正确的手机号"];
    }else if ([cell.adressLabel.text isEmptyString]) {
        [self.view showTipsView:@"请填写地址"];
    }else {
        validateSuccess = YES;
    }
    return validateSuccess;

}
#pragma mark -- Action

- (void)actionAddAdress {
    
    AddAdressViewController *controller = [[AddAdressViewController alloc]init];
    controller.titleName = @"新增收货地址";
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)clickDefaultButton:(UIButton *)sender {
    
    NSUInteger index = sender.tag -100;
    [self requestSetDefaultAddress:index];
}

- (void)adressEdit:(UIButton *)sender {
    NSUInteger index = sender.tag -1000;
    AddressCell *cell = (AddressCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    [cell.editButton setImage:[UIImage imageNamed:@"adress_edit"] forState:0];
    [self editAddressIndex:index];
}

- (void)clickDeleteButton:(UIButton *)sender {
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"确定要删除？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = sender.tag;
    [alert show];
    
}
#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        NSUInteger index = alertView.tag -10000;
        [self requestDeleteAddress:index];
    }
}

#pragma mark -- getter

_GETTER_ALLOC_BEGIN(UIButton, addButton){
    
    _addButton.frame = CGRectMake(0, GetHeight(self.view)-50-64, GetWidth(self.view), 50);
    _addButton.backgroundColor = _COLOR_HEX(0xe2a9171);
    [_addButton setTitle:@"新增收货地址" forState:UIControlStateNormal];
    [_addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _addButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
    [_addButton addTarget:self action:@selector(actionAddAdress) forControlEvents:UIControlEventTouchUpInside];
    
}
_GETTER_END(addButton)

_GETTER_ALLOC_BEGIN(UITableView, tableView) {
    
    _tableView.frame = CGRectMake(0, 0, GetWidth(self.view), GetHeight(self.view)-50);
    _tableView.backgroundColor = _COLOR_HEX(0xf1f1f1);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = (id<UITableViewDelegate>)self;
    _tableView.dataSource = (id<UITableViewDataSource>)self;
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

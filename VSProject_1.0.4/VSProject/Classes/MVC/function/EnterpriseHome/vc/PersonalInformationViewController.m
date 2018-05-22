//
//  PersonalInformationViewController.m
//  VSProject
//
//  Created by certus on 15/11/3.
//  Copyright © 2015年 user. All rights reserved.
//

#import "PersonalInformationViewController.h"
#import "InformationCell.h"
#import "SelectPhotoViewController.h"
#import "EditNameView.h"
#import "CenterManger.h"

@interface PersonalInformationViewController () {

    NSArray *leftArray;
    CenterManger *manger;

}

_PROPERTY_NONATOMIC_STRONG(UITableView, tableView)
_PROPERTY_NONATOMIC_STRONG(EditNameView, editView)

@end

@implementation PersonalInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    manger = [[CenterManger alloc]init];
    
    leftArray = @[@"头像",@"昵称",@"性别",@"手机",@"公司",@"办公地",@"公司职务"];
    [self vs_setTitleText:@"个人信息"];
    [self.view addSubview:self.tableView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)vs_back {
    if (self.editView) {
        [self.editView hide];
        self.editView = nil;
    } else {
        [super vs_back];
    }
}

#pragma mark -- Private


- (void)updateHeaderIcon:(UIImage *)image {
    
    [self vs_showLoading];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    NSArray *array = [NSArray arrayWithObject:imageData];
    [manger updateHeaderIcon:nil dataArray:array success:^(NSDictionary *responseObj) {
        //
        [self vs_hideLoadingWithCompleteBlock:nil];
        if (responseObj) {
            InformationCell *cell = (InformationCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            cell.headImageView.image = image;
        }else {
            [self.view showTipsView:@"请求失败"];
        }
    } failure:^(NSError *error) {
        //
        [self.view showTipsView:[error domain]];
        [self vs_hideLoadingWithCompleteBlock:nil];
    }];
}

#pragma mark -- UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 4;
    }else {
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 40/3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0 && indexPath.section == 0) {
        return 200/3;
    }else {
        return 50;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    InformationCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[InformationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        cell.leftLabel.text = [leftArray objectAtIndex:indexPath.row];
        if (indexPath.row == 0) {
            [cell.headImageView setHidden:NO];
            [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:[_personalDic objectForKey:@"headIconPath"]] placeholderImage:[UIImage imageNamed:@"defaultHeadPic"] options:SDWebImageUnCached];


        }
        if (indexPath.row == 1) {
            cell.rightLabel.text = [_personalDic objectForKey:@"nickName"];
        }
        if (indexPath.row == 2) {
            NSString *gender = [_personalDic objectForKey:@"gender"];
            if (gender && [gender isKindOfClass:[NSString class]] && [gender isEqualToString:@"M"]) {
                cell.rightLabel.text = @"男";
            }else if (gender && [gender isKindOfClass:[NSString class]] && [gender isEqualToString:@"F"]) {
                cell.rightLabel.text = @"女";
            }
        }
        if (indexPath.row == 3) {
            [cell.bottomline setHidden:NO];
            [cell.arrow setHidden:YES];

            NSString *username = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.username;
            cell.rightLabel.text = username;
        }
    }else {
        cell.leftLabel.text = [leftArray objectAtIndex:indexPath.row+4];
        if (indexPath.row == 0) {
            [cell.arrow setHidden:YES];
            cell.rightLabel.text = [_personalDic objectForKey:@"companyName"];
        }
        if (indexPath.row == 1) {
            [cell.arrow setHidden:YES];
            cell.rightLabel.text = [_personalDic objectForKey:@"companyAddress"];
        }
        if (indexPath.row == 2) {
            [cell.arrow setHidden:YES];
            [cell.bottomline setHidden:NO];
            cell.rightLabel.text = [_personalDic objectForKey:@"positionInCompany"];
        }
    }
    
    return cell;
}

#pragma mark -- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0 && indexPath.row == 0) {
        SelectPhotoViewController *controller = [[SelectPhotoViewController alloc]init];
        controller.getPhotosBlock = ^(UIImage *image) {
        
            [self updateHeaderIcon:image];
        };
        [self.navigationController pushViewController:controller animated:YES];
    }else if (indexPath.section == 0 && indexPath.row == 1) {
        
        EditNameView *editView = [[EditNameView alloc]initWithFrame:self.view.frame];
        editView.delegate = (id<EditNameDelegate>)self;
        editView.textField.text = [_personalDic objectForKey:@"nickName"];
        [editView show];
        self.editView = editView;
    }else if (indexPath.section == 0 && indexPath.row == 2) {
    
        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"性别修改" delegate:(id<UIActionSheetDelegate>)self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
        [sheet showInView:self.view];
    }
}

#pragma mark -- UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (buttonIndex == 2) {
        return;
    }
    InformationCell *cell = (InformationCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];

    if (buttonIndex == 0) {
        NSDictionary *para = [NSDictionary dictionaryWithObjectsAndKeys:@"gender",@"updateKey",@"M",@"updateValue", nil];
        [self vs_showLoading];
        [manger updateCustomerInfo:para success:^(NSDictionary *responseObj) {
            cell.rightLabel.text = @"男";
            [self vs_hideLoadingWithCompleteBlock:nil];
        } failure:^(NSError *error) {
            //
            [self.view showTipsView:[error domain]];
            [self vs_hideLoadingWithCompleteBlock:nil];
        }];

    }else if (buttonIndex == 1) {
        NSDictionary *para = [NSDictionary dictionaryWithObjectsAndKeys:@"gender",@"updateKey",@"F",@"updateValue", nil];
        [self vs_showLoading];
        [manger updateCustomerInfo:para success:^(NSDictionary *responseObj) {
            cell.rightLabel.text = @"女";
            [self vs_hideLoadingWithCompleteBlock:nil];
        } failure:^(NSError *error) {
            //
            [self.view showTipsView:[error domain]];
            [self vs_hideLoadingWithCompleteBlock:nil];
        }];

    }
}

#pragma mark -- EditNameDelegate

- (void)EditNameView:(EditNameView *)editNameView sureEditName:(NSString *)name {

    int nameCount = 0;
    for (int i = 0; i < name.length; i++) {
        unichar c = [name characterAtIndex:i];
        if (c >=0x4E00 && c <=0x9FFF) {//汉字
            nameCount = nameCount + 2;
        }else {
            nameCount = nameCount + 1;
        }
    }
    if (nameCount > 20) {
        [self.view showTipsView:@"最多可输入10个汉字"];
        return;
    }else if (name.length == 0){
        [self.view showTipsView:@"昵称不能为空"];
        return;
    }

    if (name && name.length > 0) {
        
        NSDictionary *para = [NSDictionary dictionaryWithObjectsAndKeys:@"nickname",@"updateKey",name,@"updateValue", nil];
        
        [self vs_showLoading];
        [manger updateCustomerInfo:para success:^(NSDictionary *responseObj) {
            [self vs_hideLoadingWithCompleteBlock:nil];
            InformationCell *cell = (InformationCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            cell.rightLabel.text = name;
            
            [self.view showTipsView:@"修改个人信息成功"];
            
        } failure:^(NSError *error) {
            //
            [self.view showTipsView:[error domain]];
            [self vs_hideLoadingWithCompleteBlock:nil];
        }];
    }

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

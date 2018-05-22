//
//  ChangeLocatiionViewController.m
//  VSProject
//
//  Created by certus on 15/11/10.
//  Copyright © 2015年 user. All rights reserved.
//

#import "ChangeLocatiionViewController.h"
#import "ChangeLocationCell.h"
#import "WorkTableView.h"
#import "HomeManger.h"

@interface ChangeLocatiionViewController () {
    
    WorkTableView *cityList;
    WorkTableView *projectList;
    HomeManger *manger;
    NSString *cityId;
    NSString *progectId;
    NSDictionary *selectDic;
}

@end

@implementation ChangeLocatiionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = _COLOR_HEX(0xf1f1f1);
    
    manger = [[HomeManger alloc]init];
    // Do any additional setup after loading the view from its nib.
    [self vs_setTitleText:@"位置切换"];
    
    _sureButton.layer.cornerRadius = 3;
    [_sureButton addTarget:self action:@selector(actionSure) forControlEvents:UIControlEventTouchUpInside];
    
    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    [self requestCitys];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- Private

- (void)requestCitys {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"city",@"type",@"0",@"cityId", nil];
    [self vs_showLoading];
    [manger requestCitysAndProgects:dic success:^(NSDictionary *responseObj) {
        [self vs_hideLoadingWithCompleteBlock:nil];
        //
        if ([responseObj isKindOfClass:[NSDictionary class]]) {
            NSArray *dataArray = [responseObj objectForKey:@"citiesOrProjects"];
            if (dataArray) {
                cityList.dataArray = dataArray;
                [cityList showInView:self.view];
                if(dataArray.count == 0){
                    [self.view showTipsView:@"暂无城市"];
                }
            }
            [cityList showInView:self.view];
        }
    } failure:^(NSError *error) {
        //
        [self vs_hideLoadingWithCompleteBlock:nil];
        [self.view showTipsView:[error domain]];
    }];
}

- (void)requestProgects {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"project",@"type",cityId,@"cityId", nil];
    [self vs_showLoading];
    [manger requestCitysAndProgects:dic success:^(NSDictionary *responseObj) {
        [self vs_hideLoadingWithCompleteBlock:nil];
        
        //
        if ([responseObj isKindOfClass:[NSDictionary class]]) {
            NSArray *dataArray = [responseObj objectForKey:@"citiesOrProjects"];
            if (dataArray) {
                projectList.dataArray = dataArray;
                [projectList showInView:self.view];
                if(dataArray.count == 0){
                    [self.view showTipsView:@"暂无项目"];
                }
            }
        }
    } failure:^(NSError *error) {
        //
        [self vs_hideLoadingWithCompleteBlock:nil];
        [self.view showTipsView:[error domain]];
    }];
}

#pragma mark -- Action


- (void)actionSure {
    
    ChangeLocationCell *cell1 = (ChangeLocationCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    ChangeLocationCell *cell2 = (ChangeLocationCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    NSString *textCity = cell1.rightTextField.text;
    NSString *projectCity = cell2.rightTextField.text;
    if (textCity && projectCity && ![textCity isEmptyString] &&![projectCity isEmptyString]) {
        if ([selectDic isKindOfClass:[NSDictionary class]]) {
            //需要存储项目信息
            NSError *error = nil;
            [VSUserLogicManager shareInstance].userDataInfo.vm_projectInfo = [[RTXProjectInfoModel alloc]initWithDictionary:selectDic error:&error];
            [[VSUserLogicManager shareInstance].userDataInfo vp_saveToLocal];
        }
        if (cityId && progectId) {
            [self.navigationController popViewControllerAnimated:YES];
            _resetLayout();
        }
    }else {
        [self.view showTipsView:@"城市或项目名称未选择！"];
        return;
    }
}

- (void)showCitys {
    if (cityList.dataArray.count == 0) {
        [self requestCitys];
    }else {
        [cityList.workTableView reloadData];
        [cityList show];
    }
}

- (void)showProjects {
    
    if (!cityId) {
        [self.view showTipsView:@"请先选择城市"];
    }else if (projectList.dataArray.count == 0) {
        [self requestProgects];
    }else {
        [projectList.workTableView reloadData];
        [projectList show];
    }
}

#pragma mark -- WorkTableViewDelegate

- (void)tableView:(UIView *)view WithSelectedObj:(id)obj {
    
    switch (view.tag) {
        case 1000:
        {
            ChangeLocationCell *cell = (ChangeLocationCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            NSDictionary *dic = (NSDictionary *)obj;
            cell.rightTextField.text = [dic objectForKey:@"name"];
            cityId = [dic objectForKey:@"organizationId"];
            [self requestProgects];
            ChangeLocationCell *cell1 = (ChangeLocationCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            cell1.rightTextField.text = @"";
        }
            break;
            
        case 1001:
        {
            ChangeLocationCell *cell = (ChangeLocationCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            NSDictionary *dic = (NSDictionary *)obj;
            selectDic = (NSDictionary *)obj;
            
            cell.rightTextField.text = [dic objectForKey:@"name"];
            progectId = [dic objectForKey:@"organizationId"];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark -- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"ChangeLocationCell";
    
    ChangeLocationCell *cell = (ChangeLocationCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ChangeLocationCell" owner:nil options:nil] lastObject];
        cell.backgroundColor = [UIColor clearColor];
    }
    if (indexPath.row == 0) {
        cell.leftLabel.text = @"请选择城市：";
        [cell.rightButton addTarget:self action:@selector(showCitys) forControlEvents:UIControlEventTouchUpInside];
        cityList = [[WorkTableView alloc]initFrame:CGRectMake(cell.rightTextField.frame.origin.x, 112, MainWidth-120-40, 0)];
        cityList.delegate = (id<WorkTableViewDelegate>)self;
        cityList.tag = 1000;
        
    }else if (indexPath.row == 1) {
        cell.leftLabel.text = @"请选择项目名称：";
        [cell.rightButton addTarget:self action:@selector(showProjects) forControlEvents:UIControlEventTouchUpInside];
        projectList = [[WorkTableView alloc]initFrame:CGRectMake(cell.rightTextField.frame.origin.x, 170, MainWidth-120-40, 0)];
        projectList.delegate = (id<WorkTableViewDelegate>)self;
        projectList.tag = 1001;
        
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

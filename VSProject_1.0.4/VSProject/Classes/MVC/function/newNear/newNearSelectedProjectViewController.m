//
//  newNearSelectedProjectViewController.m
//  VSProject
//
//  Created by 陈 海涛 on 16/8/31.
//  Copyright © 2016年 user. All rights reserved.
//

#import "newNearSelectedProjectViewController.h"
#import "BCNetWorkTool.h"
#import "Masonry.h"
#import "MJExtension.h"
#import "Project.h"
#import "ProjectTableViewCell.h"
#import "NewNearViewController.h"
#import "VSPageRoute.h"
#import "NearProjectTableViewCell.h"

@interface newNearSelectedProjectViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) UIView *noDataView;

@property (nonatomic,strong)  NSArray *projectList;

@property (nonatomic, strong) Project *targetProject;

@end

@implementation newNearSelectedProjectViewController


- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource =self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        
        UINib *nib = [UINib nibWithNibName:@"ProjectTableViewCell" bundle:nil];
        [_tableView registerNib:nib forCellReuseIdentifier:NSStringFromClass([ProjectTableViewCell class])];
        [_tableView registerClass:[NearProjectTableViewCell class] forCellReuseIdentifier:@"NearProjectTableViewCell"];
    }
    return _tableView;
}

- (UIView *)noDataView{
    if (_noDataView == nil) {
        _noDataView = [UIView new];
        _noDataView.backgroundColor = _Colorhex(0xf1f1f1);
        
        UIView *view = _noDataView;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"not-have"]];
        [_noDataView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(view);
            make.top.equalTo(view).offset(78);
        }];
        
        UILabel *titleLabel = [UILabel new];
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.textColor = _Colorhex(0x999999);
        titleLabel.text = @"抱歉，无可选地产项目";
        
        [_noDataView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(view);
            make.top.equalTo(imageView.mas_bottom).offset(30);
        }];
    }
    
    return _noDataView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    __weak typeof(self) weakSelf = self;
    
    [self.view addSubview:self.noDataView];
    [self.noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    self.noDataView.hidden = YES;
    
    [self.view addSubview:self.tableView];
    [self.tableView addHeaderWithCallback:^{
        [weakSelf loadData];
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    [self.tableView headerBeginRefreshing];
}

- (void)refresh {
    
    [self.tableView headerBeginRefreshing];
    
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self loadData];
}

- (void)loadData{
    
//    [self vs_showLoading];
    
    NSString *lng=[[NSUserDefaults standardUserDefaults] objectForKey:@"longitude"]?:@"0";
    NSString *lat=[[NSUserDefaults standardUserDefaults] objectForKey:@"latitude"]?:@"0";
    NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    
//        lng=@"116.309385";
//        lat=@"39.9";
    
    NSMutableDictionary *dic1=[NSMutableDictionary dictionary];
    [dic1 setObject:lng forKey:@"longtitude"];
    [dic1 setObject:lat forKey:@"latitude"];
    [dic1 setObject:partyId forKey:@"partyId"];
    [dic1 setObject:@"1" forKey:@"page"];
    [dic1 setObject:@"1000" forKey:@"row"];
    
    
    
    __weak typeof(self) weakSelf = self;
    
    [BCNetWorkTool executeGETNetworkWithParameter:dic1 andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.application/get-target-project" withSuccess:^(id callBackData) {
        
        NSDictionary *targetProjectDic = [callBackData objectForKey:@"targetProject"];
    
        self.targetProject = nil;
        if (targetProjectDic != nil  && ![targetProjectDic isKindOfClass:[NSNull class]]) {
            self.targetProject = [Project mj_objectWithKeyValues: [(NSDictionary *)callBackData objectForKey:@"targetProject"]];
        }
        else {
            weakSelf.noDataView.hidden = YES;
        }
        
        NSDictionary *listDic = [(NSDictionary *)callBackData objectForKey:@"projects"];
        if ( listDic != nil  && ![listDic isKindOfClass:[NSNull class]]) {
            self.projectList = [Project mj_objectArrayWithKeyValuesArray: [(NSDictionary *)callBackData objectForKey:@"projects"]];
        }
        else {
            if (!self.targetProject) {
                weakSelf.noDataView.hidden = NO;
            }
        }
        
        [self.tableView reloadData];
        
        [weakSelf vs_hideLoadingWithCompleteBlock:nil];
        [weakSelf.tableView headerEndRefreshing];
        
        
    } orFail:^(id callBackData) {
        
        weakSelf.noDataView.hidden = NO;
        
        [weakSelf vs_hideLoadingWithCompleteBlock:nil];
        [weakSelf.tableView headerEndRefreshing];
        
    }];
    
    [self.tableView reloadData];
}


#pragma mark - UITableView delegate and dataSource method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.targetProject) {
        self.tableView.hidden = NO;
        return 1;
    }
    
    if (self.projectList.count == 0) {
        self.tableView.hidden = YES;
    }else{
        self.tableView.hidden = NO;
    }
    
    return self.projectList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NearProjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NearProjectTableViewCell class])];
    
    if (self.targetProject) {
        [cell setDataSource:self.targetProject];
    }
    else {
        [cell setDataSource:self.projectList[indexPath.row]];
    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  Get750Width(498.0f);
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (self.targetProject) {
        return [UIView new];
    }
    
    UIView *view = [UIView new];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sorry"]];
    UILabel *content = [UILabel new];
    content.textColor = _Colorhex(0x302f37);
    content.font = [UIFont systemFontOfSize:16];
    content.text = @"抱歉，周边暂无可选地产项目";
    content.numberOfLines = 2;
    
    [view addSubview:imageView];
    [view addSubview:content];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_top).offset(Get750Width(21.0f));
        make.left.equalTo(@(Get750Width(24.0f)));
        make.width.equalTo(@(Get750Width(46.0f)));
        make.height.equalTo(@(Get750Width(46.0f)));
    }];
    
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.mas_right).offset(Get750Width(20.0f));
        make.top.equalTo(view.mas_top).offset(Get750Width(29.0f));
        make.width.equalTo(@(Get750Width(600.0f)));
        make.height.equalTo(@(Get750Width(30.0f)));
    }];
    
    view.backgroundColor = _Colorhex(0xffffff);
    
    UIView *spaceView = [[UIView alloc] init];
    spaceView.frame = CGRectMake(0, Get750Width(88.0f), MainWidth, Get750Width(20.0f));
    spaceView.backgroundColor = _Colorhex(0xefeff4);
    [view addSubview:spaceView];

    UIView *sectionHeadView = [[UIView alloc] init];
    sectionHeadView.frame = CGRectMake(0, Get750Width(108.0f), MainWidth, Get750Width(90.0f));
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.frame = CGRectMake(Get750Width(24.0f), Get750Width(30.0f), Get750Width(28.0f), Get750Width(28.0f));
    iconImageView.image = [UIImage imageNamed:@"recommend"];
    [sectionHeadView addSubview:iconImageView];
    
    UILabel *sectionLabel = [[UILabel alloc] init];
    sectionLabel.frame = CGRectMake(iconImageView.frame.origin.x + iconImageView.frame.size.width + Get750Width(10.0f), Get750Width(30.0f), Get750Width(600.0f), Get750Width(30.0f));
    sectionLabel.font = FONT_TITLE(15.0f);
    sectionLabel.textColor = _Colorhex(0xcccccc);
    sectionLabel.textAlignment = NSTextAlignmentLeft;
    sectionLabel.text = @"为您推荐";
    [sectionHeadView addSubview:sectionLabel];
    
    [view addSubview:sectionHeadView];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (self.targetProject) {
        return 0.0001f;
    }
    else {
        return  Get750Width(88.0f + 20.0f + 90.0f);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Project *p = nil;
    if (self.targetProject) {
        p = self.targetProject;
    }
    else {
        p = self.projectList[indexPath.row];
    }
    
    NewNearViewController *nearDetailVC = [[NewNearViewController alloc] init];
    nearDetailVC.targetproject = p;
    [[VSPageRoute currentNav] pushViewController:nearDetailVC animated:YES];
}

#pragma mark -

@end

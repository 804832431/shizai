//
//  ServerListViewController.m
//  VSProject
//
//  Created by pch_tiger on 16/12/18.
//  Copyright © 2016年 user. All rights reserved.
//

#import "ServerListViewController.h"
#import "NewShareWebViewController.h"
#import "ServerProductDTO.h"
#import "ServerBoutiqueSectionCell.h"
#import "AdsTableViewCell.h"
#import "BCNetWorkTool.h"
#import "BannerDTO.h"
#import "MJExtension.h"
#import "VSAdsView.h"

@interface ServerListViewController () <UITableViewDelegate, UITableViewDataSource>
{
    dispatch_group_t requestGroup;
}

@property (nonatomic, strong) VSAdsView *adsView;

@property (nonatomic, strong) UIView *typeBar;

@property (nonatomic, strong) UIButton *defaultButton; // 默认

@property (nonatomic, strong) UIButton *salesButton; // 销量

@property (nonatomic, strong) UIButton *priceButton; // 价格

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *adList;

@property (nonatomic, strong) NSMutableArray *serverList;

@end

@implementation ServerListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    requestGroup = dispatch_group_create();
    
    self.title = self.vcTitle;
    
    self.view.backgroundColor = _COLOR_HEX(0xdedede);
    
    [self.tableView registerClass:[ServerBoutiqueSectionCell class] forCellReuseIdentifier:@"ServerBoutiqueSectionCell"];

    [self.view addSubview:self.adsView];
    [self.view addSubview:self.typeBar];
    
    __weak typeof(self) weakSelf = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView addHeaderWithCallback:^{
        [weakSelf requestData];
    }];
    
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        CGFloat vOffset = self.typeBar.frame.origin.y + self.typeBar.frame.size.height;
        _tableView.frame = CGRectMake(0, vOffset, MainWidth, MainHeight - vOffset - 5.0f);
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        
        [_tableView registerClass:[AdsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([AdsTableViewCell class])];
    }
    
    return _tableView;
}

- (VSAdsView *)adsView {
    
    if (!_adsView) {
        _adsView = [[VSAdsView alloc] init];
        [_adsView setFrame:CGRectMake(0, 64.0f, MainWidth, MainWidth * 406 / 1126)];
        __weak typeof(self) weakself = self;
        [_adsView setAdsClickBlock:^(id data) {
            if ([data isKindOfClass:[BannerDTO class]]) {
                BannerDTO *dto = (BannerDTO *)data;
                
                if ([dto.bannerDetail.uppercaseString hasPrefix:@"HTTP"]) {
                    
                    NSLog(@"%@",dto.bannerDetail);
                    
                    NewShareWebViewController *vc = [[NewShareWebViewController alloc] initWithUrl:[NSURL URLWithString:dto.bannerDetail]];
                    [weakself.navigationController pushViewController:vc animated:YES];
                    
                }
            }
        }];
    }
    return _adsView;
}

- (UIView *)typeBar {
    
    if (!_typeBar) {
        _typeBar = [[UIView alloc] init];
        _typeBar.frame = CGRectMake(0, self.adsView.frame.origin.y + (MainWidth * 406 / 1126), MainWidth, 44.0f);
        _typeBar.backgroundColor = [UIColor whiteColor];
        
        [_typeBar addSubview:self.defaultButton];
        [_typeBar addSubview:self.salesButton];
        [_typeBar addSubview:self.priceButton];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5f, MainWidth, 0.5f)];
        lineView.backgroundColor = _COLOR_HEX(0xdedede);
        [_typeBar addSubview:lineView];
    }
    
    return _typeBar;
}

- (UIButton *)defaultButton {
    
    if (!_defaultButton) {
        _defaultButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, MainWidth/3.0000f, 43.5f)];
        _defaultButton.backgroundColor = [UIColor clearColor];
        [_defaultButton setTitleColor:_COLOR_HEX(0x212121) forState:UIControlStateNormal];
        [_defaultButton setTitleColor:_COLOR_HEX(0x64e4b7) forState:UIControlStateSelected];
        _defaultButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _defaultButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [_defaultButton setTitle:@"默认" forState:UIControlStateNormal];
        _defaultButton.selected = YES;
        
        _defaultButton.tag = 1001;
        [_defaultButton addTarget:self action:@selector(serverTypeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _defaultButton;
}

- (UIButton *)salesButton {
    
    if (!_salesButton) {
        _salesButton = [[UIButton alloc] initWithFrame:CGRectMake(MainWidth/3.0000f, 0, MainWidth/3.0000f, 43.5f)];
        _salesButton.backgroundColor = [UIColor clearColor];
        [_salesButton setTitleColor:_COLOR_HEX(0x212121) forState:UIControlStateNormal];
        [_salesButton setTitleColor:_COLOR_HEX(0x64e4b7) forState:UIControlStateSelected];
        _salesButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _salesButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [_salesButton setTitle:@"销量" forState:UIControlStateNormal];
        _salesButton.selected = NO;
        
        _salesButton.tag = 1002;
        [_salesButton addTarget:self action:@selector(serverTypeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _salesButton;
}

- (UIButton *)priceButton {
    
    if (!_priceButton) {
        _priceButton = [[UIButton alloc] initWithFrame:CGRectMake(self.salesButton.frame.origin.x + MainWidth/3.0000f, 0, MainWidth - MainWidth/3.0000f*2, 43.5f)];
        _priceButton.backgroundColor = [UIColor clearColor];
        [_priceButton setTitleColor:_COLOR_HEX(0x212121) forState:UIControlStateNormal];
        [_priceButton setTitleColor:_COLOR_HEX(0x64e4b7) forState:UIControlStateSelected];
        _priceButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _priceButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [_priceButton setTitle:@"价格" forState:UIControlStateNormal];
        _priceButton.selected = NO;
        
        _priceButton.tag = 1003;
        [_priceButton addTarget:self action:@selector(serverTypeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _priceButton;
}

- (NSMutableArray *)serverList {
    
    if (!_serverList) {
        _serverList = [NSMutableArray array];
    }
    return _serverList;
}

- (void)requestData {
    
    [self vs_showLoading];
    
    [self loadAdData];
    [self loadServerData];
    
    dispatch_group_notify(requestGroup, dispatch_get_main_queue(), ^{
        [self vs_hideLoadingWithCompleteBlock:nil];
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];
        [_tableView reloadData];
    });
}

- (void)loadAdData {
    /**
     banner-type	Banner类型：1：全局首页，2：应用，3：项目
     object-id	Banner类型对应对象id，类型是全局object-id传空
     */
    
    dispatch_group_enter(requestGroup);
    
    NSDictionary *dic = @{
                          @"bannerType":@"4"
                          };
    
    [BCNetWorkTool executeGETNetworkWithParameter:dic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.banner/get-banner-info/version/1.2.0" withSuccess:^(id callBackData) {
        NSLog(@"%@",callBackData );
        
        NSDictionary *dic = (NSDictionary *)callBackData;
        
        [self.adList removeAllObjects];
        
        self.adList = [NSMutableArray arrayWithArray:[BannerDTO mj_objectArrayWithKeyValuesArray:dic[@"advertisementList"]]];
    
        [self.adsView setAds:self.adList];
        
        dispatch_group_leave(requestGroup);
        
    } orFail:^(id callBackData) {
        dispatch_group_leave(requestGroup);
    }];
}

- (void)loadServerData {
    
    ServerProductDTO *dto = [[ServerProductDTO alloc] init];
    for (NSInteger index=0; index<10; ++index) {
        [self.serverList addObject:dto];
    }
}

#pragma mark -  tableView delegate and dataSource method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return self.serverList.count;
    }
    else {
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        ServerBoutiqueSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ServerBoutiqueSectionCell" forIndexPath:indexPath];
        
        ServerProductDTO *dto = [self.serverList objectAtIndex:indexPath.row];
        cell.type = CELLTYPE_LIST;
        [cell setData:dto];
        
        return cell;
    }
    
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {

        return 100.0f + 5.0f;
    }
    
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.00001f;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.0001f;
}

- (void)serverTypeAction:(UIButton *)button {
    
    button.selected = YES;
    switch (button.tag) {
        case 1001:
            
            break;
            
        case 1002:
            
            break;
            
        case 1003:
            
            break;
            
        default:
            break;
    }
}

@end

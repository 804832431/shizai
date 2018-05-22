//
//  SpaceLeaseListViewController.m
//  VSProject
//
//  Created by pangchao on 2017/10/23.
//  Copyright © 2017年 user. All rights reserved.
//

#import "SpaceLeaseListViewController.h"
#import "NewShareWebViewController.h"
#import "BCNetWorkTool.h"
#import "AdsTableViewCell.h"
#import "BannerDTO.h"
#import "MJExtension.h"
#import "ArrowUpAndDownTwoColButton.h"
#import "NewPolicyManager.h"
#import "CityAreaModel.h"
#import "IndustryModel.h"
#import "PolicySelectCItyAreaView.h"
#import "PolicySelectSortTypeView.h"
#import "SpaceLeaseListCell.h"
#import "SpaceProjectModel.h"
#import "CooperateViewController.h"
#import "VSAdsView.h"
#import "SpaceLeaseDetailViewController.h"

@interface SpaceLeaseListViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
{
    NewPolicyManager *manger;
    dispatch_group_t requestGroup;
}

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *adList; // 广告数据源
@property (nonatomic, strong) NSMutableArray *spaceProjectArray; // 空间租赁List<DTO>

@property (nonatomic, strong) VSAdsView *vSAdsView;

@property (nonatomic, strong) UIView *segmentBar; // 选择区域 and 排序view
@property (nonatomic, strong) ArrowUpAndDownTwoColButton *areaButton; // 区域
@property (nonatomic, strong) ArrowUpAndDownTwoColButton *sortButton; // 排序

@property (nonatomic, strong) UIButton *blackClearView;
@property (nonatomic, strong) PolicySelectCItyAreaView *policySelectCItyAreaView; // 选择城市View
@property (nonatomic, strong) PolicySelectSortTypeView *policySelectSortView; // 选择排序方式View

@property (nonatomic, assign) BOOL flagForIsShowingCityChooseView;
@property (nonatomic, assign) BOOL flagForIsShowingSortChooseView;

@property (nonatomic, assign) BOOL flagForChangedCity;
@property (nonatomic, assign) BOOL flagForChangedSort;

@property (nonatomic, copy) NSString *selectedCityId;
@property (nonatomic, copy) NSString *selectedAreaId;
@property (nonatomic, copy) NSString *selectedSort;

@property (nonatomic,strong) NSArray *dataSources;

@property (nonatomic,strong) NSArray *contentTaleViews;

@property (nonatomic,assign) NSInteger index;// 选中segmentView index

@property (nonatomic, assign) NSInteger curPage;

@end

@implementation SpaceLeaseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self vs_setTitleText:@"空间租赁"];
    
    self.edgesForExtendedLayout = 0;
    self.shouldShowOneKeyConsign = YES;
    self.shouldShouContactCustomService = YES;
    [self.customServiceButton setFrame:CGRectMake(__SCREEN_WIDTH__ - 64, self.view.frame.size.height - 49 - 49 - 70 - 60, 56, 60)];
    [self.oneKeyConsignButton setFrame:CGRectMake(__SCREEN_WIDTH__ - 64, self.view.frame.size.height - 49 - 60 - 60, 56, 60)];
    
    requestGroup = dispatch_group_create();
    manger = [[NewPolicyManager alloc] init];
    
    self.selectedCityId = @"110100"; //默认北京
    self.selectedAreaId = @"";
    self.selectedSort = @"sort_asc";
    self.curPage = 1;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self recoverRightButton];
    
    [self.view addSubview:self.vSAdsView];
    [self.view addSubview:self.segmentBar];
    
    __weak typeof(self) weakSelf = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView addHeaderWithCallback:^{
        [weakSelf requestData];
    }];
    
    [self.tableView addFooterWithCallback:^{
        [weakSelf refreshList:weakSelf.selectedSort page:[NSString stringWithFormat:@"%ld", weakSelf.curPage] row:@"10" tableView:nil];
    }];
    
    [self.tableView headerBeginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (VSAdsView *)vSAdsView {
    if (!_vSAdsView) {
        _vSAdsView = [[VSAdsView alloc] init];
        [_vSAdsView setFrame:CGRectMake(0, 0, __SCREEN_WIDTH__, __SCREEN_WIDTH__ * 320 / 750)];
        __weak typeof(self) weakself = self;
        [_vSAdsView setAdsClickBlock:^(id data) {
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
    return _vSAdsView;
}

- (void)recoverRightButton {
    
    self.navigationItem.rightBarButtonItem = nil;
    [self vs_showRightButton:YES];
    
    [self vs_showRightButton:YES];
    [self.vm_rightButton setFrame:_CGR(0, 0, 70, 28)];
    self.vm_rightButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.vm_rightButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.vm_rightButton setTitle:@"  我要合作" forState:UIControlStateNormal];
}

- (void)vs_rightButtonAction:(id)sender
{
    [self userlogin:LOGIN_BACK_DEFAULT popVc:self animated:YES LoginSucceed:^{
        CooperateViewController *controller = [[CooperateViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    } cancel:^{
        
    }];
}

- (void)requestData {
    
    [self loadAdData];
    
    [self getCityAndDistrict];
    
    [self refreshList:self.selectedSort page:@"1" row:@"10" tableView:nil];
    
    __weak typeof(self)weakself = self;
    dispatch_group_notify(requestGroup, dispatch_get_main_queue(), ^{
        [weakself vs_hideLoadingWithCompleteBlock:nil];
        [weakself.tableView headerEndRefreshing];
        [weakself.tableView footerEndRefreshing];
        [weakself.tableView reloadData];
    });
}

- (void)loadAdData {
    
    dispatch_group_enter(requestGroup);
    
    NSDictionary *dic = @{
                          @"bannerType":@"2",
                          @"objectId" : @"space",
                          };
    __weak typeof(self)weakself = self;
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *url = [NSString stringWithFormat:@"/RUI-CustomerJSONWebService-portlet.banner/get-banner-info/version/%@", [infoDictionary objectForKey:@"CFBundleShortVersionString"]];
    [BCNetWorkTool executeGETNetworkWithParameter:dic andUrlIdentifier:url withSuccess:^(id callBackData) {
        NSLog(@"%@",callBackData );
        
        NSDictionary *dic = (NSDictionary *)callBackData;
        
        weakself.adList = [BannerDTO mj_objectArrayWithKeyValuesArray:dic[@"advertisementList"]];
        
        [weakself vs_hideLoadingWithCompleteBlock:nil];
        
        [self.vSAdsView setAds:self.adList];
        
        dispatch_group_leave(requestGroup);
        
    } orFail:^(id callBackData) {
        [weakself vs_hideLoadingWithCompleteBlock:nil];
        
        dispatch_group_leave(requestGroup);
    }];
}

- (void)getCityAndDistrict {
    
//    /api/jsonws/RUI-CustomerJSONWebService-portlet.space/get--area-list/version/2.0.0
    dispatch_group_enter(requestGroup);
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *url = [NSString stringWithFormat:@"/RUI-CustomerJSONWebService-portlet.space/get-area-list/version/%@", [infoDictionary objectForKey:@"CFBundleShortVersionString"]];
    [BCNetWorkTool executeGETNetworkWithParameter:nil andUrlIdentifier:url withSuccess:^(id callBackData) {
        
        NSError *err;
        NSDictionary *dic = (NSDictionary *)callBackData;
        [self vs_hideLoadingWithCompleteBlock:nil];
         NSArray *list = [CityAreaModel arrayOfModelsFromDictionaries:[dic objectForKey:@"cityAreaList"] error:&err];
        
        for (CityAreaModel *c_model in list) {
            c_model.areaList = [AreaModel arrayOfModelsFromDictionaries:c_model.areaList];
        }
        
        [self.policySelectCItyAreaView onSetCityList:list];
        
        if ([list count] > 0) {
            [self vs_showRightButton:YES];
        }
        
        [self vs_hideLoadingWithCompleteBlock:nil];
        
        dispatch_group_leave(requestGroup);
        
    } orFail:^(id callBackData) {
        
        dispatch_group_leave(requestGroup);
    }];
}

- (void)refreshList:(NSString *)status  page:(NSString *)page row:(NSString *)row tableView:(UITableView *)tableView {
    
    dispatch_group_enter(requestGroup);
    
    NSDictionary *dic = @{
                          @"cityId" :   self.selectedCityId,
                          @"areaId" :   self.selectedAreaId,
                          @"sort"   :   status,
                          @"page"   :   page,
                          @"row"    :   row,
                          };
    
    __weak typeof(self)weakself = self;
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *url = [NSString stringWithFormat:@"/RUI-CustomerJSONWebService-portlet.space/get-space-lease/version/%@", [infoDictionary objectForKey:@"CFBundleShortVersionString"]];
    [BCNetWorkTool executeGETNetworkWithParameter:dic andUrlIdentifier:url withSuccess:^(id callBackData) {
        
        NSDictionary *dic = (NSDictionary *)callBackData;
        NSArray *spaceProjectList = [dic objectForKey:@"spaceProjectList"];
        
        if ([page isEqualToString:@"1"]) {
            [weakself.spaceProjectArray removeAllObjects];
        }
        for (NSDictionary *tmpDic in spaceProjectList) {
            SpaceProjectModel *spaceProjectModel = [[SpaceProjectModel alloc] initWithDic:tmpDic];
            [weakself.spaceProjectArray addObject:spaceProjectModel];
        }
        
        NSString *nextPage = [dic objectForKey:@"nextPage"];
        if ([nextPage isEqualToString:@"Y"]) {
            [weakself.tableView setFooterHidden:NO];
        }else{
            [weakself.tableView setFooterHidden:YES];
        }
        
        [weakself.tableView headerEndRefreshing];
        [weakself.tableView footerEndRefreshing];
        [self vs_hideLoadingWithCompleteBlock:nil];
        dispatch_group_leave(requestGroup);
        
        [weakself.tableView reloadData];
        
    } orFail:^(id callBackData) {
        
        [weakself.tableView headerEndRefreshing];
        [weakself.tableView footerEndRefreshing];
        [weakself vs_hideLoadingWithCompleteBlock:nil];
        
        NSDictionary *dic = (NSDictionary *)callBackData;
        NSString *errorMessage = [dic objectForKey:@"errorMessage"];
        [weakself.view showTipsView:errorMessage];
        
        dispatch_group_leave(requestGroup);
    }];
}

#pragma mark -- 控件初始化

- (NSMutableArray *)spaceProjectArray {
    
    if (!_spaceProjectArray) {
        
        _spaceProjectArray = [[NSMutableArray alloc] init];
    }
    return _spaceProjectArray;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = CGRectMake(0, self.segmentBar.frame.origin.y + self.segmentBar.frame.size.height, MainWidth, MainHeight - 64.0f - self.segmentBar.frame.size.height - self.vSAdsView.frame.size.height);
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        
        [_tableView registerClass:[AdsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([AdsTableViewCell class])];
        [_tableView registerClass:[SpaceLeaseListCell class] forCellReuseIdentifier:@"SpaceLeaseListCell"];
    }
    
    return _tableView;
}

- (UIButton *)blackClearView {
    if (!_blackClearView) {
        _blackClearView = [[UIButton alloc] initWithFrame:CGRectMake(0, 44 + (__SCREEN_WIDTH__ * 320 / 750), __SCREEN_WIDTH__, __SCREEN_HEIGHT__ - 64 - 44 - (__SCREEN_WIDTH__ * 320 / 750))];
        [_blackClearView setBackgroundColor:ColorWithHex(0x000000, 0.3)];
        [_blackClearView addTarget:self action:@selector(blackClearAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _blackClearView;
}

- (void)blackClearAction:(UIButton *)button {
    
    if (self.flagForChangedCity) {
        [self.areaButton setImage:__IMAGENAMED__(@"xz_h") forState:UIControlStateNormal];
    } else {
        [_areaButton setTitleColor:ColorWithHex(0x302f37, 1.0) forState:UIControlStateNormal];
    }
    
    if (self.flagForChangedSort) {
        [_sortButton setTitleColor:ColorWithHex(0x00c88c, 1.0) forState:UIControlStateNormal];
        [self.sortButton setImage:__IMAGENAMED__(@"xz_h") forState:UIControlStateNormal];
    } else {
        [_sortButton setTitleColor:ColorWithHex(0x00c88c, 1.0) forState:UIControlStateNormal];
        [self.sortButton setImage:__IMAGENAMED__(@"xz_h") forState:UIControlStateNormal];
    }
    
    self.flagForIsShowingCityChooseView = NO;
    [self.policySelectCItyAreaView removeFromSuperview];
    self.flagForChangedSort = NO;
    [self.policySelectSortView removeFromSuperview];
    
    [self.blackClearView removeFromSuperview];
}

- (UIView *)segmentBar {
    if (!_segmentBar) {
        _segmentBar = [[UIView alloc] initWithFrame:CGRectMake(0, (__SCREEN_WIDTH__ * 320 / 750), __SCREEN_WIDTH__, 44)];
        [_segmentBar setBackgroundColor:ColorWithHex(0xf7f7f7, 1.0)];
        [_segmentBar addSubview:self.areaButton];
        [_segmentBar addSubview:self.sortButton];
    }
    return _segmentBar;
}

- (ArrowUpAndDownTwoColButton *)areaButton {
    if (!_areaButton) {
        _areaButton = [[ArrowUpAndDownTwoColButton alloc] initWithFrame:CGRectMake(0, 0, (__SCREEN_WIDTH__ / 2) - 0.5, 44)];
        [_areaButton setTitle:@"区域" forState:UIControlStateNormal];
        [_areaButton setTitleColor:ColorWithHex(0x302f37, 1.0) forState:UIControlStateNormal];
        [_areaButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_areaButton.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        
        [_areaButton addTarget:self action:@selector(areaAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _areaButton;
}

- (void)areaAction {
    
    [_areaButton setTitleColor:ColorWithHex(0x00c88c, 1.0) forState:UIControlStateNormal];
    [self.sortButton setImage:__IMAGENAMED__(@"xz_h") forState:UIControlStateNormal];
        [_sortButton setTitleColor:ColorWithHex(0x302f37, 1.0) forState:UIControlStateNormal];
    
    self.flagForIsShowingSortChooseView = NO;
    [self.policySelectSortView removeFromSuperview];
    [self.blackClearView removeFromSuperview];

    if (self.flagForIsShowingCityChooseView) {
        self.flagForIsShowingCityChooseView = NO;
        [self.policySelectCItyAreaView removeFromSuperview];
        [self.blackClearView removeFromSuperview];
        if (self.flagForChangedCity) {
            [self.areaButton setImage:__IMAGENAMED__(@"xz_h") forState:UIControlStateNormal];
        } else {
            [_areaButton setTitleColor:ColorWithHex(0x302f37, 1.0) forState:UIControlStateNormal];
        }
    } else {
        self.flagForIsShowingCityChooseView = YES;
        [self.view addSubview:self.blackClearView];
        [self.blackClearView addSubview:self.policySelectCItyAreaView];
    }
}

- (ArrowUpAndDownTwoColButton *)sortButton {
    if (!_sortButton) {
        _sortButton = [[ArrowUpAndDownTwoColButton alloc] initWithFrame:CGRectMake((__SCREEN_WIDTH__ / 2) + 0.5, 0, (__SCREEN_WIDTH__ / 2) - 0.5, 44)];
        [_sortButton setTitle:@"智能排序" forState:UIControlStateNormal];
        [_sortButton setTitleColor:ColorWithHex(0x00c88c, 1.0) forState:UIControlStateNormal];
        [_sortButton setImage:__IMAGENAMED__(@"xz_h") forState:UIControlStateNormal];
        [_sortButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        
        [_sortButton addTarget:self action:@selector(sortAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sortButton;
}

- (void)sortAction {

    if (self.flagForChangedCity) {
        [self.areaButton setImage:__IMAGENAMED__(@"xz_h") forState:UIControlStateNormal];
    } else {
        [self.areaButton setTitleColor:ColorWithHex(0x302f37, 1.0) forState:UIControlStateNormal];
    }
    
    [self.sortButton setTitleColor:ColorWithHex(0x00c88c, 1.0) forState:UIControlStateNormal];
    
    self.flagForIsShowingCityChooseView = NO;
    [self.policySelectCItyAreaView removeFromSuperview];
    [self.blackClearView removeFromSuperview];

    if (self.flagForIsShowingSortChooseView) {
        self.flagForIsShowingSortChooseView = NO;
        [self.policySelectSortView removeFromSuperview];
        [self.blackClearView removeFromSuperview];
        if (self.flagForChangedSort) {
            [self.sortButton setImage:__IMAGENAMED__(@"xz_h") forState:UIControlStateNormal];
        } else {
            [self.sortButton setImage:__IMAGENAMED__(@"xz_h") forState:UIControlStateNormal];
        }
    } else {
        self.flagForIsShowingSortChooseView = YES;
        [self.view addSubview:self.blackClearView];
        [self.blackClearView addSubview:self.policySelectSortView];
    }
}

- (PolicySelectCItyAreaView *)policySelectCItyAreaView {
    
    if (!_policySelectCItyAreaView) {
        _policySelectCItyAreaView = [[PolicySelectCItyAreaView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_WIDTH__, __SCREEN_HEIGHT__ * 670 / 1334)];
        
        __weak typeof(&*self) weakSelf = self;
        [_policySelectCItyAreaView setOnSelectedAreaBlock:^(CityAreaModel *cityAreaModel,NSMutableArray *selectedAreas,NSString *selectedAreasString){
            
            weakSelf.flagForChangedCity = YES;
            
            weakSelf.selectedCityId = cityAreaModel.cityId;
            weakSelf.selectedAreaId = selectedAreasString;
            if (![selectedAreasString isEqualToString:@""]) {
                //部分选择，拼接展示字段
                NSMutableString *displayString = [[NSMutableString alloc] init];
                for (AreaModel *selModel in selectedAreas) {
                    if (displayString.length == 0) {
                        [displayString appendString:selModel.areaName];
                    } else {
                        [displayString appendString:@","];
                        [displayString appendString:selModel.areaName];
                    }
                }
                [weakSelf.areaButton setTitle:displayString forState:UIControlStateNormal];
            } else {
                //全部
                if (![cityAreaModel.cityName isEqualToString:@""]) {
                    [weakSelf.areaButton setTitle:cityAreaModel.cityName forState:UIControlStateNormal];
                }
            }
            
            
            for (NSMutableArray *array in weakSelf.dataSources) {
                [array removeAllObjects];
            }
            
            [weakSelf refreshList:weakSelf.selectedSort page:@"1" row:@"10" tableView:weakSelf.tableView];
            
            weakSelf.flagForIsShowingCityChooseView = NO;
            [weakSelf.policySelectCItyAreaView removeFromSuperview];
            [weakSelf.blackClearView removeFromSuperview];
            [weakSelf.areaButton setTitleColor:ColorWithHex(0x00c88c, 1.0) forState:UIControlStateNormal];
            [weakSelf.areaButton setImage:__IMAGENAMED__(@"xz_h") forState:UIControlStateNormal];
        }];
    }
    return _policySelectCItyAreaView;
}

- (PolicySelectSortTypeView *)policySelectSortView {
    
    if (!_policySelectSortView) {
        _policySelectSortView = [[PolicySelectSortTypeView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_WIDTH__, __SCREEN_HEIGHT__ - 64 - 44 - (__SCREEN_WIDTH__ * 320 / 750))];
        
        __weak typeof(&*self) weakSelf = self;
        [_policySelectSortView setOnSelectedSortTypeBlock:^(NSString *selectedSortString, NSInteger selectIndex) {
            if (selectedSortString) {
                weakSelf.flagForChangedSort = YES;
                
                [weakSelf.sortButton setTitle:selectedSortString forState:UIControlStateNormal];
                
                for (NSMutableArray *array in weakSelf.dataSources) {
                    [array removeAllObjects];
                }
            
                switch (selectIndex) {
                    case 0:
                        weakSelf.selectedSort = @"sort_asc";
                        break;
                    case 1:
                        weakSelf.selectedSort = @"updateTime_desc";
                        break;
                    case 2:
                        weakSelf.selectedSort = @"singlePrice_asc";
                        break;
                    case 3:
                        weakSelf.selectedSort = @"singlePrice_desc";
                        break;
                        
                    default:
                        break;
                }
                [weakSelf refreshList:weakSelf.selectedSort page:@"1" row:@"10" tableView:weakSelf.tableView];
                
                weakSelf.flagForIsShowingSortChooseView = NO;
                [weakSelf.policySelectSortView removeFromSuperview];
                [weakSelf.blackClearView removeFromSuperview];
                [weakSelf.sortButton setTitleColor:ColorWithHex(0x00c88c, 1.0) forState:UIControlStateNormal];
                [weakSelf.sortButton setImage:__IMAGENAMED__(@"xz_h") forState:UIControlStateNormal];
            } else {
                [weakSelf vs_rightButtonAction:nil];
            }
        }];
    }
    return _policySelectSortView;
}

#pragma mark -  tableView delegate and dataSource method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return self.spaceProjectArray.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        SpaceLeaseListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SpaceLeaseListCell class])];
        
        SpaceProjectModel *model = [self.spaceProjectArray objectAtIndex:indexPath.row];
        [cell setDataSource:model];
        
        return cell;
    }
    
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return [SpaceLeaseListCell getHeight];
    }
    
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return [[UIView alloc] init];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        SpaceProjectModel *model = [self.spaceProjectArray objectAtIndex:indexPath.row];
        SpaceLeaseDetailViewController *webVC = [[SpaceLeaseDetailViewController alloc] initWithUrl:[NSURL URLWithString:model.projectDetail]];
        webVC.model = model;
        [self.navigationController pushViewController:webVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.0001f;
}

@end

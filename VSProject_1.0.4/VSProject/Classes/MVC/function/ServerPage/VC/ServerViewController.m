//
//  ServerViewController.m
//  VSProject
//
//  Created by pch_tiger on 16/12/18.
//  Copyright © 2016年 user. All rights reserved.
//

#import "ServerViewController.h"
#import "NewShareWebViewController.h"
#import "ServerCollectionCell.h"
#import "AdsTableViewCell.h"
#import "BCNetWorkTool.h"
#import "BannerDTO.h"
#import "MJExtension.h"
#import "ServerBoutiqueSectionCell.h"
#import "ServerListViewController.h"
#import "HomeManger.h"
#import "RTXCAppModel.h"
#import "ServerManger.h"
#import "ServerProductDTO.h"
#import "AppointmentViewController.h"
#import "SpacePageViewController.h"
#import "ServerButtonCell.h"
#import "TopicDTO.h"
#import "ServerRegion_2_TableViewCell.h"
#import "ServerRegion_3_TableViewCell.h"
#import "ServerRegion_4_TableViewCell.h"
#import "ServerRegion_5_TableViewCell.h"

@interface ServerViewController () <UITableViewDelegate, UITableViewDataSource, ServerButtonDelegate>
{
    HomeManger *manger;
    ServerManger *serverManger;
    dispatch_group_t requestGroup;
}

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *adList; // 广告数据源

@property (nonatomic, strong) NSMutableArray *serverList; // 服务数据源

@property (nonatomic, strong) NSMutableArray *serverBoutiqueList; // 精品服务数据列表

@property (nonatomic, strong) NSMutableArray *serverTopicList; // 服务主题数据

@property (nonatomic, strong) NSMutableArray *floorList;

@end

@implementation ServerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.shouldShowOneKeyConsign = YES;
    self.shouldShouContactCustomService  = YES;
    
    requestGroup = dispatch_group_create();
    
    manger = [[HomeManger alloc]init];
    
    serverManger = [[ServerManger alloc] init];
    
    [self vs_setTitleText:@"服务"];
    
    self.view.backgroundColor = _COLOR_HEX(0xdedede);
    
    __weak typeof(self) weakSelf = self;
    [self.view addSubview:self.tableView];
    self.view.frame = CGRectMake(0, 64.0f, MainWidth, MainHeight - 64.0f - 44.0f);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.leading.trailing.equalTo(weakSelf.view);
    }];
    
    [self.tableView addHeaderWithCallback:^{
        [weakSelf requestData];
    }];
    
    [self.tableView registerClass:[ServerBoutiqueSectionCell class] forCellReuseIdentifier:@"ServerBoutiqueSectionCell"];
    
    [self.tableView headerBeginRefreshing];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark -- 控件初始化

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        
        [_tableView registerClass:[AdsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([AdsTableViewCell class])];
        [_tableView registerClass:[ServerButtonCell class] forCellReuseIdentifier:NSStringFromClass([ServerButtonCell class])];
        
        [_tableView registerClass:[ServerRegion_2_TableViewCell class] forCellReuseIdentifier:NSStringFromClass([ServerRegion_2_TableViewCell class])];
        [_tableView registerClass:[ServerRegion_3_TableViewCell class] forCellReuseIdentifier:NSStringFromClass([ServerRegion_3_TableViewCell class])];
        [_tableView registerClass:[ServerRegion_4_TableViewCell class] forCellReuseIdentifier:NSStringFromClass([ServerRegion_4_TableViewCell class])];
        [_tableView registerClass:[ServerRegion_5_TableViewCell class] forCellReuseIdentifier:NSStringFromClass([ServerRegion_5_TableViewCell class])];
        
    }
    
    return _tableView;
}

- (NSMutableArray *)serverList {
    
    if (!_serverList) {
        _serverList = [NSMutableArray array];
    }
    return _serverList;
}

- (NSMutableArray *)serverBoutiqueList {
    
    if (!_serverBoutiqueList) {
        _serverBoutiqueList = [NSMutableArray array];
    }
    return _serverBoutiqueList;
}

- (NSMutableArray *)serverTopicList {
    
    if (!_serverTopicList) {
        _serverTopicList = [NSMutableArray array];
    }
    return _serverTopicList;
}

- (NSMutableArray *)floorList {
    
    if (!_floorList) {
        _floorList = [NSMutableArray array];
    }
    return _floorList;
}

#pragma mark -- 获取网络数据源

- (void)requestData {
    
//    [self vs_showLoading];
    
    [self loadAdData];
    [self loadServerData];
    [self loadBoutiqueData];
    [self loadTopicData];
    
    dispatch_group_notify(requestGroup, dispatch_get_main_queue(), ^{
        [self vs_hideLoadingWithCompleteBlock:nil];
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];
        
        [self.floorList removeAllObjects];
        if (self.adList.count > 0) {
            [self.floorList addObject:self.adList];
        }
        if (self.serverList.count > 0) {
            [self.floorList addObject:self.serverList];
        }
        if (self.serverTopicList.count > 0) {
            [self.floorList addObject:self.serverTopicList];
        }
        if (self.serverBoutiqueList.count > 0) {
            [self.floorList addObject:self.serverBoutiqueList];
        }
        
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
        
        self.adList = [BannerDTO mj_objectArrayWithKeyValuesArray:dic[@"advertisementList"]];
        
        dispatch_group_leave(requestGroup);
        
    } orFail:^(id callBackData) {
        dispatch_group_leave(requestGroup);
    }];
}

- (void)loadServerData {
    
    /*
     获取服务列表
     */
    dispatch_group_enter(requestGroup);
    
    [serverManger getServiceAppArea:[NSDictionary dictionary] success:^(NSDictionary *responseObj) {
        
        NSMutableArray *arr = [NSMutableArray arrayWithArray:[responseObj objectForKey:@"appList"]];
        NSMutableArray *mArr = [NSMutableArray array];
        
        for (int i = 0; i <arr.count; i++) {
            
            NSDictionary *dic = [arr objectAtIndex:i];
            RTXBapplicationInfoModel *model = [RTXBapplicationInfoModel mj_objectWithKeyValues:dic];
            [mArr addObject:model];
        }
        
        self.serverList = [NSMutableArray arrayWithArray:mArr];
        
        dispatch_group_leave(requestGroup);
        
    } failure:^(NSError *error) {
        dispatch_group_leave(requestGroup);
    }];
}

- (void)loadBoutiqueData {
    
    /*
     获取精品服务列表
     */
    dispatch_group_enter(requestGroup);
    
    __weak typeof(self)weakself = self;
    [serverManger getServiceProduct:[NSDictionary dictionary] success:^(NSDictionary *responseObj) {

        [weakself.serverBoutiqueList removeAllObjects];
       NSMutableArray *productList = [responseObj mutableArrayValueForKey:@"productList"];
        for (NSInteger index=0; index<productList.count; ++index) {
            ServerProductDTO *productDTO = [[ServerProductDTO alloc] initWithDic:[productList objectAtIndex:index]];
            [weakself.serverBoutiqueList addObject:productDTO];
        }
        
        dispatch_group_leave(requestGroup);
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        dispatch_group_leave(requestGroup);
    }];
}

- (void)loadTopicData {
    
    /*
     获取精品服务列表
     */
    dispatch_group_enter(requestGroup);
    
    __weak typeof(self)weakself = self;
    [BCNetWorkTool executeGETNetworkWithParameter:nil andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.home/get-service-topic/version/1.6.0" withSuccess:^(id callBackData) {
        NSLog(@"%@",callBackData );
        
        NSDictionary *dic = (NSDictionary *)callBackData;
        
        [weakself.serverTopicList removeAllObjects];
        NSArray *topicList = [dic arrayValue:@"topicList"];
        for (NSDictionary *dic in topicList) {
            TopicDTO *topicDTO = [[TopicDTO alloc] initWithDic:dic];
            [weakself.serverTopicList addObject:topicDTO];
        }
        
        dispatch_group_leave(requestGroup);
        
    } orFail:^(id callBackData) {
        dispatch_group_leave(requestGroup);
    }];
}

#pragma mark -  tableView delegate and dataSource method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.floorList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0 && self.adList.count > 0) {
        return 1;
    }
    else if (section == 1 && self.serverList.count > 0) {
        return 1;
    }
    else if (section == 2) {
        if (self.serverTopicList.count > 0) {
            return self.serverTopicList.count;
        }
        else {
            return self.serverBoutiqueList.count;
        }
    }
    else if (section == 3) {
        return self.serverBoutiqueList.count;
    }
    else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && self.adList.count > 0) {
        
        AdsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AdsTableViewCell class])];
        cell.ads = self.adList;
        
        __weak typeof(self) weakself = self;
        [cell setAdsClickBlock:^(id data) {
            
            
            if ([data isKindOfClass:[BannerDTO class]]) {
                BannerDTO *dto = (BannerDTO *)data;
                
                if ([dto.bannerDetail.uppercaseString hasPrefix:@"HTTP"]) {
                    
                    NSLog(@"%@",dto.bannerDetail);
                    
                    NewShareWebViewController *vc = [[NewShareWebViewController alloc] initWithUrl:[NSURL URLWithString:dto.bannerDetail]];
                    [weakself.navigationController pushViewController:vc animated:YES];
                }
            }
            
        }];
        
        return cell;
        
        
    }else if(indexPath.section == 1 && self.serverList.count > 0) {
        
        ServerButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ServerButtonCell"];
        
        if (cell == nil) {
            cell = [[ServerButtonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ServerButtonCell"];
        }
        
        cell.delegate = self;
        [cell setDataSource:self.serverList];
        
        return cell;
    }
    else if(indexPath.section == 2) {
        
        if (self.serverTopicList.count > 0) {
            TopicDTO *topicDTO = [self.serverTopicList objectAtIndex:indexPath.row];
            if (topicDTO.projectList.count == 2) {
                ServerRegion_2_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ServerRegion_2_TableViewCell"];
                
                [cell setDataSource:topicDTO];
                [cell setServerRgion_2_Block:^(TopicProductDTO *topicDTO) {
                    [self gotoTopicViewController:topicDTO];
                }];
                
                return cell;
            }
            else if (topicDTO.projectList.count == 3) {
                ServerRegion_3_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ServerRegion_3_TableViewCell"];
                
                [cell setDataSource:topicDTO];
                [cell setServerRgion_3_Block:^(TopicProductDTO *topicDTO) {
                    [self gotoTopicViewController:topicDTO];
                }];
                
                return cell;
            }
            else if (topicDTO.projectList.count == 4) {
                ServerRegion_4_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ServerRegion_4_TableViewCell"];
                
                [cell setDataSource:topicDTO];
                [cell setServerRgion_4_Block:^(TopicProductDTO *topicDTO) {
                    [self gotoTopicViewController:topicDTO];
                }];
                
                return cell;
            }
            else if (topicDTO.projectList.count == 5) {
                ServerRegion_5_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ServerRegion_5_TableViewCell"];
                
                [cell setDataSource:topicDTO];
                [cell setServerRgion_5_Block:^(TopicProductDTO *topicDTO) {
                    [self gotoTopicViewController:topicDTO];
                }];
                
                return cell;
            }
            else {
                return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            }
        }
        else {
            ServerBoutiqueSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ServerBoutiqueSectionCell" forIndexPath:indexPath];
            
            cell.type = CELLTYPE_BOUTIQUE;
            cell.adImageView.backgroundColor = [UIColor redColor];
            ServerProductDTO *productDTO = [self.serverBoutiqueList objectAtIndex:indexPath.row];
            [cell setData:productDTO];
            
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            return cell;
        }
    }
    else if (indexPath.section == 3) {
        
        ServerBoutiqueSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ServerBoutiqueSectionCell" forIndexPath:indexPath];
        
        cell.type = CELLTYPE_BOUTIQUE;
        cell.adImageView.backgroundColor = [UIColor redColor];
        ServerProductDTO *productDTO = [self.serverBoutiqueList objectAtIndex:indexPath.row];
        [cell setData:productDTO];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        return cell;
    }
    
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && self.adList.count > 0) {
        
        
        return 320/750.0 * [UIScreen mainScreen].bounds.size.width;
        
    }else if (indexPath.section == 1 && self.serverList.count > 0) {
        
        return [ServerButtonCell getHeightWithIconCount:self.serverList.count];
        
    }else if(indexPath.section == 2) {
        
        if (self.serverTopicList.count > 0) {
        TopicDTO *topicDTO = [self.serverTopicList objectAtIndex:indexPath.row];
            if (topicDTO.projectList.count == 2) {
                return [ServerRegion_2_TableViewCell getHeight];
            }
            else if (topicDTO.projectList.count == 3) {
                return [ServerRegion_3_TableViewCell getHeight];
            }
            else if (topicDTO.projectList.count == 4) {
                return [ServerRegion_4_TableViewCell getHeight];
            }
            else if (topicDTO.projectList.count == 5) {
                return [ServerRegion_5_TableViewCell getHeight];
            }
            else {
                return 0.0001f;
            }
        }
        else {
            return 100.0f + 5.0f;
        }
    }
    else if (indexPath.section == 3) {
        return 100.0f + 5.0f;
    }
    
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    if ((section == 2 && self.serverTopicList.count <= 0) || (section == 3 && self.serverBoutiqueList.count > 0)) {
        UIView *headView = [[UIView alloc] init];
        headView.frame = CGRectMake(0, 0, MainWidth, 32.5f);
        headView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *iconImageView = [[UIImageView alloc] init];
        iconImageView.frame = CGRectMake(12.0f, 9.0f, 14.0f, 14.0f);
        iconImageView.image = [UIImage imageNamed:@"server_circle"];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(iconImageView.frame.origin.x + iconImageView.frame.size.width + 5.0f, 9.0f, MainWidth - 12.0f*2 - 14.0f - 5.0f, 16.0f);
        titleLabel.font = [UIFont systemFontOfSize:15.0f];
        titleLabel.textColor = _Colorhex(0x828282);
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.text = @"精选服务";
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 32.0f, MainWidth, 0.5f)];
        lineView.backgroundColor = _Colorhex(0xcdcdcd);
        
        [headView addSubview:iconImageView];
        [headView addSubview:titleLabel];
        [headView addSubview:lineView];
        
        return headView;
    }
    
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ((indexPath.section == 2 && self.serverTopicList.count <= 0) || indexPath.section == 3) {
        [self userlogin:LOGIN_BACK_DEFAULT popVc:self animated:YES LoginSucceed:^{
            ServerProductDTO *productDTO = [self.serverBoutiqueList objectAtIndex:indexPath.row];
            NewShareWebViewController *jswebvc = [[NewShareWebViewController alloc] initWithUrl:[NSURL URLWithString:productDTO.productDetail]];
            [self.navigationController pushViewController:jswebvc animated:YES];
        } cancel:^{
            
        }];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    if ((section == 2 && self.serverTopicList.count <= 0) || section == 3) {
        return 32.5f;
    }
    else {
        return 0.00001;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if ((section == 1 && self.serverTopicList.count <= 0) || (section == 2 && self.serverTopicList.count > 0 && self.serverBoutiqueList.count > 0)) {
        return 5.0f;
    }
    else {
        return 0.0001;
    }
}

#pragma mark -- ServerButtonDelegate 

- (void)clickedButtonAction:(RTXBapplicationInfoModel *)model {
    
    [self userlogin:LOGIN_BACK_DEFAULT popVc:self animated:YES LoginSucceed:^{
        if ([model.visitType isEqualToString:@"NATIVE"]) {
            [VSPageRoute routeToTarget:model];
        }
        else {
            [self toApplication:model fromController:self];
        }
    } cancel:^{
        
    }];
}

- (void)gotoTopicViewController:(TopicProductDTO *)topicDTO {
    
    [self userlogin:LOGIN_BACK_DEFAULT popVc:self animated:YES LoginSucceed:^{
        NewShareWebViewController *jswebvc = [[NewShareWebViewController alloc] initWithUrl:[NSURL URLWithString:topicDTO.productDetailUrl]];
        [self.navigationController pushViewController:jswebvc animated:YES];
    } cancel:^{
        
    }];
}

@end

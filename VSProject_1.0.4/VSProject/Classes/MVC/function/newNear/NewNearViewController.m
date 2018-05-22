//
//  NewNearViewController.m
//  VSProject
//
//  Created by 陈 海涛 on 16/7/28.
//  Copyright © 2016年 user. All rights reserved.
//

#import "NewNearViewController.h"
#import "AdsTableViewCell.h"
#import "ManagementManger.h"
#import "RTXCAppModel.h"
#import "MJRefresh.h"
#import "BCNetWorkTool.h"
#import "NearNewProductCell.h"
#import "VSJsWebViewController.h"
#import "NewShareWebViewController.h"
#import "newNearSelectedProjectViewController.h"
#import "BannerDTO.h"
#import "MJExtension.h"
#import "VSPageRoute.h"
#import "NearCollectionViewCell.h"
#import "NearNewTableViewCell.h"


#define homeb_cellheight          (MainWidth/3.000000)

@interface NewNearViewController ()
{
    UILabel* titleLabel;
    
    ManagementManger *manger;
    
    NSArray *dataList;
    
    NSArray *productList;
    
    dispatch_group_t requestGorup;
}

@property (nonatomic, strong)UICollectionView *collectionView;

@property (nonatomic,strong) UIView *sectionHeaderView;

@property (nonatomic,strong) newNearSelectedProjectViewController *selectedVC;

@property (nonatomic,strong) NSArray *adList;

@end

@implementation NewNearViewController


- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView registerClass:[AdsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([AdsTableViewCell class])];
        
        [_tableView registerClass:[NearNewProductCell   class] forCellReuseIdentifier:NSStringFromClass([NearNewProductCell class])];
        
        [_tableView registerClass:[NearNewTableViewCell   class] forCellReuseIdentifier:NSStringFromClass([NearNewTableViewCell class])];
        
        
    }
    
    return _tableView;
}


- (UIView *)sectionHeaderView{
    if (_sectionHeaderView == nil) {
        _sectionHeaderView = [UIView new];
        _sectionHeaderView.backgroundColor = _COLOR_WHITE;
        
        UIView *view = _sectionHeaderView;
        
        UIView *lineView = [UIView new];
        lineView.backgroundColor = _Colorhex(0xcccccc);
        [_sectionHeaderView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.trailing.equalTo(view);
            make.height.mas_equalTo(0.5);
        }];
        
        UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"server_circle"]];
        [_sectionHeaderView addSubview:imageView];
        
        
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).offset(10);
        }];
        
        UILabel *contentLabel = [UILabel new];
        contentLabel.text = @"最新产品";
        contentLabel.textAlignment = NSTextAlignmentLeft;
        contentLabel.font = [UIFont systemFontOfSize:14];
        contentLabel.textColor = _COLOR_BLACK;
        
        [_sectionHeaderView addSubview:contentLabel];
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view).offset(15);
            make.leading.equalTo(imageView.mas_trailing).offset(6);
            make.centerY.equalTo(imageView);
        }];
    }
    
    return _sectionHeaderView;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.shouldShowOneKeyConsign = YES;
    self.shouldShouContactCustomService = YES;
    self.edgesForExtendedLayout = 0;
    
    [self vs_setTitleText:self.targetproject.projectName];
    
    requestGorup = dispatch_group_create();
    
    manger = [[ManagementManger alloc]init];
    
//    [self buildNavigationItem];
    
    self.view.backgroundColor = _COLOR_HEX(0xdedede);
    
    __weak typeof(self) weakSelf = self;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.leading.trailing.equalTo(weakSelf.view);
    }];
    
    [self.tableView addHeaderWithCallback:^{
        [weakSelf reqeustData];
    }];
    
    
    [self.tableView addFooterWithCallback:^{
        [weakSelf reqeustMoreData];
    }];
    
    [self reqeustData];
    
    
  /*
    newNearSelectedProjectViewController *selectedVC = [[newNearSelectedProjectViewController alloc] init];
    
    [self addChildViewController:selectedVC];
    selectedVC.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, [UIScreen mainScreen].bounds.size.height - 49);
    [self.view addSubview:selectedVC.view];
    [selectedVC didMoveToParentViewController:self];
    self.selectedVC = selectedVC;
    
    [self.selectedVC setCallBackBlock:^(Project *p){
        weakSelf.targetproject = p;
        [weakSelf reqeustData];
    }];
    */
}

- (void)setTargetproject:(Project *)targetproject{
    _targetproject = targetproject;
    
    [[VSUserLogicManager shareInstance] userDataInfo].vm_catalogId = targetproject.id;
    
    
}


- (void)reqeustData{
    
    [self vs_showLoading];
    
    [self requestBusinessApplications];
    
    [self loadData];
    
    [self loadAdData];
    
    dispatch_group_notify(requestGorup, dispatch_get_main_queue(), ^{
        
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        
        if (productList.count % 5 > 0) {
            [self.tableView removeFooter];
        }
        
        [self.collectionView reloadData];
        [self.tableView reloadData];
        
        [self resetTitle];
        
        [self vs_hideLoadingWithCompleteBlock:nil];
        
        
    });
}




- (void)loadAdData{
    /**
     
     banner-type	Banner类型：1：全局首页，2：应用，3：项目
     object-id	Banner类型对应对象id，类型是全局object-id传空
     
     
     */
    
    dispatch_group_enter(requestGorup);
    
    NSDictionary *dic = @{
                          @"bannerType":@"3",
                          @"objectId":self.targetproject.id
                          };
    
    [BCNetWorkTool executeGETNetworkWithParameter:dic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.banner/get-banner-info/version/1.2.0" withSuccess:^(id callBackData) {
        NSLog(@"%@",callBackData );
        
        NSDictionary *dic = (NSDictionary *)callBackData;
        
        self.adList = [BannerDTO mj_objectArrayWithKeyValuesArray:dic[@"advertisementList"]];
        
        dispatch_group_leave(requestGorup);
        
    } orFail:^(id callBackData) {
        dispatch_group_leave(requestGorup);
    }];
}


- (void)reqeustMoreData{
    
    [self vs_showLoading];
    
    
    [self loadMoreData];
    
    __weak typeof(self ) weakSelf = self;
    
    dispatch_group_notify(requestGorup, dispatch_get_main_queue(), ^{
        
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        
        if (productList.count % 5 > 0) {
            [self.tableView removeFooter];
        }else{
            [self.tableView addFooterWithCallback:^{
                [weakSelf reqeustMoreData];
            }];
        }
        
        [self.collectionView reloadData];
        [self.tableView reloadData];
        
        [self vs_hideLoadingWithCompleteBlock:nil];
        
    });
}


- (UICollectionView *)collectionView{
    
    if (_collectionView == nil) {
        
        float itemHeight = 160/750.0 * [UIScreen mainScreen].bounds.size.width;
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        flowLayout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width/3.0000f, itemHeight);
        
        flowLayout.minimumLineSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.headerReferenceSize = CGSizeMake(0, 0);
        flowLayout.footerReferenceSize = CGSizeMake(0, 0);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = _COLOR_WHITE;
        
        _collectionView.delegate = (id<UICollectionViewDelegate>)self;
        _collectionView.dataSource = (id<UICollectionViewDataSource>)self;
        [_collectionView registerClass:[NearCollectionViewCell class] forCellWithReuseIdentifier:@"NearCollectionViewCell"];
    }
    
    return _collectionView;
    
}


- (void)loadData {
    
    dispatch_group_enter(requestGorup);
    
    NSString *organizationId = self.targetproject.id.length > 0?self.targetproject.id:@"";
    
    NSDictionary *para = @{@"page":@"1",@"row":@"5",@"organizationId":organizationId};
    
    
    [BCNetWorkTool executeGETNetworkWithParameter:para andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.application/get-organization-product-list" withSuccess:^(id callBackData) {
        
        
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *dic in callBackData[@"productList"]) {
            NearNewProduct *p = [[NearNewProduct alloc] initWithDictionary:dic];
            [arr addObject:p];
        }
        productList = [NSMutableArray arrayWithArray:arr];
        
        //        productList = [NearNewProduct arrayOfModelsFromDictionaries:callBackData[@"productList"]];
        
        dispatch_group_leave(requestGorup);
        
    } orFail:^(id callBackData) {
        
        [self.view showTipsView:[callBackData domain]];
        
        dispatch_group_leave(requestGorup);
    }];
}


- (void)loadMoreData {
    
    dispatch_group_enter(requestGorup);
    
    NSString *organizationId = self.targetproject.id.length > 0?self.targetproject.id:@"";
    
    NSInteger page = productList.count / 5 + 1;
    
    NSDictionary *para = @{@"page":[NSString stringWithFormat:@"%li",page],@"row":@"5",@"organizationId":organizationId};
    
    [BCNetWorkTool executeGETNetworkWithParameter:para andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.application/get-organization-product-list" withSuccess:^(id callBackData) {
        
        //                NSArray*  list  = [NearNewProduct arrayOfModelsFromDictionaries :callBackData[@"productList"]];
        
        NSMutableArray *list = [NSMutableArray array];
        for (NSDictionary *dic in callBackData[@"productList"]) {
            NearNewProduct *p = [[NearNewProduct alloc] initWithDictionary:dic];
            [list addObject:p];
        }
        
        
        
        NSMutableArray *mArr = [NSMutableArray array];
        
        [mArr addObjectsFromArray:productList];
        
        [mArr addObjectsFromArray:list];
        
        productList = [NSArray arrayWithArray:mArr];
        
        dispatch_group_leave(requestGorup);
        
    } orFail:^(id callBackData) {
        
        [self.view showTipsView:[callBackData domain]];
        
        dispatch_group_leave(requestGorup);
    }];
}

- (void)buildNavigationItem {
    
    UIButton *titleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, (MainWidth-84)/2, 64)];
    titleButton .backgroundColor = [UIColor clearColor];
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((titleButton.bounds.size.width - 80)/2, 12, 80, 40)];
    
    UIButton* locateView = [[UIButton alloc]initWithFrame:CGRectMake((titleButton.bounds.size.width - 80)/2 - 35, 12, 40, 40)];
    [locateView setImage:[UIImage imageNamed:@"location"] forState:0];
    locateView.tag = 1011;
    [titleButton addSubview:locateView];
    
    
    
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    [titleButton addSubview:titleLabel];
    
    
    self.navigationItem.titleView = titleButton;
    
    [self resetTitle];
}

- (void)resetTitle{
    
    UIView *locateView = [titleLabel.superview viewWithTag:1011];
    
    NSString *name = self.targetproject.projectName;
    if (name) {
        
        titleLabel.text = name;
        
        locateView.hidden = NO;
        
    }else{
        titleLabel.text = @"周边";
        locateView.hidden = YES;
    }
}


- (void)requestBusinessApplications {
    
    dispatch_group_enter(requestGorup);
    
    NSDictionary *dic = @{@"organizationId":self.targetproject.id};
    
    [manger requestBusinessApplications:dic success:^(NSDictionary *responseObj) {
        
        
        NSMutableArray *aar = [NSMutableArray arrayWithArray:[responseObj objectForKey:@"layout"]];
        
        NSMutableArray *mArr = [NSMutableArray array];
        
        for (int i = 0; i <aar.count; i++) {
            
            RTXCAppModel *model = [RTXCAppModel new ];
            RTXBapplicationInfoModel *aModel =aar[i];
            
            model.appIcon = aModel.appIcon;
            model.appIconKey = aModel.appIconKey;
            model.appIntroduction = aModel.appIntroduction;
            model.appName = aModel.appName;
            model.catalogId = aModel.catalogId;
            model.id  = aModel.m_id;
            model.orderType = aModel.orderType;
            model.protocol = aModel.protocol;
            model.visitType = aModel.visitType;
            model.visitkeyword = aModel.visitkeyword;
            
            [mArr addObject:model];
        }
        
        dataList  = [NSArray arrayWithArray:mArr];
        
        dispatch_group_leave(requestGorup);
        
        
    } failure:^(NSError *error) {
        
        [self.view showTipsView:[error domain]];
        dispatch_group_leave(requestGorup);
    }];
}


#pragma mark -  tableView delegate and dataSource method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 2) {
        return productList.count;
    }else{
        return 1;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
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
        
    }else if(indexPath.section == 1){
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
        }
        
        if (self.collectionView.superview) {
            [self.collectionView removeFromSuperview];
        }
        
        [cell.contentView addSubview:self.collectionView];
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
            make.top.equalTo(@(10));
        }];
        
        return cell;
        
        
    }else if(indexPath.section == 2){
        
        NearNewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NearNewTableViewCell class])];
        
        [cell setData:productList[indexPath.row]];
        
        return cell;
    }
    
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        return BannerHeight;
        
    }else if (indexPath.section == 1){
        
        return dataList.count > 0? 200/750.0 * [UIScreen mainScreen].bounds.size.width +1 : 0;
        
        
    }else if(indexPath.section == 2){
        
        return 100.0f + 5.0f;
    }
    
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 2) {
        return self.sectionHeaderView;
    }
    
    return nil;
}






- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    if (section == 2) {
        return 35;
    }
    
    return 0.00001;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 2) {
        NearNewProduct*  product = productList[indexPath.row];
        
        
        [[VSUserLogicManager shareInstance] userDataInfo].vm_orderTypeId = product.orderType;
        
        
        NewShareWebViewController *jswebvc = [[NewShareWebViewController alloc] initWithUrl:[NSURL URLWithString:product.productDetailUrl]];
        [self.navigationController pushViewController:jswebvc animated:YES];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RTXCAppModel *model = [dataList objectAtIndex:indexPath.row];
    
    NearCollectionViewCell *cell = (NearCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"NearCollectionViewCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor redColor];
    cell.c_titleLabel.text = model.appName;
    //    cell.c_subLabel.text = model.appIntroduction;
    
    NSString *imagePath = [NSString stringWithFormat:@"%@",model.appIcon];
    [cell.c_imageView sd_setImageWithString:imagePath placeholderImage:[UIImage imageNamed:@"usercenter_defaultpic"]];
    
    return cell;
}



#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RTXCAppModel *model = dataList[indexPath.row];
    
    model.organizationId = self.targetproject.id;
    
    [self toApplication:model fromController:self];
    
}


@end

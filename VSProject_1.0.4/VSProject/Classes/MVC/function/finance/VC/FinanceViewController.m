//
//  FinanceViewController.m
//  VSProject
//
//  Created by pangchao on 17/1/5.
//  Copyright © 2017年 user. All rights reserved.
//

#import "FinanceViewController.h"
#import "BCNetWorkTool.h"
#import "MJExtension.h"
#import "NewsModel.h"
#import "BusinessCollectionViewCell.h"
#import "NewShareWebViewController.h"
#import "PartnerCollectionViewCell.h"
#import "CaseTableViewCell.h"

@interface FinanceViewController () <UITableViewDelegate, UITableViewDataSource>
{
    dispatch_group_t requestGroup;
}

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray<NewsModel *> *businessList;

@property (nonatomic, strong) NSArray<NewsModel *> *caseList;

@property (nonatomic, strong) NSArray<NewsModel *> *partnerList;

@property (nonatomic, strong) UICollectionView *businessCollectionView; // 业务介绍

@property (nonatomic, strong) UICollectionView *partnerCollectionView; // 战略合作伙伴

@end

@implementation FinanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = 0;
    
    self.shouldShowOneKeyConsign = YES;
    self.shouldShouContactCustomService  = YES;
    
    [self vs_setTitleText:@"企业金融"];
    
    requestGroup = dispatch_group_create();
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    __weak typeof(self) weakSelf = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.leading.trailing.equalTo(weakSelf.view);
    }];
    
    [self.tableView addHeaderWithCallback:^{
        [weakSelf requestData];
    }];
    
    [self.tableView headerBeginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)requestData {
    
//    [self vs_showLoading];
    
    [self loadFinanceData];
    
    dispatch_group_notify(requestGroup, dispatch_get_main_queue(), ^{
        [self vs_hideLoadingWithCompleteBlock:nil];
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];
        [_tableView reloadData];
    });
}

- (void)loadFinanceData {
    
    dispatch_group_enter(requestGroup);
    
    __weak typeof(self)weakself = self;
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *url = [NSString stringWithFormat:@"/RUI-CustomerJSONWebService-portlet.news/get-enterprise-news/version/%@", [infoDictionary objectForKey:@"CFBundleShortVersionString"]];
    [BCNetWorkTool executeGETNetworkWithParameter:nil andUrlIdentifier:url withSuccess:^(id callBackData) {
        NSLog(@"%@",callBackData);
        
        NSDictionary *dic = (NSDictionary *)callBackData;
        weakself.businessList = [NewsModel mj_objectArrayWithKeyValuesArray:dic[@"businessList"]];
        weakself.caseList = [NewsModel mj_objectArrayWithKeyValuesArray:dic[@"caseList"]];
        weakself.partnerList = [NewsModel mj_objectArrayWithKeyValuesArray:dic[@"partnerList"]];
        
        dispatch_group_leave(requestGroup);
    } orFail:^(id callBackData) {
        dispatch_group_leave(requestGroup);
    }];
}

#pragma mark -- 控件初始化

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.frame = CGRectMake(0, 0, MainWidth, MainHeight - 64.0f);
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        
        [_tableView registerClass:[CaseTableViewCell class] forCellReuseIdentifier:@"CaseTableViewCell"];
    }
    
    return _tableView;
}

-  (UICollectionView *)businessCollectionView {
    
    if (_businessCollectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        flowLayout.itemSize = CGSizeMake((MainWidth)/2.000000f, 175.0f/2);
        flowLayout.minimumLineSpacing = 10.0f;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.headerReferenceSize = CGSizeMake(0, 0);
        flowLayout.footerReferenceSize = CGSizeMake(0, 0);
        flowLayout.minimumInteritemSpacing = 0.0f;
        
        _businessCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight) collectionViewLayout:flowLayout];
        _businessCollectionView.backgroundColor = [UIColor clearColor];
        _businessCollectionView.delegate = (id<UICollectionViewDelegate>)self;
        _businessCollectionView.dataSource = (id<UICollectionViewDataSource>)self;
        _businessCollectionView.showsVerticalScrollIndicator = NO;
        [_businessCollectionView registerClass:[BusinessCollectionViewCell class] forCellWithReuseIdentifier:@"BusinessCollectionViewCell"];
        _businessCollectionView.scrollEnabled = NO;
        _businessCollectionView.tag = 1001;
    }
    
    return _businessCollectionView;
}

-  (UICollectionView *)partnerCollectionView {
    
    if (_partnerCollectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        flowLayout.itemSize = CGSizeMake((MainWidth)/3.000000f, 45.0f);
        flowLayout.minimumLineSpacing = 0.0f;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.headerReferenceSize = CGSizeMake(0, 0);
        flowLayout.footerReferenceSize = CGSizeMake(0, 0);
        flowLayout.minimumInteritemSpacing = 0;
        
        _partnerCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight) collectionViewLayout:flowLayout];
        _partnerCollectionView.backgroundColor = [UIColor clearColor];
        _partnerCollectionView.delegate = (id<UICollectionViewDelegate>)self;
        _partnerCollectionView.dataSource = (id<UICollectionViewDataSource>)self;
        _partnerCollectionView.showsVerticalScrollIndicator = NO;
        [_partnerCollectionView registerClass:[PartnerCollectionViewCell class] forCellWithReuseIdentifier:@"PartnerCollectionViewCell"];
        _partnerCollectionView.scrollEnabled = NO;
        _partnerCollectionView.tag = 1002;
    }
    
    return _partnerCollectionView;
}

#pragma mark -  tableView delegate and dataSource method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    NSInteger sectionNum = 0;
    if (self.businessList.count > 0) {
        sectionNum ++;
    }
    if (self.caseList.count > 0) {
        sectionNum ++;
    }
    if (self.partnerList.count > 0) {
        sectionNum ++;
    }
    return sectionNum;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 1) {
        return self.caseList.count;
    }
    else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessCollectionCell"];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BusinessCollectionCell"];
            }
            
            if (self.businessCollectionView.superview) {
                [self.businessCollectionView removeFromSuperview];
            }
            
            [cell.contentView addSubview:self.businessCollectionView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [self.businessCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(cell.contentView);
            }];
            
            return cell;
        }
        case 1:
        {
            CaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CaseTableViewCell" forIndexPath:indexPath];
            
            NewsModel *model = [self.caseList objectAtIndex:indexPath.row];
            [cell setModel:model];
            
            return cell;
        }
        case 2:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PartnercollectionCell"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PartnercollectionCell"];
            }
            
            if (self.partnerCollectionView.superview) {
                [self.partnerCollectionView removeFromSuperview];
            }
            
            [cell.contentView addSubview:self.partnerCollectionView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [self.partnerCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(cell.contentView);
            }];
            
            return cell;
        }
    
        default:
            break;
    }
    
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        CGFloat cellHeight = 175.0f/2;
        if (self.businessList.count > 0) {
            return  (self.businessList.count % 2 ==0 ? self.businessList.count/2 : self.businessList.count/2+1) * (cellHeight + 10.0f);
        }
    }else if (indexPath.section == 1) {
        
        return 100.0f;
    }
    else if (indexPath.section == 2) {
        CGFloat cellHeight = 45.0f;
        if (self.partnerList.count > 0) {
            return  (self.partnerList.count % 3 ==0 ? self.partnerList.count/3 : self.partnerList.count/3+1) * (cellHeight);
        }
    }
    
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(12.0f, (45.0f - 14.0f)/2, 14.0f, 14.0f);
    [headerView addSubview:imageView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(imageView.frame.origin.x + imageView.frame.size.width + 7.5f, imageView.frame.origin.y, 200.0f, 14.0f);
    titleLabel.font = [UIFont systemFontOfSize:13.0f];
    titleLabel.textColor = _COLOR_HEX(0x212121);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [headerView addSubview:titleLabel];
    
    switch (section) {
        case 0:
            imageView.image = [UIImage imageNamed:@"business_head_icon"];
            titleLabel.text = @"业务介绍";
            break;
        case 1:
            imageView.image = [UIImage imageNamed:@"case_head_icon"];
            titleLabel.text = @"相关案例";
            break;
        case 2:
            imageView.image = [UIImage imageNamed:@"partner_head_con"];
            titleLabel.text = @"战略合作伙伴";
            break;
            
        default:
            break;
    }
    
    return headerView;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        NewsModel *model = self.caseList[indexPath.row];
        NewShareWebViewController *jswebvc = [[NewShareWebViewController alloc] initWithUrl:[NSURL URLWithString:model.visitURL]];
        [self.navigationController pushViewController:jswebvc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    CGFloat headHeight = 45.0f;
    switch (section) {
        case 0:
            if (self.businessList.count <= 0) {
                headHeight = 0.0001f;
            }
            break;
        case 1:
            if (self.caseList.count <= 0) {
                headHeight = 0.0001f;
            }
            break;
        case 2:
            if (self.partnerList.count <= 0) {
                headHeight = 0.0001f;
            }
            break;
            
        default:
            headHeight = 0.0001f;
            break;
    }
    
    return headHeight;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.0001f;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (collectionView.tag == 1001) {
        return self.businessList.count;
    }
    else if (collectionView.tag == 1002) {
        return self.partnerList.count;
    }
    else {
        return 0;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView.tag == 1001) {
        NewsModel *model = [self.businessList objectAtIndex:indexPath.row];
        
        BusinessCollectionViewCell *cell = (BusinessCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"BusinessCollectionViewCell" forIndexPath:indexPath];
        
        cell.backgroundColor = [UIColor clearColor];
        cell.nameLabel.text = model.title;
        [cell.imageView sd_setImageWithString:model.image placeholderImage:[UIImage imageNamed:@"usercenter_defaultpic"]];
        
        return cell;
    }
    else if (collectionView.tag == 1002) {
        NewsModel *model = [self.partnerList objectAtIndex:indexPath.row];
        
        PartnerCollectionViewCell *cell = (PartnerCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"PartnerCollectionViewCell" forIndexPath:indexPath];
        
        cell.backgroundColor = [UIColor clearColor];
        [cell.imageView sd_setImageWithString:model.image placeholderImage:[UIImage imageNamed:@"usercenter_defaultpic"]];
        
        return cell;
    }
    else {
        return [[UICollectionViewCell alloc] init];
    }
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView.tag == 1001) {
        [self userlogin:LOGIN_BACK_DEFAULT popVc:self animated:YES LoginSucceed:^{
            NewsModel *model = self.businessList[indexPath.row];
            NewShareWebViewController *jswebvc = [[NewShareWebViewController alloc] initWithUrl:[NSURL URLWithString:model.visitURL]];
            [self.navigationController pushViewController:jswebvc animated:YES];
        } cancel:^{
            
        }];
    }
    else if (collectionView.tag == 1002) {
      /*  [self userlogin:LOGIN_BACK_DEFAULT popVc:self animated:YES LoginSucceed:^{
            NewsModel *model = self.partnerList[indexPath.row];
            NewShareWebViewController *jswebvc = [[NewShareWebViewController alloc] initWithUrl:[NSURL URLWithString:model.visitURL]];
            [self.navigationController pushViewController:jswebvc animated:YES];
        } cancel:^{
            
        }];
       */
    }
}

@end

//
//  MeCenterViewController.m
//  VSProject
//
//  Created by pangchao on 16/12/21.
//  Copyright © 2016年 user. All rights reserved.
//

#import "MeCenterViewController.h"
#import "CenterManger.h"
#import "MeCollectionViewCell.h"
#import "MeTableViewCell.h"
#import "MeConfigDTO.h"
#import "NewCenterOrderViewController.h"
#import "ServiceOrderViewController.h"
#import "PersonalInformationViewController.h"
#import "MeSettingViewController.h"
#import "TagsSelectViewController.h"
#import "MyPolicyViewController.h"
#import "CouponViewController.h"
#import "ReceivingAddressViewController.h"
#import "MyBidCenterViewController.h"
#import "NewMyActivityViewController.h"
#import "LDResisterManger.h"
#import "ManagementViewController.h"
#import "MyBidCollectionViewController.h"
#import "BidDepositBackListViewController.h"
#import "RefundViewController.h"
#import "BuyOrderViewController.h"
#import "RTXMyAppointmentViewController.h"
#import "MessageViewController.h"
#import "MessageManager.h"
#import "MyAppliedPolicyViewController.h"
#import "BCNetWorkTool.h"
#import "BidderManager.h"
#import "MJExtension.h"
#import "MyBidListCenterViewController.h"
#import "MyEnrolledActivityViewController.h"
#import "AppointmentOrderViewController.h"
#import "AuthEnterpriseViewController.h"
#import "AuthStatusPassOrRejectViewController.h"
#import "AuthStatusUnReslovedViewController.h"
#import "FinanceViewController.h"
#import "MyCollectionViewController.h"

@interface MeCenterViewController () <UITableViewDelegate, UITableViewDataSource>
{
    CenterManger *manger;
    dispatch_group_t requestGroup;
}

@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UIImageView *levelImageView;
@property (nonatomic, strong) UILabel *companyLabel;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *userNameDefaultLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UIImageView *redPoint_imageView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *groupData;

@end

@implementation MeCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = _COLOR_HEX(0xf3f3f3);
    self.navigationController.navigationBarHidden = NO;
    
    [self vs_setTitleText:@"我的"];
    
    [self vs_setTitleColor:_COLOR_HEX(0x302f37)];
    
    [self recoverRightButton];
    
    requestGroup = dispatch_group_create();
    manger = [[CenterManger alloc] init];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[MeTableViewCell class] forCellReuseIdentifier:@"MeTableViewCell"];
    
    [self updateheadView];
    
    [self requestCustomerInfo];
    [self requesthaveNewMessage];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self updateheadView];
    
    [self requestCustomerInfo];
    [self requesthaveNewMessage];
    self.navigationController.navigationBarHidden = NO;
    
    NSNumber *number = [[NSUserDefaults standardUserDefaults] valueForKey:@"hasUnreadMsg"];
    [self addRedPoint:[number boolValue]];
}

- (void)addRedPoint:(BOOL)hasUnread {
    if (hasUnread) {
        [self.vm_rightButton addSubview:self.redPoint_imageView];
    } else {
        [self.redPoint_imageView removeFromSuperview];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)recoverRightButton {
    
    self.navigationItem.rightBarButtonItem = nil;
    [self vs_showRightButton:YES];
    
    [self.vm_rightButton setImage:[UIImage imageNamed:@"ic_notification_n"] forState:0];
}

- (UIView *)headView {
    
    if (!_headView) {
        _headView = [[UIView alloc] init];
        _headView.frame = CGRectMake(0, 0, MainWidth, Get750Width(214.0f));
        _headView.backgroundColor = [UIColor whiteColor];
        
        [_headView addSubview:self.headImageView];
        [_headView addSubview:self.levelImageView];
        [_headView addSubview:self.companyLabel];
        [_headView addSubview:self.userNameLabel];
        [_headView addSubview:self.userNameDefaultLabel];
        [_headView addSubview:self.arrowImageView];
    }
    return _headView;
}

- (UIImageView *)headImageView {
    
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.frame = CGRectMake(Get750Width(24.0f), Get750Width(37.0f), Get750Width(140.0f), Get750Width(140.0f));
        _headImageView.backgroundColor = _COLOR_CLEAR;
        _headImageView.layer.borderColor = _COLOR_HEX(0xdbdbdb).CGColor;
        _headImageView.layer.borderWidth = 1.f;
        _headImageView.layer.cornerRadius = 5;
        _headImageView.clipsToBounds = YES;
        _headImageView.image = [UIImage imageNamed:@"me_icon"];
    }
    return _headImageView;
}

- (UIImageView *)redPoint_imageView {
    if (!_redPoint_imageView) {
        _redPoint_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(Get750Width(40.0f + 20.0f), -3.5, 7, 7)];
        [_redPoint_imageView setImage:__IMAGENAMED__(@"hongdian")];
    }
    return _redPoint_imageView;
}

- (UIImageView *)levelImageView {
    
    if (!_levelImageView) {
        _levelImageView = [[UIImageView alloc] init];
        _levelImageView.frame = CGRectMake(self.headImageView.frame.origin.x + self.headImageView.frame.size.width - Get750Width(25.0f), self.headImageView.frame.origin.y - Get750Width(25.0f), Get750Width(50.0f), Get750Width(50.0f));
        _levelImageView.backgroundColor = [UIColor clearColor];
        _levelImageView.image = [UIImage imageNamed:@"me_level_icon"];
    }
    return _levelImageView;
}

- (UILabel *)companyLabel {
    
    if (!_companyLabel) {
        _companyLabel = [[UILabel alloc] init];
        _companyLabel.frame = CGRectMake(self.headImageView.frame.origin.x + self.headImageView.frame.size.width + Get750Width(32.0f), self.userNameLabel.frame.origin.y + self.userNameLabel.frame.size.height + Get750Width(22.0f), MainWidth - Get750Width(48.0f + 140.0f + 32.0f), 15.0f);
        _companyLabel.font = FONT_TITLE(15.0f);
        _companyLabel.textColor = _COLOR_HEX(0x121212);
        _companyLabel.textAlignment = NSTextAlignmentLeft;
        _companyLabel.text = @"公司名称";
    }
    return _companyLabel;
}

- (UILabel *)userNameLabel {
    
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.frame = CGRectMake(self.headImageView.frame.origin.x + self.headImageView.frame.size.width + Get750Width(32.0f), Get750Width(60.0f), MainWidth, Get750Width(40.0f));
        _userNameLabel.font = FONT_TITLE(20.0f);
        _userNameLabel.textColor = _COLOR_HEX(0x302f37);
        _userNameLabel.textAlignment = NSTextAlignmentLeft;
        _userNameLabel.text = @"昵称";
    }
    return _userNameLabel;
}

- (UILabel *)userNameDefaultLabel {
    
    if (!_userNameDefaultLabel) {
        _userNameDefaultLabel = [[UILabel alloc] init];
        _userNameDefaultLabel.frame = CGRectMake(self.headImageView.frame.origin.x + self.headImageView.frame.size.width + Get750Width(32.0f), Get750Width(82.0f), self.userNameLabel.frame.size.width, Get750Width(40.0f));
        _userNameDefaultLabel.font = FONT_TITLE(20.0f);
        _userNameDefaultLabel.textColor = _COLOR_HEX(0x302f37);
        _userNameDefaultLabel.textAlignment = NSTextAlignmentLeft;
        _userNameDefaultLabel.text = @"用户名";
    }
    return _userNameDefaultLabel;
}

- (UIImageView *)arrowImageView {
    
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.frame = CGRectMake(MainWidth - Get750Width(64.0f), Get750Width((214.0f - 24.0f)/2), Get750Width(14.0f), Get750Width(24.0f));
        _arrowImageView.image = [UIImage imageNamed:@"me_arrow"];
    }
    return _arrowImageView;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, GetWidth(self.view), GetHeight(self.view) - 64.0f - 44.0f) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = _COLOR_HEX(0xf3f3f3);
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    return _tableView;
}

- (UICollectionView *)collectionView {
    
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        flowLayout.itemSize = CGSizeMake((MainWidth - 7.5f)/3.000000f, Get750Width(148.0f));
        flowLayout.minimumLineSpacing = Get750Width(10.0f);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.headerReferenceSize = CGSizeMake(0, 0);
        flowLayout.footerReferenceSize = CGSizeMake(0, 0);
        flowLayout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = (id<UICollectionViewDelegate>)self;
        _collectionView.dataSource = (id<UICollectionViewDataSource>)self;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[MeCollectionViewCell class] forCellWithReuseIdentifier:@"MeCollectionViewCell"];
        _collectionView.scrollEnabled = NO;
        
    }
    
    return _collectionView;
}

- (NSMutableArray *)groupData {
    
    if (!_groupData) {
        _groupData = [NSMutableArray array];
        
        MeConfigDTO *configDTO = [[MeConfigDTO alloc] init];
        configDTO.iconName = @"me_icon";
        configDTO.title = @"用户名";
        configDTO.arrowImageName = @"me_arrow";
        [_groupData addObject:@[configDTO]];
        
        MeConfigDTO *goodsOrderDTO = [[MeConfigDTO alloc] init];
        goodsOrderDTO.iconName = @"me_goodsorder_icon";
        goodsOrderDTO.title = @"商品订单";
        
        MeConfigDTO *serverOrderDTO = [[MeConfigDTO alloc] init];
        serverOrderDTO.iconName = @"me_serverorder_icon";
        serverOrderDTO.title = @"服务订单";
        
        MeConfigDTO *openOrderDTO = [[MeConfigDTO alloc] init];
        openOrderDTO.iconName = @"me_openorder_icon";
        openOrderDTO.title = @"预约订单";
        
        MeConfigDTO *refundOrderDTO = [[MeConfigDTO alloc] init];
        refundOrderDTO.iconName = @"me_refundorder_icon";
        refundOrderDTO.title = @"订单退款";
        
        MeConfigDTO *refundMarginDTO = [[MeConfigDTO alloc] init];
        refundMarginDTO.iconName = @"me_refundmargin_icon";
        refundMarginDTO.title = @"保证金退款";
        
        MeConfigDTO *couponDTO = [[MeConfigDTO alloc] init];
        couponDTO.iconName = @"me_coupon_icon";
        couponDTO.title = @"优惠券";
        [_groupData addObject:@[goodsOrderDTO, serverOrderDTO, openOrderDTO, refundOrderDTO, refundMarginDTO, couponDTO]];
        
        MeConfigDTO *policyDTO = [[MeConfigDTO alloc] init];
        policyDTO.iconName = @"me_policy_icon";
        policyDTO.title = @"我的政策";
        policyDTO.arrowImageName = @"me_arrow";
        
        MeConfigDTO *tenderDTO = [[MeConfigDTO alloc] init];
        tenderDTO.iconName = @"me_tender_icon";
        tenderDTO.title = @"我的招投标";
        tenderDTO.arrowImageName = @"me_arrow";
        
        MeConfigDTO *activityDTO = [[MeConfigDTO alloc] init];
        activityDTO.iconName = @"me_activity_icon";
        activityDTO.title = @"我的活动";
        activityDTO.arrowImageName = @"me_arrow";
        
        MeConfigDTO *collectDTO = [[MeConfigDTO alloc] init];
        collectDTO.iconName = @"user_icon_collect";
        collectDTO.title = @"我的收藏";
        collectDTO.arrowImageName = @"me_arrow";
        [_groupData addObject:@[policyDTO, tenderDTO, activityDTO, collectDTO]];
        
        MeConfigDTO *addressDTO = [[MeConfigDTO alloc] init];
        addressDTO.iconName = @"me_address_icon";
        addressDTO.title = @"收货地址";
        addressDTO.arrowImageName = @"me_arrow";
        [_groupData addObject:@[addressDTO]];
        
        MeConfigDTO *managementDTO = [[MeConfigDTO alloc] init];
        managementDTO.iconName = @"me_management_icon";
        managementDTO.title = @"企业信息";
        managementDTO.arrowImageName = @"me_arrow";
        
        MeConfigDTO *tagDTO = [[MeConfigDTO alloc] init];
        tagDTO.iconName = @"me_tag_icon";
        tagDTO.title = @"标签";
        tagDTO.arrowImageName = @"me_arrow";
        
        MeConfigDTO *settingDTO = [[MeConfigDTO alloc] init];
        settingDTO.iconName = @"me_setting_icon";
        settingDTO.title = @"设置";
        settingDTO.arrowImageName = @"me_arrow";
        [_groupData addObject:@[managementDTO, tagDTO, settingDTO]];
    }
    return _groupData;
}

- (NSDictionary *)personalDic {
    
    if (!_personalDic) {
        _personalDic = [NSDictionary dictionary];
    }
    return _personalDic;
}

- (void)updateheadView {
    
    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId;
    // 未登录
    if (!partyId) {
        self.companyLabel.hidden = YES;
        self.userNameLabel.hidden = YES;
        self.levelImageView.hidden = YES;
        self.userNameDefaultLabel.hidden = NO;
        self.userNameDefaultLabel.text = @"用户名";
        
        self.headImageView.frame = CGRectMake(Get750Width(24.0f), Get750Width(37.0f), Get750Width(140.0f), Get750Width(140.0f));
    }
    else {
//        NSString *companyName = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.companyName;
        NSString *companyName = [BidderManager shareInstance].authedEnterPrise.bidder.enterpriseName;
        NSString *status = [BidderManager shareInstance].authedEnterPrise.authStatus;
        if (!companyName || [companyName isEqualToString:@""] || ![status isEqualToString:@"PASS"]) {
            self.levelImageView.hidden = YES;
            self.companyLabel.hidden = YES;
            self.userNameLabel.hidden = YES;
            self.userNameDefaultLabel.hidden = NO;
            self.userNameDefaultLabel.text = self.userNameLabel.text;
            if ([self.userNameDefaultLabel.text length] <= 0) {
                self.userNameDefaultLabel.text = @"用户名";
            }
            self.headImageView.frame = CGRectMake(Get750Width(24.0f), Get750Width(37.0f), Get750Width(140.0f), Get750Width(140.0f));
        }
        else {
            self.companyLabel.hidden = NO;
            self.userNameLabel.hidden = NO;
            self.levelImageView.hidden = NO;
            self.userNameDefaultLabel.hidden = YES;
            self.companyLabel.text = companyName;
            self.userNameDefaultLabel.text = @"用户名";
            self.headImageView.frame = CGRectMake(Get750Width(24.0f), Get750Width(37.0f), Get750Width(140.0f), Get750Width(140.0f));
        }
    }
}

#pragma mark -- request

- (void)requestCustomerInfo {
    
    [self.headImageView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"me_icon"] options:SDWebImageUnCached];
    
    __weak typeof(self)weakself = self;
    dispatch_group_enter(requestGroup);
    [manger requestCustomerInfo:nil success:^(NSDictionary *responseObj) {
        dispatch_group_leave(requestGroup);
        //
        weakself.personalDic = [NSDictionary dictionaryWithDictionary:[responseObj vs_filterDictionary:responseObj]];
        NSString *headIconPath = [[weakself.personalDic objectForKey:@"me_icon"] isEqual:[NSNull null]]?@"":[weakself.personalDic objectForKey:@"headIconPath"];
        NSString *nickName = [[weakself.personalDic objectForKey:@"nickName"] isEqual:[NSNull null]]?@"":[weakself.personalDic objectForKey:@"nickName"];
        
        NSArray *sectionArray = [self.groupData objectAtIndex:0];
        MeConfigDTO *dto = [sectionArray objectAtIndex:0];
        dto.iconUrl = [weakself.personalDic objectForKey:@"headIconPath"];
        dto.title = [weakself.personalDic objectForKey:@"nickName"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself.headImageView sd_setImageWithURL:[NSURL URLWithString:headIconPath] placeholderImage:[UIImage imageNamed:@"me_icon"] options:SDWebImageUnCached];
            weakself.userNameLabel.text = nickName;
            [weakself updateheadView];
        });
        NSLog(@"personalDic---%@",weakself.personalDic);
    } failure:^(NSError *error) {
        dispatch_group_leave(requestGroup);
        //
        [weakself.view showTipsView:[error domain]];
        [weakself updateheadView];
    }];
}

- (void)gotoEnterpriseInfo {
    [self vs_showLoading];
    
    NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    
    NSDictionary *dic = @{
                          @"partyId" : partyId
                          };
    
    [BCNetWorkTool executeGETNetworkWithParameter:dic  andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.enterprise/get-authed-enterprise/version/1.2.0" withSuccess:^(id callBackData) {
        
        [self vs_hideLoadingWithCompleteBlock:nil];
        
        [BidderManager shareInstance].authedEnterPrise = [AuthedEnterprise mj_objectWithKeyValues:callBackData];
        
        
        NSString *status = [BidderManager shareInstance].authedEnterPrise.authStatus;
        
        if ([status isEqualToString:@"UNAPPLY"]) {
            AuthEnterpriseViewController *vc = [AuthEnterpriseViewController new];
            [vc setDataSource:[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.bidder];
            [self.navigationController pushViewController:vc animated:YES];
        }else if([status isEqualToString:@"UNRESOLVED"]){
            
            AuthStatusUnReslovedViewController *vc = [[AuthStatusUnReslovedViewController alloc] initWithNibName:@"AuthStatusUnReslovedViewController" bundle:nil];
            
            [self.navigationController pushViewController:vc animated:YES ];
            
        }else if([status isEqualToString:@"PASS"]){
            
            AuthStatusUnReslovedViewController *vc = [[AuthStatusUnReslovedViewController alloc] initWithNibName:@"AuthStatusUnReslovedViewController" bundle:nil];
            
            [self.navigationController pushViewController:vc animated:YES ];
            
        }else if([status isEqualToString:@"REJECT"]){
            AuthStatusUnReslovedViewController *vc = [[AuthStatusUnReslovedViewController alloc] initWithNibName:@"AuthStatusUnReslovedViewController" bundle:nil];
            
            [self.navigationController pushViewController:vc animated:YES ];
        }
    } orFail:^(id callBackData) {
        [self vs_hideLoadingWithCompleteBlock:nil];
    }];
}

#pragma mark -  tableView delegate and dataSource method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.groupData.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 1) {
        return 1;
    }
    else {
        NSArray *sectionArray = [self.groupData objectAtIndex:section];
        return sectionArray.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        UITableViewCell *headCell = [tableView dequeueReusableCellWithIdentifier:@"headCell"];
        if (headCell == nil) {
            headCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"headCell"];
        }
        
        if (self.headView.superview) {
            [self.headView removeFromSuperview];
        }
    
        [headCell.contentView addSubview:self.headView];
        headCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(headCell.contentView);
        }];
        
        return headCell;
    }
    else if(indexPath.section == 1) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"collectionCell"];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"collectionCell"];
        }
        
        if (self.collectionView.superview) {
            [self.collectionView removeFromSuperview];
        }
        
        [cell.contentView addSubview:self.collectionView];
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
        
        return cell;
    }
    else if(indexPath.section==2 || indexPath.section==3 || indexPath.section==4) {
        
        MeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeTableViewCell" forIndexPath:indexPath];
        
        NSArray *sectionArray = [self.groupData objectAtIndex:indexPath.section];
        MeConfigDTO *configDTO = [sectionArray objectAtIndex:indexPath.row];
        cell.iconImageView.image = [UIImage imageNamed:configDTO.iconName];
        //收藏图片过大问题
        if ([configDTO.iconName isEqualToString:@"user_-icon_--collect"]) {
            [cell.iconImageView setFrame:CGRectMake(13.5f, 11.0f, 20.0f, 20.0f)];
        }
        cell.titleLabel.text = configDTO.title;
        cell.arrowImageView.image = [UIImage imageNamed:configDTO.arrowImageName];
        if (indexPath.row == sectionArray.count-1) {
            cell.bottomLineView.hidden = YES;
        }
        else {
            cell.bottomLineView.hidden = NO;
        }
        
        return cell;
    }
    
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return Get750Width(214.0f);
        
    }
    else if (indexPath.section == 1) {
        
        return   Get750Width(326.0f);
        
    }
    else if(indexPath.section==2 || indexPath.section==3 || indexPath.section==4) {
        
        return Get750Width(108.0f);
    }
    
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *sectionArray = [self.groupData objectAtIndex:indexPath.section];
    MeConfigDTO *configDTO = [sectionArray objectAtIndex:indexPath.row];
    if (indexPath.section == 0) {
        // 用户设置页面
        PersonalInformationViewController *controller = [[PersonalInformationViewController alloc] init];
        controller.personalDic = self.personalDic;
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if (indexPath.section == 1) {
        return;
    }
    else {
        if ([configDTO.title isEqualToString:@"设置"]) {
            
            MeSettingViewController *controller = [[MeSettingViewController alloc] init];
            controller.personalDic = self.personalDic;
            [self.navigationController pushViewController:controller animated:YES];
        }
        else if ([configDTO.title isEqualToString:@"标签"]) {
        
            TagsSelectViewController *tagsVC = [[TagsSelectViewController alloc] init];
            [self.navigationController pushViewController:tagsVC animated:YES];
            
        }
        else if ([configDTO.title isEqualToString:@"我的政策"]) {
            
            MyAppliedPolicyViewController *vc = [[MyAppliedPolicyViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if ([configDTO.title isEqualToString:@"我的招投标"]) {
            
            [self vs_showLoading];
            
            NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
            
            NSDictionary *dic = @{
                                  @"partyId" : partyId
                                  };
            
            [BCNetWorkTool executeGETNetworkWithParameter:dic  andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.enterprise/get-authed-enterprise/version/1.2.0" withSuccess:^(id callBackData) {
                
                [self vs_hideLoadingWithCompleteBlock:nil];
                
                [BidderManager shareInstance].authedEnterPrise = [AuthedEnterprise mj_objectWithKeyValues:callBackData];
                
                MyBidListCenterViewController *vc = [MyBidListCenterViewController new];
                [self.navigationController pushViewController:vc animated:YES];
                
                
            } orFail:^(id callBackData) {
                [self vs_hideLoadingWithCompleteBlock:nil];
                MyBidListCenterViewController *vc = [MyBidListCenterViewController new];
                [self.navigationController pushViewController:vc animated:YES];
            }];
        }
        else if ([configDTO.title isEqualToString:@"我的活动"]) {
            
            MyEnrolledActivityViewController *vc = [[MyEnrolledActivityViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if ([configDTO.title isEqualToString:@"我的收藏"]) {

            MyCollectionViewController *vc = [[MyCollectionViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if ([configDTO.title isEqualToString:@"收货地址"]) {
            
            ReceivingAddressViewController *vc = [[ReceivingAddressViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if ([configDTO.title isEqualToString:@"企业信息"]) {
            [self gotoEnterpriseInfo];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        return 0.00001f;
    }
    else {
        return Get750Width(20.0f);
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.0001;
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSArray *sectionArray = [self.groupData objectAtIndex:1];
    return sectionArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *sectionArray = [self.groupData objectAtIndex:1];
    MeConfigDTO *configDTO = [sectionArray objectAtIndex:indexPath.row];
    
    MeCollectionViewCell *cell = (MeCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"MeCollectionViewCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.nameLabel.text = configDTO.title;
    cell.imageView.image = [UIImage imageNamed:configDTO.iconName];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    NSArray *sectionArray = [self.groupData objectAtIndex:1];
    MeConfigDTO *configDTO = [sectionArray objectAtIndex:indexPath.row];
    if ([configDTO.title isEqualToString:@"商品订单"]) {
        BuyOrderViewController *vc = [BuyOrderViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([configDTO.title isEqualToString:@"服务订单"]) {
        ServiceOrderViewController *vc = [ServiceOrderViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([configDTO.title isEqualToString:@"预约订单"]) {
        AppointmentOrderViewController *appointmentvc = [AppointmentOrderViewController new];
        [self.navigationController pushViewController:appointmentvc animated:YES];
    }
    else if ([configDTO.title isEqualToString:@"订单退款"]) {
        RefundViewController *vc = [RefundViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([configDTO.title isEqualToString:@"保证金退款"]) {
        BidDepositBackListViewController *vc = [BidDepositBackListViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([configDTO.title isEqualToString:@"优惠券"]) {
        CouponViewController *vc = [[CouponViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark -- message

- (void)requesthaveNewMessage {
    
    MessageManager *messageManager = [[MessageManager alloc] init];
    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    
    if ([partyId isEmptyString]) {
        return;
    }
    [messageManager requesthaveNewMessage:nil success:^(NSDictionary *responseObj) {
        
        NSNumber *hasNewMessage = [responseObj objectForKey:@"hasNewMessage"];
        [self vs_showRightButton:YES];
        [VSUserLogicManager shareInstance].userDataInfo.vm_haveNewMessage = hasNewMessage.boolValue;
        // 切换消息图片
        [self recoverRightButton];
    } failure:^(NSError *error) {
        
    }];
}

- (void)vs_rightButtonAction:(id)sender
{
    MessageViewController *controller = [[MessageViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

@end

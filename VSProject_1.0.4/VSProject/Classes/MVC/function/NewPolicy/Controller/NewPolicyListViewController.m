//
//  NewPolicyListViewController.m
//  VSProject
//
//  Created by apple on 11/6/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "NewPolicyListViewController.h"
#import "NewPolicyManager.h"
#import "UIColor+TPCategory.h"
#import "NewPolicyCell.h"
#import "NewPolicyDetaileViewController.h"
#import "CityAreaModel.h"
#import "IndustryModel.h"
#import "PolicySelectCItyAreaView.h"
#import "PolicySelectIndustryView.h"
#import "PolicySelectTimeView.h"
#import "BCNetWorkTool.h"
#import "BannerDTO.h"
#import "NSObject+MJKeyValue.h"
#import "VSAdsView.h"
#import "PolicyProxyViewController.h"
#import "BidderManager.h"
#import "AuthEnterpriseViewController.h"
#import "AuthStatusUnReslovedViewController.h"
#import "ArrowUpAndDownButton.h"

@interface NewPolicyListViewController () <UITableViewDataSource,UITableViewDelegate>
{
    NewPolicyManager *manger;
    dispatch_group_t requestGroup;
}

_PROPERTY_NONATOMIC_STRONG(UIView, emptyView);

_PROPERTY_NONATOMIC_STRONG(UIView, segmentBar);

_PROPERTY_NONATOMIC_STRONG(ArrowUpAndDownButton, industryButton);

_PROPERTY_NONATOMIC_STRONG(ArrowUpAndDownButton, areaButton);

_PROPERTY_NONATOMIC_STRONG(ArrowUpAndDownButton, timeButton);

_PROPERTY_NONATOMIC_STRONG(PolicySelectCItyAreaView, policySelectCItyAreaView);

_PROPERTY_NONATOMIC_STRONG(PolicySelectIndustryView, policySelectIndustryView);

_PROPERTY_NONATOMIC_STRONG(PolicySelectTimeView, policySelectTimeView);

_PROPERTY_NONATOMIC_ASSIGN(BOOL, flagForIsShowingCityChooseView);

_PROPERTY_NONATOMIC_ASSIGN(BOOL, flagForIsShowingIndustryChooseView);

_PROPERTY_NONATOMIC_ASSIGN(BOOL, flagForIsShowingTimeChooseView);

_PROPERTY_NONATOMIC_ASSIGN(BOOL, flagForChangedCity);

_PROPERTY_NONATOMIC_ASSIGN(BOOL, flagForChangedIndustry);

_PROPERTY_NONATOMIC_ASSIGN(BOOL, flagForChangedTime);

_PROPERTY_NONATOMIC_STRONG(UIButton, blackClearView);

_PROPERTY_NONATOMIC_STRONG(NSString, selectedCityId);

_PROPERTY_NONATOMIC_STRONG(NSString, selectedAreaId);

_PROPERTY_NONATOMIC_STRONG(NSString, selectedIndustryCode);

_PROPERTY_NONATOMIC_STRONG(NSString, selectedTime);

_PROPERTY_NONATOMIC_STRONG(NSArray, adList);

_PROPERTY_NONATOMIC_STRONG(VSAdsView, vSAdsView);

_PROPERTY_NONATOMIC_STRONG(UIButton, flowButton)

@property (nonatomic,strong) UIScrollView *contentScrollView;

@property (nonatomic,strong) NSArray *contentTaleViews;

@property (nonatomic,strong) NSArray *dataSources;

@property (nonatomic,assign) NSInteger index;//选中segmentView index

@end

@implementation NewPolicyListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.shouldShowOneKeyConsign = YES;
//    self.shouldShouContactCustomService  = YES;
    
    [self vs_setTitleText:@"政策申报"];
    [self.view setBackgroundColor:ColorWithHex(0xeeeeee, 1.0)];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view addSubview:self.vSAdsView];
    requestGroup = dispatch_group_create();
    [self loadAdData];
    
    self.selectedCityId = @"110100"; //默认北京
    self.selectedAreaId = @"";
    self.selectedTime = @"N";
    self.selectedIndustryCode = @"";
    
    manger = [[NewPolicyManager alloc] init];
    
    [self getCityAndDistrict];
    
    [self _initTableViews];
    
    [self _initContentScrollView];
    
    [self.view addSubview:self.segmentBar];
    
//    [self.vm_rightButton setFrame:_CGR(0, 0, 50, 28)];
//    [self.vm_rightButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
//    [self.vm_rightButton setTitle:@"北京市" forState:UIControlStateNormal];
//    [self.vm_rightButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
//    UIImageView *arrowView = [[UIImageView alloc] initWithImage:__IMAGENAMED__(@"nav_but_arrow_n")];
//    [arrowView setFrame:CGRectMake(50, 11, 10, 6)];
//    [self.vm_rightButton addSubview:arrowView];
    
    [self addFlowButton];
    
    [self performSelector:@selector(changeSegmentView) withObject:nil afterDelay:0.3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addFlowButton {
    
    UIButton *flowButton = [[UIButton alloc]initWithFrame:CGRectMake(MainWidth - 76.0f, MainHeight - 44.0f - 60.0f - 75.0f, 75.0f, 75.0f)];
    flowButton.backgroundColor = [UIColor clearColor];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, 75.0f, 75.0f);
    imageView.image = [UIImage imageNamed:@"btn_round"];
    [flowButton addSubview:imageView];
    
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.frame = CGRectMake(10.0f, 10.0f, 55.0f, 55.0f);
    textLabel.font = [UIFont systemFontOfSize:18.0f];
    textLabel.textColor = [UIColor whiteColor];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.numberOfLines = 0;
    textLabel.text = @"委托\n申报";
    [flowButton addSubview:textLabel];
    
    [flowButton addTarget:self action:@selector(proxyAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.flowButton = flowButton;
    
    [self.view addSubview:self.flowButton];
    [self.view bringSubviewToFront:self.flowButton];
}


- (void)checkEnterpriseStatus {
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
            
            [self.view showTipsView:@"您的企业信息还在认证中，请耐心等待"];
            
        }else if([status isEqualToString:@"PASS"]){
            
            //政策代理入口
            PolicyProxyViewController *vc = [[PolicyProxyViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if([status isEqualToString:@"REJECT"]){
            AuthStatusUnReslovedViewController *vc = [[AuthStatusUnReslovedViewController alloc] initWithNibName:@"AuthStatusUnReslovedViewController" bundle:nil];
            
            [self.navigationController pushViewController:vc animated:YES ];
        }
    } orFail:^(id callBackData) {
        [self vs_hideLoadingWithCompleteBlock:nil];
    }];
}

- (void)proxyAction {
    
    [self userlogin:LOGIN_BACK_DEFAULT popVc:self animated:YES LoginSucceed:^{
        [self checkEnterpriseStatus];
    } cancel:^{
        
    }];
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

- (UIView *)emptyView {
    if (!_emptyView) {
        _emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_WIDTH__, __SCREEN_HEIGHT__ - 30 - (__SCREEN_WIDTH__ * 320 / 750))];
        [_emptyView setBackgroundColor:[UIColor whiteColor]];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((__SCREEN_WIDTH__ - 60)/2, 53, 60, 55)];
        [imageView setImage:__IMAGENAMED__(@"bg_img_nothing")];
        [_emptyView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 53 + 55 +14, __SCREEN_WIDTH__, 21)];
        [label setText:@"暂无信息"];
        [label setFont:[UIFont systemFontOfSize:13]];
        [label setTextColor:ColorWithHex(0x5c5c5c, 1.0)];
        [label setTextAlignment:NSTextAlignmentCenter];
        [_emptyView addSubview:label];
    }
    return _emptyView;
}

#pragma mark - segment view
- (UIView *)segmentBar {
    if (!_segmentBar) {
        _segmentBar = [[UIView alloc] initWithFrame:CGRectMake(0, (__SCREEN_WIDTH__ * 320 / 750), __SCREEN_WIDTH__, 44)];
        [_segmentBar setBackgroundColor:ColorWithHex(0xf7f7f7, 1.0)];
        [_segmentBar addSubview:self.industryButton];
        [_segmentBar addSubview:self.areaButton];
        [_segmentBar addSubview:self.timeButton];
    }
    return _segmentBar;
}

- (ArrowUpAndDownButton *)industryButton {
    if (!_industryButton) {
        _industryButton = [[ArrowUpAndDownButton alloc] initWithFrame:CGRectMake(0 - 10, 0, (__SCREEN_WIDTH__ / 3) - 0.5, 44)];
        [_industryButton setTitle:@"所属行业" forState:UIControlStateNormal];
        [_industryButton setTitleColor:ColorWithHex(0x302f37, 1.0) forState:UIControlStateNormal];
        [_industryButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        
        [_industryButton addTarget:self action:@selector(industryAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _industryButton;
}

- (void)industryAction {
    [_industryButton setTitleColor:ColorWithHex(0x00c88c, 1.0) forState:UIControlStateNormal];
    if (self.flagForChangedCity) {
        [self.areaButton setImage:__IMAGENAMED__(@"xz_h") forState:UIControlStateNormal];
    } else {
        [_areaButton setTitleColor:ColorWithHex(0x302f37, 1.0) forState:UIControlStateNormal];
    }

    [self.timeButton setImage:__IMAGENAMED__(@"xz_h") forState:UIControlStateNormal];
//    [_timeButton setTitleColor:ColorWithHex(0x302f37, 1.0) forState:UIControlStateNormal];
    
    self.flagForIsShowingCityChooseView = NO;
    [self.policySelectCItyAreaView removeFromSuperview];
    [self.blackClearView removeFromSuperview];
    
    self.flagForIsShowingTimeChooseView = NO;
    [self.policySelectTimeView removeFromSuperview];
    [self.blackClearView removeFromSuperview];
    
    if (self.flagForIsShowingIndustryChooseView) {
        self.flagForIsShowingIndustryChooseView = NO;
        [self.policySelectIndustryView removeFromSuperview];
        [self.blackClearView removeFromSuperview];
        if (self.flagForChangedIndustry) {
            [self.industryButton setImage:__IMAGENAMED__(@"xz_h") forState:UIControlStateNormal];
        } else {
            [_industryButton setTitleColor:ColorWithHex(0x302f37, 1.0) forState:UIControlStateNormal];
        }
    } else {
        self.flagForIsShowingIndustryChooseView = YES;
        [self.view addSubview:self.blackClearView];
        [self.blackClearView addSubview:self.policySelectIndustryView];
    }
}

- (ArrowUpAndDownButton *)areaButton {
    if (!_areaButton) {
        _areaButton = [[ArrowUpAndDownButton alloc] initWithFrame:CGRectMake((__SCREEN_WIDTH__ / 3) + 0.5 - 10, 0, (__SCREEN_WIDTH__ / 3) - 0.5, 44)];
        [_areaButton setTitle:@"区域" forState:UIControlStateNormal];
        [_areaButton setTitleColor:ColorWithHex(0x302f37, 1.0) forState:UIControlStateNormal];
        [_areaButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_areaButton.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        
        [_areaButton addTarget:self action:@selector(areaAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _areaButton;
}

- (void)areaAction {
    if (self.flagForChangedIndustry) {
        [self.industryButton setImage:__IMAGENAMED__(@"xz_h") forState:UIControlStateNormal];
    } else {
        [_industryButton setTitleColor:ColorWithHex(0x302f37, 1.0) forState:UIControlStateNormal];
    }
    
    [_areaButton setTitleColor:ColorWithHex(0x00c88c, 1.0) forState:UIControlStateNormal];
    [self.timeButton setImage:__IMAGENAMED__(@"xz_h") forState:UIControlStateNormal];
//    [_timeButton setTitleColor:ColorWithHex(0x302f37, 1.0) forState:UIControlStateNormal];
    
    self.flagForIsShowingTimeChooseView = NO;
    [self.policySelectTimeView removeFromSuperview];
    [self.blackClearView removeFromSuperview];
    
    self.flagForIsShowingIndustryChooseView = NO;
    [self.policySelectIndustryView removeFromSuperview];
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

- (ArrowUpAndDownButton *)timeButton {
    if (!_timeButton) {
        _timeButton = [[ArrowUpAndDownButton alloc] initWithFrame:CGRectMake((__SCREEN_WIDTH__ * 2 / 3) + 0.5 -10, 0, (__SCREEN_WIDTH__ / 3) - 0.5, 44)];
        [_timeButton setTitle:@"当前政策" forState:UIControlStateNormal];
        [_timeButton setTitleColor:ColorWithHex(0x00c88c, 1.0) forState:UIControlStateNormal];
        [_timeButton setImage:__IMAGENAMED__(@"xz_h") forState:UIControlStateNormal];
        [_timeButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        
        [_timeButton addTarget:self action:@selector(timeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _timeButton;
}

- (void)timeAction {
    if (self.flagForChangedIndustry) {
        [self.industryButton setImage:__IMAGENAMED__(@"xz_h") forState:UIControlStateNormal];
    } else {
        [_industryButton setTitleColor:ColorWithHex(0x302f37, 1.0) forState:UIControlStateNormal];
    }
    
    if (self.flagForChangedCity) {
        [self.areaButton setImage:__IMAGENAMED__(@"xz_h") forState:UIControlStateNormal];
    } else {
        [_areaButton setTitleColor:ColorWithHex(0x302f37, 1.0) forState:UIControlStateNormal];
    }
    
    [_timeButton setTitleColor:ColorWithHex(0x00c88c, 1.0) forState:UIControlStateNormal];
    
    
    
    self.flagForIsShowingCityChooseView = NO;
    [self.policySelectCItyAreaView removeFromSuperview];
    [self.blackClearView removeFromSuperview];
    
    self.flagForIsShowingIndustryChooseView = NO;
    [self.policySelectIndustryView removeFromSuperview];
    [self.blackClearView removeFromSuperview];
    
    if (self.flagForIsShowingTimeChooseView) {
        self.flagForIsShowingTimeChooseView = NO;
        [self.policySelectTimeView removeFromSuperview];
        [self.blackClearView removeFromSuperview];
        if (self.flagForChangedTime) {
            [self.timeButton setImage:__IMAGENAMED__(@"xz_h") forState:UIControlStateNormal];
        } else {
            [self.timeButton setImage:__IMAGENAMED__(@"xz_h") forState:UIControlStateNormal];
        }
    } else {
        self.flagForIsShowingTimeChooseView = YES;
        [self.view addSubview:self.blackClearView];
        [self.blackClearView addSubview:self.policySelectTimeView];
    }
}

- (PolicySelectIndustryView *)policySelectIndustryView {
    if (!_policySelectIndustryView) {
        _policySelectIndustryView = [[PolicySelectIndustryView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_WIDTH__, __SCREEN_HEIGHT__ - 64 - 44 - (__SCREEN_WIDTH__ * 320 / 750))];
        __weak typeof(&*self) weakSelf = self;
        [_policySelectIndustryView setOnSelectedIndustyBlock:^(IndustryModel *industyModel){
            if (industyModel) {
                weakSelf.flagForChangedIndustry = YES;
                
                weakSelf.selectedIndustryCode = industyModel.industryCode;
                [weakSelf.industryButton setTitle:industyModel.industryName forState:UIControlStateNormal];
                
                for (NSMutableArray *array in weakSelf.dataSources) {
                    [array removeAllObjects];
                }
                
                [weakSelf refreshList:@"N" page:@"1" row:@"10" dataSource:weakSelf.dataSources[weakSelf.index] tableView:[weakSelf.contentTaleViews firstObject]];
                
                weakSelf.flagForIsShowingIndustryChooseView = NO;
                [weakSelf.policySelectIndustryView removeFromSuperview];
                [weakSelf.blackClearView removeFromSuperview];
                if ([industyModel.industryName isEqualToString:@"全部"]) {
                    weakSelf.flagForChangedIndustry = NO;
                    [weakSelf.industryButton setTitle:@"所属行业" forState:UIControlStateNormal];
                    [weakSelf.industryButton setTitleColor:ColorWithHex(0x302f37, 1.0) forState:UIControlStateNormal];
                    [weakSelf.industryButton setImage:__IMAGENAMED__(@"xz_n") forState:UIControlStateNormal];
                } else {
                    [weakSelf.industryButton setTitleColor:ColorWithHex(0x00c88c, 1.0) forState:UIControlStateNormal];
                    [weakSelf.industryButton setImage:__IMAGENAMED__(@"xz_h") forState:UIControlStateNormal];
                }
            } else {
                [weakSelf vs_rightButtonAction:nil];
            }
        }];
    }
    return _policySelectIndustryView;
}

- (PolicySelectCItyAreaView *)policySelectCItyAreaView {
    if (!_policySelectCItyAreaView) {
//        _policySelectCItyAreaView = [[PolicySelectCItyAreaView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_WIDTH__, __SCREEN_HEIGHT__ - 64 - 44 - (__SCREEN_WIDTH__ * 320 / 750))];
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
            
            
            [weakSelf refreshList:@"N" page:@"1" row:@"10" dataSource:weakSelf.dataSources[weakSelf.index] tableView:[weakSelf.contentTaleViews firstObject]];
            
            weakSelf.flagForIsShowingCityChooseView = NO;
            [weakSelf.policySelectCItyAreaView removeFromSuperview];
            [weakSelf.blackClearView removeFromSuperview];
            [weakSelf.areaButton setTitleColor:ColorWithHex(0x00c88c, 1.0) forState:UIControlStateNormal];
            [weakSelf.areaButton setImage:__IMAGENAMED__(@"xz_h") forState:UIControlStateNormal];
        }];
    }
    return _policySelectCItyAreaView;
}

- (PolicySelectTimeView *)policySelectTimeView {
    if (!_policySelectTimeView) {
        _policySelectTimeView = [[PolicySelectTimeView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_WIDTH__, __SCREEN_HEIGHT__ - 64 - 44 - (__SCREEN_WIDTH__ * 320 / 750))];
        __weak typeof(&*self) weakSelf = self;
        [_policySelectTimeView setOnSelectedTimeBlock:^(NSString *selectedTimeString){
            if (selectedTimeString) {
                weakSelf.flagForChangedTime = YES;
                
                if ([selectedTimeString isEqualToString:@"当前政策未公示"]) {
                    weakSelf.selectedTime = @"N";
                    [weakSelf.timeButton setTitle:@"当前政策" forState:UIControlStateNormal];
                } else {
                    weakSelf.selectedTime = @"Y";
                    [weakSelf.timeButton setTitle:@"历史政策" forState:UIControlStateNormal];
                }
                
                for (NSMutableArray *array in weakSelf.dataSources) {
                    [array removeAllObjects];
                }
                
                [weakSelf refreshList:@"N" page:@"1" row:@"10" dataSource:weakSelf.dataSources[weakSelf.index] tableView:[weakSelf.contentTaleViews firstObject]];
                
                weakSelf.flagForIsShowingTimeChooseView = NO;
                [weakSelf.policySelectTimeView removeFromSuperview];
                [weakSelf.blackClearView removeFromSuperview];
                [weakSelf.timeButton setTitleColor:ColorWithHex(0x00c88c, 1.0) forState:UIControlStateNormal];
                [weakSelf.timeButton setImage:__IMAGENAMED__(@"xz_h") forState:UIControlStateNormal];
            } else {
                [weakSelf vs_rightButtonAction:nil];
            }
        }];
    }
    return _policySelectTimeView;
}

#pragma mark - tableview
- (NSArray *)dataSources{
    
    if (_dataSources == nil) {
        
        _dataSources = @[[NSMutableArray array]];
    }
    
    return _dataSources;
    
}

- (UIScrollView *)contentScrollView{
    
    if (_contentScrollView == nil) {
        _contentScrollView = [UIScrollView new];
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.scrollEnabled = NO;
    }
    
    return _contentScrollView;
}



- (void)vs_rightButtonAction:(id)sender {
    [super vs_rightButtonAction:sender];
//    if (self.flagForIsShowingCityChooseView) {
//        self.flagForIsShowingCityChooseView = NO;
//        [self.policySelectCItyAreaView removeFromSuperview];
//        [self.blackClearView removeFromSuperview];
//    } else {
//        self.flagForIsShowingCityChooseView = YES;
//        [self.view addSubview:self.blackClearView];
//        [self.blackClearView addSubview:self.policySelectCItyAreaView];
//    }
    
    if (self.flagForChangedIndustry) {
        [self.industryButton setImage:__IMAGENAMED__(@"xz_h") forState:UIControlStateNormal];
    } else {
        [_industryButton setTitleColor:ColorWithHex(0x302f37, 1.0) forState:UIControlStateNormal];
    }
    
    if (self.flagForChangedCity) {
        [self.areaButton setImage:__IMAGENAMED__(@"xz_h") forState:UIControlStateNormal];
    } else {
        [_areaButton setTitleColor:ColorWithHex(0x302f37, 1.0) forState:UIControlStateNormal];
    }
    
    if (self.flagForChangedTime) {
        [_timeButton setTitleColor:ColorWithHex(0x00c88c, 1.0) forState:UIControlStateNormal];
        [self.timeButton setImage:__IMAGENAMED__(@"xz_h") forState:UIControlStateNormal];
    } else {
        [_timeButton setTitleColor:ColorWithHex(0x00c88c, 1.0) forState:UIControlStateNormal];
        [self.timeButton setImage:__IMAGENAMED__(@"xz_h") forState:UIControlStateNormal];
    }
    
    self.flagForIsShowingIndustryChooseView = NO;
    [self.policySelectIndustryView removeFromSuperview];
    self.flagForIsShowingCityChooseView = NO;
    [self.policySelectCItyAreaView removeFromSuperview];
    self.flagForIsShowingTimeChooseView = NO;
    [self.policySelectTimeView removeFromSuperview];
    
    [self.blackClearView removeFromSuperview];
}

- (UIButton *)blackClearView {
    if (!_blackClearView) {
        _blackClearView = [[UIButton alloc] initWithFrame:CGRectMake(0, 44 + (__SCREEN_WIDTH__ * 320 / 750), __SCREEN_WIDTH__, __SCREEN_HEIGHT__ - 64 - 44 - (__SCREEN_WIDTH__ * 320 / 750))];
        [_blackClearView setBackgroundColor:ColorWithHex(0x000000, 0.3)];
        [_blackClearView addTarget:self action:@selector(vs_rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _blackClearView;
}

#pragma mark － 获取网络数据

- (void)loadAdData{
    /**
     
     banner-type	Banner类型：1：全局首页，2：应用，3：项目
     object-id	Banner类型对应对象id，类型是全局object-id传空
     
     
     */
    
    dispatch_group_enter(requestGroup);
    
    NSDictionary *dic = @{
                          @"bannerType":@"2",
                          @"objectId":@"policy"
                          
                          };
    
    [BCNetWorkTool executeGETNetworkWithParameter:dic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.banner/get-banner-info/version/1.2.2" withSuccess:^(id callBackData) {
        NSLog(@"%@",callBackData );
        
        NSDictionary *dic = (NSDictionary *)callBackData;
        
        self.adList = [BannerDTO mj_objectArrayWithKeyValuesArray:dic[@"advertisementList"]];
        
        [self.vSAdsView setAds:self.adList];
        
        dispatch_group_leave(requestGroup);
        
    } orFail:^(id callBackData) {
        dispatch_group_leave(requestGroup);
    }];
}

#pragma mark -

- (void)startRequest {
    
    dispatch_group_enter(requestGroup);
    
}
- (void)endRequest {
    
    dispatch_group_leave(requestGroup);
    
}

- (void) changeSegmentView{
    
    [self.contentTaleViews.firstObject headerBeginRefreshing];
    self.index = 0;
}

- (NSArray *)contentTaleViews{
    
    if (_contentTaleViews == nil) {
        _contentTaleViews  = @[[UITableView new]];
    }
    
    return _contentTaleViews;
}

- (void)_initContentScrollView{
    
    [self.view addSubview:self.contentScrollView];
    
    __weak typeof(&*self) weakSelf = self;
    
    [self.contentScrollView setFrame:CGRectMake(0, 44 + (__SCREEN_WIDTH__ * 320 / 750), __SCREEN_WIDTH__, __SCREEN_HEIGHT__ - 64 - 44 - (__SCREEN_WIDTH__ * 320 / 750))];
    
//    [self.contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.trailing.bottom.equalTo(weakSelf.view);
//        make.top.equalTo(weakSelf.segmentBar.mas_top);
//    }];
    
    UIView *containerView = [UIView new];
    [self.contentScrollView addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentScrollView);
        make.height.equalTo(weakSelf.contentScrollView);
        make.leading.trailing.equalTo(weakSelf.contentScrollView);
        
    }];
    
    UIView *preView = nil;
    for (NSInteger i =0 ; i < self.contentTaleViews.count ; i++) {
        
        [containerView addSubview:self.contentTaleViews[i]];
        
        [self.contentTaleViews[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(containerView);
            make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
            
            if (preView) {
                
                make.leading.equalTo(preView.mas_trailing);
                
            }else{
                
                make.leading.equalTo(containerView);
                
            }
        }];
        
        
        preView = self.contentTaleViews[i];
        
    }
    
    if (preView) {
        [preView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(containerView);
        }];
    }
    
}

- (void)getCityAndDistrict {
    [manger onRequestCityAndDistrictSuccess:^(NSDictionary *responseObj) {
        NSError *err;
        [self vs_hideLoadingWithCompleteBlock:nil];
        NSArray *list = [CityAreaModel arrayOfModelsFromDictionaries:[responseObj objectForKey:@"cityAreaList"] error:&err];
        
        NSArray *industryList = [IndustryModel arrayOfModelsFromDictionaries:[responseObj objectForKey:@"industryList"] error:&err];
        
        for (CityAreaModel *c_model in list) {
            c_model.areaList = [AreaModel arrayOfModelsFromDictionaries:c_model.areaList];
        }
        
        NSLog(@"%@",list);
        
        [self.policySelectCItyAreaView onSetCityList:list];
        
        [self.policySelectIndustryView onSetIndustyList:industryList];
        
        if ([list count] > 0) {
            [self vs_showRightButton:YES];
        }
        
        [self vs_hideLoadingWithCompleteBlock:nil];
    } failure:^(NSError *error) {
        
    }];
}

- (void)_initTableViews{
    
    for (UITableView *tableView in self.contentTaleViews) {
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor clearColor];
        
        UINib *nib = [UINib nibWithNibName:@"NewPolicyCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:NSStringFromClass([NewPolicyCell class])];
        
        __weak typeof(&*self) weakSelf = self;
        __weak UITableView *weakTableView = tableView;
        
        [tableView addHeaderWithCallback:^{
            NSInteger index = [weakSelf.contentTaleViews indexOfObject:weakTableView];
            NSString *status = nil;
            
            if (index == 0) {
                status = [NSString stringWithFormat:@"N"];
            }else if(index == 1) {
                status = [NSString stringWithFormat:@"Y"];
            }
            
            [weakSelf refreshList:status  page:@"1" row:@"10" dataSource:weakSelf.dataSources[index] tableView:weakTableView];
        }];
        
        [tableView addFooterWithCallback:^{
            NSInteger index = [weakSelf.contentTaleViews indexOfObject:weakTableView];
            NSString *status = nil;
            
            if (index == 0) {
                status = [NSString stringWithFormat:@"N"];
            }else if(index == 1) {
                status = [NSString stringWithFormat:@"Y"];
            }
            
            NSArray *data = weakSelf.dataSources[index];
            NSInteger page = data.count / 10 + 1;
            
            [weakSelf refreshList:status  page:[NSString stringWithFormat:@"%zi",page] row:@"10" dataSource:weakSelf.dataSources[index] tableView:weakTableView];
        }];
    }
}


- (void)refreshList:(NSString *)status  page:(NSString *)page row:(NSString *)row dataSource:(NSMutableArray *)datasource tableView:(UITableView *)tableView{
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self vs_showLoading];
//    });
    
    NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    
    [manger onRequestPolicyList:page row:row partyId:partyId industryCode:self.selectedIndustryCode cityId:self.selectedCityId areaId:self.selectedAreaId publicityStatus:self.selectedTime success:^(NSDictionary *responseObj) {
        NSError *err;
        [self vs_hideLoadingWithCompleteBlock:nil];
        NSArray *list = [NewPolicyModel arrayOfModelsFromDictionaries:[responseObj objectForKey:@"policyList"] error:&err];
        
        [self vs_hideLoadingWithCompleteBlock:nil];
        
        if (page.integerValue == 1) {
            [datasource removeAllObjects];
        }
        
        [datasource addObjectsFromArray:list];
        
        [tableView headerEndRefreshing];
        [tableView footerEndRefreshing];
        
        [tableView reloadData];
        
        if ([responseObj[@"nextPage"] isEqualToString:@"Y"]) {
            [tableView setFooterHidden:NO];
        }else{
            [tableView setFooterHidden:YES];
        }
    } failure:^(NSError *error) {
        [self vs_hideLoadingWithCompleteBlock:nil];
        [self.view showTipsView:[error domain]];
        [tableView headerEndRefreshing];
        [tableView footerEndRefreshing];
        [tableView reloadData];
    }];
}

#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger index = [self.contentTaleViews indexOfObject:tableView];

    NSMutableArray * arr = self.dataSources[index];
    
    
    if (arr.count == 0) {
        [tableView addSubview:self.emptyView];
    }else{
        [self.emptyView removeFromSuperview];
    }
    
    return arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = [self.contentTaleViews indexOfObject:tableView];
    NSMutableArray * arr =(NSMutableArray *)self.dataSources[index];
    
    NewPolicyModel *p_model = (NewPolicyModel *)[arr objectAtIndex:indexPath.row];
    
    CGSize titleSize = [p_model.policyName boundingRectWithSize:CGSizeMake(__SCREEN_WIDTH__ - 19, MAXFLOAT)
                                                        options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}
                                                        context:nil].size;
    
    CGFloat height = titleSize.height;
    
//    return height + 83;
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"NewPolicyCell";
    NewPolicyCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    NewPolicyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"NewPolicyCell" owner:nil options:nil] lastObject];
        cell.contentView.clipsToBounds = YES;
    }
    NSInteger index = [self.contentTaleViews indexOfObject:tableView];
    NSMutableArray * arr =(NSMutableArray *)self.dataSources[index];
    
    NewPolicyModel *p_model = (NewPolicyModel *)[arr objectAtIndex:indexPath.row];
    [cell setDataSource:p_model];

    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.contentView setFrame:CGRectMake(12, 5, __SCREEN_WIDTH__ - 24, 100)];
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = [self.contentTaleViews indexOfObject:tableView];
    NSMutableArray * arr =(NSMutableArray *)self.dataSources[index];
    NewPolicyModel *p_model = [arr objectAtIndex:indexPath.row];
    NSString *urlString = p_model.policyDetail;
    
    [self userlogin:LOGIN_BACK_DEFAULT popVc:self animated:YES LoginSucceed:^{
        NewPolicyDetaileViewController *vc = [[NewPolicyDetaileViewController alloc]init];
        vc.webUrl = [NSURL URLWithString:urlString];
        vc.p_model = p_model;
        vc.selectedAreaId = self.selectedAreaId;
        [self.navigationController pushViewController:vc animated:YES];
    } cancel:^{
        
    }];
}

@end

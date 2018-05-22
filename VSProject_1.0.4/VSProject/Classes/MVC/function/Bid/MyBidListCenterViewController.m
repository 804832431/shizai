//
//  MyBidListCenterViewController.m
//  VSProject
//
//  Created by 陈 海涛 on 16/9/23.
//  Copyright © 2016年 user. All rights reserved.
//

#import "MyBidListCenterViewController.h"
#import "UIColor+TPCategory.h"
#import "BidCenterTableViewCell.h"
#import "BidNoDataView.h"
#import "BCNetWorkTool.h"
#import "BidderManager.h"
#import "MJExtension.h"
#import "BidProject.h"
#import "BidWebViewController.h"
#import "BidCenterOpTableViewCell.h"
#import "BidDepositOprationViewController.h"
#import "MeEmptyDataView.h"


@interface MyBidListCenterViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIView *bidTypeSegmentView;

@property (nonatomic,strong) UILabel *segmentTopLineView;

@property (nonatomic,strong) UILabel *segmentBottomLineView;

@property (nonatomic,strong) UIView *segmentViewWhiteContentView;

@property (nonatomic,strong) NSArray *segmentViewTitles;

@property (nonatomic,strong) NSArray *contentTaleViews;

@property (nonatomic,strong) UIScrollView *contentScrollView;

@property (nonatomic,strong) NSArray *dataSources;

@property (nonatomic, strong) UIView *headBottomLine; // 头部下划线

@end

@implementation MyBidListCenterViewController

- (NSArray *)dataSources{
    
    if (_dataSources == nil) {
        
        _dataSources = @[[NSMutableArray array],[NSMutableArray array],[NSMutableArray array],[NSMutableArray array]];
    }
    
    return _dataSources;
    
}

- (NSArray *)segmentViewTitles{
    
    if (_segmentViewTitles == nil) {
        _segmentViewTitles = @[@"全部",@"未开标",@"已中标",@"未中标"];
    }
    return _segmentViewTitles;
}

- (NSArray *)contentTaleViews{
    
    if (_contentTaleViews == nil) {
        _contentTaleViews  = @[[UITableView new],[UITableView new],[UITableView new],[UITableView new]];
    }
    
    return _contentTaleViews;
}

- (UIScrollView *)contentScrollView{
    
    if (_contentScrollView == nil) {
        _contentScrollView = [UIScrollView new];
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.scrollEnabled = NO;
    }
    
    return _contentScrollView;
}

- (UIView *)bidTypeSegmentView{
    
    if (_bidTypeSegmentView == nil) {
        
        _bidTypeSegmentView = [UIView new];
        _bidTypeSegmentView.backgroundColor = [UIColor colorFromHexRGB:@"f1f1f1"];
        
    }
    
    return _bidTypeSegmentView;
    
}

- (UILabel *)segmentTopLineView{
    
    if (_segmentTopLineView == nil) {
        _segmentTopLineView = [UILabel new];
        _segmentTopLineView.backgroundColor = [UIColor colorFromHexRGB:@"dbdbdb"];
        
    }
    
    return _segmentTopLineView;
}

- (UILabel *)segmentBottomLineView{
    
    if (_segmentBottomLineView == nil) {
        _segmentBottomLineView = [UILabel new];
        _segmentBottomLineView.backgroundColor = [UIColor colorFromHexRGB:@"dbdbdb"];
        
    }
    
    return _segmentBottomLineView;
}


- (UIView *)segmentViewWhiteContentView{
    
    if (_segmentViewWhiteContentView == nil) {
        _segmentViewWhiteContentView = [UIView new];
        _segmentViewWhiteContentView.backgroundColor = [UIColor whiteColor];
    }
    
    return _segmentViewWhiteContentView;
}

- (UIView *)headBottomLine {
    
    if (!_headBottomLine) {
        _headBottomLine = [[UIView alloc] initWithFrame:CGRectZero];
        _headBottomLine.backgroundColor = _COLOR_HEX(0x5bddb1);
        _headBottomLine.hidden = YES;
    }
    return _headBottomLine;
}

- (void)_initOrderTypeSegmentView{
    
    __weak typeof(&*self) weakSelf = self;
    
    [self.view addSubview:self.bidTypeSegmentView];
    
    [self.segmentViewWhiteContentView addSubview:self.segmentTopLineView];
    [self.segmentViewWhiteContentView addSubview:self.segmentBottomLineView];
    [self.segmentViewWhiteContentView addSubview:self.headBottomLine];
    [self.bidTypeSegmentView addSubview:self.segmentViewWhiteContentView];
    
    [self.segmentTopLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(weakSelf.bidTypeSegmentView);
        make.top.equalTo(weakSelf.segmentViewWhiteContentView);
        make.height.mas_equalTo(RETINA_1PX);
    }];
    
    [self.segmentViewWhiteContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(weakSelf.bidTypeSegmentView);
        make.height.equalTo(@45);
    }];
    
    [self.segmentBottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(weakSelf.segmentViewWhiteContentView);
        make.height.mas_equalTo(RETINA_1PX);
    }];
    
    [self.bidTypeSegmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.equalTo(weakSelf.view);
        make.height.mas_equalTo(45);
    }];
    
    [self.headBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(weakSelf.segmentViewWhiteContentView);
        make.height.mas_equalTo(4.0f);
    }];
    
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 10 * 5)/4;
    
    for (NSInteger i = 0; i < self.segmentViewTitles.count; i++) {
        
        NSString *title = self.segmentViewTitles[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorFromHexRGB:@"949494"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorFromHexRGB:@"ffffff"] forState:UIControlStateSelected];
        [button.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [button setBackgroundColor:[UIColor whiteColor]];
        //button.layer.cornerRadius = 2;
        //button.layer.borderColor = [[UIColor colorFromHexRGB:@"b2b2b2"] CGColor];
        //button.layer.borderWidth = 0.5;
        button.tag = 100 + i ;
        
        [self.segmentViewWhiteContentView addSubview:button];
        [button addTarget:self action:@selector(segmentViewAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.segmentViewWhiteContentView);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(41);
            
            if (i == 0) {
                make.leading.equalTo(weakSelf.segmentViewWhiteContentView).offset(10);
            }else{
                make.leading.equalTo(weakSelf.segmentViewWhiteContentView).offset(10 + (width + 10) * i  );
            }
        }];
        
    }
}

- (void)segmentViewAction:(UIButton *)sender{
    
    self.index = sender.tag - 100;
    
    for (UIView *view  in self.segmentViewWhiteContentView.subviews) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            view.backgroundColor = [UIColor whiteColor];
            [(UIButton *)view  setSelected:NO];
            view.layer.borderColor = [[UIColor colorFromHexRGB:@"b2b2b2"] CGColor];
        }
        
    }
    
    UIButton *button = (UIButton *)sender;
    //[button setBackgroundColor:[UIColor colorFromHexRGB:@"35b38d"]];
    //button.selected = YES;
    //button.layer.borderColor = [[UIColor clearColor] CGColor];
    
    self.contentScrollView.contentOffset = CGPointMake([UIScreen mainScreen].bounds.size.width * (button.tag - 100), 0);
    
    NSMutableArray *dataSource = self.dataSources[sender.tag -100];
    UITableView *tableView = [self.contentTaleViews  objectAtIndex:sender.tag - 100];
    
    if (dataSource.count == 0) {
        
        [tableView headerBeginRefreshing];
    }
    
    self.headBottomLine.hidden = NO;
    self.headBottomLine.frame = CGRectMake(button.frame.origin.x, 41.0f, button.frame.size.width, 4.0f);
    self.headBottomLine.backgroundColor = _COLOR_HEX(0x5bddb1);
}



- (void)_initContentScrollView{
    
    [self.view addSubview:self.contentScrollView];
    
    __weak typeof(&*self) weakSelf = self;
    
    [self.contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.bidTypeSegmentView.mas_bottom);
    }];
    
    UIView *containerView = [UIView new];
    [self.contentScrollView addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(weakSelf.contentScrollView);
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

- (void)_initTableViews{
    
    for (UITableView *tableView in self.contentTaleViews) {
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor colorFromHexRGB:@"f1f1f1"];
        
        UINib *nib = [UINib nibWithNibName:@"BidCenterTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:NSStringFromClass([BidCenterTableViewCell class])];
        
        nib = [UINib nibWithNibName:@"BidCenterOpTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:NSStringFromClass([BidCenterOpTableViewCell class])];

        
        
        __weak typeof(&*self) weakSelf = self;
        __weak UITableView *weakTableView = tableView;
        
        /*
         未开标：NOT_COMPLETE
         已中标：WIN
         未中标：NOT_WIN
         流标：FAILING
         */
        
        [tableView addHeaderWithCallback:^{
            NSInteger index = [weakSelf.contentTaleViews indexOfObject:weakTableView];
            NSString *status = nil;
            
            if (index == 0) {
                status =[NSString stringWithFormat:@"%@,%@,%@", @"NOT_OPEN",@"WIN",@"NOT_WIN"];
            }else if(index == 1){
                status = @"NOT_OPEN";
            }else if(index == 2){
                status = @"WIN";
            }else if(index == 3){
                status = @"NOT_WIN";
            }
            
            
            [weakSelf refreshList:status  page:@"1" row:@"10" dataSource:weakSelf.dataSources[index] tableView:weakTableView];
            
            
            
        }];
        
        [tableView addFooterWithCallback:^{
            NSInteger index = [weakSelf.contentTaleViews indexOfObject:weakTableView];
            NSString *status = nil;
            
            if (index == 0) {
                status =[NSString stringWithFormat:@"%@,%@,%@", @"NOT_OPEN",@"WIN",@"NOT_WIN"];
            }else if(index == 1){
                status = @"NOT_OPEN";
            }else if(index == 2){
                status = @"WIN";
            }else if(index == 3){
                status = @"NOT_WIN";
            }
            
            NSArray *data = weakSelf.dataSources[index];
            NSInteger page = data.count / 10 + 1;
            
            [weakSelf refreshList:status  page:[NSString stringWithFormat:@"%zi",page] row:@"10" dataSource:weakSelf.dataSources[index] tableView:weakTableView];
        }];
    }
}

////刷新订单列表
- (void)refreshList:(NSString *)status  page:(NSString *)page row:(NSString *)row dataSource:(NSMutableArray *)datasource tableView:(UITableView *)tableView{
    
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self vs_showLoading];
//    });
    
    
    NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    
    NSString * bidderId = [NSString stringWithFormat:@"%zi",[BidderManager shareInstance].authedEnterPrise.bidder.id.integerValue];
    
    if (!([BidderManager shareInstance].authedEnterPrise.bidder.id.integerValue > 0)) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self vs_hideLoadingWithCompleteBlock:nil];
        });
        
        [tableView headerEndRefreshing];
        [tableView footerEndRefreshing];
        [tableView setFooterHidden:YES];
        
        [tableView reloadData];
        
        
        return;
    }
    
    
    NSDictionary *dic = @{@"bidderId":bidderId,
                          @"partyId":partyId,
                          @"status":status,//	状态
                          @"page":page,//	显示第几页
                          @"row":row,//	每页显示条数
                          };
    
    
    [BCNetWorkTool executeGETNetworkWithParameter:dic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.enterprise/get-my-bid-project-list/version/1.2.0" withSuccess:^(id callBackData) {
        
        
        
        [self vs_hideLoadingWithCompleteBlock:nil];
        
        
        
        
        NSDictionary *dic = (NSDictionary *)callBackData;
        
        NSArray *list = dic[@"bidProjectList"];
        
        if (page.integerValue == 1) {
            [datasource removeAllObjects];
        }
        
        
        NSArray *arr = [BidProject mj_objectArrayWithKeyValuesArray:list];
        
        [datasource addObjectsFromArray:arr];
        
        
        [tableView headerEndRefreshing];
        [tableView footerEndRefreshing];
        
        [tableView reloadData];
        
        if ( [dic[@"nextPage"] isEqualToString:@"Y"]) {
            [tableView setFooterHidden:NO];
        }else{
            [tableView setFooterHidden:YES];
        }
        
        
        
    } orFail:^(id callBackData) {
        
        
        [self vs_hideLoadingWithCompleteBlock:nil];
        
        
        [self.view showTipsView:[callBackData domain]];
        
        [tableView headerEndRefreshing];
        [tableView footerEndRefreshing];
        
        
    }];
    
}

#pragma mark -

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self vs_setTitleText:@"我的投标"];
    
    
    [self _initOrderTypeSegmentView];
    
    [self _initTableViews];
    
    [self _initContentScrollView];
    
    
    [self performSelector:@selector(changeSegmentView) withObject:nil afterDelay:0.3];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction) name:@"refundDepositSuccessNOtification" object:nil];
    
}

- (void)notificationAction{
    
    UITableView *tableView = [self.contentTaleViews  objectAtIndex:self.index];
    
    [tableView headerBeginRefreshing];
}


#pragma mark -

- (void) changeSegmentView{
    UIButton *button = (UIButton *)[self.segmentViewWhiteContentView viewWithTag:self.index+100];
    [self segmentViewAction:button];
}

#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    NSInteger index = [self.contentTaleViews indexOfObject:tableView];
    
    NSInteger count = [(NSMutableArray *)self.dataSources[index] count];
    if (count <= 0) {
        MeEmptyDataView *noDataView = [tableView viewWithTag:1011];
        if (noDataView == nil) {
            noDataView = [[MeEmptyDataView alloc] init];
        }
        
        [tableView addSubview:noDataView];
        noDataView.tag = 1011;
        noDataView.frame = self.view.bounds;
    }
    else{
        
        MeEmptyDataView *noDataView = [tableView viewWithTag:1011];
        if (noDataView) {
            [noDataView removeFromSuperview];
        }
    }
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSMutableArray * arr = self.dataSources[self.index];
    
    return arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = [self.contentTaleViews indexOfObject:tableView];
    NSMutableArray * arr =(NSMutableArray *)self.dataSources[index];
    
    BidProject *data = [arr objectAtIndex:indexPath.row];
    
    if (data.bidDeposit.floatValue > 0) {
        if ([data.canReturn isEqualToString:@"Y"]) {
            if ([data.bidderProjectStatus isEqualToString:@"NOT_OPEN"]) {
                return 145;
            } else {
                return 110;
            }
        } else {
            return 110;
        }
    }
    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSInteger index = [self.contentTaleViews indexOfObject:tableView];
    NSMutableArray * arr =(NSMutableArray *)self.dataSources[index];
    
    BidProject *data = [arr objectAtIndex:indexPath.row];
    
    if (data.bidDeposit.floatValue > 0) {
        if ([data.canReturn isEqualToString:@"Y"]) {
            if ([data.bidderProjectStatus isEqualToString:@"NOT_OPEN"]) {
                BidCenterOpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BidCenterOpTableViewCell class])];
                
                cell.isMyBidList = YES;
                
                cell.dto = data;
                
                __weak typeof(self) weakSelf = self;
                [cell setRequestDepositBackBlock:^(BidProject * bidPro) {
                    [weakSelf requestDepositBackAction:bidPro];
                }];
                
                return cell;
            } else {
                BidCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BidCenterTableViewCell class])];
                
                cell.isMyBidList = YES;
                
                cell.dto = data;
                
                return cell;
            }
        } else {
            BidCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BidCenterTableViewCell class])];
            
            cell.isMyBidList = YES;
            
            cell.dto = data;
            
            return cell;
        }
    }
    
    BidCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BidCenterTableViewCell class])];
    
    cell.isMyBidList = YES;
    
    cell.dto = data;
    
    return cell;
}

//申请退款
- (void)requestDepositBackAction:(BidProject *)pro{
    
    BidDepositOprationViewController *vc = [BidDepositOprationViewController new];
    vc.bidPro = pro;
    [self.navigationController pushViewController:vc animated:YES];
    
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = [self.contentTaleViews indexOfObject:tableView];
    NSMutableArray * arr =(NSMutableArray *)self.dataSources[index];
    
    BidProject *dto = [arr objectAtIndex:indexPath.row];
    
    if (![dto.projectUrl isEmptyString]) {
        
        BidWebViewController *vc = [[BidWebViewController alloc] initWithUrl:[NSURL URLWithString:dto.projectUrl]];
        
        vc.isMyBidList = YES;
        
        vc.dto = dto;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

@end

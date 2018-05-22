//
//  MyEnrolledActivityViewController.m
//  VSProject
//
//  Created by apple on 10/18/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "MyEnrolledActivityViewController.h"
#import "NewActivitiesManager.h"
#import "NewActivityDetailViewController.h"
#import "NewMyActivityCell.h"
#import "UIColor+TPCategory.h"
#import "MJExtension.h"
#import "MeEmptyDataView.h"


#define spaceInButtons (__SCREEN_WIDTH__ - 50) / 3

@interface MyEnrolledActivityViewController () <UITableViewDataSource,UITableViewDelegate>
{
    NewActivitiesManager *manger;
    dispatch_group_t requestGroup;
}

_PROPERTY_NONATOMIC_STRONG(UIView, emptyView)

@property (nonatomic,strong) UIView *bidTypeSegmentView;

@property (nonatomic,strong) UILabel *segmentTopLineView;

@property (nonatomic,strong) UILabel *segmentBottomLineView;

@property (nonatomic,strong) UIView *segmentViewWhiteContentView;

@property (nonatomic,strong) NSArray *segmentViewTitles;

@property (nonatomic,strong) NSArray *contentTaleViews;

@property (nonatomic,strong) UIScrollView *contentScrollView;

@property (nonatomic,strong) NSArray *dataSources;

@property (nonatomic,assign) NSInteger index;//选中segmentView index

@property (nonatomic, strong) UIView *headBottomLine; // 头部下划线

@end

@implementation MyEnrolledActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self vs_setTitleText:@"我的活动"];
    [self.view setBackgroundColor:ColorWithHex(0xeeeeee, 1.0)];
    
    manger = [[NewActivitiesManager alloc] init];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self _initOrderTypeSegmentView];
    
    [self _initTableViews];
    
    [self _initContentScrollView];
    
    
    [self performSelector:@selector(changeSegmentView) withObject:nil afterDelay:0.3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)emptyView {
    if (!_emptyView) {
        _emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_WIDTH__, __SCREEN_HEIGHT__ - 64)];
        [_emptyView setBackgroundColor:[UIColor whiteColor]];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((__SCREEN_WIDTH__ - 60)/2, 53, 60, 55)];
        [imageView setImage:__IMAGENAMED__(@"icon_huodong_dis")];
        [_emptyView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 53 + 55 +14, __SCREEN_WIDTH__, 21)];
        [label setText:@"你没有已报名的活动,看看其他活动吧"];
        [label setFont:[UIFont systemFontOfSize:13]];
        [label setTextColor:ColorWithHex(0x5c5c5c, 1.0)];
        [label setTextAlignment:NSTextAlignmentCenter];
        [_emptyView addSubview:label];
    }
    return _emptyView;
}

#pragma mark -- request

- (NSArray *)dataSources{
    
    if (_dataSources == nil) {
        
        _dataSources = @[[NSMutableArray array],[NSMutableArray array],[NSMutableArray array],[NSMutableArray array]];
    }
    
    return _dataSources;
    
}

- (NSArray *)segmentViewTitles{
    
    if (_segmentViewTitles == nil) {
        _segmentViewTitles = @[@"全部",@"未开始",@"进行中",@"已结束"];
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
        _bidTypeSegmentView.backgroundColor = [UIColor whiteColor];
        
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
        _segmentBottomLineView.backgroundColor = [UIColor clearColor];
        
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
        make.top.equalTo(weakSelf.bidTypeSegmentView).offset(0);
        make.height.equalTo(@45);
    }];
    
    [self.segmentBottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(weakSelf.segmentViewWhiteContentView);
        make.height.mas_equalTo(RETINA_1PX);
    }];
    
    [self.headBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(weakSelf.segmentViewWhiteContentView);
        make.height.mas_equalTo(4.0f);
    }];
    
    [self.bidTypeSegmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.equalTo(weakSelf.view);
        make.height.mas_equalTo(45);
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
        
        UINib *nib = [UINib nibWithNibName:@"NewMyActivityCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:NSStringFromClass([NewMyActivityCell class])];
        
        __weak typeof(&*self) weakSelf = self;
        __weak UITableView *weakTableView = tableView;
        
        [tableView addHeaderWithCallback:^{
            NSInteger index = [weakSelf.contentTaleViews indexOfObject:weakTableView];
            NSString *status = nil;
            
            if (index == 0) {
                status =[NSString stringWithFormat:@"%@,%@,%@", @"NOT_START",@"STARTED",@"COMPLETED"];
            }else if(index == 1){
                status = @"NOT_START";
            }else if(index == 2){
                status = @"STARTED";
            }else if(index == 3){
                status = @"COMPLETED";
            }
            
            [weakSelf refreshList:status  page:@"1" row:@"10" dataSource:weakSelf.dataSources[index] tableView:weakTableView];
        }];
        
        [tableView addFooterWithCallback:^{
            NSInteger index = [weakSelf.contentTaleViews indexOfObject:weakTableView];
            NSString *status = nil;
            
            if (index == 0) {
                status =[NSString stringWithFormat:@"%@,%@,%@", @"NOT_START",@"STARTED",@"COMPLETED"];
            }else if(index == 1){
                status = @"NOT_START";
            }else if(index == 2){
                status = @"STARTED";
            }else if(index == 3){
                status = @"COMPLETED";
            }
            
            NSArray *data = weakSelf.dataSources[index];
            NSInteger page = data.count / 10 + 1;
            
            [weakSelf refreshList:status  page:[NSString stringWithFormat:@"%zi",page] row:@"10" dataSource:weakSelf.dataSources[index] tableView:weakTableView];
        }];
    }
}

////活动列表
- (void)refreshList:(NSString *)status  page:(NSString *)page row:(NSString *)row dataSource:(NSMutableArray *)datasource tableView:(UITableView *)tableView{
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self vs_showLoading];
//    });
    
    NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    
    [manger onRequestMyActivityList:page row:row status:status partyId:partyId success:^(NSDictionary *responseObj) {
        NSError *err;
        [self vs_hideLoadingWithCompleteBlock:nil];
        NSArray *list = [NewActivityModel arrayOfModelsFromDictionaries:[responseObj objectForKey:@"activityList"] error:&err];
        
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
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"NewMyActivityCell";
    NewMyActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"NewMyActivityCell" owner:nil options:nil] lastObject];
    }
    NSInteger index = [self.contentTaleViews indexOfObject:tableView];
    NSMutableArray * arr =(NSMutableArray *)self.dataSources[index];
    NewActivityModel *a_model = (NewActivityModel *)[arr objectAtIndex:indexPath.row];
    [cell setDataSource:a_model];
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.contentView setFrame:CGRectMake(12, 5, __SCREEN_WIDTH__ - 24, 100)];
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = [self.contentTaleViews indexOfObject:tableView];
    NSMutableArray * arr =(NSMutableArray *)self.dataSources[index];
    
    NewActivityModel *a_model = [arr objectAtIndex:indexPath.row];
    
    NewActivityDetailViewController *vcontroller = [[NewActivityDetailViewController alloc]init];
    vcontroller.a_model = a_model;
    vcontroller.webUrl = [NSURL URLWithString:vcontroller.a_model.activityDetail];
    [self.navigationController pushViewController:vcontroller animated:YES];
}

@end

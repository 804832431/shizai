//
//  NotificationAgentViewController.m
//  VSProject
//
//  Created by certus on 16/3/27.
//  Copyright © 2016年 user. All rights reserved.
//

#import "NotificationAgentViewController.h"
#import "UIColor+TPCategory.h"
#import "NotificationAgentCell.h"
#import "NotificationAgentManger.h"
#import "NAgentModel.h"
#import "NotificationAgentDetailViewController.h"


@interface NotificationAgentViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIView *orderTypeSegmentView;

@property (nonatomic,strong) UILabel *segmentTopLineView;

@property (nonatomic,strong) UILabel *segmentBottomLineView;

@property (nonatomic,strong) UIView *segmentViewWhiteContentView;

@property (nonatomic,strong) NSArray *segmentViewTitles;

@property (nonatomic,strong) NSArray *contentTaleViews;

@property (nonatomic,strong) UIScrollView *contentScrollView;

@property (nonatomic,strong) NSArray *dataSources;

@property (nonatomic,strong) NotificationAgentManger *manger;

@end

@implementation NotificationAgentViewController

- (NSArray *)dataSources{
    
    if (_dataSources == nil) {
        
        _dataSources = @[[NSMutableArray array],[NSMutableArray array],[NSMutableArray array],[NSMutableArray array],[NSMutableArray array]];
    }
    
    return _dataSources;
    
}

- (NSArray *)segmentViewTitles{
    
    if (_segmentViewTitles == nil) {
        _segmentViewTitles = @[@"全部",@"待处理",@"处理中",@"预约成功",@"预约失败"];
    }
    return _segmentViewTitles;
}

- (NSArray *)contentTaleViews{
    
    if (_contentTaleViews == nil) {
        _contentTaleViews  = @[[UITableView new],[UITableView new],[UITableView new],[UITableView new],[UITableView new]];
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

- (UIView *)orderTypeSegmentView{
    
    if (_orderTypeSegmentView == nil) {
        
        _orderTypeSegmentView = [UIView new];
        _orderTypeSegmentView.backgroundColor = [UIColor colorFromHexRGB:@"f1f1f1"];
        
    }
    
    return _orderTypeSegmentView;
    
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

- (NotificationAgentManger *)manger {

    if (!_manger) {
        _manger = [[NotificationAgentManger alloc]init];
    }
    return _manger;
}

- (void)_initOrderTypeSegmentView{
    
    __weak typeof(&*self) weakSelf = self;
    
    [self.view addSubview:self.orderTypeSegmentView];
    
    [self.segmentViewWhiteContentView addSubview:self.segmentTopLineView];
    [self.segmentViewWhiteContentView addSubview:self.segmentBottomLineView];
    [self.orderTypeSegmentView addSubview:self.segmentViewWhiteContentView];
    
    [self.segmentTopLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(weakSelf.orderTypeSegmentView);
        make.top.equalTo(weakSelf.segmentViewWhiteContentView);
        make.height.mas_equalTo(RETINA_1PX);
    }];
    
    [self.segmentViewWhiteContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(weakSelf.orderTypeSegmentView);
        make.top.equalTo(weakSelf.orderTypeSegmentView).offset(13);
        make.height.equalTo(@45);
    }];
    
    [self.segmentBottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(weakSelf.segmentViewWhiteContentView);
        make.height.mas_equalTo(RETINA_1PX);
    }];
    
    [self.orderTypeSegmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.equalTo(weakSelf.view);
        make.height.mas_equalTo(73);
    }];
    
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 33- 28)/5;
    
    for (NSInteger i = 0; i < self.segmentViewTitles.count; i++) {
        
        NSString *title = self.segmentViewTitles[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorFromHexRGB:@"949494"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorFromHexRGB:@"ffffff"] forState:UIControlStateSelected];
        [button.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [button setBackgroundColor:[UIColor whiteColor]];
        button.layer.cornerRadius = 2;
        button.layer.borderColor = [[UIColor colorFromHexRGB:@"b2b2b2"] CGColor];
        button.layer.borderWidth = 0.5;
        button.tag = 100 + i ;
        
        [self.segmentViewWhiteContentView addSubview:button];
        [button addTarget:self action:@selector(segmentViewAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.segmentViewWhiteContentView);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(24);
            
            if (i == 0) {
                make.leading.equalTo(weakSelf.segmentViewWhiteContentView).offset(16);
            }else{
                make.leading.equalTo(weakSelf.segmentViewWhiteContentView).offset(16 + (width + 7) * i  );
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
    [button setBackgroundColor:[UIColor colorFromHexRGB:@"35b38d"]];
    button.selected = YES;
    button.layer.borderColor = [[UIColor clearColor] CGColor];
    
    self.contentScrollView.contentOffset = CGPointMake([UIScreen mainScreen].bounds.size.width * (button.tag - 100), 0);
    
    UITableView *tableView = [self.contentTaleViews  objectAtIndex:sender.tag - 100];

    [tableView headerBeginRefreshing];

}



- (void)_initContentScrollView{
    
    [self.view addSubview:self.contentScrollView];
    
    __weak typeof(&*self) weakSelf = self;
    
    [self.contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.orderTypeSegmentView.mas_bottom);
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
        
        __weak typeof(&*self) weakSelf = self;
        __weak UITableView *weakTableView = tableView;
        [tableView addHeaderWithCallback:^{
            NSInteger index = [weakSelf.contentTaleViews indexOfObject:weakTableView];
            NSString *agentStatus = nil;
            
            if (index == 0) {
                agentStatus = @"";
            }else if(index == 1){
                agentStatus = NAGENT_SUBMIT;
            }else if(index == 2){
                agentStatus = NAGENT_PROCESSING;
            }else if(index == 3){
                agentStatus = NAGENT_CONFIRM;
            }else if(index == 4){
                agentStatus = NAGENT_REJECT;
            }
            
            
            [weakSelf refreshOrderList:agentStatus page:@"1" row:@"10" dataSource:weakSelf.dataSources[index] tableView:weakTableView];
        }];
        
        [tableView addFooterWithCallback:^{
            NSInteger index = [weakSelf.contentTaleViews indexOfObject:weakTableView];
            NSString *agentStatus = nil;
            
            if (index == 0) {
                agentStatus = @"";
            }else if(index == 1){
                agentStatus = NAGENT_SUBMIT;
            }else if(index == 2){
                agentStatus = NAGENT_PROCESSING;
            }else if(index == 3){
                agentStatus = NAGENT_CONFIRM;
            }else if(index == 4){
                agentStatus = NAGENT_REJECT;
            }
            
            NSArray *data = weakSelf.dataSources[index];
            NSInteger page = data.count / 10 + 1;
            
            [weakSelf refreshOrderList:agentStatus  page:[NSString stringWithFormat:@"%zi",page] row:@"10" dataSource:weakSelf.dataSources[index] tableView:weakTableView];
        }];
    }
}
#pragma mark - request

- (void)refresh {

    [self.contentTaleViews[0] headerBeginRefreshing];

}
//刷新预约列表
- (void)refreshOrderList:(NSString *)agentStatus page:(NSString *)page row:(NSString *)row dataSource:(NSMutableArray *)datasource tableView:(UITableView *)tableView{
    
    [self vs_showLoading];
    
    NSDictionary *dic = @{@"partyId":[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"",//partyId
                          @"status":agentStatus,//	状态
                          @"page":page,//	显示第几页
                          @"row":row,//	每页显示条数
                          };
    
    [self.manger requestGetReservationByStatus:dic success:^(NSDictionary *responseObj) {
        NSDictionary *dic = (NSDictionary *)responseObj;
        
        NSArray *reservationList = dic[@"reservationList"];
        
        NSArray *list = [NAgentModel arrayOfModelsFromDictionaries:reservationList];
        if (page.integerValue == 1) {
            [datasource removeAllObjects];
        }
        [datasource addObjectsFromArray:list];

        [tableView headerEndRefreshing];
        [tableView footerEndRefreshing];
        
        [tableView reloadData];
        
        if ( ((NSNumber *)dic[@"hasNext"]).intValue == 1) {
            [tableView setFooterHidden:NO];
        }else{
            [tableView setFooterHidden:YES];
        }
        
        [self vs_hideLoadingWithCompleteBlock:nil];

    } failure:^(NSError *error) {
        [tableView headerEndRefreshing];
        [tableView footerEndRefreshing];
        
        [self vs_hideLoadingWithCompleteBlock:nil];

    }];
    
}

- (void)cancelOrder:(NAgentModel *)model{
    
    
    [self vs_showLoading];
    
    NSDictionary *dic = @{@"reservationId":model.id,//	预约号
                          };
    
    [self.manger requestCancelReservation:dic success:^(NSDictionary *responseObj) {
        [(UITableView *)self.contentTaleViews[self.index] headerBeginRefreshing];
        
        [self vs_hideLoadingWithCompleteBlock:nil];
        
    } failure:^(NSError *error) {
        [self.view showTipsView:[error domain]];
        
        [self vs_hideLoadingWithCompleteBlock:nil];
        
    }];
    
}

#pragma mark -

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    UIButton *button = (UIButton *)[self.segmentViewWhiteContentView viewWithTag:self.orderType+100];
    [self segmentViewAction:button];

    
}
- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self vs_setTitleText:@"通知待办"];
    
    [self _initOrderTypeSegmentView];
    
    [self _initTableViews];
    
    [self _initContentScrollView];
    
    [self vs_showLoading];
    
    [self performSelector:@selector(changeSegmentView) withObject:nil afterDelay:0.3];
    
    
}


#pragma mark -

//- (void) changeSegmentView{
//    UIButton *button = (UIButton *)[self.segmentViewWhiteContentView viewWithTag:self.orderType+100];
//    [self segmentViewAction:button];
//}

#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger index = [self.contentTaleViews indexOfObject:tableView];
    NSMutableArray * arr =(NSMutableArray *)self.dataSources[index];

    return arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 146;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger index = [self.contentTaleViews indexOfObject:tableView];
    NSMutableArray * arr =(NSMutableArray *)self.dataSources[index];
    NAgentModel *model = arr[indexPath.row];
    
    static NSString *identifier = @"NotificationAgentCell";
    NotificationAgentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"NotificationAgentCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    cell.orderLabel.text = [NSString stringWithFormat:@"预约单号：%@",model.id];
    NSString *shwTime = [NSDate timeSeconds:model.createTime.longLongValue];
    cell.timeLabel.text = [NSString stringWithFormat:@"提交时间：%@",shwTime];
    if ([model.appState isEqualToString:NAGENT_SUBMIT]) {
        cell.stateLabel.text = @"待处理";
        cell.stateLabel.textColor = _COLOR_HEX(0xff6600);
        [cell.cancelButton setHidden:NO];
    }else if ([model.appState isEqualToString:NAGENT_CANCELED]) {
        cell.stateLabel.text = @"已取消";
        cell.stateLabel.textColor = _COLOR_HEX(0x222222);
        [cell.cancelButton setHidden:YES];
    }else if ([model.appState isEqualToString:NAGENT_PROCESSING]) {
        cell.stateLabel.text = @"处理中";
        cell.stateLabel.textColor = _COLOR_HEX(0xff6600);
        [cell.cancelButton setHidden:NO];
    }else if ([model.appState isEqualToString:NAGENT_REJECT]) {
        cell.stateLabel.text = @"预约失败";
        cell.stateLabel.textColor = _COLOR_HEX(0xff0000);
        [cell.cancelButton setHidden:YES];
    }else if ([model.appState isEqualToString:NAGENT_CONFIRM]) {
        cell.stateLabel.text = @"预约成功";
        cell.stateLabel.textColor = _COLOR_HEX(0x1ecb4b);
        [cell.cancelButton setHidden:YES];
    }
    cell.typeLabel.text = model.appName;
    
    __weak typeof(&*self) weakSelf = self;
    __weak typeof(&*model) weakModel = model;
    //取消
    cell.actionCancel = ^(void){
        RIButtonItem *cancelitem = [RIButtonItem itemWithLabel:@"取消" action:^{
        }];
        RIButtonItem *okitem = [RIButtonItem itemWithLabel:@"确定" action:^{
            [weakSelf cancelOrder:weakModel];
        }];
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"确定取消预约" cancelButtonItem:cancelitem otherButtonItems:okitem, nil];
        [alert show];
        
    };
    //查看
    cell.actionDetail = ^(void){
        NotificationAgentDetailViewController *vc = [[NotificationAgentDetailViewController alloc]init];
        vc.reservationId = weakModel.id;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };

    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

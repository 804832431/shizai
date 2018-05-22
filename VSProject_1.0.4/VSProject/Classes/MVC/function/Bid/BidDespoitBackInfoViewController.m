//
//  BidDespoitBackInfoViewController.m
//  VSProject
//
//  Created by 陈 海涛 on 16/11/1.
//  Copyright © 2016年 user. All rights reserved.
//

#import "BidDespoitBackInfoViewController.h"
#import "BCNetWorkTool.h"
#import "OrderDetailDTO.h"
#import "MJExtension.h"
#import "RefundOrdersTitleTableViewCell.h"
#import "RefundOrdersProductTableViewCell.h"
#import "RefundMiddleTableViewCell.h"
#import "RefundRejectedTableViewCell.h"
#import "ReturnTableViewCell.h"
#import "ReturnManTableViewCell.h"
#import "ReturnAccpetTableViewCell.h"
#import "ReturnCompleteTableViewCell.h"
#import "RequestBackDepositTableViewCell.h"
#import "BidderManager.h"

@interface BidDespoitBackInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *ReturnStatusList;
@property (nonatomic,strong) UILabel *returnDescLabel;
@end

@implementation BidDespoitBackInfoViewController

- (UILabel *)returnDescLabel{
    if (_returnDescLabel == nil) {
        _returnDescLabel = [UILabel new];
        _returnDescLabel.font = [UIFont systemFontOfSize:12];
        _returnDescLabel.textColor = _Colorhex(0x666666);
        _returnDescLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _returnDescLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self vs_setTitleText:@"退款详情"];
    
    __weak typeof(self) weakSelf = self;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    [self.tableView registerClass:[RequestBackDepositTableViewCell class] forCellReuseIdentifier:NSStringFromClass([RequestBackDepositTableViewCell class])];
    
   
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"defaultCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
   UINib* nib = [UINib nibWithNibName:@"ReturnTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:NSStringFromClass([ReturnTableViewCell class])];
    

    nib = [UINib nibWithNibName:@"ReturnAccpetTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:NSStringFromClass([ReturnAccpetTableViewCell class])];
    
    nib = [UINib nibWithNibName:@"ReturnCompleteTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:NSStringFromClass([ReturnCompleteTableViewCell class])];
    
    
    [self loadData];
    
}


- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = _Colorhex(0xf4f4f4);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    return _tableView;
}

- (void)loadData{
    

    [self vs_showLoading];
    /*
     partyId	用户id
     bidderId	投标企业id
     bidProjectId	项目id
     
     */
    
    __weak typeof(self) weakSelf = self;
    NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    
    NSDictionary *dic = @{
                          @"partyId":partyId,
                          @"bidderId":[BidderManager shareInstance].authedEnterPrise.bidder.id?:@"",
                          @"bidProjectId":self.dto.bidProjectId?:@""
                          };
    [BCNetWorkTool executeGETNetworkWithParameter:dic  andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.enterprise/get-deposit-return-view/version/1.2.2" withSuccess:^(id callBackData) {
        
        [weakSelf vs_hideLoadingWithCompleteBlock:^{
            
        }];
        
        NSDictionary *dic = (NSDictionary *)callBackData;
        
        weakSelf.dto = [BidProject mj_objectWithKeyValues:dic[@"bidProject"]];
        
        weakSelf.ReturnStatusList = dic[@"returnStatusList"];
        
        [weakSelf.tableView reloadData];
       
    } orFail:^(id callBackData) {
        
        [weakSelf vs_hideLoadingWithCompleteBlock:^{
            
        }];
        
    }];
    
}

#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    if (section == 0) {
        return 193;
    }else if(section == 1){
        
        return 30;
        
    }else{
        static RequestBackDepositTableViewCell *cell = nil;
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            cell =  [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RequestBackDepositTableViewCell class])];
        });
        
        cell.dto = self.dto;
        
        [cell.contentView setNeedsLayout];
        [cell.contentView layoutIfNeeded];
        
        
        return CGRectGetMaxY(cell.contentBackgroundView.frame) + 10;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    /*
     退款申请中
     RETURN_REQUESTED；
     已同意：
     RETURN_ACCEPTED，
     已退款：
     RETURN_COMPLETED

     */
    
    if (indexPath.section == 0) {
        
        if ([self.dto.returnStatus isEqualToString:@"RETURN_REQUESTED"]) {
            ReturnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ReturnTableViewCell class])];
            
            cell.returnStatusList = self.ReturnStatusList;
            
            return cell;
            
        }else  if([self.dto.returnStatus isEqualToString:@"RETURN_ACCEPTED"]){
            
            ReturnAccpetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ReturnAccpetTableViewCell class])];
            
           cell.returnStatusList = self.ReturnStatusList;
            
            return cell;
            
        }else if([self.dto.returnStatus isEqualToString:@"RETURN_COMPLETED"]){
            
            ReturnCompleteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ReturnCompleteTableViewCell class])];
            
            cell.returnStatusList = self.ReturnStatusList;
            
            return cell;
            
        }
        
        
        
    }else if(indexPath.section == 1){
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"defaultCell"];
        
        cell.backgroundColor = self.tableView.backgroundColor;
        
        [cell.contentView addSubview:self.returnDescLabel];
        __weak typeof(cell) weakCell = cell;
        [self.returnDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(weakCell.contentView).offset(10);
            make.trailing.equalTo(weakCell.contentView).offset(-10);
            make.top.bottom.equalTo(weakCell.contentView);
        }];
        
       /*
        退款申请中：
        RETURN_REQUESTED；
        已同意：
        RETURN_ACCEPTED，
        已退款：
        RETURN_COMPLETED

        */
        if ([self.dto.returnStatus isEqualToString:@"RETURN_REQUESTED"]) {
             self.returnDescLabel.text = @"您的退款申请正在进行中，请耐心等待～";
        }else if ([self.dto.returnStatus isEqualToString:@"RETURN_ACCEPTED"]) {
            self.returnDescLabel.text = @"您的退款申请已通过，将于5个工作日内退回您的账户";
        }else if ([self.dto.returnStatus isEqualToString:@"RETURN_COMPLETED"]) {
            
            BOOL isAlPay = [self.dto.paymentType isEqualToString:@"EXT_ALIPAY"];
            self.returnDescLabel.text = [NSString stringWithFormat:@"您的保证金已退回您的%@账户",isAlPay?@"支付宝":@"微信"];
        }
        
        return cell;
       
        
        
    }else if (indexPath.section == 2) {
        
        RequestBackDepositTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RequestBackDepositTableViewCell class])];
        
        cell.dto = self.dto;
        
        return cell;
        
        
    }
    
    
    
    return nil;
}

@end

//
//  SpaceCheckOrderViewController.m
//  VSProject
//
//  Created by pangchao on 17/1/9.
//  Copyright © 2017年 user. All rights reserved.
//

#import "SpaceCheckOrderViewController.h"
#import "AddressTableViewCell.h"
#import "ChoosePayTypeTableViewCell.h"
#import "ChooseSendTimeTableViewCell.h"
#import "OrderBottomView.h"
#import "OrderProductTableViewCell.h"
#import "OrderShopTableViewCell.h"
#import "OrderSumAndDiscountTableViewCell.h"
#import "UIColor+TPCategory.h"
#import "OrderPayViewController.h"
#import "BCNetWorkTool.h"
#import "ReceivingAddressViewController.h"
#import "AdressModel.h"
#import "AdressManger.h"
#import "CouponViewController.h"
#import "CouponManger.h"

static  NSString* AddressTableViewCellIdentifier = @"AddressTableViewCellIdentifier";
static  NSString* OrderShopTableViewCellIdentifier = @"OrderShopTableViewCellIdentifier";
static  NSString* OrderProductTableviewCellIdentifier = @"OrderProductTableviewCellIdentifier";
static  NSString* OrderSumAndDiscountTableViewCellIdentifier = @"OrderSumAndDiscountTableViewCellIdentifier";
static  NSString* ChooseSendTimeTableViewCellIdentifier = @"ChooseSendTimeTableViewCellIdentifier";
static  NSString* ChoosePayTypeTableViewCellIdentifier = @"ChoosePayTypeTableViewCellIdentifier";

@interface SpaceCheckOrderViewController ()

@property (nonatomic,strong) NSString * m_promoCode;
//modify by Thomas ［优惠码存全局，供创建订单使用］－－－end

@property (nonatomic,strong) OrderBottomView *bottomView;

@property (nonatomic,strong) NSString *remark;

@property (nonatomic,strong) NSString *chooseSendTime;//选择配送时间

@property (nonatomic,strong) AdressModel *address;

@property (nonatomic,strong) CouponModel *coupon;

@end

@implementation SpaceCheckOrderViewController

- (void)dealloc{
    NSLog(@"CheckOrderViewController");
}

- (SendTimeChooseView *)sendTimeChooseView{
    
    if (_sendTimeChooseView == nil) {
        
        _sendTimeChooseView = [[SendTimeChooseView alloc] init];
        
    }
    
    return _sendTimeChooseView;
}


- (OrderBottomView *)bottomView{
    
    if (_bottomView == nil) {
        _bottomView = [[OrderBottomView alloc] init];
    }
    
    return _bottomView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self vs_setTitleText:@"确认订单"];
    
    [self.tableView registerClass:[AddressTableViewCell class] forCellReuseIdentifier:AddressTableViewCellIdentifier];
    [self.tableView registerClass:[OrderShopTableViewCell class] forCellReuseIdentifier:OrderShopTableViewCellIdentifier];
    [self.tableView registerClass:[OrderProductTableViewCell class] forCellReuseIdentifier:OrderProductTableviewCellIdentifier];
    [self.tableView registerClass:[OrderSumAndDiscountTableViewCell class] forCellReuseIdentifier:OrderSumAndDiscountTableViewCellIdentifier];
    [self.tableView registerClass:[ChooseSendTimeTableViewCell class] forCellReuseIdentifier:ChooseSendTimeTableViewCellIdentifier];
    [self.tableView registerClass:[ChoosePayTypeTableViewCell class] forCellReuseIdentifier:ChoosePayTypeTableViewCellIdentifier];
    
    __weak typeof(&*self) weakSelf = self;
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view).offset(-50);
    }];
    
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.leading.trailing.equalTo(weakSelf.view);
        make.height.mas_equalTo(50);
    }];
    
    
    
    [self requestDefaultCoupon];
    [self.bottomView setGoToPayBlock:^{
        
        
        
        NSDictionary *dic = nil;
        
        NSMutableArray *proArr = [NSMutableArray array];
        
        for (ProductDTO *dto in weakSelf.selectedProductDTOList) {
            
            if (dto.quantity.integerValue == 0) {
                continue;
            }
            
            NSDictionary *dic = @{@"quantity":dto.quantity,@"productId":dto.productId};
            
            [proArr addObject:dic];
        }
        
        AdressModel *defaultAddress = weakSelf.address;
        
        if (weakSelf.remark.length == 0) {
            weakSelf.remark = @"";
        }
        
        weakSelf.chooseSendTime = @"";
        
        //        if([weakSelf.selectedCategoryDTO.orderTypeId isEqualToString:SZ_SALES_ORDER_O2O_SALE]){
        //            if (weakSelf.chooseSendTime.length == 0) {
        //                [weakSelf.view showTipsView:@"请选择配送时间"];
        //                return ;
        //            }
        //        }else{
        //            weakSelf.chooseSendTime = @"";
        //        }
        
        
        if (defaultAddress == nil) {
            [weakSelf.view showTipsView:@"请完善地址信息"];
            return ;
        }
        
        
        [weakSelf vs_showLoading];
        //modify by Thomas ［优惠码存全局，供创建订单使用］－－－start
        NSString *promoCodeStr = weakSelf.m_promoCode?:@"";
        //modify by Thomas ［优惠码存全局，供创建订单使用］－－－end
        dic = @{@"promoCode":promoCodeStr,
                @"userLoginId":[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.username,
                @"productStoreId":weakSelf.selectedCategoryDTO.productStoreId,
                @"catalogId":weakSelf.selectedCategoryDTO.catalogId?:@"",
                @"categoryId":weakSelf.selectedCategoryDTO.categoryId?:@"",
                @"reservationDate":weakSelf.chooseSendTime,
                @"orderTypeId":weakSelf.selectedCategoryDTO.orderTypeId?:@"",
                @"productItems":proArr,
                @"contactMechId":defaultAddress.contactMechId,
                @"remark":weakSelf.remark};
        
        NSData *contentData = (NSData *)[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
        
        NSString* jsonContent = [[NSString alloc] initWithData:contentData encoding:NSUTF8StringEncoding];
        
        NSDictionary * contentDic = [NSDictionary dictionaryWithObjectsAndKeys:jsonContent,@"content", nil];
        
        [BCNetWorkTool executePostNetworkWithParameter:contentDic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.order/create-sales-order" withSuccess:^(id callBackData) {
            NSDictionary *dic = (NSDictionary *)callBackData;
            OrderPayViewController *vc = [OrderPayViewController new];
            vc.orderId = dic[@"orderId"];
            vc.orderType = weakSelf.selectedCategoryDTO.orderTypeId;
            vc.needPayMoeny = weakSelf.shoppingCartInfo.totalPayAmount;
            vc.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:vc animated:YES];
            
            [weakSelf vs_hideLoadingWithCompleteBlock:nil];
            
            if (weakSelf.fromShoppingCart) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"kOrderCreatedSuccess" object:nil userInfo:@{@"proList":proArr}];
            }
            
            
        } orFail:^(id callBackData) {
            
            //            [weakSelf.view showTipsView:@"操作失败"];
            [weakSelf.view showTipsView:[callBackData domain]];
            
            [weakSelf vs_hideLoadingWithCompleteBlock:nil];
        }];
        
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.address = [VSUserLogicManager shareInstance].userDataInfo.vm_defaultAdressInfo;
    
    if (self.address == nil) {
        
        self.address = [VSUserLogicManager shareInstance].userDataInfo.vm_defaultAdressInfo;
        
        if (self.address == nil) {
            [self vs_showLoading];
            [self requestReceivingAddressed:nil success:^(NSDictionary *responseObj) {
                self.address = [VSUserLogicManager shareInstance].userDataInfo.vm_defaultAdressInfo;
                [self.tableView reloadData];
                
                [self vs_hideLoadingWithCompleteBlock:nil];
                
            } failure:^(NSError *error) {
                //
                [self vs_hideLoadingWithCompleteBlock:nil];
            }];
        }
    }
    
    
    
    [self.tableView reloadData];
}

#pragma mark - tableViewCell delegate and datasource method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    [self calulateProductMoney];
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 3 + self.shoppingCartInfo.cartItemsList.count;
    }else if(section ==1){
        return 2;
    }
    
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return nil;
    }else if(section == 1){
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor colorFromHexRGB:@"dbdbdb"];
        return view;
    }
    
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    __weak typeof(&*self) weakSelf = self;
    
    if (indexPath.section == 0) {
        
        NSInteger num = [self tableView:tableView numberOfRowsInSection:indexPath.section];
        
        if (indexPath.row == 0) {
            
            AddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AddressTableViewCellIdentifier];
            
            cell.orderTypeId = self.selectedCategoryDTO.orderTypeId;
            
            cell.address = self.address;
            
            return cell;
            
        }else if(indexPath.row == num - 1 ){
            
            OrderSumAndDiscountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderSumAndDiscountTableViewCellIdentifier];
            
            cell.shoppingCartInfoDTO = self.shoppingCartInfo;
            
            cell.orderDemand = self.orderDemand;
            
            cell.orderTypeId = self.selectedCategoryDTO.orderTypeId;
            
            [cell setCouponBlock:^{
                [weakSelf pushCouponVc];
            }];
            
            [cell setRemarkBlock:^(NSString *remark) {
                weakSelf.remark = remark;
            }];
            
            return cell;
            
        }else if (indexPath.row == 1) {
            
            OrderShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderShopTableViewCellIdentifier];
            cell.cartInfoDTO = self.shoppingCartInfo;
            
            return cell;
            
        }else{
            
            OrderProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderProductTableviewCellIdentifier];
            
            CartItemDTO *itemDTO = self.shoppingCartInfo.cartItemsList[indexPath.row - 2];
            cell.orderType = 1;
            
            for (ProductDTO *dto in self.selectedCategoryDTO.prodsList) {
                if ([dto.productId isEqualToString:itemDTO.productId]) {
                    cell.productDTO = dto;
                    break;
                }
            }
            
            cell.cartItemDTO = itemDTO;
            
            if (indexPath.row == num - 2) {
                cell.lastBottomView.hidden = NO;
                cell.bottomView.hidden = YES;
            }else{
                cell.lastBottomView.hidden = YES;
                cell.bottomView.hidden = NO;
            }
            
            return cell;
            
        }
        
        
    }else if(indexPath.section == 1){
        
        if (indexPath.row == 0) {
            
            ChooseSendTimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ChooseSendTimeTableViewCellIdentifier];
            
            if (self.chooseSendTime.length > 0) {
                cell.sendTimeValue.text = self.chooseSendTime;
            }else{
                cell.sendTimeValue.text = @"请选择";
            }
            
            //            if ([self.selectedCategoryDTO.orderTypeId isEqualToString:SZ_SALES_ORDER_O2O_SERVICE_PAY] ){
            //                cell.topLineView.hidden = YES;
            //                cell.sendTime.hidden = YES;
            //                cell.sendTimeValue.hidden = YES;
            //                cell.detailImageView.hidden = YES;
            //            }else{
            //                cell.topLineView.hidden = NO;
            //                cell.sendTime.hidden = NO;
            //                cell.sendTimeValue.hidden = NO;
            //                cell.detailImageView.hidden = NO;
            //            }
            
            cell.topLineView.hidden = YES;
            cell.sendTime.hidden = YES;
            cell.sendTimeValue.hidden = YES;
            cell.detailImageView.hidden = YES;
            
            cell.hidden = YES;
            
            return cell;
            
        }else if(indexPath.row == 1){
            
            ChoosePayTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ChoosePayTypeTableViewCellIdentifier];
            
            cell.hidden = YES;
            
            return cell;
            
        }
        
    }
    
    
    return nil;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            static AddressTableViewCell *cell = nil;
            static dispatch_once_t onceToken;
            //只会走一次
            dispatch_once(&onceToken, ^{
                cell = (AddressTableViewCell*)[tableView dequeueReusableCellWithIdentifier:AddressTableViewCellIdentifier];
            });
            
            cell.address = self.address;
            
            if (cell.address == nil) {
                return 93;
            }
            
            cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.frame), CGRectGetHeight(cell.bounds));
            
            
            CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
            
            
            return size.height+1.0f;
            
            
            
        }else if(indexPath.row == [self tableView:tableView numberOfRowsInSection:0]-1){
            
            
            if ([self.selectedCategoryDTO.orderTypeId isEqualToString:SZ_SALES_ORDER_O2O_SALE]) {
                return 153 + 45;
            }else{
                return 153 + 50 + 45;
            }
            
        }else if (indexPath.row == 1) {
            
            return 35;
            
        }else{
            
            return 73;
            
        }
        
        
    }else if(indexPath.section == 1){
        
        //        if (indexPath.row == 0) {
        //            if ([self.selectedCategoryDTO.orderTypeId isEqualToString:@"SALES_ORDER_B2C"]) {
        //                return 0;
        //            }else{
        //                return 38;
        //            }
        //        }
        
        if (indexPath.row == 0) {
            return 0;
        }else if (indexPath.row == 1){
            return 0;
        }
        
        //        return 38;
        
        
        
    }
    
    
    return 0;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        ReceivingAddressViewController *vc = [ReceivingAddressViewController new];
        
        __weak typeof(&*self) weakSelf = self;
        
        vc.selectReceiveAdress = ^(AdressModel *adModel){
            
            weakSelf.address = adModel;
            [weakSelf.tableView reloadData];
            
        };
        
        [self.navigationController pushViewController:vc animated:YES];
        
        return;
    }
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        
        if ([self.selectedCategoryDTO.orderTypeId  isEqualToString: SZ_SALES_ORDER_O2O_SERVICE_PAY] ) {
            
            return;
        }
        
        __weak typeof(&*self) weakSelf = self;
        
        [self.view addSubview:self.sendTimeChooseView];
        
        
        
        [self.sendTimeChooseView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.leading.trailing.top.bottom.equalTo(weakSelf.view);
            
        }];
        
        
        [self.sendTimeChooseView setChooseTimeBlock:^(NSString *time) {
            
            
            weakSelf.chooseSendTime = time;
            
            [weakSelf.tableView reloadData];
            
        }];
        
        //        NSDate *now = [NSDate date];
        //
        //        NSDate *today = [self theDay:0];
        //        NSDate *todayTwo = [self theDayHour:14 fromNSDate:today];
        //
        //        if ([now compareToDate:todayTwo]) {
        //
        //            self.chooseSendTime = @"16:00-17:00";
        //
        //        }else{
        //
        //            self.chooseSendTime = @"11:00-12:00";
        //
        //        }
        //        [tableView reloadData];
        
    }
    
}

#pragma mark -

- (void)resetCouponCell {
    
    NSInteger num = [self tableView:self.tableView numberOfRowsInSection:0];
    OrderSumAndDiscountTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:num-1 inSection:0]];
    
    if (self.coupon.validCount.floatValue > 0) {
        cell.couponLabel.text = [NSString stringWithFormat:@"%@元优惠券(%@张可用)",self.coupon.value,self.coupon.validCount];
    }else if (self.coupon.value.floatValue > 0) {
        cell.couponLabel.text = [NSString stringWithFormat:@"%@元优惠券",self.coupon.value];
    }else {
        cell.couponLabel.text = @"没有可用的优惠券";
    }
    
    [self promoCodeAction:self.coupon.code];
    
}
- (void)pushCouponVc {
    
    __weak typeof(self)weakself = self;
    
    CouponViewController *vc = [[CouponViewController alloc]init];
    vc.titleName = @"选择优惠券";
    vc.key = @"own";
    vc.orderAmount = self.shoppingCartInfo.totalAmount?:@"";
    vc.merchantId = self.selectedCategoryDTO.categoryId?:@"";
    [vc setCouponModelBlock:^(CouponModel *model) {
        
        weakself.coupon = [model copy];
        [weakself resetCouponCell];
        
    }];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)requestDefaultCoupon {
    CouponManger *couponManger = [[CouponManger alloc]init];
    
    [self vs_showLoading];
    __weak typeof(self)weakself = self;
    
    NSString *username=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.username?:@"";
    
    NSDictionary *para = @{@"userLoginId":username,
                           @"orderAmount":self.shoppingCartInfo.totalAmount?:@"",
                           @"merchantId":self.selectedCategoryDTO.categoryId?:@""
                           };
    [couponManger requestDefaultCoupon:para success:^(NSDictionary *responseObj) {
        [self vs_hideLoadingWithCompleteBlock:nil];
        
        self.coupon = [[CouponModel alloc]initWithDictionary:responseObj error:nil];
        [weakself resetCouponCell];
        
    } failure:^(NSError *error) {
        //
        [self vs_hideLoadingWithCompleteBlock:nil];
    }];
}

- (void)promoCodeAction:(NSString *)promoCode{
    
    [self.view endEditing:YES];
    
    if (promoCode.length == 0) {
        
        return;
    }
    
    [self vs_showLoading];
    
    CategoryDTO *category = self.selectedCategoryDTO;
    
    NSMutableArray *proArr = [NSMutableArray array];
    
    for (ProductDTO *dto in self.selectedProductDTOList) {
        NSDictionary *dic = @{@"quantity":dto.quantity,@"productId":dto.productId};
        [proArr addObject:dic];
    }
    
    NSDictionary *dic = nil;
    
    dic = @{ @"promoCode":promoCode,@"userLoginId":[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.username,@"productStoreId":category.productStoreId,@"catalogId":category.catalogId?:@"",@"categoryId":category.categoryId?:@"",@"productItems":proArr,@"orderTypeId":category.orderTypeId};
    NSLog(@"dic--%@",dic);
    
    NSData *contentData = (NSData *)[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString* jsonContent = [[NSString alloc] initWithData:contentData encoding:NSUTF8StringEncoding];
    
    NSDictionary * contentDic = [NSDictionary dictionaryWithObjectsAndKeys:jsonContent,@"content", nil];
    
    
    [BCNetWorkTool executePostNetworkWithParameter:contentDic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.order/confirm-order" withSuccess:^(id callBackData) {
        //modify by Thomas ［优惠码存全局，供创建订单使用］－－－start
        self.m_promoCode = promoCode;
        //modify by Thomas ［优惠码存全局，供创建订单使用］－－－end
        NSDictionary *dic = (NSDictionary *)callBackData;
        
        ShoppingCartInfoDTO *dto = [[ShoppingCartInfoDTO alloc] initWithDictionary:dic[@"shoppingCartInfo"] error:nil];
        
        self.orderDemand = dic[@"orderDemand"];
        
        self.shoppingCartInfo = dto;
        
        [self.tableView reloadData];
        
        [self vs_hideLoadingWithCompleteBlock:nil];
        
    } orFail:^(id callBackData) {
        [self.view showTipsView:[callBackData domain]];
        [self vs_hideLoadingWithCompleteBlock:nil];
        
    }];
}

#pragma mark -

- (void)calulateProductMoney{
    
    
    self.bottomView.totalMoney.text = [NSString stringWithFormat:@"¥ %.2f",self.shoppingCartInfo.totalPayAmount.doubleValue];
    
}


#pragma mark -
- (NSDate *)theDay:(NSInteger)dayNum
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:[NSDate date]];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setDay:dayNum];
    
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:[NSDate date] options:0];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyyMMdd"];
    
    NSString *result = [formatter stringFromDate:newdate];
    
    NSDate *resultDate = [formatter dateFromString:result];
    
    return resultDate;
}

- (NSDate *)theDayHour:(NSInteger)hourNum fromNSDate:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSCalendarUnitHour fromDate:date];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setHour:hourNum];
    
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyyMMddHHmmSS"];
    
    return newdate;
}


#pragma mark -
- (void)requestReceivingAddressed:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse {
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.postaladdress/get-customer-postal-address"];
    
    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    
    paraDic = [NSDictionary dictionaryWithObjectsAndKeys:partyId,@"partyId", nil];
    [RequestService requesturl:url paraDic:paraDic success:^(NSDictionary *responseObj) {
        
        //存默认地址
        NSArray *postalAddresses = [responseObj objectForKey:@"postalAddresses"];
        for (NSDictionary *dic in postalAddresses) {
            NSString *isDefault = [dic objectForKey:@"isDefault"];
            if ([isDefault isEqualToString:@"Y"]) {
                AdressModel *admodel = [[AdressModel alloc]initWithDictionary:dic error:nil];
                [VSUserLogicManager shareInstance].userDataInfo.vm_defaultAdressInfo = admodel;
                [[VSUserLogicManager shareInstance].userDataInfo vp_saveToLocal];
                break;
            }
        }
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}

@end

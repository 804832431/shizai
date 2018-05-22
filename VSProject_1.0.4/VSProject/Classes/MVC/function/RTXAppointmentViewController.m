//
//  RTXAppointmentViewController.m
//  VSProject
//
//  Created by XuLiang on 15/11/27.
//  Copyright © 2015年 user. All rights reserved.
//

#import "RTXAppointmentViewController.h"
#import "BusinessInfoCell.h"
#import "VSAccountBtnActionCell.h"
#import "BusinessAccountModel.h"
#import "BCNetWorkTool.h"
#import "CategoryDTO.h"
#import "ProductDTO.h"
#import "ReceivingAddressViewController.h"
#import "UINavigationController+HomePushVC.h"
#import "DriveTimePickerView.h"

@interface RTXAppointmentViewController()<VSAccountBtnActionCellDelegate,DriveTimePickerViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    CategoryDTO *m_dataModel;
    NSArray * AppointmentArry;
    AdressModel *defaultAddress;//当前页面的地址信息
    
    UIControl *bgBlack;
    DriveTimePickerView *timePicker;
    NSArray *arrPickerDay;//天
    NSMutableArray *arrPickerHour;//小时
    NSMutableArray *arrPickerMinute;//分钟
    
    NSString *strSelectedTime;//选择的时间
    NSTimeInterval appointmentTime;
}
@property (nonatomic, strong) BusinessAccountModel *firstItem;
@property (nonatomic, strong) BusinessAccountModel *secondItem;
@property (nonatomic, strong) BusinessAccountModel *thirdItem;
@property (nonatomic, strong) BusinessAccountModel *forthItem;

@property (nonatomic,strong) NSString *chooseSendTime;//选择配送时间

@end
@implementation RTXAppointmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self vs_setTitleText:self.selectedCategoryDTO.categoryName];
    //使用默认地址
    defaultAddress = [VSUserLogicManager shareInstance].userDataInfo.vm_defaultAdressInfo;
    
    self.secondItem.m_content = defaultAddress.recipient;
    self.thirdItem.m_content = defaultAddress.contactNumber;
    //Modify by Thomas 睿天下RUI-794［预约商品列表页面，选择商品，点击立即预约 跳转到填写预约时间和联系地址的页面，该页面上自动带入的默认地址 缺少省市区］---start
    self.forthItem.m_content = [NSString stringWithFormat:@"%@%@",defaultAddress.zipCode?:@"",defaultAddress.address?:@""];
    //Modify by Thomas 睿天下RUI-794 ---end
    VSView *headView = _ALLOC_OBJ_WITHFRAME_(VSView, _CGR(0, 0, GetWidth(self.tableView), 15));
    self.tableView.tableHeaderView = headView;
    self.dataSource = @[ @[self.firstItem, self.secondItem, self.thirdItem, self.forthItem],@[@"提交"]];
//    __weak typeof(&*self) weakSelf = self;
    
    arrPickerDay = [[NSArray alloc] initWithObjects:NSLocalizedString(@"今天", nil),NSLocalizedString(@"明天", nil),NSLocalizedString(@"后天", nil), nil];
    arrPickerMinute = [[NSMutableArray alloc] init];
    arrPickerHour = [[NSMutableArray alloc] init];

}

- (void)vp_btnActionClicked:(VSAccountBtnActionCell*)sender{
    __weak typeof(&*self) weakSelf = self;
    NSDictionary *dic = nil;
    
    NSMutableArray *proArr = [NSMutableArray array];
    
    for (ProductDTO *dto in weakSelf.selectedProductDTOList) {
        NSDictionary *dic = @{@"quantity":dto.quantity,@"productId":dto.productId};
        
        [proArr addObject:dic];
    }
    
    if (weakSelf.chooseSendTime.length == 0) {
        [weakSelf.view showTipsView:@"请选择预约时间!"];
        return ;
    }
    
    
    if (defaultAddress == nil) {
        [weakSelf.view showTipsView:@"请完善地址信息!"];
        return ;
    }
    
    
    [weakSelf vs_showLoading];
    
    dic = @{@"userLoginId":[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.username,
            @"productStoreId":weakSelf.selectedCategoryDTO.productStoreId,
            @"catalogId":weakSelf.selectedCategoryDTO.catalogId,
            @"categoryId":weakSelf.selectedCategoryDTO.categoryId,
            @"reservationDate":weakSelf.chooseSendTime,
            @"orderTypeId":weakSelf.selectedCategoryDTO.orderTypeId,
            @"productItems":proArr,
            @"contactMechId":defaultAddress.contactMechId,
            @"remark":@""};
    
    NSData *contentData = (NSData *)[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString* jsonContent = [[NSString alloc] initWithData:contentData encoding:NSUTF8StringEncoding];
    
    NSDictionary * contentDic = [NSDictionary dictionaryWithObjectsAndKeys:jsonContent,@"content", nil];
    
    [BCNetWorkTool executePostNetworkWithParameter:contentDic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.order/create-sales-order" withSuccess:^(id callBackData) {
        NSDictionary *dic = (NSDictionary *)callBackData;
        //预约成功，跳转到预约成功界面
        
        [weakSelf vs_hideLoadingWithCompleteBlock:nil];
        [self.navigationController vs_pushToSuccessAppointmentVC];
        
        
    } orFail:^(id callBackData) {
        [weakSelf vs_hideLoadingWithCompleteBlock:nil];
        if ([callBackData isKindOfClass:[NSError class]]) {
            NSError *error = (NSError *)callBackData;
            [weakSelf.view showTipsView:[error domain]];
        }
        
    }];


}
- (SendTimeChooseView *)sendTimeChooseView{
    
    if (_sendTimeChooseView == nil) {
        
        _sendTimeChooseView = [[SendTimeChooseView alloc] init];
        
    }
    
    return _sendTimeChooseView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //收货信息
    if (indexPath.section ==0 && indexPath.row == 2) {
        //modify by Thomas [只上传默认收货信息的问题]－－－start
        ReceivingAddressViewController *vc = [ReceivingAddressViewController new];
        __weak typeof(&*self) weakSelf = self;
        vc.selectReceiveAdress = ^(AdressModel *adModel){
//            __strong typeof (RTXAppointmentViewController)strongSelf =
            defaultAddress = adModel;
            weakSelf.secondItem.m_content = adModel.recipient;
            weakSelf.thirdItem.m_content = adModel.contactNumber;
            weakSelf.forthItem.m_content = [NSString stringWithFormat:@"%@%@",adModel.zipCode?:@"",adModel.address?:@""];
            [weakSelf.tableView reloadData];
            NSLog(@"得到收货地址---%@",adModel);
            
            
        };
        
        [self.navigationController pushViewController:vc animated:YES];
        //modify by Thomas [只上传默认收货信息的问题]－－－end
        return;
    }
    //配送时间
    if (indexPath.section == 0 && indexPath.row == 0) {
        __weak typeof(&*self) weakSelf = self;
        [self showPicker];
//        [self.view addSubview:self.sendTimeChooseView];
//        [self.sendTimeChooseView mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.leading.trailing.top.bottom.equalTo(weakSelf.view);
//            
//        }];
//        [self.sendTimeChooseView setChooseTimeBlock:^(NSString *time) {
//            
//            
//            weakSelf.chooseSendTime = time;
//            weakSelf.firstItem.m_content = time;
//            
//            [weakSelf.tableView reloadData];
//            
//        }];
//        NSDate *now = [NSDate date];
//        
//        NSDate *today = [self theDay:0];
//        NSDate *todayTwo = [self theDayHour:14 fromNSDate:today];
//        //判断时间大小
//        if ([now compareToDate:todayTwo]) {
//            
//            self.chooseSendTime = @"16:00---17:00";
//            
//        }else{
//            
//            self.chooseSendTime =@"10:00---11:00";
//            
//        }
//        [tableView reloadData];
    }
}
- (void)showPicker{
    if (bgBlack == nil) {
        bgBlack = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_WIDTH__, __SCREEN_HEIGHT__)];
        bgBlack.backgroundColor = [UIColor blackColor];
        bgBlack.alpha = 0;
        [bgBlack addTarget:self action:@selector(blackBgTapped) forControlEvents:UIControlEventTouchDown];
        [self.navigationController.view addSubview:bgBlack];
        
        [UIView animateWithDuration:0.3f animations:^{
            bgBlack.alpha = 0.4f;
        } completion:^(BOOL finished) {
            
        }];
        
        timePicker = [[DriveTimePickerView alloc] initWithFrame:CGRectMake(0, __SCREEN_HEIGHT__, __SCREEN_WIDTH__, 216.f)];
        timePicker.backgroundColor = _COLOR_WHITE;
        timePicker.m_delegate = self;
        timePicker.m_timePicker.delegate = self;
        timePicker.m_timePicker.dataSource = self;
        [self.navigationController.view addSubview:timePicker];
        
        [UIView animateWithDuration:0.3f animations:^{
            timePicker.frame = CGRectMake(0, __SCREEN_HEIGHT__ - 216.f, __SCREEN_WIDTH__, 216.f);
        } completion:^(BOOL finished) {
            
        }];
        
        [self updatePicker];
    }
}

- (void)blackBgTapped{
    [self removePicker];
}

- (void)removePicker{
    if (bgBlack) {
        [UIView animateWithDuration:0.3f animations:^{
            timePicker.frame = CGRectMake(0, __SCREEN_HEIGHT__, __SCREEN_WIDTH__, 216.f);
        } completion:^(BOOL finished) {
            [timePicker removeFromSuperview];
            timePicker = nil;
        }];
        
        [UIView animateWithDuration:0.3f animations:^{
            bgBlack.alpha = 0;
        } completion:^(BOOL finished) {
            [bgBlack removeFromSuperview];
            bgBlack = nil;
        }];
    }
}

- (void)updatePicker{
    NSInteger dayIndex = [timePicker.m_timePicker selectedRowInComponent:0];
    NSInteger hourIndex = [timePicker.m_timePicker selectedRowInComponent:1];
    [arrPickerHour removeAllObjects];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *timeString = [formatter stringFromDate:[NSDate date]];
    NSLog(@"current date %@",timeString);
    NSInteger hour = [[timeString substringWithRange:NSMakeRange(8, 2)] integerValue];
    NSInteger minute = [[timeString substringWithRange:NSMakeRange(10, 2)] integerValue];
    
    NSInteger loopCount = 0;
    //modify by Thomes 预约时间为半小时制－－－start
//    if (minute >= 50) {
    if (minute >= 30) {
    //modify by Thomes 预约时间为半小时制－－－end
        hour += 1;
        if (hour == 24) {
            [timePicker.m_timePicker selectRow:1 inComponent:0 animated:YES];
            loopCount = 24;
        }else{
            [timePicker.m_timePicker selectRow:0 inComponent:0 animated:YES];
            loopCount = 24 - hour;
        }
        //        [timePicker.m_timePicker selectRow:0 inComponent:2 animated:YES];
    }else{
        //        [timePicker.m_timePicker selectRow:minute/10+1 inComponent:2 animated:YES];
        loopCount = 24 - hour;
    }
    
    for (int i = 0; i < loopCount; i++) {
        hour = hour % 24;
        [arrPickerHour addObject:[NSNumber numberWithInteger:hour]];
        hour++;
    }
    
    [timePicker.m_timePicker selectRow:hourIndex inComponent:1 animated:YES];
    
    [arrPickerMinute removeAllObjects];
    
    NSInteger currentHour = [[timeString substringWithRange:NSMakeRange(8, 2)] integerValue];
    //modify by Thomas 预约时间修改为半小时制 －－－start
    if (dayIndex == 0 && (currentHour == [arrPickerHour[hourIndex] integerValue])) {
//        NSInteger tmp = minute/10 + 1;
        NSInteger tmp = minute/30 + 1;
//        while (tmp < 6) {
//            [arrPickerMinute addObject:@(tmp*10)];
//            tmp++;
//        }
        while (tmp < 2) {
            [arrPickerMinute addObject:@(tmp*30)];
            tmp++;
        }
        [timePicker.m_timePicker selectRow:0 inComponent:2 animated:YES];
    }else{
//        for (int i = 0; i < 6; i++) {
//            [arrPickerMinute addObject:@(i*10)];
//        }
        for (int i = 0; i < 2; i++) {
            [arrPickerMinute addObject:@(i*30)];
        }
        [timePicker.m_timePicker selectRow:0 inComponent:2 animated:YES];
    }
    //modify by Thomas 预约时间修改为半小时制 －－－end
    
    [timePicker.m_timePicker reloadAllComponents];
}
#pragma mark -

#pragma mark-DriveTimePickerViewDelegate
- (void)cancelTimeChoose{
    [self removePicker];
}

- (void)selectTime{
    
    if ([self isSelectedTimePassed]) {
        [self.view showTipsView:@"预约时间已过" afterDelay:1.0f];
        return;
    }
    self.firstItem.m_content = strSelectedTime;
    [self.tableView reloadData];
    [self removePicker];
}
#pragma mark-UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 35.f;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    switch (component) {
        case 0:
            return arrPickerDay.count;
        case 1:
            return arrPickerHour.count;
        case 2:
            return arrPickerMinute.count;
        default:
            return 0;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    switch (component) {
        case 0:
            return [arrPickerDay objectAtIndex:row];
        case 1:
            return [NSString stringWithFormat:@"%d点",[[arrPickerHour objectAtIndex:row] integerValue]];
        case 2:
            return [NSString stringWithFormat:@"%02d分钟",[[arrPickerMinute objectAtIndex:row] integerValue]];
        default:
            return nil;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSInteger dayIndex = [timePicker.m_timePicker selectedRowInComponent:0];
    NSInteger hourIndex = [timePicker.m_timePicker selectedRowInComponent:1];
    NSInteger minIndex = [timePicker.m_timePicker selectedRowInComponent:2];
    
    switch (component) {
        case 0:
        {
            dayIndex = row;
            if (dayIndex == 1 || dayIndex == 2) {
                //从今天到明天或后天
                
                //                NSInteger selectedHour = [arrPickerHour[hourIndex] integerValue];
                NSNumber *lastSelectedHour = arrPickerHour[hourIndex];
                //                NSLog(@"selectedHour %d",selectedHour);
                [arrPickerHour removeAllObjects];
                for (int i = 0; i < 24; i++) {
                    [arrPickerHour addObject:@(i)];
                }
                [timePicker.m_timePicker reloadAllComponents];
                [timePicker.m_timePicker selectRow:[arrPickerHour indexOfObject:lastSelectedHour] inComponent:1 animated:NO];
                
                
                if (hourIndex == 0) {
                    NSNumber *lastSelectedMin = arrPickerMinute[minIndex];
                    [arrPickerMinute removeAllObjects];
                    int tmp = 0;
                    //modify by Thomas 预约时间变为半小时制－－－start
//                    while (tmp < 6) {
//                        [arrPickerMinute addObject:@(tmp*10)];
//                        tmp++;
//                    }
                    while (tmp < 2) {
                        [arrPickerMinute addObject:@(tmp*30)];
                        tmp++;
                    }
                    //modify by Thomas 预约时间变为半小时制－－－end
                    [timePicker.m_timePicker reloadAllComponents];
                    [timePicker.m_timePicker selectRow:[arrPickerMinute indexOfObject:lastSelectedMin] inComponent:2 animated:NO];
                }
                
                
            }else{
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyyMMddHHmmss"];
                NSString *timeString = [formatter stringFromDate:[NSDate date]];
                NSLog(@"current date %@",timeString);
                NSInteger hour = [[timeString substringWithRange:NSMakeRange(8, 2)] integerValue];
                NSInteger minute = [[timeString substringWithRange:NSMakeRange(10, 2)] integerValue];
                NSInteger selectHour = [[arrPickerHour objectAtIndex:hourIndex] integerValue];
                NSInteger selectMin = [[arrPickerMinute objectAtIndex:minIndex] integerValue];
                
                //从明天选回今天时
                //modify by Thomas 预约时间改为半小时制－－－start
                if (selectHour <= hour && minute < 30) {
                //modify by Thomas 预约时间改为半小时制－－－end
                    NSNumber *lastSelectedHour = arrPickerHour[hourIndex];
                    //当前选择的小时数小于当前的时间
                    [arrPickerHour removeAllObjects];
                    while (hour < 24) {
                        [arrPickerHour addObject:@(hour)];
                        hour++;
                    }
                    [timePicker.m_timePicker reloadAllComponents];
                    //                    [timePicker.m_timePicker selectRow:0 inComponent:1 animated:NO];
                    if ([arrPickerHour indexOfObject:lastSelectedHour] != NSNotFound) {
                        [timePicker.m_timePicker selectRow:[arrPickerHour indexOfObject:lastSelectedHour] inComponent:1 animated:NO];
                    }else{
                        [timePicker.m_timePicker selectRow:0 inComponent:1 animated:NO];
                    }
                    
                    if (selectMin <= minute) {
                        NSNumber *lastSelectedMin = arrPickerMinute[minIndex];
                        [arrPickerMinute removeAllObjects];
                        //modify by Thomas 预约时间变为半小时制－－－start
//                        NSInteger tmp = minute/10 + 1;
//                        while (tmp < 6) {
//                            [arrPickerMinute addObject:@(tmp*10)];
//                            tmp++;
//                        }
                        NSInteger tmp = minute/30 + 1;
                        while (tmp < 2) {
                            [arrPickerMinute addObject:@(tmp*30)];
                            tmp++;
                        }
                        //modify by Thomas 预约时间变为半小时制－－－end
                        [timePicker.m_timePicker reloadAllComponents];
                        if ([arrPickerMinute indexOfObject:lastSelectedMin] != NSNotFound) {
                            [timePicker.m_timePicker selectRow:[arrPickerMinute indexOfObject:lastSelectedMin] inComponent:2 animated:NO];
                        }else
                        {
                            [timePicker.m_timePicker selectRow:0 inComponent:2 animated:NO];
                        }
                        
                    }else
                    {
                        NSNumber *lastSelectedMin = arrPickerMinute[minIndex];
                        
                        [arrPickerMinute removeAllObjects];
                        NSInteger tmp = minute/10 + 1;
                        while (tmp < 6) {
                            [arrPickerMinute addObject:@(tmp*10)];
                            tmp++;
                        }
                        //                        [timePicker.m_timePicker selectRow:0 inComponent:2 animated:YES];
                        [timePicker.m_timePicker reloadAllComponents];
                        [timePicker.m_timePicker selectRow:[arrPickerMinute indexOfObject:lastSelectedMin] inComponent:2 animated:NO];
                    }
                    
                }else
                {//selectHour > hour || minute >= 50
                    //modify by Thomas 修改预约时间为半小时制 －－start
//                    if (minute >= 50) {
                    if (minute >= 30) {
                    //modify by Thomas 修改预约时间为半小时制 －－end
                        NSNumber *lastSelectedHour = arrPickerHour[hourIndex];
                        NSInteger currentHour = [[timeString substringWithRange:NSMakeRange(8, 2)] integerValue];
                        currentHour += 1;
                        [arrPickerHour removeAllObjects];
                        while (currentHour < 24) {
                            [arrPickerHour addObject:@(currentHour)];
                            currentHour++;
                        }
                        [timePicker.m_timePicker reloadAllComponents];
                        if ([arrPickerHour indexOfObject:lastSelectedHour] != NSNotFound) {
                            [timePicker.m_timePicker selectRow:[arrPickerHour indexOfObject:lastSelectedHour] inComponent:1 animated:NO];
                        }else{
                            [timePicker.m_timePicker selectRow:0 inComponent:1 animated:NO];
                        }
                        
                        NSNumber *lastSelectedMin = arrPickerMinute[minIndex];
                        [arrPickerMinute removeAllObjects];
                        int tmp = 0;
                        //modify by Thomas 修改预约时间为半小时制 －－start
//                        while (tmp < 6) {
//                            [arrPickerMinute addObject:@(tmp*10)];
//                            tmp++;
//                        }
                        while (tmp < 2) {
                            [arrPickerMinute addObject:@(tmp*30)];
                            tmp++;
                        }
                        //modify by Thomas 修改预约时间为半小时制 －－end
                        [timePicker.m_timePicker reloadAllComponents];
                        [timePicker.m_timePicker selectRow:[arrPickerMinute indexOfObject:lastSelectedMin] inComponent:2 animated:NO];
                    }else{
                        NSNumber *lastSelectedHour = arrPickerHour[hourIndex];
                        
                        NSInteger currentHour = [[timeString substringWithRange:NSMakeRange(8, 2)] integerValue];
                        [arrPickerHour removeAllObjects];
                        while (currentHour < 24) {
                            [arrPickerHour addObject:@(currentHour)];
                            currentHour++;
                        }
                        [timePicker.m_timePicker reloadAllComponents];
                        if ([arrPickerHour indexOfObject:lastSelectedHour] != NSNotFound) {
                            [timePicker.m_timePicker selectRow:[arrPickerHour indexOfObject:lastSelectedHour] inComponent:1 animated:NO];
                        }else{
                            [timePicker.m_timePicker selectRow:0 inComponent:1 animated:NO];
                        }
                        
                        //分钟数小于50，选中的小时若是未来的小时数，则分钟数组是满的（0，10，20，30，40，50）；否则分钟数组从当前时间分钟数开始（如当前为25分，则数组中：30，40，50）
                        NSNumber *lastSelectedMin = arrPickerMinute[minIndex];
                        if (selectHour > hour) {
                            [arrPickerMinute removeAllObjects];
                            int tmp = 0;
                            //modify by Thomas 修改预约时间为半小时制 －－start
                            //                        while (tmp < 6) {
                            //                            [arrPickerMinute addObject:@(tmp*10)];
                            //                            tmp++;
                            //                        }
                            while (tmp < 2) {
                                [arrPickerMinute addObject:@(tmp*30)];
                                tmp++;
                            }
                            //modify by Thomas 修改预约时间为半小时制 －－end
                            [timePicker.m_timePicker reloadAllComponents];
                            [timePicker.m_timePicker selectRow:[arrPickerMinute indexOfObject:lastSelectedMin] inComponent:2 animated:NO];
                        }else{
                            
                            [arrPickerMinute removeAllObjects];
                            //modify by Thomas 修改预约时间为半小时制 －－start
//                            NSInteger tmp = minute/10 + 1;
//                            while (tmp < 6) {
//                                [arrPickerMinute addObject:@(tmp*10)];
//                                tmp++;
//                            }
                            NSInteger tmp = minute/30 + 1;
                            while (tmp < 2) {
                                [arrPickerMinute addObject:@(tmp*30)];
                                tmp++;
                            }
                            //modify by Thomas 修改预约时间为半小时制 －－end
                            [timePicker.m_timePicker reloadAllComponents];
                            if ([arrPickerMinute indexOfObject:lastSelectedMin] != NSNotFound) {
                                [timePicker.m_timePicker selectRow:[arrPickerMinute indexOfObject:lastSelectedMin] inComponent:2 animated:NO];
                            }else
                            {
                                [timePicker.m_timePicker selectRow:0 inComponent:2 animated:NO];
                            }
                        }
                    }
                }
                
            }
        }
            break;
        case 1:
        {
            hourIndex = row;
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString *timeString = [formatter stringFromDate:[NSDate date]];
            NSLog(@"current date %@",timeString);
            NSInteger hour = [[timeString substringWithRange:NSMakeRange(8, 2)] integerValue];
            NSInteger minute = [[timeString substringWithRange:NSMakeRange(10, 2)] integerValue];
            NSInteger selectHour = [[arrPickerHour objectAtIndex:hourIndex] integerValue];
            NSInteger selectMin = [[arrPickerMinute objectAtIndex:minIndex] integerValue];
            
            
            if (dayIndex == 0 && (hour == selectHour)) {
                NSNumber *lastSelectedMin = arrPickerMinute[minIndex];
                [arrPickerMinute removeAllObjects];
                
                //modify by Thomas 修改预约时间为半小时制 －－start
                //                            NSInteger tmp = minute/10 + 1;
                //                            while (tmp < 6) {
                //                                [arrPickerMinute addObject:@(tmp*10)];
                //                                tmp++;
                //                            }
                NSInteger tmp = minute/30 + 1;
                while (tmp < 2) {
                    [arrPickerMinute addObject:@(tmp*30)];
                    tmp++;
                }
                //modify by Thomas 修改预约时间为半小时制 －－end
                [timePicker.m_timePicker reloadAllComponents];
                //                [timePicker.m_timePicker selectRow:0 inComponent:2 animated:NO];
                if ([arrPickerMinute indexOfObject:lastSelectedMin] != NSNotFound) {
                    [timePicker.m_timePicker selectRow:[arrPickerMinute indexOfObject:lastSelectedMin] inComponent:2 animated:NO];
                }else
                {
                    [timePicker.m_timePicker selectRow:0 inComponent:2 animated:NO];
                }
            }else{
                NSNumber *lastSelectedMin = arrPickerMinute[minIndex];
                
                [arrPickerMinute removeAllObjects];
                //modify by Thomas 修改预约时间为半小时制 －－start
//                for (int i = 0; i < 6; i++) {
//                    [arrPickerMinute addObject:@(i*10)];
//                }
                for (int i = 0; i < 2; i++) {
                    [arrPickerMinute addObject:@(i*30)];
                }
                //modify by Thomas 修改预约时间为半小时制 －－end
                [timePicker.m_timePicker reloadAllComponents];
                //                [timePicker.m_timePicker selectRow:minIndex inComponent:2 animated:NO];
                [timePicker.m_timePicker selectRow:[arrPickerMinute indexOfObject:lastSelectedMin] inComponent:2 animated:NO];
            }
            
        }
            break;
        case 2:
        {
            minIndex = row;
            
        }
            break;
            
        default:
            break;
    }
}

- (BOOL)isSelectedTimePassed{
    NSInteger dayIndex = [timePicker.m_timePicker selectedRowInComponent:0];
    NSInteger hourIndex = [timePicker.m_timePicker selectedRowInComponent:1];
    NSInteger minIndex = [timePicker.m_timePicker selectedRowInComponent:2];
    
    NSDate *date = nil;
    
    if (dayIndex == 0) {
        date = [NSDate date];
    }else{
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
        [offsetComponents setDay:1];
        date = [gregorian dateByAddingComponents:offsetComponents toDate:[NSDate date] options:0];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *dateString = [formatter stringFromDate:date];
    
    NSString *minuteStr = [NSString stringWithFormat:@"%02d",[arrPickerMinute[minIndex] integerValue]];
    NSString *hourStr = [NSString stringWithFormat:@"%02d",[arrPickerHour[hourIndex] integerValue]];
    NSString *timeString = [NSString stringWithFormat:@"%@%@%@00",[dateString substringToIndex:8],hourStr,minuteStr];
    strSelectedTime = [NSString stringWithFormat:@"%@-%@-%@ %@:%@:00",[dateString substringToIndex:4],[dateString substringWithRange:NSMakeRange(4, 2)],[dateString substringWithRange:NSMakeRange(6, 2)],hourStr,minuteStr];
    self.chooseSendTime = [NSString stringWithFormat:@"%@%@%@%@%@00",[dateString substringToIndex:4],[dateString substringWithRange:NSMakeRange(4, 2)],[dateString substringWithRange:NSMakeRange(6, 2)],hourStr,minuteStr];
    NSDate *selectedDate = [formatter dateFromString:timeString];
    
    NSTimeInterval selectedDateInterval = selectedDate.timeIntervalSince1970;
    NSTimeInterval currentDateinterval = [NSDate date].timeIntervalSince1970;
    
    appointmentTime = selectedDateInterval - currentDateinterval;
    NSLog(@"appointmentTime %f",appointmentTime);
    return (appointmentTime < 0);
}
#pragma mark -- getter
_GETTER_BEGIN(NSArray, cellNameClasses)
{
    _cellNameClasses = @[
                         [BusinessInfoCell class],
                         [VSAccountBtnActionCell class]
                         ];
}
_GETTER_END(cellNameClasses)

_GETTER_ALLOC_BEGIN(BusinessAccountModel, firstItem){
    self.firstItem.m_title = @"预约时间";
    self.firstItem.m_content = @"";
    self.firstItem.m_isNeedAccessory = YES;
}
_GETTER_END(firstItem)

_GETTER_ALLOC_BEGIN(BusinessAccountModel, secondItem){
    self.secondItem.m_title = @"联系人";
    self.secondItem.m_content = @"";
}
_GETTER_END(secondItem)

_GETTER_ALLOC_BEGIN(BusinessAccountModel, thirdItem){
    self.thirdItem.m_title = @"联系方式";
    self.thirdItem.m_content = @"";
    self.thirdItem.m_isNeedAccessory = YES;
}
_GETTER_END(thirdItem)

_GETTER_ALLOC_BEGIN(BusinessAccountModel, forthItem){
    self.forthItem.m_title = @"收货地址";
    self.forthItem.m_content = @"";
}
_GETTER_END(forthItem)
@end

//
//  PersonalHomeView.m
//  VSProject
//
//  Created by 姚君 on 15/11/2.
//  Copyright © 2015年 user. All rights reserved.
//

#import "PersonalHomeView.h"
#import "PopoverView.h"
#import "UIButton+NMCategory.h"
#import "HomeManger.h"
#import "VSJsWebViewController.h"
#import "RTXCAppModel.h"
#import "VSUserLoginViewController.h"

@interface PersonalHomeView() {

    HomeManger *manger;
    NSArray *editItemList;
}
@end

@implementation PersonalHomeView


- (void)vp_setInit {

    manger = [[HomeManger alloc]init];
    
//    self.backgroundColor = _COLOR_HEX(0x35b38d);
    
    [self addSubview:self.backgroundView];
    [self addSubview:self.navigation];
    [self addSubview:self.scrollView];
    _timeStamp = @[@"7:00 am",@"8:00 am",@"9:00 am",@"10:00 am",@"11:00 am",@"12:00 am",@"1:00 pm",@"2:00 pm",@"3:00 pm",@"4:00 pm",@"5:00 pm",@"6:00 pm",@"7:00 pm",@"8:00 pm",@"9:00 pm",@"10:00 pm",@"11:00 pm"];
    editItemList = @[@"7:00 am",@"8:00 am",@"9:00 am",@"10:00 am",@"11:00 am",@"12:00 am",@"1:00 pm",@"2:00 pm",@"3:00 pm",@"4:00 pm",@"5:00 pm",@"6:00 pm",@"7:00 pm",@"8:00 pm",@"9:00 pm",@"10:00 pm",@"11:00 pm"];
    [self requestLayout];
    [self showDayOrNight];
}

- (void)showDayOrNight {

    NSDate *nowDate = [NSDate new];
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit fromDate:nowDate];
    if (components.hour > 18 && components.hour < 6) {//晚上
        _backgroundView.image = [UIImage imageNamed:@"时间轴（夜）_"];
    }else {//白天
        _backgroundView.image = [UIImage imageNamed:@"时间轴（白天）"];
    }
}

- (void)buildViews {

    for (int index = 0; index < _timeStamp.count; index ++) {
        NSDictionary *dic = [_timeStamp objectAtIndex:index];
        
        UIButton *cricleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cricleButton.backgroundColor = CircleBgColor;
        cricleButton.layer.cornerRadius = CircleRadius;
        cricleButton.frame = CGRectMake(0, 0, CircleRadius*2, CircleRadius*2);
        cricleButton.center = CGPointMake(CirclePadLeft+CircleRadius, PointGap*index+PageTop);
        [_scrollView addSubview:cricleButton];
        
        UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, TimeBgHeight)];
        timeLabel.text = [dic objectForKey:@"timeNode"];
        timeLabel.textAlignment =NSTextAlignmentLeft;
        timeLabel.textColor = TimeBgColor;
        timeLabel.backgroundColor = _COLOR_CLEAR;
        timeLabel.font = TimeBgFont;
        timeLabel.center = CGPointMake(TimePadLeft+40, PointGap*index+PageTop);
        [_scrollView addSubview:timeLabel];
        
        UIButton *gridItem = [[UIButton alloc] initWithFrame:CGRectMake(5, 100,GirdItemWidth, GirdItemWidth)];
        gridItem.backgroundColor = [UIColor whiteColor];
        NSString *imagePath = [NSString stringWithFormat:@"%@%@",[dic objectForKey:@"appIcon"],@"_ios_1l.png"];

        [gridItem sd_setBackgroundImageWithURL:imagePath placeholderImage:[UIImage imageNamed:@"精选"]];
        [gridItem addTarget:self action:@selector(actionGridItem:) forControlEvents:UIControlEventTouchUpInside];
        [gridItem setExclusiveTouch:NO];
        gridItem.tag = 10000+index;
        gridItem.layer.cornerRadius = GirdItemRadius;
        gridItem.clipsToBounds = YES;
        [gridItem setDragEnable:YES];
        [gridItem setAdsorbEnable:YES];
        if (index%2 == FirstLeft) {
            gridItem.center = CGPointMake(GirdItemPadLeft1, PointGap*index+PageTop);
        }else {
            gridItem.center = CGPointMake(GirdItemPadLeft2, PointGap*index+PageTop);
        }
        [_scrollView addSubview:gridItem];

    }
}

- (void)buildBottomViews {
    
    for (int index = 0; index < editItemList.count; index ++) {
        
        RTXCAppModel *model = [editItemList objectAtIndex:index];
        UIButton *gridItem = [[UIButton alloc] initWithFrame:CGRectMake(5, 100,GirdItemWidth, GirdItemWidth)];
        gridItem.tag = 100+index;
        gridItem.backgroundColor = [UIColor whiteColor];
        gridItem.layer.cornerRadius = GirdItemRadius;
        gridItem.clipsToBounds = YES;
        [gridItem setDragEnable:YES];
        [gridItem setAdsorbEnable:YES];
        gridItem.center = CGPointMake((BottomGirdItemWidth+BottomGirdItemGap/2)*index+BottomGirdItemWidth/2, 50);
        NSString *imagePath = [NSString stringWithFormat:@"%@%@",model.appIcon,@"_ios_1l.png"];
        [gridItem sd_setBackgroundImageWithURL:imagePath placeholderImage:[UIImage imageNamed:@"精选"]];
        [_bottomScrollView addSubview:gridItem];
    }
}

- (void)vs_rightButtonAction:(id)sender
{
    NSLog(@"btn click");
    NSArray *titles = @[@"个人中心",@"服务定制",@"导航"];
    NSArray *images = @[@"centerhead",@"Application",@"location"];
    PopoverView *tmppopoverView = [[PopoverView alloc] initWithPoint:CGPointMake(CGRectGetMidX(_navigation.buttonRight1.frame), CGRectGetMaxY(_navigation.buttonRight1.frame)-kArrowHeight) titles:titles images:images];
    tmppopoverView.selectRowAtIndex = ^(NSInteger index){
        if (index == 0) {
            
            [self userCenter];
            
        }else if(index == 1){
            
            [self customizeHome];

        }else if(index == 2){
            
            [self HomeNav];
            
        }else{
            NSLog(@"have no action");
        }
        
    };
    [tmppopoverView show];
}

#pragma mark -- private

- (void)requestLayout {

    NSString *lng=[[NSUserDefaults standardUserDefaults] objectForKey:@"longitude"]?:@"118.880203";
    NSString *lat=[[NSUserDefaults standardUserDefaults] objectForKey:@"latitude"]?:@"32.09008";
    NSString *organizationId=[VSUserLogicManager shareInstance].userDataInfo.vm_projectInfo.organizationId;

    NSMutableDictionary *dic1=[NSMutableDictionary dictionary];
    [dic1 setObject:lng forKey:@"longtitude"];
    [dic1 setObject:lat forKey:@"latitude"];
    [dic1 setObject:@"" forKey:@"partyId"];
    [dic1 setObject:organizationId forKey:@"organizationId"];

    [manger requestCustomerLayout:dic1 success:^(NSDictionary *responseObj) {
        
        //
        _timeStamp = [NSArray arrayWithArray:[responseObj objectForKey:@"layout"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            for (UIView *view in _scrollView.subviews) {
                [view removeFromSuperview];
            }
        });
        dispatch_barrier_async(dispatch_get_main_queue(), ^{
            [self buildViews];
        });

    } failure:^(NSError *error) {
        //
    }];
}

- (void)requestCustomerConfig {
    
    [manger requestCustomerConfig:nil success:^(NSDictionary *responseObj) {
        
        //
        editItemList = [NSArray arrayWithArray:[responseObj objectForKey:@"applications"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            for (UIView *view in _scrollView.subviews) {
                [view removeFromSuperview];
            }
        });
        dispatch_barrier_async(dispatch_get_main_queue(), ^{
            [self buildBottomViews];
        });
        
    } failure:^(NSError *error) {
        //
    }];
}


- (void)changeLocation {
    
    [_selfController changeLocation];
}
- (void)changeHome {
    
    [_selfController changeHome];
}
- (void)HomeNav {
    
    [_selfController HomeNav];
}
- (void)tojswebview {
    
    [_selfController tojswebview];
}
- (void)userCenter {

    [_selfController userCenter];
}

#pragma mark -- Action

- (void)actionGridItem:(UIButton *)sender {

    NSUInteger index = sender.tag - 10000;
    NSDictionary *dic = [_timeStamp objectAtIndex:index];
    
    NSString *visitType = [dic objectForKey:@"visitType"];
    if (visitType && [visitType isEqualToString:@"H5"]) {
        NSString *link = [NSString stringWithFormat:@"%@%@&appId=%@&orderType=%@",[dic objectForKey:@"protocol"],[dic objectForKey:@"visitkeyword"],[dic objectForKey:@"id"],[dic objectForKey:@"orderType"]];
        [_selfController APPPushToVC:[dic objectForKey:@"visitType"] link:link catalogId:[dic objectForKey:@"catalogId"] orderType:[dic objectForKey:@"orderType"]];
    }else if(visitType && [visitType isEqualToString:@"NATIVE"]){
        [_selfController APPPushToVC:[dic objectForKey:@"visitType"] link:[dic objectForKey:@"visitkeyword"]catalogId:[dic objectForKey:@"catalogId"] orderType:[dic objectForKey:@"orderType"]];
    }else{
        NSLog(@"");
    }

}

- (void)leftOne {
    
    CGPoint oldPoint = _bottomScrollView.contentOffset;
    oldPoint.x -= GirdItemWidth+5;
    [_bottomScrollView setContentOffset:oldPoint animated:YES];
}

- (void)rightOne {

    CGPoint oldPoint = _bottomScrollView.contentOffset;
    oldPoint.x += GirdItemWidth+5;
    [_bottomScrollView setContentOffset:oldPoint animated:YES];

}

- (void)customizeHome {
    if (![_selfController isUserlogin]) {

    [self requestCustomerConfig];
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, MainHeight-100, MainWidth, 100)];
    bottomView.backgroundColor = _COLOR_HEX(0x1a5946);
    [self addSubview:bottomView];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setBackgroundColor:_COLOR_HEX(0x1a5945)];
    leftButton.frame = CGRectMake(0, MainHeight-100, 50, 100);
    [leftButton addTarget:self action:@selector(leftOne) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftButton];

    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.imageView.image = [UIImage imageNamed:@"usercenter_08"];
    [rightButton setBackgroundColor:_COLOR_HEX(0x1a5945)];
    rightButton.frame = CGRectMake(MainWidth-50, MainHeight-100, 50, 100);
    [rightButton addTarget:self action:@selector(rightOne) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightButton];

    [bottomView addSubview:self.bottomScrollView];
//    [self buildBottomViews];
    
    UIView *recycleBinView = [[UIView alloc]initWithFrame:CGRectMake(MainWidth/2-27, 84, 54, 50)];
    recycleBinView.backgroundColor = [UIColor clearColor];
    [self addSubview:recycleBinView];
    
    UIImageView *deleteIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
    [deleteIcon setImage:[UIImage imageNamed:@"RecycleBin"]];
    [recycleBinView addSubview:deleteIcon];

    UILabel *deleteLabel = [[UILabel alloc]initWithFrame:CGRectMake(24, 0, 30, TimeBgHeight)];
    deleteLabel.text = @"删除";
    deleteLabel.textAlignment =NSTextAlignmentLeft;
    deleteLabel.textColor = _COLOR_WHITE;
    deleteLabel.backgroundColor = [UIColor clearColor];
    deleteLabel.font = [UIFont systemFontOfSize:15.f];
    [recycleBinView addSubview:deleteLabel];
    }

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark -- getter

_GETTER_ALLOC_BEGIN(UIScrollView, scrollView) {
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, MainHeight, MainHeight-64)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = (id<UIScrollViewDelegate>)self;
    _scrollView.tag = 10001;
    _scrollView.contentSize = CGSizeMake(MainWidth, 700);
}
_GETTER_END(scrollView)

_GETTER_ALLOC_BEGIN(UIScrollView, bottomScrollView) {
    
    _bottomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(ScrollPadLeft, 0, MainWidth-100, 100)];
    _bottomScrollView.backgroundColor = [UIColor clearColor];
    _bottomScrollView.pagingEnabled = YES;
    _bottomScrollView.showsHorizontalScrollIndicator = NO;
    _bottomScrollView.showsVerticalScrollIndicator = NO;
    _bottomScrollView.delegate = (id<UIScrollViewDelegate>)self;
    _bottomScrollView.contentSize = CGSizeMake(MainWidth*2, 0);
    _bottomScrollView.tag = 10002;
    _bottomScrollView.clipsToBounds = NO;
}
_GETTER_END(bottomScrollView)

_GETTER_ALLOC_BEGIN(NavigationBar, navigation) {
    
    _navigation = [[NavigationBar alloc]initWithNavigationTitle:@"睿天下" buttonLeft1:@"changeHome" buttonLeft2:nil buttonRight1:@"more" buttonRight2:nil];
    _navigation.frame = CGRectMake(0, 0, MainWidth, 64);
    [_navigation.titleUIButton addTarget:self action:@selector(changeLocation) forControlEvents:UIControlEventTouchUpInside];
    [_navigation.buttonLeft1 addTarget:self action:@selector(changeHome) forControlEvents:UIControlEventTouchUpInside];
    [_navigation.buttonRight1 addTarget:self action:@selector(vs_rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeLocation)];
    tap1.numberOfTapsRequired = 1;
    [_navigation.titleUIButton addGestureRecognizer:tap1];

    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeHome)];
    tap2.numberOfTapsRequired = 1;
    [_navigation.buttonLeft1 addGestureRecognizer:tap2];

    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(vs_rightButtonAction:)];
    tap3.numberOfTapsRequired = 1;
    [_navigation.buttonRight1 addGestureRecognizer:tap3];

}
_GETTER_END(navigation)

_GETTER_ALLOC_BEGIN(UIImageView, backgroundView) {
    
    _backgroundView = [[UIImageView alloc]initWithFrame:self.bounds];
    _backgroundView.backgroundColor = [UIColor clearColor];
}
_GETTER_END(backgroundView)

@end

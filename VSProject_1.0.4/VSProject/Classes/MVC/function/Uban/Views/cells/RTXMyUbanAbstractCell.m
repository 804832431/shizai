//
//  RTXMyUbanAbstractCell.m
//  VSProject
//
//  Created by XuLiang on 16/1/21.
//  Copyright © 2016年 user. All rights reserved.
//

#import "RTXMyUbanAbstractCell.h"
#import "RTXUbanTitleLabel.h"
#import "RTXUbanInfoLabel.h"
#import "RTXUbanDetalBtn.h"
#import "MyRentalModel.h"

@interface RTXMyUbanAbstractCell ()
{
    id order;
}
/**
 *  订单时间
 */
@property (nonatomic,strong) RTXUbanTitleLabel *m_timeLbl;
/**
 *  line
 */
@property (nonatomic,strong) UILabel *m_line;
/**
 *  未读
 */
@property (nonatomic,strong) UILabel *m_read;

/**
 *  楼盘名称
 */
@property (nonatomic,strong) RTXUbanInfoLabel *m_buildingNameLbl;
/**
 *  楼号
 */
@property (nonatomic,strong) RTXUbanInfoLabel *m_blockNumLbl;
/**
 *  楼层
 */
@property (nonatomic,strong) RTXUbanInfoLabel *m_floorNumLbl;
/**
 *  房号
 */
@property (nonatomic,strong) RTXUbanInfoLabel *m_roomNumLbl;
/**
 *  成交状态
 */
@property (nonatomic,strong) RTXUbanInfoLabel *m_statusLbl;
/**
 *  跟踪看房信息
 */
@property (nonatomic,strong) RTXUbanDetalBtn  *m_detailBtn;

@end

@implementation RTXMyUbanAbstractCell

- (void)vp_setInit{
    [super vp_setInit];
    //TODO：设置样式
    [self.contentView setBackgroundColor:kColor_ffffff];
    [self vm_showBottonLine:YES];
    
    [self updateConstraintsForSubViews];
}

+ (CGFloat)vp_cellHeightWithModel:(id)model withSuperWidth:(CGFloat)t_superWidth
{
    return 140.f;
}

- (void)vp_updateUIWithModel:(id)model{
    MyRentalModel *myRental = (MyRentalModel *)model;
    NSNumber *hasUnread = myRental.hasUnread;
    if (hasUnread.boolValue) {
        [self.m_read setHidden:NO];
    }else {
        [self.m_read setHidden:YES];
    }
    
    RentalModel *r_model = myRental.ubanRental;
    order = r_model.id;

    self.m_timeLbl.text = [NSDate timeMinutes2:r_model.createTime.longLongValue];
    self.m_buildingNameLbl.text = [NSString stringWithFormat:@"楼盘名称：%@",r_model.buildingName];
    self.m_blockNumLbl.text = [NSString stringWithFormat:@"楼号：%@",r_model.buildingNumber];;
    self.m_floorNumLbl.text = [NSString stringWithFormat:@"楼层：%@",r_model.floorNumber];
    self.m_roomNumLbl.text = [NSString stringWithFormat:@"房号：%@",r_model.roomNumber];
    if ([r_model.status isEqualToString:@"undeal"]) {
        self.m_statusLbl.text = @"成交状态：待租赁";
    }else if ([r_model.status isEqualToString:@"dealed"]) {
        self.m_statusLbl.text = @"成交状态：已成交";
    }else {
        self.m_statusLbl.text = @"成交状态：暂无";
    }
}

- (void)updateConstraintsForSubViews{
    [self addSubview:self.m_timeLbl];
    [self addSubview:self.m_line];
    [self addSubview:self.m_read];
    [self addSubview:self.m_buildingNameLbl];
    [self addSubview:self.m_blockNumLbl];
    [self addSubview:self.m_floorNumLbl];
    [self addSubview:self.m_roomNumLbl];
    [self addSubview:self.m_statusLbl];
    [self addSubview:self.m_detailBtn];
    
    __weak typeof(&*self) weakSelf = self;
    
    [self.m_timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@17);
        make.right.equalTo(@(-17));
        make.top.equalTo(@14);
        make.height.equalTo(@(12));
    }];
    
    [self.m_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@17);
        make.right.equalTo(@(0));
        make.top.equalTo(weakSelf.m_timeLbl.mas_bottom).offset(5);
        make.height.equalTo(@(1));
    }];
    [self.m_read mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-17));
        make.top.equalTo(self.mas_top).offset(50);
        make.width.equalTo(@5);
        make.height.equalTo(@5);
    }];

    [self.m_buildingNameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@17);
        make.right.equalTo(@(-17));
        make.top.equalTo(weakSelf.m_line.mas_bottom).offset(8);
        make.height.equalTo(@(12));
    }];

    [self.m_blockNumLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@17);
        make.right.equalTo(@(-17));
        make.top.equalTo(weakSelf.m_buildingNameLbl.mas_bottom).offset(8);
        make.height.equalTo(@(12));
    }];
    [self.m_floorNumLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@17);
        make.right.equalTo(@(-17));
        make.top.equalTo(weakSelf.m_blockNumLbl.mas_bottom).offset(8);
        make.height.equalTo(@(12));
    }];
    [self.m_roomNumLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@17);
        make.right.equalTo(@(-17));
        make.top.equalTo(weakSelf.m_floorNumLbl.mas_bottom).offset(8);
        make.height.equalTo(@(12));
    }];
    [self.m_statusLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@17);
        make.width.equalTo(@(200));
        make.top.equalTo(weakSelf.m_roomNumLbl.mas_bottom).offset(8);
        make.height.equalTo(@(12));
    }];
    [self.m_detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-17));
        make.width.equalTo(@(100));
        make.top.equalTo(weakSelf.m_roomNumLbl.mas_bottom).offset(8);
        make.height.equalTo(@(12));
    }];
}

- (void)actionIntoDetail{
    if ([self.delegate respondsToSelector:@selector(ToOrderDetail:)]) {
        [self.delegate ToOrderDetail:order];
    }
}

#pragma mark -- getter

_GETTER_ALLOC_BEGIN(RTXUbanTitleLabel, m_timeLbl){
    _m_timeLbl.text = @"";
}
_GETTER_END(m_timeLbl)

_GETTER_ALLOC_BEGIN(UILabel, m_line){
    _m_line.backgroundColor = kColor_dbdbdb;
}
_GETTER_END(m_line)

_GETTER_ALLOC_BEGIN(UILabel, m_read){
    _m_read.backgroundColor = [UIColor redColor];
    _m_read.layer.cornerRadius = 2.5f;
    _m_read.clipsToBounds = YES;
}
_GETTER_END(m_read)

_GETTER_ALLOC_BEGIN(RTXUbanInfoLabel, m_buildingNameLbl){
    _m_buildingNameLbl.text = @"楼盘名称：";
}
_GETTER_END(m_buildingNameLbl)

_GETTER_ALLOC_BEGIN(RTXUbanInfoLabel, m_blockNumLbl){
    _m_blockNumLbl.text = @"楼号：";
}
_GETTER_END(m_blockNumLbl)

_GETTER_ALLOC_BEGIN(RTXUbanInfoLabel, m_floorNumLbl){
    _m_floorNumLbl.text = @"楼层：";
}
_GETTER_END(m_floorNumLbl)

_GETTER_ALLOC_BEGIN(RTXUbanInfoLabel, m_roomNumLbl){
    _m_roomNumLbl.text = @"房号：";
}
_GETTER_END(m_roomNumLbl)

_GETTER_ALLOC_BEGIN(RTXUbanInfoLabel, m_statusLbl){
    _m_statusLbl.text = @"成交状态：";
}
_GETTER_END(m_statusLbl)

_GETTER_ALLOC_BEGIN(RTXUbanDetalBtn, m_detailBtn){
    _m_detailBtn.titleLabel.font = kSysFont_13;
    [_m_detailBtn setTitleColor:kColor_717171 forState:UIControlStateNormal];
    //设置选中文字颜色,下划线---start
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"跟踪看房信息"];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    [str addAttribute:NSForegroundColorAttributeName value:kColor_0065ff range:strRange];
    [_m_detailBtn setAttributedTitle:str forState:UIControlStateNormal];
    //设置选中文字颜色,下划线---end
    
    _m_detailBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight ;//设置文字位置，设为居左，默认居中
    //[_agreementButton.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [_m_detailBtn addTarget:self action:@selector(actionIntoDetail) forControlEvents:UIControlEventTouchUpInside];
}
_GETTER_END(m_detailBtn)
@end

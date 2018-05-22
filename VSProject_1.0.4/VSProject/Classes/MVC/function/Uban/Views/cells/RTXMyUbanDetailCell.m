//
//  RTXMyUbanDetailCell.m
//  VSProject
//
//  Created by XuLiang on 16/1/21.
//  Copyright © 2016年 user. All rights reserved.
//

#import "RTXMyUbanDetailCell.h"
#import "RTXUbanTitleLabel.h"
#import "RTXUbanInfoLabel.h"
#import "LookHomeModel.h"

@interface RTXMyUbanDetailCell ()

/**
 *  背景
 */
@property (nonatomic,strong) UIView *m_bgView;
    /**
     *  订单时间
     */
    @property (nonatomic,strong) RTXUbanTitleLabel *m_timeLbl;

    /**
     *  客户类型
     */
    @property (nonatomic,strong) RTXUbanInfoLabel *m_customerTypeLbl;

    /**
     *  中间区域
     */
    @property (nonatomic,strong) UIView *m_middleView;

        /**
         *  客户备注
         */
        @property (nonatomic,strong) RTXUbanInfoLabel *m_remarks;

    /**
     *  line
     */
    @property (nonatomic,strong) UILabel *m_topLine;
    /**
     *  line
     */
    @property (nonatomic,strong) UILabel *m_bottomLine;

@end

@implementation RTXMyUbanDetailCell

- (void)vp_setInit{
    [super vp_setInit];
    //TODO：设置样式
    [self.contentView setBackgroundColor:kColor_Clear];
    [self.contentView addSubview:self.m_bgView];
    [self.m_bgView setBackgroundColor:kColor_ffffff];
    [self.m_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.bottom.equalTo(@(-13.3));
        make.left.equalTo(@0);
        make.right.equalTo(@0);
    }];
    [self updateConstraintsForSubViews];
    [self vm_showBottonLine:YES];
    
}

+ (CGFloat)vp_cellHeightWithModel:(id)model withSuperWidth:(CGFloat)t_superWidth
{
    return 210.f;
}

- (void)vp_updateUIWithModel:(id)model{
    LookHomeModel *l_model = (LookHomeModel *)model;
    NSString *shwTime = [NSDate timeSeconds:l_model.showTime.longLongValue];
    _m_timeLbl.text = [NSString stringWithFormat:@"看房时间：%@",shwTime];
    _m_customerTypeLbl.text = [NSString stringWithFormat:@"客户类型：%@",l_model.customerType];
    _m_remarks.text = [NSString stringWithFormat:@"需求备注:\n%@",l_model.customerRequirement];
}

- (void)updateConstraintsForSubViews{
    [self.m_bgView addSubview:self.m_timeLbl];
    [self.m_bgView addSubview:self.m_topLine];
    [self.m_bgView addSubview:self.m_bottomLine];
    [self.m_bgView addSubview:self.m_customerTypeLbl];
    [self.m_bgView addSubview:self.m_middleView];
    [self.m_middleView addSubview:self.m_remarks];
    
    __weak typeof(&*self) weakSelf = self;
    
    [self.m_timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@17);
        make.right.equalTo(@(-17));
        make.top.equalTo(@0);
        make.height.equalTo(@(40));
    }];
    
    [self.m_topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@(0));
        make.top.equalTo(weakSelf.m_timeLbl.mas_bottom).offset(0);
        make.height.equalTo(@(1));
    }];
    
    [self.m_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@(0));
        make.top.equalTo(weakSelf.m_bgView.mas_bottom).offset(-1);
        make.height.equalTo(@(1));
    }];
    /**
     *  客户类型
     */
    [self.m_customerTypeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@31);
        make.right.equalTo(@(-31));
        make.top.equalTo(weakSelf.m_topLine.mas_bottom).offset(0);
        make.height.equalTo(@(40));
    }];
    
    [self.m_middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@17);
        make.right.equalTo(@(-17));
        make.top.equalTo(weakSelf.m_customerTypeLbl.mas_bottom).offset(0);
        make.bottom.equalTo(@(-21));
    }];
    
    [self.m_remarks mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(@(-15));
        make.top.equalTo(@(12));
//        make.bottom.equalTo(@(-12));
    }];
}
#pragma mark -- getter

_GETTER_ALLOC_BEGIN(UIView, m_bgView){
    
}
_GETTER_END(m_bgView)

_GETTER_ALLOC_BEGIN(RTXUbanTitleLabel, m_timeLbl){
    _m_timeLbl.text = @"看房时间：";
    _m_timeLbl.textColor = kColor_222222;
}
_GETTER_END(m_timeLbl)

_GETTER_ALLOC_BEGIN(UILabel, m_topLine){
    _m_topLine.backgroundColor = kColor_dbdbdb;
}
_GETTER_END(m_topLine)

_GETTER_ALLOC_BEGIN(UILabel, m_bottomLine){
    _m_bottomLine.backgroundColor = kColor_dbdbdb;
}
_GETTER_END(m_bottomLine)

_GETTER_ALLOC_BEGIN(RTXUbanInfoLabel, m_customerTypeLbl){

    _m_customerTypeLbl.text = @"客户类型：";
}
_GETTER_END(m_customerTypeLbl)

_GETTER_ALLOC_BEGIN(UIView, m_middleView){
    _m_middleView.backgroundColor = kColor_fff6db;
}
_GETTER_END(m_middleView)

_GETTER_ALLOC_BEGIN(RTXUbanInfoLabel, m_remarks){
    
    _m_remarks.text = @"需求备注:\n";
    _m_remarks.numberOfLines = 0;
    _m_remarks.textAlignment = NSTextAlignmentLeft;
    _m_remarks.lineBreakMode = NSLineBreakByWordWrapping;
}
_GETTER_END(m_remarks)
@end

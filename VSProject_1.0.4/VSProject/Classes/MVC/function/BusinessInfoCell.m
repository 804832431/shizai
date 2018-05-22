//
//  BusinessInfoCell.m
//  VSProject
//
//  Created by XuLiang on 15/11/2.
//  Copyright © 2015年 user. All rights reserved.
//

#import "BusinessInfoCell.h"
#import "BusinessAccountModel.h"

@interface BusinessInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *m_contentLbl;
@property (nonatomic, strong) NSString *m_content;


@end
@implementation BusinessInfoCell

- (void)vp_setInit
{
    [super vp_setInit];
    [self setBackgroundColor:kColor_ffffff];
    //TODO：设置样式
    [self.contentView setBackgroundColor:kColor_ffffff];
    
    self.m_contentLbl.font = kSysFont_16;
    self.m_contentLbl.textColor = [UIColor lightGrayColor];
    self.m_contentLbl.textAlignment = NSTextAlignmentLeft;
    
    [self vm_showBottonLine:YES];
}

//更新Cell的高度
+ (CGFloat)vp_cellHeightWithModel:(BusinessAccountModel *)model withSuperWidth:(CGFloat)t_superWidth{
    CGSize textSize     = [NSString caculateTextSize:[NSString stringWithFormat:@"%@：%@",model.m_title,model.m_content?:@""] width:t_superWidth - 45 fontSize:16];
    CGFloat msgHeight   = (textSize.height <= 21)?50:(50 + textSize.height - 21);
    return msgHeight;
}

- (void)vp_updateUIWithModel:(id)model{
    //TODO：更新UI
    if ([model isKindOfClass:[BusinessAccountModel class]]) {
        BusinessAccountModel *cellModel = (BusinessAccountModel *)model;
        if (cellModel.m_tintcolor) {
            self.m_contentLbl.textColor = cellModel.m_tintcolor;
            [self.contentView setBackgroundColor:kColor_Clear];
        }
        if (cellModel.m_isNeedAccessory) {
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else{
            self.accessoryType = UITableViewCellAccessoryNone;
        }
        self.m_contentLbl.text = [NSString stringWithFormat:@"%@：%@",cellModel.m_title,cellModel.m_content?:@""];
        _m_content = [NSString stringWithFormat:@"%@",cellModel.m_content?:@""];
        
    }else{
        NSLog(@"the Model is NOT ‘BusinessAccountModel’");
    }
}
- (NSString*)vs_title{
    //返回内容
    return _m_content;
}
@end

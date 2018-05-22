//
//  RTXAppointmentCell.m
//  VSProject
//
//  Created by XuLiang on 15/11/28.
//  Copyright © 2015年 user. All rights reserved.
//

#import "RTXAppointmentCell.h"
#import "OrderNormalLabel.h"
#import "Order.h"
@interface RTXAppointmentCell()
@property (weak, nonatomic) IBOutlet UIImageView *m_productImg;
@property (weak, nonatomic) IBOutlet OrderNormalLabel *m_serviceContentLbl;
@property (weak, nonatomic) IBOutlet OrderNormalLabel *m_stateLbl;
@property (weak, nonatomic) IBOutlet OrderNormalLabel *m_serviceLbl;
@property (weak, nonatomic) IBOutlet OrderNormalLabel *m_productNameLbl;
@property (weak, nonatomic) IBOutlet OrderNormalLabel *m_timeLbl;
@property (weak, nonatomic) IBOutlet UIButton *m_serviceBtn;

@end
@implementation RTXAppointmentCell
- (void)vp_setInit
{
    [super vp_setInit];
    //TODO：设置样式
    [self.contentView setBackgroundColor:_COLOR_CLEAR];
    
    
    [self vm_showBottonLine:YES];
}
+ (CGFloat)vp_height
{
    return 167.f;
}
//更新Cell的高度
//+ (CGFloat)vp_cellHeightWithModel:(BusinessAccountModel *)model withSuperWidth:(CGFloat)t_superWidth{
//
//}

- (void)vp_updateUIWithModel:(id)model{
    //TODO：更新UI
    if ([model isKindOfClass:[Order class]]) {
        Order *datamodel = (Order *)model;
        OrderProduct *product = (OrderProduct *)[datamodel.orderProductList objectAtIndex:0];
        [self.m_productImg sd_setImageWithString:[NSString stringWithFormat:@"%@%@",PIC_SERVER_IP,product.smallImageUrl] placeholderImage:[UIImage  imageNamed:@"usercenter_defaultpic"]];
        [self.m_serviceContentLbl setText:[NSString stringWithFormat:@"%@",product.productName?:@""]];
        [self.m_stateLbl setText:[NSString stringWithFormat:@"%@",datamodel.orderHeader.orderStatus]];
        [self.m_serviceLbl setText:[NSString stringWithFormat:@"服务:%@",@""]];
        [self.m_productNameLbl setText:[NSString stringWithFormat:@"商户:%@",product.productName?:@""]];
        [self.m_timeLbl setText:[NSString stringWithFormat:@"预约时间:%@",@""]];
        [self.m_serviceBtn setTitle:@"" forState:UIControlStateNormal];
    }

}
@end

//
//  RTXMotionCouponView.m
//  VSProject
//
//  Created by XuLiang on 15/11/16.
//  Copyright © 2015年 user. All rights reserved.
//

#import "RTXMotionCouponView.h"
#import "RTXRandomProductInfoModel.h"

@interface RTXMotionCouponView()
@property (weak, nonatomic) IBOutlet UIImageView *m_largeImage;
@property (weak, nonatomic) IBOutlet UILabel *m_productName;
@property (weak, nonatomic) IBOutlet UILabel *m_promoPrice;
@property (weak, nonatomic) IBOutlet UILabel *m_productDetail;


@end
@implementation RTXMotionCouponView

+ (CGFloat)vp_height{
    
    return  100.0f;
}

- (void)vp_setInit{
    [super vp_setInit];
    self.m_productName.font = kBoldFont_15;
    self.m_promoPrice.font = kBoldFont_18;
    self.m_productDetail.font = kBoldFont_11;
    self.m_productName.numberOfLines = 0;
    self.m_productDetail.numberOfLines = 0;
    self.backgroundColor = [UIColor whiteColor];
}

- (void)vp_updateUIWithModel:(id)model{

    if ([model isKindOfClass:[RTXRandomProductInfoModel class]]) {
        NSLog(@"%@",model);
        RTXRandomProductInfoModel *datamodel = (RTXRandomProductInfoModel *)model;
        [self.m_largeImage sd_setImageWithString:datamodel.largeImageUrl placeholderImage:[UIImage  imageNamed:@"usercenter_defaultpic"]];
        [self.m_productName setText:datamodel.productName];
        float price = [datamodel.promoPrice doubleValue];
        [self.m_promoPrice setText:[NSString stringWithFormat:@"¥ %.2f",price]];
        [self.m_productDetail setText:[NSString stringWithFormat:@"%@",datamodel.m_description?:@""]];

    }
}
#pragma mark -- getter

@end

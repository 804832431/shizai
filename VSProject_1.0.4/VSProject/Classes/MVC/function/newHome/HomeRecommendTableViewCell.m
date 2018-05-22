//
//  HomeRecommendTableViewCell.m
//  VSProject
//
//  Created by apple on 12/30/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "HomeRecommendTableViewCell.h"

@implementation HomeRecommendTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.customContentView.layer setCornerRadius:5.0f];
    [self.customContentView setClipsToBounds:YES];
    [self.serviceImageView setClipsToBounds:YES];
    [self.serviceTitleLabel setClipsToBounds:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataSource:(ServiceModel *)service {
//    资讯：news，
//    空间类型：space,
//    商品：product，
//    招投标：bid，
//    政策：policy，
//    活动：activity
    [self.serviceImageView sd_setImageWithURL:[NSURL URLWithString:service.image] placeholderImage:__IMAGENAMED__(@"usercenter_defaultpic")];
    if ([service.type isEqualToString:@"news"]) {
        [self.serviceTitleLabel setText:[NSString stringWithFormat:@"【资讯】%@",service.title]];
    } else if ([service.type isEqualToString:@"space"]) {
        [self.serviceTitleLabel setText:[NSString stringWithFormat:@"【空间】%@",service.title]];
    } else if ([service.type isEqualToString:@"product"]) {
        [self.serviceTitleLabel setText:[NSString stringWithFormat:@"【商品】%@",service.title]];
    } else if ([service.type isEqualToString:@"bid"]) {
        [self.serviceTitleLabel setText:[NSString stringWithFormat:@"【招投标】%@",service.title]];
    } else if ([service.type isEqualToString:@"policy"]) {
        [self.serviceTitleLabel setText:[NSString stringWithFormat:@"【政策】%@",service.title]];
    } else if ([service.type isEqualToString:@"activity"]) {
        [self.serviceTitleLabel setText:[NSString stringWithFormat:@"【活动】%@",service.title]];
    } else if ([service.type isEqualToString:@"enterprise"]) {
        [self.serviceTitleLabel setText:[NSString stringWithFormat:@"【企业】%@",service.title]];
    }
}

@end

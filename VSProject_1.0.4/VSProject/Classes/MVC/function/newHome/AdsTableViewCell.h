//
//  LifeAdsTableViewCell.h
//  smallDay
//
//  Created by 陈 海涛 on 16/6/20.
//  Copyright © 2016年 陈 海涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdsTableViewCell : UITableViewCell

@property (nonatomic,strong) NSArray *ads;

@property (nonatomic,copy) void (^adsClickBlock)(id ad);

@end

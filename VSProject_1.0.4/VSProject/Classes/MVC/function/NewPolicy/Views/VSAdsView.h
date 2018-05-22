//
//  VSAdsView.h
//  VSProject
//
//  Created by apple on 11/10/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VSAdsView : UIView

@property (nonatomic,strong) NSArray *ads;

@property (nonatomic,copy) void (^adsClickBlock)(id ad);

@end

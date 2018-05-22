//
//  BidNoDataView.h
//  VSProject
//
//  Created by 陈 海涛 on 16/9/23.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    BidNoDataViewTypeBid,
    BidNoDataViewTypeCollection,
    BidNoDataViewTypeAuth,
    BidNoDataViewTypeDeposit
    
} BidNoDataViewType;

@interface BidNoDataView : UIView

@property (nonatomic,assign) BidNoDataViewType type;

+ (instancetype) noDataViewWithType:(BidNoDataViewType) type;

@property (weak, nonatomic) IBOutlet UILabel *noDataDescLabel;

@property (weak, nonatomic) IBOutlet UIImageView *noDataImageView;


@end

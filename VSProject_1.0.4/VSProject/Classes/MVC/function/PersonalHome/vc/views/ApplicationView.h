//
//  ApplicationView.h
//  HomeView
//
//  Created by certus on 15/11/21.
//  Copyright © 2015年 certus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApplicationView : UIView

@property (nonatomic,strong)UILabel *appTitleLabel;
@property (nonatomic,strong)UILabel *appSubTitleLabel;
@property (nonatomic,strong)UIImageView *appImageView;
@property (nonatomic,strong)UIImageView *appBgImageView;
_PROPERTY_NONATOMIC_STRONG(UIButton, deleteButton);

@end

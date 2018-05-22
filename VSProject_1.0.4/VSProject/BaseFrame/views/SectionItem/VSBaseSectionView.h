//
//  WMBaseSetionView.h
//  beautify
//
//  Created by user on 15/1/4.
//  Copyright (c) 2015年 Elephant. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VSBaseSectionViewProtocol <UIInitProtocol>

@optional
+ (CGFloat)vp_viewHeightWithModel:(id)model;

@end

@interface VSBaseSectionView : UIView<VSBaseSectionViewProtocol>

@property(nonatomic, assign)NSInteger sectionIndex;

@end

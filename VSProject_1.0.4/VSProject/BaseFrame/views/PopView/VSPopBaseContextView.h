//
//  VSPopBaseContextView.h
//  QianbaoIM
//
//  Created by liyan on 9/23/14.
//  Copyright (c) 2014 liu nian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VSPopView;
@protocol VSPopBaseContextViewDelegate<NSObject>

@optional
- (void)didSelectUpdateModel:(id)model;

@end

@interface VSPopBaseContextView : UIView

- (id)initWithHeight:(CGFloat)height;

@property (nonatomic, weak)VSPopView *popView;

@property (nonatomic, weak)id<VSPopBaseContextViewDelegate> delegate;
@property(nonatomic, strong)id model;
- (void)updateUIWithModel:(id)data;
- (void)show;

@end

@interface VSPopBaseContextView(deprecated)
@end

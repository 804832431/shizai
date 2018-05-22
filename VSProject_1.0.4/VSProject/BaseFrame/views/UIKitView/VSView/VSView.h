//
//  VSView.h
//  VSProject
//
//  Created by user on 15/1/20.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol VSViewProtocol<UIInitProtocol>
@optional
- (void)vp_updateUIWithModel:(id)model;
@end
@interface VSView : UIView<UIInitProtocol>

@end

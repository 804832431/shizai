//
//  VSTabbarView.h
//  VSProject
//
//  Created by bestjoy on 15/1/26.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSView.h"
#import "VSLabel.h"
#import "VSImageView.h"
typedef void (^VSTabbarViewBlock)();
@protocol VSTabbardelegate <NSObject>

-(void)vs_TabbarSelect:(id)sender;

@end
@interface VSTabbarView : VSView
_PROPERTY_NONATOMIC_STRONG(VSImageView, icon);
_PROPERTY_NONATOMIC_STRONG(VSLabel, textlbl);
_PROPERTY_NONATOMIC_STRONG(UIImage, image);
_PROPERTY_NONATOMIC_STRONG(NSString, text);
_PROPERTY_NONATOMIC_WEAK(id<VSTabbardelegate>, delegate);
@property(nonatomic, copy)VSTabbarViewBlock block;
- (instancetype)initWithText:(NSString*)text andImage:(UIImage*)image withBlock:(VSTabbarViewBlock)block;
@end

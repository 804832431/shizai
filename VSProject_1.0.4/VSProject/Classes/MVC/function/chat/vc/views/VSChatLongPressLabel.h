//
//  VSChatLongPressLabel.h
//  WYStarService
//
//  Created by BestBoy on 14/12/29.
//  Copyright (c) 2014年 zhangtie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VSChatLongPressLabel;
@protocol VSChatLongPressLabelDelegate <NSObject>

@optional
- (void)vp_resendMsg:(VSChatLongPressLabel*)sender;

@end

@interface VSChatLongPressLabel : UILabel

@property(nonatomic,assign)NSInteger  indexValue; //这个label所在cell的 index值，
@property(nonatomic,assign)BOOL       isSendSuccess;

_PROPERTY_NONATOMIC_WEAK(id<VSChatLongPressLabelDelegate>, delegate);

@end



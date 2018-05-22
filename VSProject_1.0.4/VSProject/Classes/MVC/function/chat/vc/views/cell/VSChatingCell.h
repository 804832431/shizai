//
//  VSChatingCell.h
//  WYStarService
//
//  Created by BestBoy on 14/12/16.
//  Copyright (c) 2014年 zhangtie. All rights reserved.
//

#import "VSBaseTableViewCell.h"
#import "VSChatLongPressLabel.h"

@class VSChatingCell;
@protocol VSChatingCellDelegate <NSObject>

@optional
- (void)vp_rendMsgChatingCell:(VSChatingCell*)sender;

@end

@interface VSChatingCell : VSBaseTableViewCell<UIGestureRecognizerDelegate>

_PROPERTY_NONATOMIC_ASSIGN(BOOL, isFromMe);
_PROPERTY_NONATOMIC_ASSIGN(CGSize, msgSize);
_PROPERTY_NONATOMIC_STRONG(UIImageView, msgImgView)
_PROPERTY_NONATOMIC_STRONG(VSChatLongPressLabel, msgLabel);
_PROPERTY_NONATOMIC_STRONG(UILabel, dateLabel);
_PROPERTY_NONATOMIC_ASSIGN(MsgSendStatus, msgSendStus);
//_PROPERTY_NONATOMIC_STRONG(WYTextView, msgTxtView);


_PROPERTY_NONATOMIC_STRONG(UIButton, reSendBtn);
_PROPERTY_NONATOMIC_STRONG(UIActivityIndicatorView, activutyView);
_PROPERTY_NONATOMIC_STRONG(UIView, extnView);

_PROPERTY_NONATOMIC_WEAK(id<VSChatingCellDelegate>, delegate);


@end

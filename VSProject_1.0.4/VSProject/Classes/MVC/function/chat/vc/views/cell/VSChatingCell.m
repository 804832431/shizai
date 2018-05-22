//
//  VSChatingCell.m
//  WYStarService
//
//  Created by BestBoy on 14/12/16.
//  Copyright (c) 2014年 zhangtie. All rights reserved.
//

#import "VSChatingCell.h"
#import "VSChatMsgData.h"

#define tityWidth    5
#define plusNumber  25
#define sizeWidth   (_msgSize.width+plusNumber)
#define sizeHeight  (_msgSize.height+10)
#define msgStatus    @"msgStatusString"

@interface VSChatingCell ()<VSChatLongPressLabelDelegate>
{
    NSDictionary *_statusDictionary;
}


@end

@implementation VSChatingCell

- (void)vp_setInit
{
    [super vp_setInit];
    
    _isFromMe = YES; //默认是右边
    _msgSize = CGSizeZero;
    _msgSendStus = MsgIsReadyToSend;
    
    
    UIImage *chatbgself=[UIImage imageNamed:@"chatbgself"];
    _msgImgView = [[UIImageView alloc] init];
    _msgImgView.userInteractionEnabled = YES;
    [self.contentView addSubview:_msgImgView];
    _msgImgView.image = [chatbgself stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    [_msgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(5));
        make.left.equalTo(@(10));
        make.width.equalTo(@(sizeWidth));
        make.height.equalTo(@(sizeHeight));
    }];
    
    _msgLabel                        = [[VSChatLongPressLabel alloc] init];
    _msgLabel.delegate               = self;
    _msgLabel.textColor              = _COLOR_BLACK;
    _msgLabel.font                   = FONT_TITLE(15);
    _msgLabel.numberOfLines          = 0;
    _msgLabel.userInteractionEnabled = YES;
    _msgLabel.textAlignment          = NSTextAlignmentLeft;
    _msgLabel.backgroundColor        = _COLOR_CLEAR;
    [_msgImgView addSubview:_msgLabel];
    [_msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.left.equalTo(@(tityWidth));
        make.right.equalTo(@(-tityWidth));
        make.bottom.equalTo(@(0));
    }];
    _dateLabel = [[UILabel alloc] init];
    _dateLabel.textAlignment =_isFromMe?NSTextAlignmentRight:NSTextAlignmentLeft;
    _dateLabel.textColor = _COLOR_LIGHT_GRAY;
    _dateLabel.font = FONT_TITLE(10);
    _dateLabel.userInteractionEnabled = YES;
    [self.contentView addSubview:_dateLabel];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_msgImgView.mas_bottom).offset(0);
        make.left.equalTo(@10);
        make.right.equalTo(@(-10));
        make.height.equalTo(@(12));
    }];
}

+ (CGFloat)vp_cellHeightWithModel:(VSChatMsgData*)model withSuperWidth:(CGFloat)t_superWidth
{
    CGSize textSize     = [NSString caculateTextSize:model.vm_msgContent width:t_superWidth - 120 fontSize:15];
    CGFloat msgHeight   = textSize.height;
    return msgHeight + 27;
}

- (void)vp_updateCellInfoWithModel:(VSChatMsgData*)model withSuperWidth:(CGFloat)t_superWidth
{
    CGSize textSize = [NSString caculateTextSize:model.vm_msgContent width:t_superWidth - 120 fontSize:15];
    
    self.msgLabel.text = model.vm_msgContent;
    // wechatCell.msgLabel.indexValue = indexPath.row;
    
//    MsgSendStatus sendStatus = [MyDBChatMsgManager queueQueryChatMsgSendStatus:chatModel.rowid];
//    switch (sendStatus) {
//        case MsgIsSending:
//            wechatCell.dateLabel.text = @"正在发送...";
//            wechatCell.msgLabel.isSendSuccess = NO;
//            break;
//        case MsgSendSuccess:
//            wechatCell.dateLabel.text = [NSString transformDateFormat:[NSDate transformDateWithTimeString: chatModel.sendDate]];
//            break;
//        case MsgSendFailed:
//            wechatCell.dateLabel.text = @"发送失败!";
//            wechatCell.msgLabel.isSendSuccess = NO;
//            break;
//        default:
//            break;
//    }
    BOOL isFromeMee = false;
    self.isFromMe = isFromeMee;
    self.msgSize = textSize;
}

- (void)setIsFromMe:(BOOL)isFromMe
{
    _isFromMe = isFromMe;
    UIImage *chatbg=[UIImage imageNamed:@"chatbg"];
    UIImage *chatbgself=[UIImage imageNamed:@"chatbgself"];
    
    if (_isFromMe)
    { //如果是我发的
        _dateLabel.textAlignment = NSTextAlignmentRight;
        _msgLabel.textColor = _COLOR_BLACK;
        _msgImgView.image = [chatbgself stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        
        [_msgImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(5));
            make.right.equalTo(@(-10));
            make.width.equalTo(@(sizeWidth));
            make.height.equalTo(@(sizeHeight));
        }];
    }
    else
    {
        _dateLabel.textAlignment = NSTextAlignmentLeft;
        _msgLabel.textColor = _COLOR_BLACK;
        _msgImgView.image = [chatbg stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        
        
        [_msgImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(5));
            make.left.equalTo(@(10));
            make.width.equalTo(@(sizeWidth));
            make.height.equalTo(@(sizeHeight));
        }];
    }
    
    [_msgLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.left.equalTo(@(tityWidth));
        make.right.equalTo(@(-tityWidth));
        make.bottom.equalTo(@(0));
    }];
}

- (void)setMsgSize:(CGSize)msgSize
{
    _msgSize = msgSize;
    UIImage *chatbg=[UIImage imageNamed:@"chatbg"];
    UIImage *chatbgself=[UIImage imageNamed:@"chatbgself"];
    
    if (_isFromMe) { //如果是我发的
        _dateLabel.textAlignment = NSTextAlignmentRight;
        _msgLabel.textColor = _COLOR_BLACK;
        _msgImgView.image = [chatbgself stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        
        [_msgImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(5));
            make.right.equalTo(@(-10));
            make.width.equalTo(@(sizeWidth));
            make.height.equalTo(@(sizeHeight));
        }];
    }else{
        _dateLabel.textAlignment = NSTextAlignmentLeft;
        _msgLabel.textColor = _COLOR_BLACK;
        _msgImgView.image = [chatbg stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        
        [_msgImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(5));
            make.left.equalTo(@(10));
            make.width.equalTo(@(sizeWidth));
            make.height.equalTo(@(sizeHeight));
        }];
    }
    
    [_msgLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.left.equalTo(@(tityWidth));
        make.right.equalTo(@(-tityWidth));
        make.bottom.equalTo(@(0));
    }];
}

#pragma mark -- VSChatLongPressLabelDelegate
- (void)vp_resendMsg:(VSChatLongPressLabel *)sender
{
    if([self.delegate respondsToSelector:@selector(vp_rendMsgChatingCell:)])
    {
        [self.delegate vp_rendMsgChatingCell:self];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

//
//  ServerRegion_3_TableViewCell.m
//  VSProject
//
//  Created by pangchao on 17/6/26.
//  Copyright © 2017年 user. All rights reserved.
//

#import "ServerRegion_3_TableViewCell.h"
#import "ServerTheme_250_375_View.h"

@interface ServerRegion_3_TableViewCell () <Server_250_375_TopicClickedDelegate>

@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *tipsLabel;


@property (nonatomic, strong) ServerTheme_250_375_View *oneView;
@property (nonatomic, strong) ServerTheme_250_375_View *twoView;
@property (nonatomic, strong) ServerTheme_250_375_View *threeView;

@end

@implementation ServerRegion_3_TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        [self.contentView addSubview:self.headView];
        [self.contentView addSubview:self.oneView];
        [self.contentView addSubview:self.twoView];
        [self.contentView addSubview:self.threeView];
    }
    
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.headView.frame = CGRectMake(0, 0, MainWidth, Get750Width(88.0f));
    
    self.oneView.frame = CGRectMake(0, self.headView.frame.origin.y + self.headView.frame.size.height, Get750Width(250.0f), Get750Width(375.0f));
    
    self.twoView.frame = CGRectMake(Get750Width(250.0f), self.headView.frame.origin.y + self.headView.frame.size.height, Get750Width(250.0f), Get750Width(375.0f));
    
    self.threeView.frame = CGRectMake(Get750Width(250.0f) * 2, self.headView.frame.origin.y + self.headView.frame.size.height, Get750Width(250.0f), Get750Width(375.0f));
}

- (UIView *)headView {
    
    if (!_headView) {
        
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, Get750Width(88.0f))];
        
        _headView.backgroundColor = _Colorhex(0xffc284);
        
        [_headView addSubview:self.titleLabel];
        [_headView addSubview:self.tipsLabel];
    }
    
    return _headView;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(Get750Width(24.0f), Get750Width(26.0f), Get750Width(300.0f), Get750Width(36.0f))];
        _titleLabel.font = FONT_TITLE(18.0f);
        _titleLabel.textColor = _Colorhex(0xffffff);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _titleLabel;
}

- (UILabel *)tipsLabel {
    
    if (!_tipsLabel) {
        
        _tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(Get750Width(300.0f), Get750Width(29.0f), Get750Width(450.0f - 24.0f), Get750Width(30.0f))];
        _tipsLabel.font = FONT_TITLE(15.0f);
        _tipsLabel.textColor = _Colorhex(0xffffff);
        _tipsLabel.textAlignment = NSTextAlignmentRight;
    }
    
    return _tipsLabel;
}

- (ServerTheme_250_375_View *)oneView {
    
    if (!_oneView) {
        
        _oneView = [[ServerTheme_250_375_View alloc] initWithFrame:CGRectMake(0, self.headView.frame.origin.y + self.headView.frame.size.height, Get750Width(250.0f), Get750Width(375.0f))];
        _oneView.delegate = self;
    }
    
    return _oneView;
}

- (ServerTheme_250_375_View *)twoView {
    
    if (!_twoView) {
        
        _twoView = [[ServerTheme_250_375_View alloc] initWithFrame:CGRectMake(Get750Width(250.0f), self.headView.frame.origin.y + self.headView.frame.size.height, Get750Width(250.0f), Get750Width(375.0f))];
        _twoView.delegate = self;
    }
    
    return _twoView;
}

- (ServerTheme_250_375_View *)threeView {
    
    if (!_threeView) {
        
        _threeView = [[ServerTheme_250_375_View alloc] initWithFrame:CGRectMake(Get750Width(250.0f) * 2, self.headView.frame.origin.y + self.headView.frame.size.height, Get750Width(250.0f), Get750Width(375.0f))];
        _threeView.delegate = self;
    }
    
    return _threeView;
}

- (void)setDataSource:(TopicDTO *)topicDTO {
    
    self.topicDTO = topicDTO;
    
    self.titleLabel.text = topicDTO.name;
    self.tipsLabel.text = topicDTO.desc;
    
    [self.oneView setData:[self.topicDTO.projectList objectAtIndex:0]];
    [self.twoView setData:[self.topicDTO.projectList objectAtIndex:1]];
    [self.threeView setData:[self.topicDTO.projectList objectAtIndex:2]];
}

- (void)topic_250_375_ClickedAction:(TopicProductDTO *)dto {
    
    if (self.serverRgion_3_Block) {
        self.serverRgion_3_Block(dto);
    }
}

+ (CGFloat)getHeight {
    
    return Get750Width(375.0f + 88.0f);
}

@end

//
//  ServerRegion_5_TableViewCell.m
//  VSProject
//
//  Created by pangchao on 17/6/26.
//  Copyright © 2017年 user. All rights reserved.
//

#import "ServerRegion_5_TableViewCell.h"
#import "ServerTheme_500_375_View.h"
#import "ServerTheme_250_375_View.h"

@interface ServerRegion_5_TableViewCell () <Server_500_375_TopicClickedDelegate, Server_250_375_TopicClickedDelegate>

@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *tipsLabel;

@property (nonatomic, strong) ServerTheme_500_375_View *row1_col1_view;
@property (nonatomic, strong) ServerTheme_250_375_View *row1_col2_view;
@property (nonatomic, strong) ServerTheme_250_375_View *row2_col1_view;
@property (nonatomic, strong) ServerTheme_250_375_View *row2_col2_view;
@property (nonatomic, strong) ServerTheme_250_375_View *row2_col3_view;

@property (nonatomic, strong) UIView *spaceLineView;

@end

@implementation ServerRegion_5_TableViewCell

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
        [self.contentView addSubview:self.row1_col1_view];
        [self.contentView addSubview:self.row1_col2_view];
        [self.contentView addSubview:self.spaceLineView];
        [self.contentView addSubview:self.row2_col1_view];
        [self.contentView addSubview:self.row2_col2_view];
        [self.contentView addSubview:self.row2_col3_view];
    }
    
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.headView.frame = CGRectMake(0, 0, MainWidth, Get750Width(88.0f));
    self.row1_col1_view.frame = CGRectMake(0, self.headView.frame.origin.y + self.headView.frame.size.height, Get750Width(500.0f), Get750Width(375.0f));
    self.row1_col2_view.frame = CGRectMake(self.row1_col1_view.frame.origin.x + self.row1_col1_view.frame.size.width, self.headView.frame.origin.y + self.headView.frame.size.height, Get750Width(250.0f), Get750Width(375.0f));
    self.spaceLineView.frame = CGRectMake(0, self.row1_col1_view.frame.origin.y + self.row1_col1_view.frame.size.height, MainWidth, Get750Width(1.0f));;
    self.row2_col1_view.frame = CGRectMake(0, self.spaceLineView.frame.origin.y + self.spaceLineView.frame.size.height, Get750Width(250.0f), Get750Width(375.0f));
    self.row2_col2_view.frame = CGRectMake(Get750Width(250.0f), self.spaceLineView.frame.origin.y + self.spaceLineView.frame.size.height, Get750Width(250.0f), Get750Width(375.0f));
    self.row2_col3_view.frame = CGRectMake(Get750Width(250.0f) * 2, self.spaceLineView.frame.origin.y + self.spaceLineView.frame.size.height, Get750Width(250.0f), Get750Width(375.0f));
}

- (UIView *)headView {
    
    if (!_headView) {
        
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, Get750Width(88.0f))];
        
        _headView.backgroundColor = _Colorhex(0x5bd5be);
        
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

- (ServerTheme_500_375_View *)row1_col1_view {
    
    if (!_row1_col1_view) {
        
        _row1_col1_view = [[ServerTheme_500_375_View alloc] initWithFrame:CGRectMake(0, self.headView.frame.origin.y + self.headView.frame.size.height, Get750Width(500.0f), Get750Width(375.0f))];
        _row1_col1_view.delegate = self;
    }
    
    return _row1_col1_view;
}

- (ServerTheme_250_375_View *)row1_col2_view {
    
    if (!_row1_col2_view) {
        
        _row1_col2_view = [[ServerTheme_250_375_View alloc] initWithFrame:CGRectMake(self.row1_col1_view.frame.origin.x + self.row1_col1_view.frame.size.width, self.headView.frame.origin.y + self.headView.frame.size.height, Get750Width(250.0f), Get750Width(375.0f))];
        _row1_col2_view.delegate = self;
    }
    
    return _row1_col2_view;
}

- (UIView *)spaceLineView {
    
    if (!_spaceLineView) {
        
        _spaceLineView = [[UIView alloc] init];
        _spaceLineView.frame = CGRectMake(0, self.row1_col1_view.frame.origin.y + self.row1_col1_view.frame.size.height, MainWidth, Get750Width(1.0f));
        _spaceLineView.backgroundColor = _Colorhex(0xefeff4);
    }
    
    return _spaceLineView;
}

- (ServerTheme_250_375_View *)row2_col1_view {
    
    if (!_row2_col1_view) {
        
        _row2_col1_view = [[ServerTheme_250_375_View alloc] initWithFrame:CGRectMake(0, self.spaceLineView.frame.origin.y + self.spaceLineView.frame.size.height, Get750Width(250.0f), Get750Width(375.0f))];
        _row2_col1_view.delegate = self;
    }
    
    return _row2_col1_view;
}

- (ServerTheme_250_375_View *)row2_col2_view {
    
    if (!_row2_col2_view) {
        
        _row2_col2_view = [[ServerTheme_250_375_View alloc] initWithFrame:CGRectMake(Get750Width(250.0f), self.spaceLineView.frame.origin.y + self.spaceLineView.frame.size.height, Get750Width(250.0f), Get750Width(375.0f))];
        _row2_col2_view.delegate = self;
    }
    
    return _row2_col2_view;
}

- (ServerTheme_250_375_View *)row2_col3_view {
    
    if (!_row2_col3_view) {
        
        _row2_col3_view = [[ServerTheme_250_375_View alloc] initWithFrame:CGRectMake(Get750Width(250.0f) * 2, self.spaceLineView.frame.origin.y + self.spaceLineView.frame.size.height, Get750Width(250.0f), Get750Width(375.0f))];
        _row2_col3_view.delegate = self;
    }
    
    return _row2_col3_view;
}

- (void)setDataSource:(TopicDTO *)topicDTO {
    
    self.topicDTO = topicDTO;
    
    self.titleLabel.text = topicDTO.name;
    self.tipsLabel.text = topicDTO.desc;
    
    [self.row1_col1_view setData:[self.topicDTO.projectList objectAtIndex:0]];
    [self.row1_col2_view setData:[self.topicDTO.projectList objectAtIndex:1]];
    [self.row2_col1_view setData:[self.topicDTO.projectList objectAtIndex:2]];
    [self.row2_col2_view setData:[self.topicDTO.projectList objectAtIndex:3]];
    [self.row2_col3_view setData:[self.topicDTO.projectList objectAtIndex:4]];
}

- (void)topic_250_375_ClickedAction:(TopicProductDTO *)dto {
    
    if (self.serverRgion_5_Block) {
        self.serverRgion_5_Block(dto);
    }
}

- (void)topic_500_375_ClickedAction:(TopicProductDTO *)dto {
    
    if (self.serverRgion_5_Block) {
        self.serverRgion_5_Block(dto);
    }
}

+ (CGFloat)getHeight {
    
    return Get750Width(375.0f * 2 + 88.0f + 1.0f);
}

@end

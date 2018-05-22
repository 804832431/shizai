//
//  EvaluateTextCell.m
//  VSProject
//
//  Created by 陈 海涛 on 16/7/30.
//  Copyright © 2016年 user. All rights reserved.
//

#import "EvaluateTextCell.h"

@implementation EvaluateTextCell

- (JSTextView *)textView{
    if (_textView == nil) {
        _textView = [[JSTextView alloc] initWithFrame:CGRectMake(5, 10, [UIScreen mainScreen].bounds.size.width - 10, 177)];
        _textView.myPlaceholder = @"写下此次服务感受来帮助其他小伙伴";
        _textView.backgroundColor = _RGB_A(245, 245, 245, 1);
        _textView.layer.cornerRadius = 1;
        _textView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        _textView.layer.borderWidth = 0.5;
    }
    return _textView;
}

- (UILabel *)wordCountLabel{
    if (_wordCountLabel == nil) {
        _wordCountLabel = [UILabel new];
        _wordCountLabel.text = @"0/500";
        _wordCountLabel.font = [UIFont systemFontOfSize:13];
        _wordCountLabel.textColor = _COLOR_HEX(0xaeaeae);
    }
    return _wordCountLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.textView];
        
        [self.contentView addSubview:self.wordCountLabel];
        
        __weak typeof(self) weakSelf = self;
        
        [self.wordCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(weakSelf.textView);
            make.top.equalTo(weakSelf.textView.mas_bottom).offset(3);
        }];
        
        //开始编辑
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editing:) name:UITextViewTextDidChangeNotification object:nil];
    }
    
    return self;
}

- (void)editing:(NSNotification *)notification {
    
    self.wordCountLabel.text = [NSString stringWithFormat:@"%li/500",self.textView.text.length];
    
    if (self.textView.text.length > 500) {
        _wordCountLabel.textColor = _COLOR_RED;
    }else{
        _wordCountLabel.textColor = _COLOR_HEX(0xaeaeae);
    }
    
    if (self.evaluateTextBlock) {
        self.evaluateTextBlock(self.textView.text);
    }
    
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end















































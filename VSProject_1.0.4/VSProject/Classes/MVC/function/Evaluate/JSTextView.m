//
//  JSTextView.m
//  VSProject
//
//  Created by 陈 海涛 on 16/7/30.
//  Copyright © 2016年 user. All rights reserved.
//

#import "JSTextView.h"

@interface JSTextView ()

@property (nonatomic,weak) UILabel *placeholderLabel;
@end

@implementation JSTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //添加一个占位label
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.backgroundColor = [UIColor clearColor];
        placeholderLabel.numberOfLines = 0;
        [self addSubview:placeholderLabel];
        self.placeholderLabel = placeholderLabel;
        
        
        //设置占位文字默认颜色
        self.myPlaceholderColor = _COLOR_HEX(0xaeaeae);
        
        //设置默认的字体
        self.font = [UIFont systemFontOfSize:13];
        
        //通知:监听文字的改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
        
    }
    return self;
}


#pragma mark - 监听文字改变
- (void)textDidChange
{
    // text属性：只包括普通的文本字符串
    // attributedText：包括了显示在textView里面的所有内容（表情、text）
    self.placeholderLabel.hidden = self.hasText;  //(self.attributedText.length !=0)
    
}


- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textDidChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self textDidChange];
}

//重写这个set方法保持font一致
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    
    //重新计算子控件frame
    [self setNeedsLayout];
}


- (void)setMyPlaceholder:(NSString *)myPlaceholder
{
    _myPlaceholder = [myPlaceholder copy];
    
    //设置文字
    self.placeholderLabel.text = myPlaceholder;
    
    //重新计算子控件frame
    [self setNeedsLayout];
    
}


- (void)setMyPlaceholderColor:(UIColor *)myPlaceholderColor
{
    _myPlaceholderColor = myPlaceholderColor;
    
    //设置颜色
    self.placeholderLabel.textColor = myPlaceholderColor;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    //    self.placeholderLabel.y = 8;
    //    self.placeholderLabel.x = 5;
    //    self.placeholderLabel.width = self.width - self.placeholderLabel.x*2.0;
    //    
    //    //根据文字计算高度
    //    CGSize maxSize = CGSizeMake(self.placeholderLabel.width, MAXFLOAT);
    //    
    //    self.placeholderLabel.height = [self.myPlaceholder boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.placeholderLabel.font} context:nil].size.height;
    
    self.placeholderLabel.frame = CGRectMake(10, 10, 300, 20);
    
    
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:UITextViewTextDidChangeNotification];
}

@end

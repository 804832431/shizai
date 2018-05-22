//
//  TagSelectView.m
//  VSProject
//
//  Created by pch_tiger on 16/12/21.
//  Copyright © 2016年 user. All rights reserved.
//

#import "TagSelectView.h"

#define CORNER_RADIUS 15.0f
#define LABEL_MARGIN 15.0f
#define BOTTOM_MARGIN 23.0f
#define FONT_SIZE 13.0f
#define HORIZONTAL_PADDING 15.0f
#define VERTICAL_PADDING 23.0f

#define TAG_BUTTON_START 1000

#define TAG_BOUND_COLOR_SELECTED _COLOR_HEX(0x09aa89)
#define TAG_BOUND_COLOR_DEFAULT _COLOR_HEX(0x080808)

@implementation TagSelectView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.btnBackgroundColor  = _COLOR_HEX(0x77d2c5);
        _numbersOfLine = 0;
    }
    return self;
}

- (void)setTags:(NSArray *)array
{
    textArray = [[NSArray alloc] initWithArray:array];
    tagBtns = [NSMutableArray array];
    maxSelectCount = 3;
    sizeFit = CGSizeZero;
    //重新赋值数据时，清空原来的行数
    _numbersOfLine = 0;
    [self display];
}

- (void)display
{
    for (UIView *subview in [self subviews]) {
        [subview removeFromSuperview];
    }
    
    float totalHeight = 0;
    CGRect previousFrame = CGRectZero;
    BOOL gotPreviousFrame = NO;
    for (int i = 0; i < textArray.count ;i ++) {
        NSString *text = textArray[i];
        NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        CGSize textSize = [text boundingRectWithSize:CGSizeMake(self.frame.size.width, 1500) options:options attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FONT_SIZE]} context:nil].size;
        textSize.width += HORIZONTAL_PADDING*2;
        textSize.height = 26.0f;
        UIButton *btn = nil;
        if (!gotPreviousFrame) {
            btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, textSize.width, textSize.height)];
            totalHeight = textSize.height;
            _numbersOfLine ++;
        } else {
            CGRect newRect = CGRectZero;
            if (CGRectGetMaxX(previousFrame) + textSize.width + LABEL_MARGIN > self.frame.size.width) {
                newRect.origin = CGPointMake(0, CGRectGetMaxY(previousFrame) + BOTTOM_MARGIN);
                totalHeight += textSize.height + BOTTOM_MARGIN;
                
                _numbersOfLine ++;
            } else {
                newRect.origin = CGPointMake(CGRectGetMaxX(previousFrame)+ LABEL_MARGIN, CGRectGetMinY(previousFrame));
            }
            newRect.size = textSize;
            btn = [[UIButton alloc] initWithFrame:newRect];
        }
        previousFrame = btn.frame;
        gotPreviousFrame = YES;
        
        btn.adjustsImageWhenHighlighted = NO;
        if (_isReadOnly) {
            btn.enabled = NO;
        }
        
        btn.layer.masksToBounds = YES;
        btn.layer.borderColor = TAG_BOUND_COLOR_DEFAULT.CGColor;
        btn.layer.borderWidth = 0.5f;
        btn.layer.cornerRadius = 25.0f/2;
        
        [btn setTitle:textArray[i] forState:UIControlStateNormal];
        
        [btn setTitleColor:_COLOR_HEX(0x080808) forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        [btn setTitleColor:_COLOR_HEX(0x09aa89) forState:UIControlStateSelected];
        [btn setTitleColor:_COLOR_HEX(0x09aa89) forState:UIControlStateHighlighted];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:FONT_SIZE];
        
        btn.tag = TAG_BUTTON_START + i;
        [btn addTarget:self action:@selector(tagBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        [tagBtns addObject:btn];
    }
    sizeFit = CGSizeMake(self.frame.size.width, totalHeight + 1.0f);
    CGRect frame = self.frame;
    frame.size.height = sizeFit.height;
    self.frame = frame;
    
    [self refreshData];
}

- (CGSize)fittedSize
{
    return sizeFit;
}

- (void)tagBtnClick:(UIButton *)sender
{
    NSInteger allSelect = 0;
    for(UIButton *btn in tagBtns)
    {
        if (btn.selected)
        {
            allSelect++;
        }
    }
    if (sender.selected)
    {//想取消
        sender.selected = NO;
        sender.layer.borderColor = TAG_BOUND_COLOR_DEFAULT.CGColor;
    }
    else
    {//想选中
        if (allSelect < maxSelectCount)
        {
            //只能选择一个，清空之前的选择
            if (_singleSelect) {
                for(UIButton *btn in tagBtns)
                {
                    btn.selected = NO;
                    btn.layer.borderColor = TAG_BOUND_COLOR_DEFAULT.CGColor;
                }
            }
            
            sender.selected = YES;
            sender.layer.borderColor = TAG_BOUND_COLOR_SELECTED.CGColor;
        }
        else
        {
            [self showTipsView:@"选择不超过3个标签"];
        }
    }
    
    if (self.delegate && [_delegate respondsToSelector:@selector(TagSelectBtnClicked:btnTagList:index:)])
    {
        [self.delegate TagSelectBtnClicked:sender btnTagList:self index:(sender.tag - TAG_BUTTON_START)];
    }
}

- (NSMutableArray *)selectedTags
{
    NSMutableArray *tags = [NSMutableArray array];
    for(UIButton *btn in tagBtns)
    {
        if (btn.selected)
        {
            [tags addObject:[btn titleForState:UIControlStateNormal]];
        }
    }
    return tags;
}

- (NSMutableArray *)unSelectedTags
{
    NSMutableArray *tags = [NSMutableArray array];
    for(UIButton *btn in tagBtns)
    {
        if (!btn.selected)
        {
            [tags addObject:[btn titleForState:UIControlStateNormal]];
        }
    }
    return tags;
}

- (void)refreshData {
    //将已经选中的高亮
    if (self.defaultSelctArray == nil || self.defaultSelctArray.count <= 0) {
        return;
    }
    for (UIButton *btn in tagBtns) {
        for(NSString *title in self.defaultSelctArray) {
            if([title isEqualToString:[btn titleForState:UIControlStateNormal]]) {
                btn.selected = YES;
                btn.layer.borderColor = TAG_BOUND_COLOR_SELECTED.CGColor;
            }
        }
    }
}

@end

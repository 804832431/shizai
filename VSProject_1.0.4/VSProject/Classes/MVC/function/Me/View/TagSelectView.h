//
//  TagSelectView.h
//  VSProject
//
//  Created by pch_tiger on 16/12/21.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TagSelectView;

@protocol TagSelectDelegate <NSObject>
@required
- (void)TagSelectBtnClicked:(UIButton *)sender btnTagList:(TagSelectView *)tagSelectView index:(NSInteger) index;
@end

@interface TagSelectView : UIView
{
    NSArray *textArray;
    CGSize sizeFit;
    
    NSMutableArray *tagBtns;
    NSInteger maxSelectCount;
}

@property (nonatomic, strong) NSArray *defaultSelctArray; //默认选中的标签
@property (nonatomic, assign) NSInteger numbersOfLine; //行数

@property (nonatomic, strong) UIColor *btnBackgroundColor;
@property (nonatomic, weak) id<TagSelectDelegate> delegate;

- (void)setTags:(NSArray *)array;
- (CGSize)fittedSize;
- (NSMutableArray *)selectedTags;
- (NSMutableArray *)unSelectedTags;

//适配能力标签
@property (nonatomic, assign)BOOL singleSelect; //默认NO:多选 YES:单选

@property (nonatomic, assign)BOOL isReadOnly; //默认NO YES:只能看不能改

@end

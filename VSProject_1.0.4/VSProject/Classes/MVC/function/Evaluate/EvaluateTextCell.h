//
//  EvaluateTextCell.h
//  VSProject
//
//  Created by 陈 海涛 on 16/7/30.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSTextView.h"

@interface EvaluateTextCell : UITableViewCell

@property (nonatomic,strong) JSTextView *textView;

@property (nonatomic,strong) UILabel *wordCountLabel;

@property (nonatomic,copy) void (^evaluateTextBlock)(NSString *text);

@end

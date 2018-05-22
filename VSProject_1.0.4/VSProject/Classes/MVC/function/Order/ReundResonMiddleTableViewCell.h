//
//  ReundResonMiddleTableViewCell.h
//  VSProject
//
//  Created by 陈 海涛 on 16/8/31.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BRPlaceholderTextView.h"

@interface ReundResonMiddleTableViewCell : UITableViewCell

@property (nonatomic,weak) IBOutlet BRPlaceholderTextView *textView;

@property (weak, nonatomic) IBOutlet UIButton *commitButton;

- (IBAction)commitAction:(id)sender;

@property (nonatomic,copy) void (^commitActionBlock)(NSString *str);

@end

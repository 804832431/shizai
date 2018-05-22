//
//  NewPolicyCell.m
//  VSProject
//
//  Created by apple on 11/4/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "NewPolicyCell.h"

@implementation NewPolicyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataSource:(NewPolicyModel *)policyModel {
    [self.whiteContentView.layer setCornerRadius:5.0];
    
    [self.titleLabel setText:policyModel.policyName];
    [self.ownerLabel setText:policyModel.partner];
    
    if ([policyModel.publicityStatus isEqualToString:@"Y"]) {
        [self.gongshiLabel setText:@"已公示"];
    } else {
        [self.gongshiLabel setText:@"未公示"];
    }
    
    //v1.6.0版本改版
    //时间处理
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    //转化string到date
    NSDate *dateBegin = [dateFormatter dateFromString:policyModel.applyDateBegin];
    NSDate *dateEnd = [dateFormatter dateFromString:policyModel.applyDateEnd];
    //输出格式为：09.14 14:00
    NSDateFormatter *displayFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [displayFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *dateStringBegin = [displayFormatter stringFromDate:dateBegin];
    NSString *dateStringEnd = [displayFormatter stringFromDate:dateEnd];
    [self.gongshiLabel setText:[NSString stringWithFormat:@"申报时间：%@-%@",dateStringBegin,dateStringEnd]];
    
    
    NSString *minString;
    if (policyModel.minSubsidy.length > 0) {
        minString = [self removeFloatAllZero:policyModel.minSubsidy];
    } else {
        minString = @"";
    }
    NSString *maxString;
    if (policyModel.maxSubsidy.length > 0) {
        maxString = [self removeFloatAllZero:policyModel.maxSubsidy];
    } else {
        maxString = @"";
    }
    
    NSString *displayString = @"";
    if (minString.length == 0 && maxString.length == 0) {
        [self.butieTitle setHidden:YES];
        [self.butieLabel setHidden:YES];
    } else if (minString.length == 0 || maxString.length == 0) {
        if (minString.length == 0) {
            displayString = [NSString stringWithFormat:@"%@万",maxString];
            [self.butieLabel setText:displayString];
        } else {
            displayString = [NSString stringWithFormat:@"%@万",minString];
            [self.butieLabel setText:displayString];
        }
    } else {
        displayString = [NSString stringWithFormat:@"%@-%@万",minString,maxString];
        [self.butieLabel setText:displayString];
    }
    
    CGSize titleSize = [displayString boundingRectWithSize:CGSizeMake(__SCREEN_WIDTH__, MAXFLOAT)
                                           options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                        attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}
                                           context:nil].size;

    if (titleSize.width > 65.5) {
        [self.heightOfButie setConstant:titleSize.width + 10];
    }
    
}

-(NSString*)removeFloatAllZero:(NSString*)string
{
    
    NSString * testNumber = string;
    NSString * outNumber = [NSString stringWithFormat:@"%@",@(testNumber.floatValue)];
    
    //    价格格式化显示
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
    NSString *formatterString = [formatter stringFromNumber:[NSNumber numberWithFloat:[outNumber doubleValue]]];
    
    NSRange range = [formatterString rangeOfString:@"."]; //现获取要截取的字符串位置
    NSLog(@"--------%lu",(unsigned long)range.length);
    
    if (range.length>0) {
        
        NSString * result = [formatterString substringFromIndex:range.location]; //截取字符串
        
        if (result.length>=4) {
            
            formatterString=[formatterString substringToIndex:formatterString.length-1];
        }
        
    }
    
    NSLog(@"Formatted number string:%@",formatterString);
    
    NSLog(@"Formatted number string:%@",outNumber);
    //    输出结果为：[1223:403] Formatted number string:123,456,789
    
    return formatterString;
}

@end

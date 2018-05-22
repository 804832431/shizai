//
//  HomeShareLineView.m
//  VSProject
//
//  Created by apple on 12/30/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "HomeShareLineView.h"

@implementation HomeShareLineView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"HomeShareLineView" owner:nil options:nil];
        self = [nibView firstObject];
    }
    return self;
}

- (void)onSetTime:(NSNumber *)time {
    //时间处理
    NSTimeInterval timeInterval = [time integerValue];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    //转化string到date
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:timeInterval/1000];
//    NSDate *date = [dateFormatter dateFromString:time];
    //输出格式为：09.14 14:00
    NSDateFormatter *displayFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [displayFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [displayFormatter stringFromDate:date];
    [self.shareTimeLabel setText:dateString];
}

@end

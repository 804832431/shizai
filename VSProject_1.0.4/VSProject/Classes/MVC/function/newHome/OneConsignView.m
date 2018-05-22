//
//  OneConsignView.m
//  VSProject
//
//  Created by apple on 9/3/17.
//  Copyright © 2017 user. All rights reserved.
//

#import "OneConsignView.h"

@implementation OneConsignView

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"OneConsignView" owner:nil options:nil];
        self = [nibView firstObject];
    }
    return self;
}

- (NSMutableArray *)labelArray {
    if (!_labelArray) {
        _labelArray = [[NSMutableArray alloc] init];
    }
    return _labelArray;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)setDataSource:(NSArray *)array {
    [self.labelArray removeAllObjects];
    [self.dataArray removeAllObjects];
    
    [self.dataArray addObjectsFromArray:array];
    
    //三个一行
    double linef = array.count / 3.0f;
    NSInteger line = ceil(linef);
    [self setBounds:CGRectMake(0.0f, 0.0f, __SCREEN_WIDTH__ - 50, 130 + 54.0f * line)];

    double labelWidth = (__SCREEN_WIDTH__ - 50 - 30)/3.0f;
    double labelHigh = 54.0f;
    
    for (NSInteger i = 0; i < array.count; i++) {
        NSDictionary *dic = [array objectAtIndex:i];
        
        NSInteger labelRow = ceil((i+1)/3.0f) - 1;
        NSLog(@"%ld",labelRow);
        
        NSInteger labelLine = i - (labelRow) * 3.0f;
        NSLog(@"%ld",labelLine);
        //00 01 02 10 11 12
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(labelWidth*labelLine, labelHigh*labelRow, labelWidth, labelHigh)];
//        [view.layer setBorderColor:[UIColor redColor].CGColor];
//        [view.layer setBorderWidth:1];
        UIButton *label = [[UIButton alloc] initWithFrame:CGRectMake(7.5, 7, labelWidth - 15, labelHigh - 14)];
        [label setTitle:[dic valueForKey:@"appName"] forState:UIControlStateNormal];
        [label setTitleColor:_Colorhex(0x595959) forState:UIControlStateNormal];
        [label.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [label.layer setCornerRadius:20];
        [label.layer setBorderColor:_Colorhex(0x595959).CGColor];
        [label.layer setBorderWidth:0.75f];
        [label setTag:i];
        [label addTarget:self action:@selector(selectTab:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:label];
        
        [self.labelArray addObject:label];
        
        [self.labelView addSubview:view];
    }
}

- (IBAction)selectTab:(id)sender {
    for (NSInteger i = 0; i < self.labelArray.count; i++) {
        UIButton *cacheLabel = [self.labelArray objectAtIndex:i];
        if (i != ((UIButton *)sender).tag) {
            [cacheLabel setTitleColor:_Colorhex(0x595959) forState:UIControlStateNormal];
            [cacheLabel.layer setBorderColor:_Colorhex(0x595959).CGColor];
        } else {
            [cacheLabel setTitleColor:_Colorhex(0x00c88c) forState:UIControlStateNormal];
            [cacheLabel.layer setBorderColor:_Colorhex(0x00c88c).CGColor];
        }
    }
    
    NSDictionary *dic = [self.dataArray objectAtIndex:((UIButton *)sender).tag];
    self.clickBlock(dic);
}

@end

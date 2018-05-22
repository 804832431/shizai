//
//  HomeAppView.m
//  VSProject
//
//  Created by apple on 12/28/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "HomeAppView.h"
#import "NewShareWebViewController.h"

@interface HomeAppView ()

@property (nonatomic,strong) RTXCAppModel *appModel;

@end

@implementation HomeAppView

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
        NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"HomeAppView" owner:nil options:nil];
        self = [nibView firstObject];
    }
    return self;
}

- (void)setDataSource:(RTXCAppModel *)appModel {
    self.appModel = appModel;
    [self.appIconImageView sd_setImageWithURL:[NSURL URLWithString:appModel.appIcon] placeholderImage:__IMAGENAMED__(@"")];
    [self.appTitleLabel setText:appModel.appName];
    if (__SCREEN_WIDTH__ == 320) {
        [self.appTitleLabel setFont:[UIFont systemFontOfSize:12]];
    }
}

- (IBAction)clickAction:(id)sender {
    [VSPageRoute routeToTarget:self.appModel];
}
@end

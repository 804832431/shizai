//
//  WeatherView.m
//  VSProject
//
//  Created by certus on 16/1/15.
//  Copyright © 2016年 user. All rights reserved.
//

#import "WeatherView.h"


@implementation WeatherView

- (id)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if (self) {
        _bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bgButton.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.7];
        [_bgButton addTarget:self action:@selector(hideBg) forControlEvents:UIControlEventTouchUpInside];
        _bgButton.frame = CGRectZero;
        [self addSubview:_bgButton];

        _bgImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_bgImageView];
        
        _weatherItem = [[[NSBundle mainBundle]loadNibNamed:@"WeatherCell" owner:nil options:nil]lastObject];
        [_bgImageView addSubview:_weatherItem];
        [_weatherItem setHidden:YES];

        _downImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _downImageView.image = [UIImage imageNamed:@"home_downArrow"];
        _downImageView.userInteractionEnabled = YES;
        _downImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_downImageView];
        [_downImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.equalTo(self.mas_bottom);
        }];
    }
    
    return self;
}

- (void)hideBg {
    
    self.frame = CGRectMake(0, 0, MainWidth, TOPIMAGE_H);
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    if (self.frame.size.height < TOPIMAGE_EH) {
        //缩回
        if ([NSDate nowIsNight]) {//晚上
            [_bgImageView sd_setImageWithString:[VSUserLogicManager shareInstance].userDataInfo.vm_projectImg_day placeholderImage:[UIImage imageNamed:@"home_top"]];
        }else {//白天
            [_bgImageView sd_setImageWithString:[VSUserLogicManager shareInstance].userDataInfo.vm_projectImg_day placeholderImage:[UIImage imageNamed:@"home_top"]];
        }
        
        [self hideWeatherItem];
        [_downImageView setHidden:NO];
        [UIView animateWithDuration:.4f animations:^{
            _bgImageView.frame = CGRectMake(0, 0, MainWidth, TOPIMAGE_H);
            _bgButton.frame = CGRectMake(0, 0, MainWidth, 0);
        }];

    }else {
        //拉伸
        [_bgImageView sd_setImageWithString:[VSUserLogicManager shareInstance].userDataInfo.vm_WeatherInfo.backgroundImageURL placeholderImage:[UIImage imageNamed:@"weatherBg_default"]];

        [UIView animateWithDuration:.4f animations:^{
            _bgImageView.frame = CGRectMake(0, 0, MainWidth, TOPIMAGE_H+TOPIMAGE_EH);
            _bgButton.frame = CGRectMake(0, TOPIMAGE_EH, MainWidth, MainHeight-TOPIMAGE_EH);
            [_downImageView setHidden:YES];
        }completion:^(BOOL finished) {
            [self loadWeatherItem];
        }];

    }
}

- (void)loadWeatherItem {

    if (_weatherItem && !_hideWeather) {
        
        [_weatherItem setHidden:NO];
    }
}

- (void)hideWeatherItem {
    
    if (_weatherItem) {
        
        [_weatherItem setHidden:YES];
    }
}

- (void)reloadWeatherData:(WeatherModel *)model {

    if ([model isKindOfClass:[WeatherModel class]]) {
        _hideWeather = !model.tempNow;
        if (!_hideWeather) {
            [_bgImageView sd_setImageWithString:model.backgroundImageURL placeholderImage:[UIImage imageNamed:@"weatherBg_default"]];
            [_weatherItem.weatherImage sd_setImageWithString:model.weatherIconURL placeholderImage:nil];
            _weatherItem.tempLabel.text = model.tempNow;
            _weatherItem.difLabel.text = model.temp;
            _weatherItem.cityLabel.text = [NSString stringWithFormat:@"%@   %@",model.projectName,model.weather];
        }else {
            
            [self hideWeatherItem];
        }
    }
    NSLog(@"model---%@",model);
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

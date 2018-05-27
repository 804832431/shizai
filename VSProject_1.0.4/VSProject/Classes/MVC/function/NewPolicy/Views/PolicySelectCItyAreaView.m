//
//  PolicySelectCItyAreaView.m
//  VSProject
//
//  Created by apple on 11/8/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "PolicySelectCItyAreaView.h"
#import "SelectCityAndAreaCell.h"

@interface PolicySelectCItyAreaView ()

_PROPERTY_NONATOMIC_STRONG(NSArray , cityList);
_PROPERTY_NONATOMIC_STRONG(NSArray , areaList);

_PROPERTY_NONATOMIC_STRONG(NSString, selectedName);
_PROPERTY_NONATOMIC_STRONG(CityAreaModel , selectedCity);
_PROPERTY_NONATOMIC_STRONG(NSMutableArray , selectedAreas);
_PROPERTY_NONATOMIC_STRONG(NSString , selectedAreasString);


@end

@implementation PolicySelectCItyAreaView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self addSubview:self.cityTableView];
    [self addSubview:self.areaTableView];
    
    [self addSubview:self.resetButton];
    [self addSubview:self.confirmButton];
    
    self.selectedAreas = [[NSMutableArray alloc] init];
    
    //默认选全部
    self.selectedAreasString = @"";
    
//    UILabel *cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_WIDTH__/2, 27.5)];
//    [cityLabel setTextAlignment:NSTextAlignmentCenter];
//    [cityLabel setBackgroundColor:ColorWithHex(0xf4f4f4, 1.0)];
//    [cityLabel setFont:[UIFont systemFontOfSize:11]];
//    [cityLabel setTextColor:ColorWithHex(0x8b8b8b, 1.0)];
//    [cityLabel setText:@"可选城市"];
//    
//    UILabel *areaLabel = [[UILabel alloc] initWithFrame:CGRectMake(__SCREEN_WIDTH__/2, 0, __SCREEN_WIDTH__/2, 27.5)];
//    [areaLabel setTextAlignment:NSTextAlignmentCenter];
//    [areaLabel setBackgroundColor:ColorWithHex(0xf4f4f4, 1.0)];
//    [areaLabel setFont:[UIFont systemFontOfSize:11]];
//    [areaLabel setTextColor:ColorWithHex(0x8b8b8b, 1.0)];
//    [areaLabel setText:@"可选区"];
//    [self addSubview:cityLabel];
//    [self addSubview:areaLabel];
    
    return self;
}

- (UITableView *)cityTableView {
    if (!_cityTableView) {
        _cityTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_WIDTH__* 250 / 750, self.frame.size.height - 54)];
        [_cityTableView setBackgroundColor:ColorWithHex(0xefeff4, 1.0)];
        [_cityTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _cityTableView.delegate = self;
        _cityTableView.dataSource = self;
        
        _cityTableView.estimatedRowHeight = 0;
        _cityTableView.estimatedSectionHeaderHeight = 0;
        _cityTableView.estimatedSectionFooterHeight = 0;
    }
    return _cityTableView;
}

- (UITableView *)areaTableView {
    if (!_areaTableView) {
        _areaTableView = [[UITableView alloc] initWithFrame:CGRectMake(__SCREEN_WIDTH__* 250 / 750, 0, __SCREEN_WIDTH__* 500 / 750, self.frame.size.height - 54)];
        [_areaTableView setBackgroundColor:ColorWithHex(0xefeff4, 1.0)];
        [_areaTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _areaTableView.delegate = self;
        _areaTableView.dataSource = self;
        
        _areaTableView.estimatedRowHeight = 0;
        _areaTableView.estimatedSectionHeaderHeight = 0;
        _areaTableView.estimatedSectionFooterHeight = 0;
    }
    return _areaTableView;
}

- (UIButton *)resetButton {
    if (!_resetButton) {
        _resetButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 54, __SCREEN_WIDTH__/2, 54)];
        [_resetButton setTitle:@"重置" forState:UIControlStateNormal];
        [_resetButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [_resetButton setTitleColor:ColorWithHex(0x302f35, 0.35) forState:UIControlStateNormal];
        [_resetButton addTarget:self action:@selector(resetAction:) forControlEvents:UIControlEventTouchUpInside];
        [_resetButton setBackgroundColor:ColorWithHex(0xffffff, 1.0)];
    }
    return _resetButton;
}

- (IBAction)resetAction:(id)sender {
    self.selectedCity = [self.cityList firstObject];
    [self.selectedAreas removeAllObjects];
    self.selectedAreasString = @"";
    
    [self.cityTableView reloadData];
    [self.areaTableView reloadData];
}

- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(__SCREEN_WIDTH__ / 2, self.frame.size.height - 54, __SCREEN_WIDTH__/2, 54)];
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [_confirmButton setTitleColor:ColorWithHex(0xfefefe, 1.0) forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
        [_confirmButton setBackgroundColor:ColorWithHex(0x00c88c, 1.0)];
    }
    return _confirmButton;
}

- (IBAction)confirmAction:(id)sender {
    if (self.onSelectedAreaBlock) {
        self.onSelectedAreaBlock(self.selectedCity,self.selectedAreas,self.selectedAreasString);
    }
}

- (void)onSetCityList:(NSArray *)cityList {
    self.cityList = cityList;
    if (cityList.count > 0) {
        CityAreaModel *c_model = [cityList objectAtIndex:0];
        self.areaList = c_model.areaList;
        self.selectedCity = c_model;
    }
    
    [self.cityTableView reloadData];
    [self.areaTableView reloadData];
}

#pragma mark - UITableViewDelegate && UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([tableView isEqual:self.cityTableView]) {
        return 1;
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([tableView isEqual:self.cityTableView]) {
        return [self.cityList count];
    } else {
        if ([self.areaList count] == 0) {
            return 1;
        } else {
            return [self.areaList count] + 1;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"SelectCityAndAreaCell";
    SelectCityAndAreaCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SelectCityAndAreaCell" owner:nil options:nil] lastObject];
    }

    if ([tableView isEqual:self.cityTableView]) {
        CityAreaModel *c_model = [self.cityList objectAtIndex:[indexPath row]];
        [cell.nameLabel setText:c_model.cityName];
        if ([c_model isEqual:self.selectedCity]) {
            [cell.nameLabel setTextColor:ColorWithHex(0x00c88c, 1.0)];
        }
        
        return cell;
    } else {
        if ([indexPath row] == 0) {
            [cell.nameLabel setText:@"全部"];
            if ([self.selectedAreasString isEqualToString:@""]) {
                [cell.nameLabel setTextColor:ColorWithHex(0x00c88c, 1.0)];
                [cell.chooseImageView setHidden:NO];
            }
        } else {
            AreaModel *a_model = [self.areaList objectAtIndex:([indexPath row] - 1)];
            [cell.nameLabel setText:a_model.areaName];
            for (AreaModel *selectModel in self.selectedAreas) {
                if ([a_model isEqual:selectModel]) {
                    [cell.nameLabel setTextColor:ColorWithHex(0x00c88c, 1.0)];
                    [cell.chooseImageView setHidden:NO];
                }
            }
        }
        return cell;
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.cityTableView]) {
        CityAreaModel *c_model = [self.cityList objectAtIndex:[indexPath row]];
        self.areaList = c_model.areaList;
        self.selectedCity = c_model;
        
        [self.selectedAreas removeAllObjects];
        //拼接回调字符串，接口用
        self.selectedAreasString = @"";
        
        [self.areaTableView reloadData];
        [self.cityTableView reloadData];
    } else {
        if ([indexPath row] == 0) {
            [self.selectedAreas removeAllObjects];
            //拼接回调字符串，接口用
            self.selectedAreasString = @"";
        } else {
            AreaModel *a_model = [self.areaList objectAtIndex:[indexPath row] - 1];
            
            BOOL shouldAdd = YES;
            for (AreaModel *model in self.selectedAreas) {
                if ([model isEqual:a_model]) {
                    shouldAdd = NO;
                }
            }
            
            if (shouldAdd == YES) {
                [self.selectedAreas addObject:a_model];
            } else {
                [self.selectedAreas removeObject:a_model];
            }
            
            if (self.shoulChooseForOnlyOne) {
                [self.selectedAreas removeAllObjects];
                [self.selectedAreas addObject:a_model];
            }
            
            //拼接回调字符串，接口用
            NSMutableString *string = [[NSMutableString alloc] init];
            for (AreaModel *selModel in self.selectedAreas) {
                if (string.length == 0) {
                    [string appendString:selModel.areaId];
                } else {
                    [string appendString:@","];
                    [string appendString:selModel.areaId];
                }
            }
            
            self.selectedAreasString = string;
        }
        
        [self.areaTableView reloadData];
    }
}

@end

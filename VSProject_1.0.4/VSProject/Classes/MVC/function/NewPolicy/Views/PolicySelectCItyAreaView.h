//
//  PolicySelectCItyAreaView.h
//  VSProject
//
//  Created by apple on 11/8/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityAreaModel.h"
#import "AreaModel.h"

typedef void(^OnSelectedAreaBlock)(CityAreaModel *cityAreaModel,NSMutableArray *selectedAreas,NSString *selectedAreasString);

@interface PolicySelectCItyAreaView : UIView <UITableViewDelegate,UITableViewDataSource>

_PROPERTY_NONATOMIC_STRONG(UITableView, cityTableView);
_PROPERTY_NONATOMIC_STRONG(UITableView, areaTableView);

_PROPERTY_NONATOMIC_STRONG(UIButton, resetButton);
_PROPERTY_NONATOMIC_STRONG(UIButton, confirmButton);

@property (nonatomic, strong) OnSelectedAreaBlock onSelectedAreaBlock;

- (void)onSetCityList:(NSArray *)cityList;

@end

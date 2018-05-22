//
//  VSLeftIconTitleCell.h
//  VSProject
//
//  Created by user on 15/2/27.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseTableViewCell.h"

@interface VSIconTitleData : VSBaseDataModel

_PROPERTY_NONATOMIC_STRONG(NSString, vm_imageName);

_PROPERTY_NONATOMIC_STRONG(NSString, vm_titleText);

- (instancetype)initWithImageName:(NSString*)imageName titleText:(NSString*)title;

@end

@interface VSLeftIconTitleCell : VSBaseTableViewCell

@end

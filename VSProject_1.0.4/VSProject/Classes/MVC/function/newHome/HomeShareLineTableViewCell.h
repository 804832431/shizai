//
//  HomeShareLineTableViewCell.h
//  VSProject
//
//  Created by apple on 12/28/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeShareLineTableViewCell : UITableViewCell

@property (nonatomic,strong) NSArray *shareLineList;

@property (nonatomic,copy) void (^shareLineClickBlock)(id ad);

@end

//
//  ApplicationVisitModel.h
//  VSProject
//
//  Created by certus on 16/3/15.
//  Copyright © 2016年 user. All rights reserved.
//

#import "JSONModel.h"
#import "RTXCAppModel.h"

@interface ApplicationVisitModel : JSONModel

@property(nonatomic,strong)RTXCAppModel <Optional>*application;

@property(nonatomic,strong)NSString <Optional>*allowVisit;

@end

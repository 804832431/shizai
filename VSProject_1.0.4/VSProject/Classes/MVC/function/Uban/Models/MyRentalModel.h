//
//  MyRentalModel.h
//  VSProject
//
//  Created by certus on 16/4/14.
//  Copyright © 2016年 user. All rights reserved.
//

#import "JSONModel.h"
#import "RentalModel.h"

@interface MyRentalModel : JSONModel

@property(nonatomic,strong)NSNumber <Optional>*hasUnread;
@property(nonatomic,strong)RentalModel <Optional>*ubanRental;

@end

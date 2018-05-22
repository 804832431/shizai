//
//  AdressResponseModel.m
//  VSProject
//
//  Created by certus on 15/11/9.
//  Copyright © 2015年 user. All rights reserved.
//

#import "AdressResponseModel.h"

@implementation AdressResponseModel

+(JSONKeyMapper *)keyMapper {

    return [[JSONKeyMapper alloc]initWithDictionary:@{@"postalAddresses.contactMechId":@"contactMechId",
                                                     @"postalAddresses.recipient":@"recipient",
                                                     @"postalAddresses.contactNumber":@"contactNumber",
                                                     @"postalAddresses.address":@"address",
                                                     @"postalAddresses.zipCode":@"zipCode",
                                                     @"postalAddresses.isDefault":@"isDefault",
                                                     @"postalAddresses.partyId":@"partyId"
                                                     }];
}
@end

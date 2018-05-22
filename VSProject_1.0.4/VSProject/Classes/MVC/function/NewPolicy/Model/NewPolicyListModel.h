//
//  NewPolicyListModel.h
//  VSProject
//
//  Created by apple on 11/4/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "VSBaseNeedSaveDataModel.h"
#import "NewPolicyModel.h"

@interface NewPolicyListModel : VSBaseNeedSaveDataModel

@property (nonatomic,copy)NSString <Optional>*count;
@property (nonatomic,copy)NSString <Optional>*nextPage;
@property (nonatomic,strong)NSArray <NewPolicyModel *>*policyList;

@end

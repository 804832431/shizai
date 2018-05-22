//
//  ServiceModel.h
//  VSProject
//
//  Created by apple on 12/30/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "VSBaseDataModel.h"
#import "BidProject.h"
#import "NewPolicyModel.h"
#import "NewActivityModel.h"
#import "EnterpriseModel.h"
#import "SpaceListModel.h"

@interface ServiceModel : VSBaseDataModel

@property (nonatomic,strong)NSString <Optional>*type;
@property (nonatomic,strong)NSString <Optional>*title;
@property (nonatomic,strong)NSString <Optional>*image;
@property (nonatomic,strong)NSString <Optional>*name;
@property (nonatomic,strong)NSString <Optional>*newsDetail;
@property (nonatomic,strong)NSString <Optional>*productDetail;
@property (nonatomic,strong)NSString <Optional>*spaceDetail;
@property (nonatomic,strong)BidProject <Optional>*bidProject;
@property (nonatomic,strong)NewPolicyModel <Optional>*policy;
@property (nonatomic,strong)NewActivityModel <Optional>*activity;
@property (nonatomic,strong)EnterpriseModel <Optional>*enterprise;
@property (nonatomic,strong)SpaceListModel <Optional>*space;

@end

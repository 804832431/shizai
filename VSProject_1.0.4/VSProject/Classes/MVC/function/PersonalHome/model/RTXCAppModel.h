//
//  RTXCAppModel.h
//  VSProject
//
//  Created by certus on 15/11/20.
//  Copyright © 2015年 user. All rights reserved.
//

#import "VSBaseDataModel.h"

@interface RTXCAppModel : VSBaseDataModel

@property(nonatomic,strong)NSString <Optional>*adaptVersion;
@property(nonatomic,strong)NSString <Optional>*appIcon;
@property(nonatomic,strong)NSString <Optional>*appIconKey;
@property(nonatomic,strong)NSString <Optional>*appIntroduction;
@property(nonatomic,strong)NSString <Optional>*appName;
@property(nonatomic,strong)NSString <Optional>*catalogId;
@property(nonatomic,strong)NSString <Optional>*id;
@property(nonatomic,strong)NSString <Optional>*orderType;
@property(nonatomic,strong)NSString <Optional>*protocol;
@property(nonatomic,strong)NSString <Optional>*status;
@property(nonatomic,strong)NSString <Optional>*visitType;
@property(nonatomic,strong)NSString <Optional>*visitkeyword;
@property(nonatomic,strong)NSString <Optional>*timeNode;
@property(nonatomic,strong)NSString <Optional>*organizationId;

@end

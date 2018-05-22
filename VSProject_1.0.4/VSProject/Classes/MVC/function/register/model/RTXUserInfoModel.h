//
//  RTXUserInfoModel.h
//  VSProject
//
//  Created by certus on 15/11/18.
//  Copyright © 2015年 user. All rights reserved.
//

#import "VSBaseDataModel.h"
#import "Bidder.h"

@interface RTXUserInfoModel : VSBaseNeedSaveDataModel

@property(nonatomic,strong)NSString <Optional>*companyAddress;

@property(nonatomic,strong)NSString <Optional>*companyName;

@property(nonatomic,strong)NSString <Optional>*positionInCompany;

@property(nonatomic,strong)NSString <Optional>*username;

@property(nonatomic,strong)NSString <Optional>*password;

#pragma mark V1.4

@property(nonatomic,strong)NSString <Optional>*partyId;

@property(nonatomic,strong)NSString <Optional>*realName;

@property(nonatomic,strong)NSString <Optional>*gender;

@property(nonatomic,strong)NSString <Optional>*nickName;

@property(nonatomic,strong)NSString <Optional>*headIconPath;

@property(nonatomic,strong)NSString <Optional>*isRelatedCompany;

@property(nonatomic,strong)NSString <Optional>*companyId;

@property(nonatomic,strong)NSString <Optional>*roleInCompany;

/*
 认证状态:
 UNAPPLY：未申请过
 UNRESOLVED：待认证，
 PASS：已通过，
 REJECT：已拒绝
 */
@property (nonatomic,strong) NSString <Optional>* authStatus;

//认证过的企业信息
@property (nonatomic,strong)Bidder<Optional> *bidder;

@end

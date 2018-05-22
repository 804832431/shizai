//
//  NAgentModel.h
//  VSProject
//
//  Created by certus on 16/4/15.
//  Copyright © 2016年 user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@interface NAgentModel : JSONModel

@property(nonatomic,strong)NSString <Optional>*appId;

@property(nonatomic,strong)NSString <Optional>*appJson;

@property(nonatomic,strong)NSString <Optional>*appState;

@property(nonatomic,strong)NSString <Optional>*confirmTime;

@property(nonatomic,strong)NSString <Optional>*createTime;

@property(nonatomic,strong)NSString <Optional>*id;

@property(nonatomic,strong)NSString <Optional>*partyId;

@property(nonatomic,strong)NSString <Optional>*appName;

@end

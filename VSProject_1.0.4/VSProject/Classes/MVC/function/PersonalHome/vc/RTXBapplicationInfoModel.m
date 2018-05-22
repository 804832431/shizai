//
//  RTXBapplicationInfoModel.m
//  VSProject
//
//  Created by XuLiang on 15/11/18.
//  Copyright © 2015年 user. All rights reserved.
//

#import "RTXBapplicationInfoModel.h"
/*
 appIcon
 appIconKey
 appName
 catalogId
 m_id
 orderType
 protocol
 visitType
 visitkeyword
 */
@implementation RTXBapplicationInfoModel
-(instancetype)initwithDic:(NSDictionary *)dic{
    
    self.appIcon     = [dic objectForKey:@"appIcon"];
    self.appIconKey     = [dic objectForKey:@"appIconKey"];
    self.appIntroduction     = [dic objectForKey:@"appIntroduction"];
    self.appName     = [dic objectForKey:@"appName"];
    self.catalogId     = [dic objectForKey:@"catalogId"];
    self.m_id     = [dic objectForKey:@"id"];
    self.orderType     = [dic objectForKey:@"orderType"];
    self.protocol     = [dic objectForKey:@"protocol"];
    self.visitType     = [dic objectForKey:@"visitType"];
    self.visitkeyword     = [dic objectForKey:@"visitkeyword"];
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone {

    RTXBapplicationInfoModel *copy = [[[self class] allocWithZone:zone]init];
    copy.appIcon = [self.appIcon copyWithZone:zone];
    copy.appIconKey = [self.appIconKey copyWithZone:zone];
    copy.appIntroduction = [self.appIntroduction copyWithZone:zone];
    copy.appName = [self.appName copyWithZone:zone];
    copy.catalogId = [self.catalogId copyWithZone:zone];
    copy.m_id = [self.m_id copyWithZone:zone];
    copy.orderType = [self.orderType copyWithZone:zone];
    copy.protocol = [self.protocol copyWithZone:zone];
    copy.visitType = [self.visitType copyWithZone:zone];
    copy.visitkeyword = [self.visitkeyword copyWithZone:zone];

    return copy;
}
@end

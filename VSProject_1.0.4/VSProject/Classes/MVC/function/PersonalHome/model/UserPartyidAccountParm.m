//
//  UserPartyidAccountParm.m
//  VSProject
//
//  Created by XuLiang on 15/11/5.
//  Copyright © 2015年 user. All rights reserved.
//

#import "UserPartyidAccountParm.h"

@implementation UserPartyidAccountParm

//参数对象序列化成字典对象
- (NSDictionary*)vp_parmSerialize{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:self.partyid forKey:@"partyId"];
    return dic;
}
@end

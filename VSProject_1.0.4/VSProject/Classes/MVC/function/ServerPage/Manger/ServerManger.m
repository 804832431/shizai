//
//  ServerManger.m
//  VSProject
//
//  Created by pch_tiger on 16/12/24.
//  Copyright © 2016年 user. All rights reserved.
//

#import "ServerManger.h"
#import "RTXCAppModel.h"

@implementation ServerManger

- (void)getServiceProduct:(NSDictionary *)paraDic success:(void (^) (NSDictionary *responseObj))sResponse failure:(void (^) (NSError *error))fResponse {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    [dic setObject:partyId forKey:@"partyId"];
    [dic setObject:@"-1" forKey:@"page"];
    [dic setObject:@"-1" forKey:@"row"];
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.home/get-service-product/version/1.5.0"];
    [RequestService requesturl:url paraDic:dic success:^(NSDictionary *responseObj) {
        
        NSMutableArray *productList = [responseObj mutableArrayValueForKey:@"productList"];
        if (productList == nil) {
            productList = [NSMutableArray array];
        }
        NSString *nextPage = [responseObj objectForKey:@"nextPage"];
        NSString *totalCount = [responseObj objectForKey:@"totalCount"];
        NSDictionary *resDic = [NSDictionary dictionaryWithObjectsAndKeys:productList, @"productList", nextPage, @"nextPage", totalCount, @"totalCount", nil];
        sResponse(resDic);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
}

- (void)getServiceAppArea:(NSDictionary *)paraDic success:(void (^) (NSDictionary *responseObj))sResponse failure:(void (^) (NSError *error))fResponse {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"serviceAppArea" forKey:@"type"];
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.application/get-home-applicaton/version/1.5.0"];
    [RequestService requesturl:url paraDic:dic success:^(NSDictionary *responseObj) {
        
        NSMutableArray *serverAppList = [responseObj objectForKey:@"applications"];
        if (serverAppList == nil) {
            serverAppList = [NSMutableArray array];
        }
        NSDictionary *resDic = [NSDictionary dictionaryWithObjectsAndKeys:serverAppList, @"appList",  nil];
        sResponse(resDic);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
}

@end

//
//  CenterManger.m
//  VSProject
//
//  Created by certus on 15/11/4.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CenterManger.h"

@implementation CenterManger

//请求用户信息
- (void)requestCustomerInfo:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse{
    
    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId;
    paraDic = [NSDictionary dictionaryWithObjectsAndKeys:partyId,@"partyId", nil];

    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.account/get-customer-info"];
    [RequestService requesturl:url paraDic:paraDic success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}

//请求用户汇总信息
- (void)requestCustomerMainData:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse{
    
    NSString *username = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.username;
    paraDic = [NSDictionary dictionaryWithObjectsAndKeys:username,@"userLoginId", nil];
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.order/get-customer-main-data"];
    [RequestService requesturl:url paraDic:paraDic success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}

//更改用户信息
- (void)updateCustomerInfo:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse{
    
    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId;

    NSMutableDictionary *para = [NSMutableDictionary dictionaryWithDictionary:paraDic];
    [para setObject:partyId forKey:@"partyId"];
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.account/update-customer-info"];
    [RequestService requesturl:url paraDic:para success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}

//更改用户头像
- (void)updateHeaderIcon:(NSDictionary *)paraDic dataArray:(NSArray *)dataArray success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse{
    
    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId;
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setObject:partyId forKey:@"partyId"];
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.account/update-customer-head-icon"];
    [RequestService uploadurl:url dataArray:dataArray fileType:@"jpg" paraDic:para success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);

    } progess:^(float progess) {
        
    }];
}

- (void)updateSpaceIcon:(NSDictionary *)paraDic dataArray:(NSArray *)dataArray success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse{
    
    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId;
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setObject:partyId forKey:@"partyId"];
    [para setObject:@"space" forKey:@"imageType"];
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.home/upload-image/version/1.5.1"];
    [RequestService uploadurl:url dataArray:dataArray fileType:@"jpg" paraDic:para success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);
        
    } progess:^(float progess) {
        
    }];
}

//获取标签列表
- (void)getTagsList:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *type = [paraDic objectForKey:@"type"];
    if (!type) {
        return;
    }
    
    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    [dic setObject:partyId forKey:@"partyId"];
    [dic setObject:type forKey:@"type"];
    [dic setObject:@"-1" forKey:@"page"];
    [dic setObject:@"-1" forKey:@"row"];
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.label/get-label-list/version/1.5.0"];
    [RequestService requesturl:url paraDic:dic success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
}

//用户打标
- (void)updateMakeTags:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse {
    
    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    
    NSMutableDictionary *para = [NSMutableDictionary dictionaryWithDictionary:paraDic];
    [para setObject:partyId forKey:@"partyId"];
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.label/make-label/version/1.5.0"];
    [RequestService requesturl:url paraDic:para success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
}

@end

//
//  AdressManger.m
//  VSProject
//
//  Created by certus on 15/11/9.
//  Copyright © 2015年 user. All rights reserved.
//

#import "AdressManger.h"
#import "AdressParaModel.h"

@implementation AdressManger

//请求用户收货地址
- (void)requestReceivingAddressed:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse {

    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.postaladdress/get-customer-postal-address"];

    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    
    paraDic = [NSDictionary dictionaryWithObjectsAndKeys:partyId,@"partyId", nil];
    [RequestService requesturl:url paraDic:paraDic success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);

        //存默认地址
        NSArray *postalAddresses = [responseObj objectForKey:@"postalAddresses"];
        for (NSDictionary *dic in postalAddresses) {
            NSString *isDefault = [dic objectForKey:@"isDefault"];
            if ([isDefault isEqualToString:@"Y"]) {
                AdressModel *admodel = [[AdressModel alloc]initWithDictionary:dic error:nil];
                [VSUserLogicManager shareInstance].userDataInfo.vm_defaultAdressInfo = admodel;
                [[VSUserLogicManager shareInstance].userDataInfo vp_saveToLocal];
                return;
            }
        }
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];

}

//请求增加用户收货地址
- (void)requestAddAddress:(AdressModel *)paraModel success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse {
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.postaladdress/create-customer-postal-address"];
    
    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    paraModel.partyId = partyId;
    
    NSDictionary *paraDic = [NSDictionary dictionaryWithObjectsAndKeys:paraModel.address,@"address",paraModel.zipCode,@"zipCode",paraModel.partyId,@"partyId",paraModel.recipient,@"recipient",paraModel.contactNumber,@"contactNumber", nil];
    [RequestService requesturl:url paraContentDic:paraDic success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];

}

//请求删除用户收货地址
- (void)requestDeleteAddress:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse {
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.postaladdress/delete-customer-postal-address"];
    
    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:paraDic];
    [dic setObject:partyId forKey:@"partyId"];

    [RequestService requesturl:url paraDic:dic success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}

//请求更新用户收货地址
- (void)requestUpdateAddress:(AdressModel *)paraModel success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse {
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.postaladdress/update-customer-postal-address"];
    
    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    paraModel.partyId = partyId;

    NSDictionary *paraDic = [NSDictionary dictionaryWithObjectsAndKeys:paraModel.address,@"address",paraModel.zipCode,@"zipCode",paraModel.partyId,@"partyId",paraModel.recipient,@"recipient",paraModel.contactNumber,@"contactNumber",paraModel.contactMechId,@"contactMechId", nil];

    [RequestService requesturl:url paraContentDic:paraDic success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}

//请求置成默认地址
- (void)requestSetDefaultAddress:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse {
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.postaladdress/config-as-default-postal-address"];
    
    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:partyId forKey:@"partyId"];
    [dic setObject:[paraDic objectForKey:@"contactMechId"] forKey:@"contactMechId"];

    [RequestService requesturl:url paraDic:dic success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}

@end

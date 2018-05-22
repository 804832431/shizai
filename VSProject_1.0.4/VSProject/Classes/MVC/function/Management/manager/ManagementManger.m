//
//  ManagementManger.m
//  VSProject
//
//  Created by certus on 16/3/10.
//  Copyright © 2016年 user. All rights reserved.
//

#import "ManagementManger.h"
#import "RTXBapplicationInfoModel.h"
#import "EmployeeModel.h"

@implementation ManagementManger


//请求B端页面信息接口
- (void)requestBusinessApplications:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse{
    
    NSMutableDictionary *dic1=[NSMutableDictionary dictionary];
    NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    NSString *organizationId =[VSUserLogicManager shareInstance].userDataInfo.vm_projectInfo.organizationId;
    
    if ([paraDic objectForKey:@"organizationId"]) {
        organizationId = [paraDic objectForKey:@"organizationId"];
    }
    
    
    [dic1 setObject:partyId forKey:@"partyId"];
    [dic1 setObject:organizationId.length > 0 ? organizationId:@"0" forKey:@"organizationId"];
    [dic1 setObject:@"-1" forKey:@"page"];
    [dic1 setObject:@"-1" forKey:@"row"];
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.application/get-applications-for-b"];
    [RequestService requesturl:url paraDic:dic1 success:^(NSDictionary *responseObj) {
        
        RTXBapplicationsModel *dataModel = [[RTXBapplicationsModel alloc]initwithDic:responseObj];
        NSArray *resapplications = dataModel.applications;
        NSMutableDictionary *resDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:resapplications,@"layout", nil];
        
        NSDictionary *companyInfo = [responseObj objectForKey:@"companyInfo"];
        if (companyInfo && [companyInfo isKindOfClass:[NSDictionary class]] && companyInfo.count > 0) {
            [resDic setObject:companyInfo forKey:@"companyInfo"];
        }
        
        NSDictionary *relationship = [responseObj objectForKey:@"relationship"];
        if (relationship && [relationship isKindOfClass:[NSDictionary class]] && relationship.count > 0) {
            NSString *role = [relationship objectForKey:@"role"];
            [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.roleInCompany = role;
            [[VSUserLogicManager shareInstance].userDataInfo vp_saveToLocal];
            [resDic setObject:relationship forKey:@"relationship"];
        }else {
            [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.roleInCompany = nil;
            [[VSUserLogicManager shareInstance].userDataInfo vp_saveToLocal];
        }
        
        
        sResponse(resDic);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}

//校验客户访问B端应用权限
- (void)requestCheckPermissonToBApplication:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse{
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.company/check-permisson-to-b-application"];
    [RequestService requesturl:url paraDic:paraDic success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}

//获取公司信息接口
- (void)requestCompanyInfo:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse{
    
    NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    
    NSMutableDictionary *dic1=[NSMutableDictionary dictionary];
    [dic1 setObject:partyId forKey:@"partyId"];
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.company/get-company-info"];
    [RequestService requesturl:url paraDic:dic1 success:^(NSDictionary *responseObj) {
        
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}

//获取公司员工信息接口
- (void)requestCompanyEmployee:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse{
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.company/get-company-employee"];
    [RequestService requesturl:url paraDic:paraDic success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}

//邀请员工加入企业
- (void)requestInviteEmployee:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse{
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.company/invite-employee"];
    [RequestService requesturl:url paraDic:paraDic success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}

//删除企业员工
- (void)requestRemoveEmployee:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse{
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.company/remove-employee"];
    [RequestService requesturl:url paraDic:paraDic success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}


//获取员工信息
- (void)requestGetEmployeeInfo:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse{
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.company/get-employee-info"];
    [RequestService requesturl:url paraDic:paraDic success:^(NSDictionary *responseObj) {
        
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}

//更新员工信息
- (void)requestUpdateEmployeeInfo:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse{
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.company/update-employee-info"];
    [RequestService requesturl:url paraContentDic:paraDic success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}

//更公司信息
- (void)requestUpdateCompanyInfo:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse{
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.company/update-company-info"];
    [RequestService requesturl:url paraDic:paraDic success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}

//注册企业
- (void)requestRegisterCompanyInfo:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse{
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.company/register-company"];
    [RequestService requesturl:url paraContentDic:paraDic success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}
@end

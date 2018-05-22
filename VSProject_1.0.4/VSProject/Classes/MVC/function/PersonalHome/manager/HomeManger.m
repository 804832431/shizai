//
//  HomeManger.m
//  VSProject
//
//  Created by certus on 15/11/11.
//  Copyright © 2015年 user. All rights reserved.
//

#import "HomeManger.h"
#import "RTXCAppModel.h"


@implementation HomeManger

#pragma mark - < V1.4 interface

- (void)saveProjectInfo:(NSDictionary *)responseObj {
    
    NSDictionary *selectedProject = [responseObj objectForKey:@"selectedProject"];
    [VSUserLogicManager shareInstance].userDataInfo.vm_projectInfo = [[RTXProjectInfoModel alloc]initWithDictionary:selectedProject error:nil];
    
    NSString *dayImage = [responseObj objectForKey:@"miniDayBackgroudImageURL"];
    NSString *nightImage = [responseObj objectForKey:@"miniNightBackgroudImageURL"];
    [VSUserLogicManager shareInstance].userDataInfo.vm_projectImg_day = dayImage;
    [VSUserLogicManager shareInstance].userDataInfo.vm_projectImg_night = nightImage;
    
}
//请求Customer布局
- (void)requestCustomerLayout:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse{
    
    NSString *lng=[[NSUserDefaults standardUserDefaults] objectForKey:@"longitude"]?:@"0";
    NSString *lat=[[NSUserDefaults standardUserDefaults] objectForKey:@"latitude"]?:@"0";
    NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    NSString *organizationId=[VSUserLogicManager shareInstance].userDataInfo.vm_projectInfo.organizationId?:@"0";
    if (organizationId && ![organizationId isEmptyString] && organizationId.intValue != 0) {
        lng = @"";
        lat = @"";
    }
    NSMutableDictionary *dic1=[NSMutableDictionary dictionary];
    [dic1 setObject:lng forKey:@"longtitude"];
    [dic1 setObject:lat forKey:@"latitude"];
    [dic1 setObject:partyId forKey:@"partyId"];
    [dic1 setObject:organizationId forKey:@"organizationId"];
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.customerlayout/get-customer-c-layout"];
    [RequestService requesturl:url paraDic:dic1 success:^(NSDictionary *responseObj) {
        
        [self saveProjectInfo:responseObj];
        NSString * layout = [responseObj objectForKey:@"layout"];
        NSDictionary* selectedProject = [responseObj objectForKey:@"selectedProject"];
        
        NSData *layoutdata = [layout dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:layoutdata options:NSJSONReadingAllowFragments error:nil];
        
        NSArray *applications = [dic objectForKey:@"layout"];
        NSMutableArray *resapplications = [NSMutableArray array];
        
        if ([applications isKindOfClass:[NSArray class]]) {
            for (NSDictionary *appdic in applications) {
                NSError *error = nil;
                RTXCAppModel *model = [[RTXCAppModel alloc]initWithDictionary:appdic error:&error];
                NSLog(@"error==%@",error);
                [resapplications addObject:model];
            }
        }
        NSDictionary *resDic = [NSDictionary dictionaryWithObjectsAndKeys:resapplications,@"layout",selectedProject,@"selectedProject", nil];
        
        sResponse(resDic);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}

//请求可选择应用
- (void)requestCustomerConfig:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse{
    
    NSString *organizationId=[VSUserLogicManager shareInstance].userDataInfo.vm_projectInfo.organizationId?:@"0";
    
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setObject:@"-1" forKey:@"page"];
    [dic setObject:@"-1" forKey:@"row"];
    [dic setObject:organizationId forKey:@"organizationId"];
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.application/get-applications-in-config"];
    [RequestService requesturl:url paraDic:dic success:^(NSDictionary *responseObj) {
        
        NSArray *applications = [responseObj objectForKey:@"applications"];
        NSMutableArray *resapplications = [NSMutableArray array];
        
        if ([applications isKindOfClass:[NSArray class]]) {
            for (NSDictionary *appdic in applications) {
                NSError *error = nil;
                RTXCAppModel *model = [[RTXCAppModel alloc]initWithDictionary:appdic error:&error];
                NSLog(@"error==%@",error);
                [resapplications addObject:model];
            }
        }
        NSDictionary *resDic = [NSDictionary dictionaryWithObjectsAndKeys:resapplications,@"applications", nil];
        sResponse(resDic);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}

//更新首页布局
- (void)updateCustomerLayout:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse{
    
    NSArray *appLayout = [paraDic objectForKey:@"layout"];
    NSMutableArray *array = [NSMutableArray array];
    for (RTXCAppModel *model in appLayout) {
        NSDictionary *dic = [model toDictionary];
        [array addObject:dic];
    }
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.customerlayout/update-customer-c-layout"];
    //
    NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    NSString *organizationId=[VSUserLogicManager shareInstance].userDataInfo.vm_projectInfo.organizationId?:@"0";
    NSString *layout = [RequestService DataTOjsonString:[NSDictionary dictionaryWithObjectsAndKeys:array,@"layout", nil]];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:layout,@"layout",partyId,@"partyId",organizationId,@"organizationId", nil];
    [RequestService requesturl:url paraContentDic:dic success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}

//请求城市
- (void)requestCitysAndProgects:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse{
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.customerlayout/get-projects-for-c"];
    [RequestService requesturl:url paraDic:paraDic success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}

//请求天气
- (void)requestWeather:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse{
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.customerlayout/get-project-weather"];
    
    NSString *organizationId=[VSUserLogicManager shareInstance].userDataInfo.vm_projectInfo.organizationId?:@"0";
    NSString *time = @"";
    if ([NSDate nowIsNight]) {//晚上
        time = @"night";
    }else {//白天
        time = @"day";
    }
    
    paraDic = @{@"organizationId":organizationId,@"time":time};
    
    [RequestService requesturl:url paraDic:paraDic success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}

#pragma mark - V1.4

//请求C端页面信息接口
- (void)requestCustomerApplications:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse{
    
    NSString *lng=[[NSUserDefaults standardUserDefaults] objectForKey:@"longitude"]?:@"0";
    NSString *lat=[[NSUserDefaults standardUserDefaults] objectForKey:@"latitude"]?:@"0";
    NSString *organizationId=[VSUserLogicManager shareInstance].userDataInfo.vm_projectInfo.organizationId?:@"0";
    if (organizationId && ![organizationId isEmptyString] && organizationId.intValue != 0) {
        lng = @"";
        lat = @"";
    }
    NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    
    NSMutableDictionary *dic1=[NSMutableDictionary dictionary];
    [dic1 setObject:lng forKey:@"longtitude"];
    [dic1 setObject:lat forKey:@"latitude"];
    [dic1 setObject:organizationId forKey:@"organizationId"];
    [dic1 setObject:partyId forKey:@"partyId"];
    [dic1 setObject:@"-1" forKey:@"page"];
    [dic1 setObject:@"-1" forKey:@"row"];
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.application/get-applications-for-c/version/1.2.0"];
    [RequestService requesturl:url paraDic:dic1 success:^(NSDictionary *responseObj) {
        
        [self saveProjectInfo:responseObj];
        //项目信息
        
        
        RTXProjectInfoModel* projModel = [[RTXProjectInfoModel alloc]initWithDictionary:[responseObj objectForKey:@"targetOrganization"] error:nil];
        [VSUserLogicManager shareInstance].userDataInfo.vm_projectInfo = projModel;
        //房租租赁
        NSNumber *hasUnreadFWZL = [responseObj objectForKey:@"hasUnreadFWZL"];
        [VSUserLogicManager shareInstance].userDataInfo.vm_hasUnreadFWZL = hasUnreadFWZL.boolValue;
        //        [[VSUserLogicManager shareInstance].userDataInfo vp_saveToLocal];
        //应用
        NSArray *applications = [responseObj objectForKey:@"applications"];
        NSArray *resapplications = [RTXCAppModel arrayOfModelsFromDictionaries:applications];
        
        
        
        
        NSDictionary *resDic = [NSDictionary dictionaryWithObjectsAndKeys:resapplications,@"layout",projModel,@"selectedProject", nil];
        sResponse(resDic);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}



//校验客户B端访问权限
- (void)requestCheckPermissionToB:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse{
    
    NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    
    NSMutableDictionary *dic1=[NSMutableDictionary dictionary];
    [dic1 setObject:partyId forKey:@"partyId"];
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.company/check-permission-to-b"];
    [RequestService requesturl:url paraDic:dic1 success:^(NSDictionary *responseObj) {
        
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}

@end

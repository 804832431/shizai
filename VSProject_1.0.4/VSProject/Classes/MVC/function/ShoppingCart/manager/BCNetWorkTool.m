//
//  BCNetWorkTool.m
//  BeautyCat
//
//  Created by helloworld on 15-3-27.
//  Copyright (c) 2015年 chuangzhong. All rights reserved.
//

#import "BCNetWorkTool.h"


#define kNetWorkStatusChangedNotification @"kNetWorkStatusChangedNotification"

static AFHTTPRequestOperationManager *manager = nil;

@implementation BCNetWorkTool


//开始监听网络状态
+ (void)checkNetworkStatus
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNetWorkStatusChangedNotification object:nil userInfo:@{@"status":[NSNumber  numberWithInteger:status]}];
    }];
    
    [manager startMonitoring];
    
}




+ (AFHTTPRequestOperationManager *)createManager
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [AFHTTPRequestOperationManager manager];
        
        manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.requestSerializer.timeoutInterval = 30;
        manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",  nil];
        [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:USERNAME password:PASSWORD];
        
    });
    
    
    
    return manager;
}





//get方法调用网络访问方法
+ (void)executeGETNetworkWithParameter:(NSDictionary *)parameter andUrlIdentifier:(NSString *)urlIdentifier withSuccess:(SuccessCallBackBlock)successBlock orFail:(FailCallBackBlock)failBlock
{
    AFHTTPRequestOperationManager *manager = [self createManager];
    
    //    if ([urlIdentifier isEqualToString:@"/RUI-CustomerJSONWebService-portlet/weixin/pay"]) {
    //        
    //    }
    //
    
    urlIdentifier = [self replaceURLVersion:urlIdentifier];
    
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@",SERVER_IP,urlIdentifier];
    
    //微信支付特殊处理
    //    if ([urlIdentifier isEqualToString:@"/RUI-CustomerJSONWebService-portlet/weixin/pay"]) {
    //        
    //        NSRange range = [SERVER_IP rangeOfString:@"/api/jsonws"];
    //        NSString *host  =  [SERVER_IP substringToIndex:range.location];
    //        requestUrl =  [NSString stringWithFormat:@"%@%@",host,urlIdentifier];
    //    }
    
    requestUrl = [requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    
    if ([parameter isKindOfClass:[NSMutableDictionary class]]) {
        [(NSMutableDictionary *)parameter setObject:partyId forKey:@"visitPartyId"];
        
    }else{
        parameter = [NSMutableDictionary dictionaryWithDictionary:parameter];
        [(NSMutableDictionary *)parameter setObject:partyId forKey:@"visitPartyId"];
        
    }
    
    
    [manager GET:requestUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSString *resultCode = [dic objectForKey:@"resultCode"];
        NSString *errorMessage = [dic objectForKey:@"errorMessage"];
        NSLog(@"errorMessage=%@",errorMessage);
        NSLog(@"urlString=%@",requestUrl);
        
        if (resultCode && [resultCode isEqualToString:@"CODE-00000"]) {
            successBlock(dic);
        }else {
            if (errorMessage != nil) {
                NSError *error = [NSError errorWithDomain:errorMessage code:1 userInfo:nil];
                failBlock(error);
            }
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Fail: httpRequest: %@",operation.request);
        
        if (failBlock) {
            failBlock(error);
        }
        
    }];
    
}

+ (NSString*)replaceURLVersion:(NSString *)urlIdentifier{
    
    NSString *versionStr = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    NSArray *urlArr = [urlIdentifier componentsSeparatedByString:@"/"];
    
    NSMutableArray *mUrlArr = [NSMutableArray arrayWithArray:urlArr];
    
    for (NSInteger i = 0; i < mUrlArr.count; i++) {
        NSString *str = mUrlArr[i];
        if ([str isEqualToString:@"version"]) {
            NSInteger j = i + 1;
            if (j < mUrlArr.count && [mUrlArr[j] hasPrefix:@"1.2"]) {
                mUrlArr[j] = versionStr;
                break;
            }
        }
    }
    
    urlIdentifier = [mUrlArr componentsJoinedByString:@"/"];
    
    return urlIdentifier;
}



//post方法调用网络访问方法
+ (void)executePostNetworkWithParameter:(NSDictionary *)parameter andUrlIdentifier:(NSString *)urlIdentifier withSuccess:(SuccessCallBackBlock)successBlock orFail:(FailCallBackBlock)failBlock
{
    AFHTTPRequestOperationManager *manager = [self createManager];
    
    if (urlIdentifier.length > 0) {
        
        parameter = [NSMutableDictionary dictionaryWithDictionary:parameter];
        
    }
    
     urlIdentifier = [self replaceURLVersion:urlIdentifier];
    
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@",SERVER_IP,urlIdentifier];
    
    requestUrl = [requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    
    if ([parameter isKindOfClass:[NSMutableDictionary class]]) {
        [(NSMutableDictionary *)parameter setObject:partyId forKey:@"visit-party-id"];
        
    }else{
        parameter = [NSMutableDictionary dictionaryWithDictionary:parameter];
        [(NSMutableDictionary *)parameter setObject:partyId forKey:@"visit-party-id"];
        
    }
    
    [manager POST:requestUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *str = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        NSLog(@"httpRequest: %@",str);
        
        
        NSDictionary *dic = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSString *resultCode = [dic objectForKey:@"resultCode"];
        NSString *errorMessage = [dic objectForKey:@"errorMessage"];
        NSLog(@"errorMessage=%@",errorMessage);
        NSLog(@"urlString=%@",requestUrl);
        
        if (resultCode && [resultCode isEqualToString:@"CODE-00000"]) {
            successBlock(dic);
        }else {
            NSError *error = [NSError errorWithDomain:errorMessage code:1 userInfo:nil];
            failBlock(error);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Fail: httpRequest: %@",operation.request);
        
        if (failBlock) {
            failBlock(error);
        }
        
    }];
}

@end






























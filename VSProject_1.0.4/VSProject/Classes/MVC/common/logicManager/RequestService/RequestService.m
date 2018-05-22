//
//  RequestService.m
//  EmperorComing
//
//  Created by certus on 15/8/31.
//  Copyright (c) 2015年 certus. All rights reserved.
//

#import "RequestService.h"
#import "AFHTTPRequestOperationManager.h"


@implementation RequestService

//字典转json
+(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"字段转json失败！error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        //        jsonString = [jsonString stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    return jsonString;
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

//请求
+ (void)requesturl:(NSString *)urlString paraDic:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse{
    
    urlString = [self replaceURLVersion:urlString];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:USERNAME password:PASSWORD];
    manager.requestSerializer.timeoutInterval = 10.f;
    
    NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    
    if ([paraDic isKindOfClass:[NSMutableDictionary class]]) {
        [(NSMutableDictionary *)paraDic setObject:partyId forKey:@"visitPartyId"];
        
        
    }else{
        paraDic = [NSMutableDictionary dictionaryWithDictionary:paraDic];
        [(NSMutableDictionary *)paraDic setObject:partyId forKey:@"visitPartyId"];
        
    }
    
    [manager GET:urlString parameters:paraDic success:^(AFHTTPRequestOperation * manager, id responseobj) {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseobj];
        NSString *resultCode = [dic objectForKey:@"resultCode"];
        NSString *errorMessage = [dic objectForKey:@"errorMessage"];
        
        if (resultCode && ([resultCode isEqualToString:@"CODE-00000"]||[resultCode isEqualToString:@"SYSERM-10000"])) {
            sResponse(responseobj);
        }else {
            if (![errorMessage isEqual:[NSNull null]] && errorMessage) {
            }else {
                errorMessage = @"服务器错误";
            }
            NSError *error = [NSError errorWithDomain:errorMessage code:1 userInfo:nil];
            fResponse(error);
            
        }
        
    } failure:^(AFHTTPRequestOperation * manager, NSError * error) {
        
        NSString *domain = [error domain];
        if ([domain isEqual:[NSNull null]]) {
            error = [NSError errorWithDomain:@"请求出错，请检查网络" code:1 userInfo:nil];
        }else if (domain && [domain isKindOfClass:[NSString class]]) {
            error = [NSError errorWithDomain:@"请求出错，请检查网络" code:1 userInfo:nil];
        }
        fResponse(error);
        
    }];
    
}

//请求
+ (void)requesturl:(NSString *)urlString paraContentDic:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:USERNAME password:PASSWORD];
    manager.requestSerializer.timeoutInterval = 10.f;
    
    NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    
    if ([paraDic isKindOfClass:[NSMutableDictionary class]]) {
        [(NSMutableDictionary *)paraDic setObject:partyId forKey:@"visitPartyId"];
        
    }else{
        paraDic = [NSMutableDictionary dictionaryWithDictionary:paraDic];
        [(NSMutableDictionary *)paraDic setObject:partyId forKey:@"visitPartyId"];
        
    }
    
    //所有POST请求都是JSON格式 除了上传文件,content里面丢个json
    NSDictionary *contentDic = nil;
    if (paraDic && paraDic.count > 0) {
        NSString *jsonContent = [self DataTOjsonString:paraDic];
        contentDic = [NSDictionary dictionaryWithObjectsAndKeys:jsonContent,@"content", nil];
    }
    [manager POST:urlString parameters:contentDic success:^(AFHTTPRequestOperation *manager, id responseobj) {
        
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseobj];
        NSString *resultCode = [dic objectForKey:@"resultCode"];
        NSString *errorMessage = [dic objectForKey:@"errorMessage"];
        
        if (resultCode && [resultCode isEqualToString:@"CODE-00000"]) {
            sResponse(responseobj);
        }else {
            NSError *error = [NSError errorWithDomain:errorMessage code:1 userInfo:nil];
            fResponse(error);
        }
        
        
    } failure:^(AFHTTPRequestOperation *manager, NSError *error) {
        
        NSString *domain = [error domain];
        if ([domain isEqual:[NSNull null]]) {
            error = [NSError errorWithDomain:@"请求出错，请检查网络" code:1 userInfo:nil];
        }else if (domain && [domain isKindOfClass:[NSString class]]) {
            error = [NSError errorWithDomain:@"请求出错，请检查网络" code:1 userInfo:nil];
        }
        fResponse(error);
        
    }];
    
}


//根据数据上传
+ (void)uploadurl:(NSString *)urlString dataArray:(NSArray *)dataArray fileType:(NSString *)fileType paraDic:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse progess:(void (^) (float progess))progess{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:USERNAME password:PASSWORD];
    manager.requestSerializer.timeoutInterval = 10.f;
    
    NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    
    if ([paraDic isKindOfClass:[NSMutableDictionary class]]) {
        [(NSMutableDictionary *)paraDic setObject:partyId forKey:@"visitPartyId"];
        
    }else{
        paraDic = [NSMutableDictionary dictionaryWithDictionary:paraDic];
        [(NSMutableDictionary *)paraDic setObject:partyId forKey:@"visitPartyId"];
        
    }
    
    AFHTTPRequestOperation *operation = [manager POST:urlString parameters:paraDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (NSData *data in dataArray) {
            [formData appendPartWithFileData:data name:@"file" fileName:[NSString stringWithFormat:@"uploadData.%@",fileType] mimeType:@"application/octet-stream"];
        }
        
    } success:^(AFHTTPRequestOperation *manager,id responseobj) {
        //
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseobj];
        NSString *resultCode = [dic objectForKey:@"resultCode"];
        
        if (resultCode && [resultCode isEqualToString:@"CODE-00000"]) {
            sResponse(responseobj);
        }else {
            
            sResponse(nil);
        }
    } failure:^(AFHTTPRequestOperation *manager, NSError *error) {
        
        sResponse(nil);
        
    }];
    
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        
        float completedProcess = (totalBytesWritten-totalBytesExpectedToWrite)/totalBytesWritten;
        progess(completedProcess);
    }];
    
}

@end

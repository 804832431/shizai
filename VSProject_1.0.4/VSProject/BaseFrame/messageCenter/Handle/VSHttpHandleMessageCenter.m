//
//  VSHttpMessageCenter.m
//  VSProject
//
//  Created by tiezhang on 15/1/11.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSHttpHandleMessageCenter.h"
#import <AFNetworking.h>
#import "VSMessageHeader.h"
#import "VSBaseHttpPacket.h"
#import "NSOperationQueue+VSOperationQueue.h"
#import <JSONModel.h>

@interface VSHttpHandleMessageCenter ()

@property(nonatomic, strong)AFHTTPRequestOperationManager *vs_operationManager;

@end

@implementation VSHttpHandleMessageCenter

DECLARE_SINGLETON(VSHttpHandleMessageCenter)

- (void)sendPacketHandle:(VSBaseHttpPacket *)packet
{
    // 本地Hack，添加请求头
    NSDictionary *commonHeader = [[VSMessageHeader shareInstance] headers];

    [self setHTTPRequestHeaders:commonHeader];
    [self setAuthorizationHeaderFieldWithUsername:USERNAME password:PASSWORD];
    
    
    NSLog(@"%@",self.vs_operationManager.requestSerializer);
    VS_HTTPMETHOD method = packet.methodType;
    
    NSDictionary *parmDict = nil;
    if([packet.packetParm isKindOfClass:[VSBaseParmModel class]])
    {
        if([packet.packetParm respondsToSelector:@selector(vp_parmSerialize)])
        {//如果实现自定义序列化方法
            parmDict = [packet.packetParm vp_parmSerialize];
        }
        else
        {
            parmDict = [packet.packetParm toDictionary];
        }
    }
    else
    {
        parmDict = [packet.packetParm isKindOfClass:[JSONModel class]] ? [packet.packetParm toDictionary] : nil;
    }
    
    
    DBLog(@"requestURL:%@, requestParm:%@", packet.apiUrl, parmDict);
    
    AFHTTPRequestOperation *opreration = nil;
    if (method == VS_HTTPMETHOD_POST)
    {
        opreration = [self.vs_operationManager  POST:packet.apiUrl
                                          parameters:parmDict
                                             success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if(packet.completeBlock)
            {
                packet.completeBlock(operation, responseObject);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if(packet.completeBlock)
            {
                packet.completeBlock(operation, error);
            }
        }];
        
    }
    else if (method == VS_HTTPMETHOD_GET)
    {
        opreration = [self.vs_operationManager GET:packet.apiUrl
                                        parameters:parmDict
                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if(packet.completeBlock)
            {
                packet.completeBlock(operation, responseObject);
            }

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if(packet.completeBlock)
            {
                packet.completeBlock(operation, error);
            }
            NSLog(@"failed");
        }];
    }
    else if (method == VS_HTTPMETHOD_INPUT)
    {
    }
    else if (method == VS_HTTPMETHOD_DELETE)
    {
        
    }
    else
    {
        packet.completeBlock(nil, nil);
    }
    dispatch_queue_t currentQueue = [NSOperationQueue findCurrentQueue];
    opreration.completionQueue = currentQueue;
}

- (void)setHTTPRequestHeaders:(NSDictionary *)headers
{
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    [headers enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [serializer setValue:obj forHTTPHeaderField:key];
    }];
    [self.vs_operationManager setRequestSerializer:serializer];
}

- (void)setAuthorizationHeaderFieldWithUsername:(NSString *)username
                                       password:(NSString *)password
{
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    [serializer setAuthorizationHeaderFieldWithUsername:username password:password];
    [self.vs_operationManager setRequestSerializer:serializer];

}

#pragma mark -- getter
- (AFHTTPRequestOperationManager*)vs_operationManager
{
    if(!_vs_operationManager)
    {
        _vs_operationManager = [[AFHTTPRequestOperationManager alloc] init];
        _vs_operationManager.securityPolicy.allowInvalidCertificates = YES;
        _vs_operationManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
        [_vs_operationManager.reachabilityManager startMonitoring];
    }
    
    return _vs_operationManager;
}

@end

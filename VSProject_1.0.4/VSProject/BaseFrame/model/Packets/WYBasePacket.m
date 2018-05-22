//
////
////  basePacket.m
////  iBeaconApp
////
////  Created by zhangtie on 14-4-21.
////  Copyright (c) 2014年 iSoftstone infomation Technology (Group) Co.,Ltd. All rights reserved.
////
//
//#import "WYBasePacket.h"
//#import "WYPacketCenter.h"
//
//@interface WYBasePacket ()
//
//
//
//@end
//
//@implementation WYBasePacket
//
//- (void)dealloc
//{
//    [self releaseBlockOnMainThread];
//}
//
//- (void)releaseBlockOnMainThread
//{
//    NSMutableArray *blocks = [NSMutableArray array];
//    
//    if(_successBlock)
//    {
//        [blocks addObject:_successBlock];
//        _successBlock = nil;
//    }
//    
//    if(_failedBlock)
//    {
//        [blocks addObject:_failedBlock];
//        _failedBlock = nil;
//    }
//    
//    if(_completeBlock)
//    {
//        [blocks addObject:_completeBlock];
//        _completeBlock = nil;
//    }
//    
//    [self performSelectorOnMainThread:@selector(releaseBlocks) withObject:blocks waitUntilDone:YES];
//}
//
//- (void)releaseBlocks
//{
//    
//}
//
//#pragma mark -- init
//- (id)initWithRequestUrl:(NSString*)url
//{
//    return [self initWithRequestUrl:url parm:nil];
//}
//
//- (id)initWithRequestUrl:(NSString*)url parm:(NSDictionary*)parm
//{
//    return [self initWithRequestUrl:url parm:parm userInfo:nil];
//}
//
//- (id)initWithRequestUrl:(NSString*)url parm:(NSDictionary*)parm userInfo:(NSDictionary*)userInfo;
//{
//    return [self initWithRequestUrl:url parm:parm method:WYHttpMethodPost userInfo:nil];
//}
//
//- (id)initWithRequestUrl:(NSString*)url parm:(NSDictionary*)parm method:(WYHttpMethod)method
//{
//    return [self initWithRequestUrl:url parm:parm method:method userInfo:nil];
//}
//
//- (id)initWithRequestUrl:(NSString*)url parm:(NSDictionary*)parm method:(WYHttpMethod)method userInfo:(NSDictionary*)userInfo
//{
//    self = [super init];
//    if(self)
//    {
//        self.requestUrl     = url;
//        self.requestParm    = parm;
//        self.requestMethod  = method;
//        self.puserInfo      = userInfo;
//        self.isAsyn         = YES;
//        self.successBlock   = nil;
//        self.failedBlock    = nil;
//        self.completeBlock  = nil;
//    }
//    return self;
//}
//
//#pragma mark -- 消息包行为
///**
// @descrtion:    触发发送消息行为，交给消息中心去发
// @parm:         无
// @returns:
// add by zt 2013-12-4
// @exception:
// */
//- (void)sendPacket
//{
//    [[WYPacketCenter shareInstance] sendMsg:self];
//}
//
//- (void)sendRequest
//{
//    [[WYPacketCenter shareInstance] sendRequest:self];
//}
//
//- (void)sendRequestToServer
//{
//    [[WYPacketCenter shareInstance] sendRequestToServer:self];
//}
//
//- (void)sendRequestButReturnXMLData
//{
//    [[WYPacketCenter shareInstance] sendRequestButReturnXMLData:self];
//}
//
//
//#pragma mark -- setter
//- (void)setFailedBlock:(WYMsgBlock)failedBlock
//{
//    if(_failedBlock != failedBlock)
//    {
//        _failedBlock = nil;
//        _failedBlock = [failedBlock copy];
//    }
//}
//
//- (void)setSuccessBlock:(WYMsgBlock)successBlock
//{
//    if(_successBlock != successBlock)
//    {
//        _successBlock = nil;
//        _successBlock = [successBlock copy];
//    }
//}
//
//- (void)setCompleteBlock:(WYMsgBlock)completeBlock
//{
//    if(_completeBlock != completeBlock)
//    {
//        _completeBlock = nil;
//        _completeBlock = [completeBlock copy];
//    }
//}
//
//
//@end

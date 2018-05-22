////
////  QBPacketCenter.m
////  iBeaconApp
////
////  Created by zhangtie on 14-4-21.
////  Copyright (c) 2014年 iSoftstone infomation Technology (Group) Co.,Ltd. All rights reserved.
////
//
//#import "WYPacketCenter.h"
//#import "ZTHttpRequest.h"
//#import "WYMsgResultMeta.h"
//#import "XMLReader.h"
//static WYPacketCenter *packetCenterObject = nil;
//
//@interface WYPacketCenter ()
//{
//    dispatch_queue_t        _threadQueue;
//    NSCondition             *_lock;
//    
//    dispatch_semaphore_t    _semaphore;
//    
//    NSOperationQueue        *_requestQueue;
//}
////@property(nonatomic, retain)NSMutableArray *packetQueue;
//
//@end
//
//@implementation WYPacketCenter
//
//- (void)dealloc
//{
//    _threadQueue = nil;
//    _semaphore   = nil;
//    //    dispatch_release(_threadQueue);
//    //    dispatch_release(_semaphore);
//}
//
//+ (id)shareInstance
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        if(nil == packetCenterObject)
//        {
//            packetCenterObject = _ALLOC_OBJ_(WYPacketCenter);
//        }
//    });
//    
//    return packetCenterObject;
//}
//
//- (id)init
//{
//    self = [super init];
//    if(self)
//    {
//        //        _packetSendThread  = [[NSThread alloc]initWithTarget:self selector:@selector(packetQueueDone) object:nil];
//        
//        //        _lock = [[NSCondition alloc]init];
//        //
//        //        _semaphore = dispatch_semaphore_create(1);
//        //
//        //        _requestQueue = [[NSOperationQueue alloc]init];
//        
//    }
//    
//    return self;
//}
//#pragma mark - 发送请求
//- (void)sendMsg:(WYBasePacket*)packet
//{
//    
//    if(nil == packet)
//    {
//        return;
//    }
//    //    NSAssert(nil == packet, @"pack must be non-nil");
//    if(packet.requestUrl.length <= 0)
//    {
//        packet.failedBlock(nil, nil);
//        return;
//    }
//    
//    [ZTHttpRequest requestWithURLStr:packet.requestUrl
//                               param:packet.requestParm
//                          httpMethod:packet.requestMethod
//                              isAsyn:packet.isAsyn
//                     completionBlock:^(ZTHttpRequest *resquest, id data) {
//                         
//                         if([resquest.responseString hasPrefix:@"<Data>"])
//                         {
//                             NSDictionary *wyt_retDict = [WYJsonHelper convertJSONToDict:resquest.responseString];
//                             NSInteger wyt_stateCode = [PUGetElemForKeyFromDict(@"StatusCode", wyt_retDict) integerValue];
//                             if(wyt_stateCode == 1)
//                             {//成功请求
//                                 if(packet.successBlock)
//                                 {
//                                     packet.successBlock(resquest, PUGetElemForKeyFromDict(@"Data", wyt_retDict));
//                                 }
//                             }
//                             else
//                             {
//                                 if(packet.failedBlock)
//                                 {
//                                     packet.failedBlock(resquest, PUGetElemForKeyFromDict(@"StatusMessage", wyt_retDict));
//                                 }
//                             }
//                         }
//                         else
//                         {
//                             if(packet.failedBlock)
//                             {
//                                 packet.failedBlock(resquest, FAILDMESSAGE);
//                             }
//                         }
//                         
//                     }];
//    
//}
//
//#pragma mark - 发送请求 返回completionBlock，需要自己判断
//- (void)sendRequest:(WYBasePacket*)packet
//{
//    
//    if(nil == packet)
//    {
//        return;
//    }
//    if(packet.requestUrl.length <= 0)
//    {
//        packet.failedBlock(nil, nil);
//        return;
//    }
//    
//    [ZTHttpRequest requestWithURLStr:packet.requestUrl
//                               param:packet.requestParm
//                          httpMethod:packet.requestMethod
//                              isAsyn:packet.isAsyn
//                     completionBlock:^(ZTHttpRequest *resquest, id data) {
//                        
//                         
//                         NSString *dataString = resquest.responseString;
//                         DBLog(@"datastring=%@",dataString);
//                         packet.completeBlock(resquest,[WYJsonHelper convertJSONToDict:dataString]);
//                     }];
//    
//}
//
//#pragma mark - 发送请求 返回successBlock 和 failedBlock
//- (void)sendRequestToServer:(WYBasePacket*)packet
//{
//    
//    if(nil == packet)
//    {
//        return;
//    }
//    if(packet.requestUrl.length <= 0)
//    {
//        packet.failedBlock(nil, nil);
//        return;
//    }
//    
//    [ZTHttpRequest requestWithURLStr:packet.requestUrl
//                               param:packet.requestParm
//                          httpMethod:packet.requestMethod
//                              isAsyn:packet.isAsyn
//                     completionBlock:^(ZTHttpRequest *resquest, id data) {
//                         
//                         NSString *dataString = resquest.responseString;
//                         NSLog(@"输出数据 %@",dataString);
//                         
//                         if(dataString && dataString.length != 0){
//                             NSDictionary *wyt_retDict = [WYJsonHelper convertJSONToDict:dataString];
//                             //NSLog(@"输出字典 %@",wyt_retDict);
//                             
//                             NSInteger wyt_stateCode = [PUGetElemForKeyFromDict(@"StatusCode", wyt_retDict) integerValue];
//                             NSInteger baidu_stateCode=1;
//                             if(PUGetElemForKeyFromDict(@"status", wyt_retDict)!=nil)
//                             {
//                                baidu_stateCode=[PUGetElemForKeyFromDict(@"status", wyt_retDict)integerValue];
//                             }
//
//                             if(wyt_stateCode == 1||baidu_stateCode==0)//成功请求
//                              {
//                                 if(packet.successBlock)
//                                 {
//                                     if (wyt_stateCode == 1)
//                                        {
//                                         packet.successBlock(resquest, PUGetElemForKeyFromDict(@"Data", wyt_retDict));
//                                        // NSString *dataString = resquest.responseString;
//                                        }
//                                    else
//                                        {
//                                        packet.successBlock(resquest, PUGetElemForKeyFromDict(@"results", wyt_retDict));
//                                       // NSString *dataString = resquest.responseString;
//                                        }
//                                    }
//                                }
//                                  else
//                                    {
//                                    if(packet.failedBlock)
//                                    {
//                                     packet.failedBlock(resquest, PUGetElemForKeyFromDict(@"StatusMessage", wyt_retDict));
//                                    }
//                                    }
//                            }
//                            else{
//                             if(packet.failedBlock)
//                             {
//                                 packet.failedBlock(resquest, FAILDMESSAGE);
//                             }
//                            }
//                     }];
//    
//}
//
//#pragma mark - 发送请求，但返回数据是xml格式的
//- (void)sendRequestButReturnXMLData:(WYBasePacket*)packet
//{
//    
//    if(nil == packet)
//    {
//        return;
//    }
//    if(packet.requestUrl.length <= 0)
//    {
//        packet.failedBlock(nil, nil);
//        return;
//    }
//    
//    [ZTHttpRequest requestWithURLStr:packet.requestUrl
//                               param:packet.requestParm
//                          httpMethod:packet.requestMethod
//                              isAsyn:packet.isAsyn
//                     completionBlock:^(ZTHttpRequest *resquest, id data) {
//                         
//                         NSString *dataString = resquest.responseString;
//                         NSLog(@"&&&&&&&&&&&&&&&&&&&&&&&&&    responseString=%@",[resquest responseString]);
//                         if(dataString && dataString.length != 0){
//                             NSError *errors = nil;
//                             NSDictionary *wyt_retDict = [XMLReader dictionaryForXMLString:dataString error:&errors];
//                             NSDictionary *ResultMessageDic = [wyt_retDict valueForKeyPath:@"Data.ResultMessage"];
//                             NSDictionary *ProductInfoDic = [wyt_retDict valueForKeyPath:@"Data.ProductInfo"];
//                             NSInteger wyt_stateCode = [[ResultMessageDic valueForKeyPath:@"MsgCode.text"] integerValue];
//                             if(wyt_stateCode == 1)//成功请求
//                             {
//                                 if(packet.successBlock)
//                                 {
//                                     packet.successBlock(resquest, ProductInfoDic);
//                                 }
//                                 
//                             }else{
//                                 if(packet.failedBlock)
//                                 {
//                                     packet.failedBlock(resquest, ResultMessageDic);
//                                     
//                                 }
//                             }
//                         }else{
//                             if(packet.failedBlock)
//                             {
//                                 packet.failedBlock(resquest, FAILDMESSAGE);
//                             }
//                         }
//                         
//                     }];
//    
//}
//
//
//- (void)cancelMsgForTarget:(id)target
//{
//    NSOperationQueue *queue = [[ZTHttpRequest class] sharedQueue];
//    
//    NSArray *operations = [queue operations];
//    
//    for (ZTHttpRequest *request in operations)
//    {
//        if(request.target == target)
//        {
//            [request clearDelegatesAndCancel];
//        }
//    }
//}
//
//- (void)clearSession
//{
//    [[ZTHttpRequest class] clearSession];
//}
//
////待完善
////- (void)packetQueueDone
////{
////    if([self.packetQueue count] <= 0)
////    {
////        dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
////        return;
////    }
////
////    //线程
////    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
////        do {
////
////            if([self.packetQueue count] <= 0)
////            {
////                dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
////                return;
////            }
////
////            BasePacket *packet = [self.packetQueue objectAtIndex:0];
////
////            [QBHttpRequest requestWithURLStr:packet.requestUrl
////                                       param:packet.requestParm
////                                  httpMethod:packet.requestMethod
////                                      isAsyn:packet.isAsyn
////                                    userInfo:packet.puserInfo
////                                successBlock:^(QBHttpRequest *request, NSDictionary *resultDic) {
////                                    if(packet.successBlock)
////                                    {
////                                        packet.successBlock(request, resultDic);
////                                    }
////                                } failedBlock:^(QBHttpRequest *request, NSDictionary *resultDic) {
////                                    if(packet.failedBlock)
////                                    {
////                                        packet.failedBlock(request, resultDic);
////                                    }
////                                } completionBlock:^(QBHttpRequest *request, NSDictionary *resultDic) {
////
////                                    [_lock lock];
////
////                                    [self.packetQueue removeObject:packet];
////
////                                    [_lock signal];
////                                    [_lock unlock];
////
////                                    if(packet.completeBlock)
////                                    {
////                                        packet.completeBlock(request, resultDic);
////                                    }
////                                }];
////        } while (true);
////    });
////
////
////}
////
////- (void)addPacketToPacketQueue:(WYBasePacket*)packet
////{
////    if(nil == packet)
////        return;
////
////    [_lock lock];
////
////    [self.packetQueue addObject:packet];
////
////    [_lock signal];
////    [_lock unlock];
////}
////
////- (void)removePacketFromPacketQueue:(WYBasePacket*)packet
////{
////    if(nil == packet)
////        return;
////
////    [_lock lock];
////
////    [self.packetQueue removeObject:packet];
////
////    [_lock signal];
////    [_lock unlock];
////}
//
//#pragma mark -- getter
////- (NSMutableArray*)packetQueue
////{
////    @synchronized(_packetQueue)
////    {
////        _packetQueue = _ALLOC_OBJ_(NSMutableArray);
////    }
////    return _packetQueue;
////}
//
//@end

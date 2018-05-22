////
////  basePacket.h
////  iBeaconApp
////
////  Created by zhangtie on 14-4-21.
////  Copyright (c) 2014年 iSoftstone infomation Technology (Group) Co.,Ltd. All rights reserved.
////
//
//#import <Foundation/Foundation.h>
//
//@protocol BCBasePacketProtocol <NSObject>
//
//@required
//- (void)sendPacket;    //消息包行为,发送消息协议
//
//@optional
//- (void)sendRequest;
//- (void)sendRequestToServer;
//- (void)sendRequestButReturnXMLData;
//
//@end
//
//@interface WYBasePacket : NSObject<BCBasePacketProtocol>
//{
//    //消息包参数
//    NSString            *_requestUrl;
//    NSString            *_methodName;
//    NSDictionary        *_requestParm;
//    NSDictionary        *_puserInfo;
//    WYHttpMethod        _requestMethod;
//    BOOL                _isAsyn;
//    
//    //消息包回调block
//    WYMsgBlock          _successBlock;
//    WYMsgBlock          _failedBlock;
//    WYMsgBlock          _completeBlock;
//}
//
//#pragma mark -- init
//- (id)initWithRequestUrl:(NSString*)url;
//- (id)initWithRequestUrl:(NSString*)url parm:(NSDictionary*)parm;
//- (id)initWithRequestUrl:(NSString*)url parm:(NSDictionary*)parm userInfo:(NSDictionary*)userInfo;
//- (id)initWithRequestUrl:(NSString*)url parm:(NSDictionary*)parm method:(WYHttpMethod)method;
//- (id)initWithRequestUrl:(NSString*)url parm:(NSDictionary*)parm method:(WYHttpMethod)method userInfo:(NSDictionary*)userInfo;
//
//#pragma mark -- property
//@property(nonatomic, assign )BOOL               isAsyn;             //default is YES
//@property(nonatomic, copy   )NSString           *requestUrl;
//@property(nonatomic, copy   )NSString           *methodName;
//@property(nonatomic, strong )NSDictionary       *requestParm;
//@property(nonatomic, strong )NSDictionary       *puserInfo;         //default is nil
//@property(nonatomic, assign )WYHttpMethod       requestMethod;      //default is Post
//
//#pragma mark -- block
//@property(nonatomic, copy   )WYMsgBlock         failedBlock;
//@property(nonatomic, copy   )WYMsgBlock         successBlock;
//@property(nonatomic, copy   )WYMsgBlock         completeBlock;
//
//@property(nonatomic, assign )id     target;
//
//
//@end

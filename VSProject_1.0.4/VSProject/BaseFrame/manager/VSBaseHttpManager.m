//
//  VSBaseHttpManager.m
//  VSProject
//
//  Created by tiezhang on 15/1/12.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseHttpManager.h"
#import "VSBaseHttpPacket.h"
#import "VSMessageCenter.h"
#import "VSFileHelper.h"
#import "XMLReader.h"
#import "VSMessageHeader.h"

#define CONFIG_ERROR_MESSAGE(superNode, subNode)    [NSString stringWithFormat:@"%@需要配置%@节点", superNode, subNode]

@implementation VSBaseHttpManager

+ (void)vs_sendAPI:(NSString*)apiUrl
              parm:(VSBaseParmModel*)parm
      successBlock:(VSMessageHandleCallBack)successed
       failedBlock:(VSMessageHandleCallBack)failed
     completeBlock:(VSMessageHandleCallBack)completed
{
    return [[self class] vs_sendAPI:apiUrl
                               parm:parm
                         httpMethod:VS_HTTPMETHOD_GET
                   responseObjClass:nil
                       successBlock:successed
                        failedBlock:failed
                      completeBlock:completed];
    
}

+ (void)vs_sendAPI:(NSString*)apiUrl
              parm:(VSBaseParmModel*)parm
        httpMethod:(VS_HTTPMETHOD)method
      successBlock:(VSMessageHandleCallBack)successed
       failedBlock:(VSMessageHandleCallBack)failed
     completeBlock:(VSMessageHandleCallBack)completed
{
    return [[self class] vs_sendAPI:apiUrl
                               parm:parm
                         httpMethod:method
                   responseObjClass:nil
                       successBlock:successed
                        failedBlock:failed
                      completeBlock:completed];
}

+ (void)vs_sendAPI:(NSString*)apiUrl
              parm:(VSBaseParmModel*)parm
  responseObjClass:(Class)responseObjClass
      successBlock:(VSMessageHandleCallBack)successed
       failedBlock:(VSMessageHandleCallBack)failed
     completeBlock:(VSMessageHandleCallBack)completed
{
    return [self vs_sendAPI:apiUrl
                       parm:parm
                 httpMethod:VS_HTTPMETHOD_GET
           responseObjClass:responseObjClass
               successBlock:successed
                failedBlock:failed
              completeBlock:completed];
}


+ (void)vs_sendAPI:(NSString*)apiUrl
              parm:(VSBaseParmModel*)parm
        httpMethod:(VS_HTTPMETHOD)method
  responseObjClass:(Class)responseObjClass
      successBlock:(VSMessageHandleCallBack)successed
       failedBlock:(VSMessageHandleCallBack)failed
     completeBlock:(VSMessageHandleCallBack)completed
{
    VSBaseHttpPacket *httpPacket = (VSBaseHttpPacket*)[[VSBaseHttpPacket class]
                                                       createPacketUrl:apiUrl
                                                       parm:parm
                                                       callBack:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
                                                           
                                                           dispatch_async(dispatch_get_main_queue(), ^{
                                                               NSLog(@"%@",responseObject);
                                                               VSResultData *resultData = nil;
                                                               if([responseObject isKindOfClass:[NSError class]])
                                                               {
                                                                   resultData = [[VSResultData class] createResultDataMessage:kerror_message
                                                                                                                   resultCode:[NSString stringWithFormat:@"%d", INVALID_CODE]];
                                                                   if(failed)
                                                                   {
                                                                       failed(resultData, nil);
                                                                   }
                                                               }
                                                               else
                                                               {
                                                                   //TODO：成功的业务逻辑判断
                                                                   NSDictionary *configInfo = [[VSFileHelper shareIntance] loadDictInfoPlistName:@"HttpFormatConfig"];
                                                                   NSAssert(configInfo, @"需要配置HttpFormatConfig");
                                                                   
                                                                   NSAssert([[configInfo allKeys] containsObject:@"HttpFormatConfig"], CONFIG_ERROR_MESSAGE(@"HttpFormatConfig", @"codeValues"));
                                                                   NSDictionary *codeValue  = [configInfo objectForKey:@"codeValues"];
                                                                   
                                                                   
                                                                   NSAssert([[codeValue allKeys] containsObject:@"successCode"], CONFIG_ERROR_MESSAGE(@"codeValues", @"successCode"));
                                                                   NSString *successCodeValue = [codeValue objectForKey:@"successCode"];
                                                                   NSLog(@"successCodeValue=%@",successCodeValue);
                                                                   
                                                                   NSString *codeKey    = @"codeKey";
                                                                   NSAssert([[configInfo allKeys] containsObject:codeKey], CONFIG_ERROR_MESSAGE(@"HttpFormatConfig", codeKey));
                                                                   NSString *keyCode    = [configInfo objectForKey:codeKey];
                                                                   
                                                                   NSString *messageKey = @"messageKey";
                                                                   NSAssert([[configInfo allKeys] containsObject:messageKey], CONFIG_ERROR_MESSAGE(@"HttpFormatConfig", messageKey));
                                                                   NSString *keyMessage = [configInfo objectForKey:messageKey];
                                                                   
                                                                   NSString *dataKey    = @"dataKey";
                                                                   NSAssert([[configInfo allKeys] containsObject:dataKey], CONFIG_ERROR_MESSAGE(@"HttpFormatConfig", dataKey));
                                                                   
                                                                   NSString *keyData    = [configInfo objectForKey:dataKey];
                                                                   NSLog(@"[responseObject objectForKey:keyCode]=%@",[responseObject objectForKey:keyCode]);
                                                                   BOOL bsuccess = [successCodeValue isEqualToString:[responseObject objectForKey:keyCode]];
                                                                   if(bsuccess)
                                                                   {
                                                                       if(successed)
                                                                       {
                                                                           resultData = [[VSResultData class] createResultDataMessage:[responseObject objectForKey:keyMessage]
                                                                                                                           resultCode:[responseObject objectForKey:keyCode]];
                                                                           
                                                                           id dataDict = [[responseObject allKeys] containsObject:keyData] ? [responseObject objectForKey:keyData] : responseObject;
                                                                           id responseObj = nil;
                                                                           if(responseObjClass && [responseObjClass isSubclassOfClass:[JSONModel class]])
                                                                           {
                                                                               NSError *err = nil;//[responseObject objectForKey:keyData]
                                                                               
                                                                               responseObj = [[responseObjClass alloc]initWithDictionary:dataDict error:&err];
                                                                               DBLog(@"%@", err);
                                                                           }
                                                                           else
                                                                           {
                                                                               responseObj = dataDict;
                                                                           }
                                                                           successed(resultData, responseObj);
                                                                       }
                                                                   }
                                                                   else
                                                                   {
                                                                       if(failed)
                                                                       {
                                                                           resultData = [[VSResultData class] createResultDataMessage:[responseObject objectForKey:keyMessage]
                                                                                                                           resultCode:[responseObject objectForKey:keyCode]];
                                                                           failed(resultData, nil);
                                                                       }
                                                                   }
                                                               }
                                                               
                                                               if(completed)
                                                               {
                                                                   completed(resultData, responseObject);
                                                               }
                                                           });
                                                           
                                                       }];
    httpPacket.methodType = method;
    [[VSMessageCenter shareInstance] vs_sendPacket:httpPacket];
}


+ (void)vs_sendXMLAPI:(NSString*)apiUrl
                 parm:(VSBaseParmModel*)parm
         successBlock:(VSMessageHandleCallBack)successed
          failedBlock:(VSMessageHandleCallBack)failed
{
    VSBaseHttpPacket *httpPacket = (VSBaseHttpPacket*)[[VSBaseHttpPacket class]createPacketUrl:apiUrl parm:parm callBack:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *responseString = operation.responseString;
        NSLog(@"------------------------------%@------------------%@--------",responseString,responseObject);
        dispatch_async(dispatch_get_main_queue(), ^{
            if(responseString && responseString.length != 0){
                NSError *errors = nil;
                NSDictionary *vs_retDict = [XMLReader dictionaryForXMLString:responseString error:&errors];
                NSDictionary *ResultMessageDic = [vs_retDict valueForKeyPath:@"Data.ResultMessage"];
                NSDictionary *ProductInfoDic = [vs_retDict valueForKeyPath:@"Data.ProductInfo"];
                NSInteger vs_stateCode = [[ResultMessageDic valueForKeyPath:@"MsgCode.text"] integerValue];
                
                if(vs_stateCode == 1)//成功请求
                {
                    if(successed)
                    {
                        successed(responseString, ProductInfoDic);
                    }
                }else{
                    if(failed)
                    {
                        failed(responseString, ResultMessageDic);
                    }
                }
            }else{
                if(failed)
                {
                    failed(responseString, kerror_message);
                }
            }
        });
    }];
    httpPacket.methodType = VS_HTTPMETHOD_POST;
    [[VSMessageCenter shareInstance] vs_sendPacket:httpPacket];
}


+ (void)vs_sendJSONAPI:(NSString*)apiUrl
                  parm:(VSBaseParmModel*)parm
          successBlock:(VSMessageHandleCallBack)successed
           failedBlock:(VSMessageHandleCallBack)failed;
{
    VSBaseHttpPacket *httpPacket = (VSBaseHttpPacket*)[[VSBaseHttpPacket class]createPacketUrl:apiUrl parm:parm callBack:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *responseString = operation.responseString;
       // NSLog(@"responseString============================%@================================",responseString);
        dispatch_async(dispatch_get_main_queue(), ^{
            //plist 大字典
            NSDictionary *configInfo = [[VSFileHelper shareIntance] loadDictInfoPlistName:@"HttpFormatConfig"];
            NSDictionary *codeValue    = [configInfo objectForKey:@"codeValues"];
            NSString *successCodeValue = [codeValue objectForKey:@"successCode"];// == 1
            NSString *keyCode          = [configInfo objectForKey:@"codeKey"];// == StatusCode
            NSString *keyMessage       = [configInfo objectForKey:@"messageKey"];//==StatusMessage
            NSString *keyData          = [configInfo objectForKey:@"dataKey"];//== Data
          //  NSLog(@"vs_sendJSONAPI======%@===========%@===========%@=======%@=========%@================",codeValue,successCodeValue,keyCode,keyMessage,keyData);

            if(responseString && responseString.length != 0){
                NSDictionary *wyt_retDict = [VSJsonHelper convertJSONToDict:responseString];
                NSString * wyt_stateCode = VSGetElemForKeyFromDict(keyCode, wyt_retDict);
                
                if([wyt_stateCode isEqualToString:successCodeValue])//成功请求
                {
                    if(successed)
                    {
                        successed(responseString, VSGetElemForKeyFromDict(keyData, wyt_retDict));
                    }
                }else{
                    if(failed)
                    {
                        failed(responseString, VSGetElemForKeyFromDict(keyMessage, wyt_retDict));
                    }
                }
            }else{
                if(failed)
                {
                    failed(responseString, kerror_message);
                }
            }
        });
    }];
    httpPacket.methodType = VS_HTTPMETHOD_POST;
    [[VSMessageCenter shareInstance] vs_sendPacket:httpPacket];
}

@end

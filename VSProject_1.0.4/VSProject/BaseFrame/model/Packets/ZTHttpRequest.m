////
////  HttpRequestV2.m
////  LimitFreeMaster
////
////  Created by zhangtie on 13-11-27.
////
//
//#import "ZTHttpRequest.h"
//#import <OpenUDID.h>
//#import "AppDelegate.h"
//#import "NSString+Hashing.h"
//#ifndef _ALLOC_OBJ_
//#define _ALLOC_OBJ_(__obj_class__) \
//[[__obj_class__ alloc]init]
//#endif
//
//#ifndef RELEASE_SAFELY
//#define RELEASE_SAFELY(__POINTER) do{ [__POINTER release]; __POINTER = nil; } while(0)
//#endif
//
//
//
//static ZTHttpRequestHeader *requestHeaderInstance;
//
//@interface ZTHttpRequestHeader ()
//
//@end
//
//@implementation ZTHttpRequestHeader
//
//- (void)dealloc
//{
//    RELEASE_SAFELY(_commonHeader);
//}
//
//+ (id)shareInstance
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        requestHeaderInstance = _ALLOC_OBJ_(ZTHttpRequestHeader);
//    });
//    return requestHeaderInstance;
//}
//
//#pragma mark -- getter
//- (NSMutableDictionary*)commonHeader
//{
//    if(!_commonHeader)
//    {
//       _GET_APP_DELEGATE_(appDelegate);
//        NSString*token=[[NSString stringWithFormat:@"%@%@",appDelegate.userInfo.umemberInfo.mCell,appDelegate.userInfo.umemberInfo.mPwd]MD5Hash];
//        NSString *uid=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"UID"]];
//        if ([[NSUserDefaults standardUserDefaults]objectForKey:@"UID"]==nil) {
//            uid=@"-1";
//        }
//        if (!token) {
//            token=@"";
//        }
//        _commonHeader = _ALLOC_OBJ_(NSMutableDictionary);
//        SET_PARAM([OpenUDID value],         @"devid",                   _commonHeader);
//        SET_PARAM(uid,         @"uid",                   _commonHeader);
//        SET_PARAM(token,         @"token",                   _commonHeader);
//    }
//    return _commonHeader;
//}
//
//
//@end
//
//
//@interface ZTHttpRequest()
//{
//}
//@end
//
//@implementation ZTHttpRequest
//
//- (void)dealloc
//{
//    [self releaseSelfBlocksOnMainThread];
//}
//
//- (void)clearDelegatesAndCancel
//{
//    [super clearDelegatesAndCancel];
//    [self releaseSelfBlocksOnMainThread];
//}
//
//+ (ZTHttpRequest*)requestWithURLStr:(NSString *)initURLString
//                              param:(NSDictionary *)param
//                         httpMethod:(WYHttpMethod)httpMethod
//                             isAsyn:(BOOL)isAsyn
//                    completionBlock:(WYMsgBlock)aCompletionBlock
//{
//    DBLog(@"requestUrl:%@\r\nrequestData:%@",  initURLString, param);
//    ZTHttpRequest *aRequest = [[ZTHttpRequest alloc] initWithURL:nil];
//    
//    // https请求，不验证证书的有效性
//    [aRequest setValidatesSecureCertificate:NO];
//    
//    // 设置超时时间
//    [aRequest setTimeOutSeconds:30];
//    
//    // 本地Hack，添加请求头
//    NSDictionary *commonHeader = [[ZTHttpRequestHeader shareInstance] commonHeader];
//    [aRequest.requestHeaders addEntriesFromDictionary:commonHeader];
//    NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
//
//    
//    DBLog(@"requestHeaders: %@",aRequest.requestHeaders);
//    
//#if DEBUG_USEPROXY
//    // 设置请求代理
//    aRequest.proxyHost = @"192.168.6.187";
//    aRequest.proxyPort = 9999;
//#endif
//    
//    NSString *requestUrlStr = initURLString;
//    if (httpMethod == WYHttpMethodPost ||
//        httpMethod == WYHttpMethodDelete)
//    {
//        if(httpMethod == WYHttpMethodPost)
//        {
//            [aRequest addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
//
//        }
//        
//        [aRequest setRequestMethod:(httpMethod == WYHttpMethodPost) ? @"POST" : @"DELETE"];
//        
//        [param enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
//         {
//             if ([obj isKindOfClass:[NSURL class]] && [[NSFileManager defaultManager] fileExistsAtPath:[(NSURL*)obj path]])
//             {
//                 // 添加上传的文件
//                 [aRequest addFile:[(NSURL*)obj path] forKey:key];
//             }
//             else if ([obj isKindOfClass:[UIImage class]])
//             {
//                 // 添加上传的图片
//                 
//                 NSString *fileName = [key hasSuffix:@".png"] ? key : [NSString stringWithFormat:@"%@.png", key];
//                 [aRequest addData:UIImagePNGRepresentation(obj) withFileName:fileName andContentType:@"image/png" forKey:key];
//             }
//             else
//             {
//                 [aRequest addPostValue:obj forKey:key];
//             }
//         }];
//    }
//    else if(httpMethod == WYHttpMethodGet)
//    {
//        [aRequest setRequestMethod:@"GET"];
//        
//        NSMutableString *postString = [NSMutableString stringWithCapacity:0];
//        
//        NSArray *allKeys = [param allKeys];
//        
//        if([allKeys count] > 0)
//        {
//            NSInteger count = [allKeys count];
//            for (NSInteger i=0; i <= (count - 1); ++i)
//            {
//                id obj = [param objectForKey:allKeys[i]];
//                
//                if ([obj respondsToSelector:@selector(stringValue)])
//                {
//                    obj = [obj stringValue];
//                }
//                if ([obj isKindOfClass:[NSString class]])
//                {
//                    [postString appendString:[NSString stringWithFormat:@"%@=%@", allKeys[i], obj] ];
//                }
//                
//                if(i != (count - 1))
//                {
//                    [postString appendString:@"&"];
//                }
//            }
//        }
//        
//        if(postString.length > 0)
//        {
//            NSInteger questLocation = [initURLString rangeOfString:@"?"].location;
//            if (NSNotFound!=questLocation)
//            {
//                requestUrlStr = [NSString stringWithFormat:@"%@%@", initURLString, postString];
//            }
//            else
//            {
//                requestUrlStr = [NSString stringWithFormat:@"%@?%@", initURLString, postString];
//            }
//        }
//    }
//    else
//    {
//        
//    }
//    
//    [aRequest setURL:[NSURL URLWithString:[[self class] formatUrl:requestUrlStr]]];
//    
//    [aRequest setCompletionReqBlock:aCompletionBlock];
//    
//    if (isAsyn)
//    {
//        [aRequest startAsynchronous];
//    }
//    else
//    {
//        [aRequest startSynchronous];
//    }
//    
//    return aRequest;
//}
//
//+ (NSString*)formatUrl:(NSString*)sourString
//{
//    if(sourString.length <= 0)
//        return @"";
//    const char *str = [sourString UTF8String];
//    NSString *tmpurl = [NSString stringWithUTF8String:str];
//    return [tmpurl stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
//}
//
//#if NS_BLOCKS_AVAILABLE
//- (void)setCompletionReqBlock:(WYMsgBlock)aCompletionBlock
//{
//    _completionReqBlock = nil;
//    _completionReqBlock = [aCompletionBlock copy];
//}
//
//- (void)releaseSelfBlocksOnMainThread
//{
//    NSMutableArray *blocks = [NSMutableArray array];
//    if (_completionReqBlock)
//    {
//        [blocks addObject:_completionReqBlock];
//        _completionReqBlock = nil;
//        _completionReqBlock = nil;
//    }
//    
//    [[self class] performSelectorOnMainThread:@selector(releaseSelfBlocks:) withObject:blocks waitUntilDone:[NSThread isMainThread]];
//    
//}
//
//+ (void)releaseSelfBlocks:(NSArray*)blocks
//{
//    
//}
//
//#endif
//
//- (void)requestFinished
//{
//    [super requestFinished];
//#if NS_BLOCKS_AVAILABLE
//    
//    if(_completionReqBlock)
//    {
//        _completionReqBlock(self, nil);
//    }
//#endif
//}
//- (void)failWithError:(NSError *)theError
//{
//    [super failWithError:theError];
//#if NS_BLOCKS_AVAILABLE
//    
//    if(_completionReqBlock)
//    {
//        _completionReqBlock(self, nil);
//    }
//#endif
//}
//
//#pragma mark - getter/setter
//+ (NSDictionary *)commonParams
//{
//    NSMutableDictionary *commonParams = [NSMutableDictionary dictionaryWithCapacity:0];
//    return commonParams;
//}
//
//- (NSMutableDictionary*)requestHeaders
//{
//    if(!requestHeaders)
//    {
//        requestHeaders = _ALLOC_OBJ_(NSMutableDictionary);
//    }
//    
//    return requestHeaders;
//}
//
//@end

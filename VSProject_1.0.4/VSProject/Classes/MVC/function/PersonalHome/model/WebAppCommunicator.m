
/*********************************************************************
 文件名称 : WebAppCommunicator.m
 作   者 : xu_liang
 创建时间 : 2015-5-5
 文件描述 : js交互接口方法
 *********************************************************************/

#import "WebAppCommunicator.h"
#import "VSJsWebViewController.h"
#import "EnterpriceInfoViewController.h"

@interface WebAppCommunicator ()
{
@protected
    UIViewController *_containerViewController;
    UIWebView *_webView;
}

@end

@implementation WebAppCommunicator


- (id)initWithContainerViewController:(UIViewController *)containerViewController webView:(UIWebView *)webView
{
    if (self = [super init])
    {
        _containerViewController = containerViewController;
        _webView = webView;
    }
    return self;
}

@end

@interface WebAppInterface ()

@property(nonatomic, retain) NSMutableDictionary *dataStorageDic;

@end
@implementation WebAppInterface

- (id)initWithContainerViewController:(UIViewController *)containerViewController webView:(UIWebView *)webView
{
    if (self = [super initWithContainerViewController:containerViewController webView:webView])
    {
        _dataStorageDic = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [_dataStorageDic release];
    [super dealloc];
}

- (NSString *)getDatas:(NSString *)key
{
    NSLog(@"执行getDatas方法");
    if(key.length == 0)
    {
        return NULL;
    }
    if ([key isEqualToString:@"userId"])
    {
        return @"";
    }
    if ([key isEqualToString:@"userName"])
    {
        return @"";
    }
    return NULL;
}
- (void)setDatas:(NSString *)key :(NSString *)value
{
    NSLog(@"执行setDatas方法-----key==%@,value==%@",key,value);
}
//刷新页面
- (void)refreshPage{
    NSLog(@"==========Refresh page===========");
    [_webView reload];
}
- (NSString *)getCartInfo:(NSString *)key{
    //    return @"[{\"productId\":\"10290\",\"quantity\":1,\"categoryId\":\"Gshop_promotion\"},{\"productId\":\"10271\",\"quantity\":1,\"categoryId\":\"Gshop_promotion\"}]";
    NSString *dataStr = nil;
    if (key) {
        if ([_containerViewController isKindOfClass:[VSJsWebViewController class]])
        {
            VSJsWebViewController *webCtrl = (VSJsWebViewController *)_containerViewController;
            if ([webCtrl respondsToSelector:@selector(getCartInfo:)]) {
                //webview方法
                dataStr = [webCtrl getCartInfo:key];
            }
            
            webCtrl.TriggerFuncCallback = ^(NSString *func){
                [_webView performSelectorOnMainThread:@selector(stringByEvaluatingJavaScriptFromString:) withObject:func waitUntilDone:NO];
            };
        }
    }
    return dataStr;
}
- (void)toProInfo:(NSString *)string{
    NSLog(@"==========toProInfo===========");
    id jsonData = [self deserializeJsonString:string];
    NSLog(@"===toProInfo-jsonDic--%@===",jsonData);
    if (!jsonData) {
        return;
    }
    if ([_containerViewController isKindOfClass:[VSJsWebViewController class]])
    {
        VSJsWebViewController *webCtrl = (VSJsWebViewController *)_containerViewController;
        if ([webCtrl respondsToSelector:@selector(toProInfo:)]) {
            //webview方法
            //modify by Thomas 数据无需解析直接当做缓存－－－start
            //            [webCtrl toProInfo:jsonData];
            [webCtrl toProInfo:string];
            //modify by Thomas 数据无需解析直接当做缓存－－－end
        }
        
        webCtrl.TriggerFuncCallback = ^(NSString *func){
            [_webView performSelectorOnMainThread:@selector(stringByEvaluatingJavaScriptFromString:) withObject:func waitUntilDone:NO];
            //        [_webView stringByEvaluatingJavaScriptFromString:func];
        };
    }
}
- (void)toOrder:(NSString *)string{
    NSLog(@"==========goOrder===========");
    id jsonData = [self deserializeJsonString:string];
    NSLog(@"===goOrder-jsonDic--%@===",jsonData);
    if (!jsonData) {
        return;
    }
    
    if ([_containerViewController isKindOfClass:[VSJsWebViewController class]])
    {
        VSJsWebViewController *webCtrl = (VSJsWebViewController *)_containerViewController;
        if ([webCtrl respondsToSelector:@selector(toOrder:)]) {
            //webview方法
            [webCtrl toOrder:jsonData];
        }
        
        webCtrl.TriggerFuncCallback = ^(NSString *func){
            [_webView performSelectorOnMainThread:@selector(stringByEvaluatingJavaScriptFromString:) withObject:func waitUntilDone:NO];
            //        [_webView stringByEvaluatingJavaScriptFromString:func];
        };
    }
}

- (void)toCart:(NSString *)string{
    NSLog(@"==========toCart===========");
    id jsonData = [self deserializeJsonString:string];
    NSLog(@"===jsonDic--%@===",jsonData);
    if (!jsonData) {
        return;
    }
    if ([_containerViewController isKindOfClass:[VSJsWebViewController class]])
    {
        VSJsWebViewController *webCtrl = (VSJsWebViewController *)_containerViewController;
        if ([webCtrl respondsToSelector:@selector(toCart:)]) {
            //webview方法
            [webCtrl toCart:jsonData];
        }
        
        webCtrl.TriggerFuncCallback = ^(NSString *func){
            [_webView performSelectorOnMainThread:@selector(stringByEvaluatingJavaScriptFromString:) withObject:func waitUntilDone:NO];
            //        [_webView stringByEvaluatingJavaScriptFromString:func];
        };
    }
}

//打电话
- (void)toCall:(NSString *)string{
    NSLog(@"=========toCall===========");
    id jsonData = string;
    NSLog(@"===jsonDic--%@===",jsonData);
    if (!jsonData) {
        return;
    }
    if ([_containerViewController isKindOfClass:[VSJsWebViewController class]])
    {
        VSJsWebViewController *webCtrl = (VSJsWebViewController *)_containerViewController;
        if ([webCtrl respondsToSelector:@selector(toCall:)]) {
            //webview方法
            [webCtrl toCall:jsonData];
        }
        
        webCtrl.TriggerFuncCallback = ^(NSString *func){
            [_webView performSelectorOnMainThread:@selector(stringByEvaluatingJavaScriptFromString:) withObject:func waitUntilDone:NO];
            //        [_webView stringByEvaluatingJavaScriptFromString:func];
        };
    }
}

//预约
- (void)toPoint:(NSString *)string{
    NSLog(@"==========toPoint===========");
    id jsonData = [self deserializeJsonString:string];
    NSLog(@"===jsonDic--%@===",jsonData);
    if (!jsonData) {
        return;
    }
    if ([_containerViewController isKindOfClass:[VSJsWebViewController class]])
    {
        VSJsWebViewController *webCtrl = (VSJsWebViewController *)_containerViewController;
        if ([webCtrl respondsToSelector:@selector(toPoint:)]) {
            //webview方法
            [webCtrl toPoint:jsonData];
        }
    }
}

//分享
- (void)toShare:(NSString *)string{
    NSLog(@"==========toShare===========");
    id jsonData = [self deserializeJsonString:string];
    NSLog(@"===jsonDic--%@===",jsonData);
    if (!jsonData) {
        return;
    }
    if ([_containerViewController isKindOfClass:[VSJsWebViewController class]])
    {
        VSJsWebViewController *webCtrl = (VSJsWebViewController *)_containerViewController;
        if ([webCtrl respondsToSelector:@selector(toShare:)]) {
            //webview方法
            [webCtrl toShare:jsonData];
        }
    }
}


// 空间预约，产品预约
- (void)toSubscribe:(NSString *)string {
    
    NSLog(@"==========toSubscribe===========");
    id jsonData = [self deserializeJsonString:string];
    NSLog(@"===jsonDic--%@===", jsonData);
    if (!jsonData) {
        return;
    }
    if ([_containerViewController isKindOfClass:[VSJsWebViewController class]])
    {
        VSJsWebViewController *webCtrl = (VSJsWebViewController *)_containerViewController;
        if ([webCtrl respondsToSelector:@selector(toShare:)]) {
            //webview方法
            [webCtrl toSubscribe:jsonData];
        }
    }
}

// 空间预订
- (void)toBook:(NSString *)string {
    NSLog(@"==========toBook===========");
    id jsonData = [self deserializeJsonString:string];
    NSLog(@"===toBook-jsonDic--%@===",jsonData);
    if (!jsonData) {
        return;
    }
    
    if ([_containerViewController isKindOfClass:[VSJsWebViewController class]])
    {
        VSJsWebViewController *webCtrl = (VSJsWebViewController *)_containerViewController;
        if ([webCtrl respondsToSelector:@selector(toBook:)]) {
            //webview方法
            [webCtrl toBook:jsonData];
        }
        
        webCtrl.TriggerFuncCallback = ^(NSString *func){
            [_webView performSelectorOnMainThread:@selector(stringByEvaluatingJavaScriptFromString:) withObject:func waitUntilDone:NO];
            //        [_webView stringByEvaluatingJavaScriptFromString:func];
        };
    }
}

- (void)toEnterpriceInfo:(NSString *)string {
    
    if (!string) {
        return;
    }
    
    if ([_containerViewController isKindOfClass:[VSJsWebViewController class]])
    {
        EnterpriceInfoViewController *webVC = [[EnterpriceInfoViewController alloc] initWithUrl:[NSURL URLWithString:string]];
        [_containerViewController.navigationController pushViewController:webVC animated:YES];
    }
}

// 金融 立即申请
- (void)toApply:(NSString *)string {
    NSLog(@"==========toApply===========");
    id jsonData = [self deserializeJsonString:string];
    NSLog(@"===toApply-jsonDic--%@===",jsonData);
    if (!jsonData) {
        return;
    }
    
    if ([_containerViewController isKindOfClass:[VSJsWebViewController class]])
    {
        VSJsWebViewController *webCtrl = (VSJsWebViewController *)_containerViewController;
        if ([webCtrl respondsToSelector:@selector(toApply:)]) {
            //webview方法
            [webCtrl toApply:jsonData];
        }
        
        webCtrl.TriggerFuncCallback = ^(NSString *func){
            [_webView performSelectorOnMainThread:@selector(stringByEvaluatingJavaScriptFromString:) withObject:func waitUntilDone:NO];
        };
    }
}

- (id)deserializeJsonString:(NSString *)jsonString{
    if (jsonString == nil) {
        NSLog(@"jsonString is nil");
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    if (error != nil) {
        NSLog(@"An error occurred while deserialization-error=%@=",error);
    }
    if ([jsonObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary *resultDic = [NSDictionary dictionaryWithDictionary:jsonObject];
        return resultDic;
    }else if ([jsonObject isKindOfClass:[NSArray class]]){
        return jsonObject;
    }
    return nil;
}
- (NSString *)getJsonStringWithStr:(NSString *)str{
    NSString *oldKey = @"\\'";
    NSString *newKey = @"\"";
    NSString *newStr = nil;
    NSRange range = [str rangeOfString:oldKey];
    if (range.location !=NSNotFound){
        newStr = [str stringByReplacingOccurrencesOfString:oldKey withString:newKey];
    }
    return newStr;
}
@end

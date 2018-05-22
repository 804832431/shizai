/*********************************************************************
 文件名称 : JavaScriptBridge.m
 作   者 :
 创建时间 : 2015-5-5
 文件描述 :
 *********************************************************************/
//

#import "JavaScriptBridge.h"
#import "JSDataFunction.h"
#import "JSWebView.h"
#import <objc/runtime.h>

/*这是easyjs-inject.js内容
 把它列为防止加载文件*/
NSString *INJECT_JS = @"window.EasyJS = {\
__callbacks: {},\
\
invokeCallback: function (cbID, removeAfterExecute){\
var args = Array.prototype.slice.call(arguments);\
args.shift();\
args.shift();\
\
for (var i = 0, l = args.length; i < l; i++){\
args[i] = decodeURIComponent(args[i]);\
}\
\
var cb = EasyJS.__callbacks[cbID];\
if (removeAfterExecute){\
EasyJS.__callbacks[cbID] = undefined;\
}\
return cb.apply(null, args);\
},\
\
call: function (obj, functionName, args){\
var formattedArgs = [];\
for (var i = 0, l = args.length; i < l; i++){\
if (typeof args[i] == \"function\"){\
formattedArgs.push(\"f\");\
var cbID = \"__cb\" + (+new Date);\
EasyJS.__callbacks[cbID] = args[i];\
formattedArgs.push(cbID);\
}else{\
formattedArgs.push(\"s\");\
formattedArgs.push(encodeURIComponent(args[i]));\
}\
}\
\
var argStr = (formattedArgs.length > 0 ? \"/\" + encodeURIComponent(formattedArgs.join(\"/\")) : \"\");\
\
var iframe = document.createElement(\"IFRAME\");\
iframe.setAttribute(\"src\", \"js-call:/\" + obj + \"/\" + encodeURIComponent(functionName) + argStr);\
document.documentElement.appendChild(iframe);\
iframe.parentNode.removeChild(iframe);\
iframe = null;\
\
var ret = EasyJS.retValue;\
EasyJS.retValue = undefined;\
\
if (ret){\
return decodeURIComponent(ret);\
}\
return ret;\
},\
\
inject: function (obj, methods){\
window[obj] = {};\
var jsObj = window[obj];\
\
for (var i = 0, l = methods.length; i < l; i++){\
(function (){\
var method = methods[i];\
var jsMethod = method.replace(new RegExp(\":\", \"g\"), \"\");\
jsObj[jsMethod] = function (){\
return EasyJS.call(obj, method, Array.prototype.slice.call(arguments));\
};\
})();\
}\
}\
};";

@interface JavaScriptBridge() <UIWebViewDelegate,NSURLConnectionDelegate>

@property (nonatomic, assign) JSWebView *webView;
@property (nonatomic, retain) NSURL *url;
@property (nonatomic, retain) NSURLConnection *urlConnection;

@end

@implementation JavaScriptBridge

/**
 *  重写 dealloc 方法
 */
- (void)dealloc
{
    [_javascriptInterfaces release];
    [_urlConnection cancel];
    [_urlConnection release];
    _webView = nil;
    [_url release];
    [super dealloc];
}

/**
 *  添加 JavaScript Interface
 *
 *  @param interface interface 实例
 *  @param name      interface 名称
 */
- (void)addJavascriptInterface:(NSObject *)interface withName:(NSString*)name
{
    if (!_javascriptInterfaces)
    {
        self.javascriptInterfaces = [NSMutableDictionary dictionary];
    }
    [_javascriptInterfaces setValue:interface forKey:name];
}

/**
 *  WebView 加载失败回调
 *
 *  @param webView webView 实例
 *  @param error   错误
 */
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //网页加载失败通知
//    [KNotificationCenter postNotificationName:NoticeName_WebViewDidFailLoadMsg object:nil];
}

/**
 *  WebView 加载开始回调
 *
 *  @param webView webView 实例
 */
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NoticeName_WebViewDidBeginLoadMsg object:nil];
}

/**
 *  WebView 加载结束回调
 *
 *  @param webView webView 实例
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //    NSLog(@"webViewDidFinishLoad");
    
    if (!_javascriptInterfaces)
    {
        self.javascriptInterfaces = [NSMutableDictionary dictionary];
    }
    
    if (_javascriptInterfaces.count > 0)
    {
        NSMutableString *injection = [NSMutableString string];
        
        //inject the javascript interface
        for(id key in _javascriptInterfaces)
        {
            NSObject* interface = [_javascriptInterfaces objectForKey:key];
            
            [injection appendString:@"EasyJS.inject(\""];
            [injection appendString:key];
            [injection appendString:@"\", ["];
            
            unsigned int mc = 0;
            Class cls = object_getClass(interface);
            Method * mlist = class_copyMethodList(cls, &mc);
            for (int i = 0; i < mc; i++)
            {
                [injection appendString:@"\""];
                [injection appendString:[NSString stringWithUTF8String:sel_getName(method_getName(mlist[i]))]];
                [injection appendString:@"\""];
                
                if (i != mc - 1)
                {
                    [injection appendString:@", "];
                }
            }
            free(mlist);
            [injection appendString:@"]);"];
        }
        
        NSString* js = INJECT_JS;
        //inject the basic functions first
        [webView stringByEvaluatingJavaScriptFromString:js];
        //inject the function interface
        [webView stringByEvaluatingJavaScriptFromString:injection];
    }
    
    NSString *jsMethod = [NSString stringWithFormat:@"%@()",@"iosInit"];
    [webView performSelectorOnMainThread:@selector(stringByEvaluatingJavaScriptFromString:) withObject:jsMethod waitUntilDone:NO];
    //网页加载完成通知
    [KNotificationCenter postNotificationName:NoticeName_WebViewDidLoadMsg object:nil];
}

/**
 *  WebView 加载 URL request
 *
 *  @param webView        webView实例
 *  @param request        URL request
 *  @param navigationType 请求类型
 *
 *  @return 是否执行原 URL request
 */

BOOL _Authenticated;
NSURLRequest *_FailedRequest;

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //网页开始加载通知
//    [KNotificationCenter postNotificationName:NoticeName_WebViewShouldStartLoadMsg object:nil];
    
    NSString *requestString = [[[request URL] absoluteString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"+++++requestString is %@",requestString);
    
    if ([requestString hasPrefix:@"js-call:"])
    {
        NSArray *components = [requestString componentsSeparatedByString:@"/"];
        
        NSString *name = [components objectAtIndex:1];
        NSString *method = [[components objectAtIndex:2] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSObject *interface = [_javascriptInterfaces objectForKey:name];
        
        // execute the interfacing method
        SEL selector = NSSelectorFromString(method);
        NSMethodSignature *sig = [[interface class] instanceMethodSignatureForSelector:selector];
        NSInvocation *invoker = [NSInvocation invocationWithMethodSignature:sig];
        invoker.selector = selector;
        invoker.target = interface;
        
        NSMutableArray *args = [NSMutableArray array];
        
        if ([components count] > 3)
        {
            NSArray *formattedArgs = [components subarrayWithRange:NSMakeRange(3, components.count - 3)];
            int argIndex = 2;
            for (int i = 0; i < formattedArgs.count; i += 2)
            {
                NSString *type = [formattedArgs objectAtIndex:i];
                NSString *argStr = [formattedArgs objectAtIndex:i + 1];
                
                if ([@"f" isEqualToString:type])
                {
                    JSDataFunction *func = [[JSDataFunction alloc] initWithWebView:(JSWebView *)webView];
                    func.funcID = argStr;
                    [args addObject:func];
                    [invoker setArgument:&func atIndex:argIndex];
                    argIndex++;
                }
                else if ([@"s" isEqualToString:type])
                {
                    NSString *arg = [argStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    [args addObject:arg];
                    [invoker setArgument:&arg atIndex:argIndex];
                    argIndex++;
                }
            }
        }
        [invoker invoke];
        
        //return the value by using javascript
        if ([sig methodReturnLength] > 0)
        {
            NSString *retValue;
            [invoker getReturnValue:&retValue];
            
            if (retValue == NULL || retValue == nil)
            {
                [webView stringByEvaluatingJavaScriptFromString:@"EasyJS.retValue=null;"];
            }
            else
            {
                retValue = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef) retValue, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8));
                [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"EasyJS.retValue=\"%@\";", retValue]];
            }
        }
        return NO;
    }
    else
    {
        //        NSString *lastComponent = [requestString pathExtension] ;
        //        NSArray *downloadArray = @[@"jpg",@"jpeg",@"png",@"bmp",@"doc",@"docx",@"xls",@"ppt",@"xlsx",@"pptx",@"pdf"];
        //        for (NSString *info in downloadArray) {
        //            if ([info caseInsensitiveCompare:lastComponent] == NSOrderedSame) {
        //                [[DownloadManager sharedInstance] downloadFileWithSourceURL:requestString];
        //                return NO;
        //            }
        //        }
        
        if (!_Authenticated &&[[[request URL] scheme] caseInsensitiveCompare:@"https" ] == NSOrderedSame) {
            BOOL result = _Authenticated;
            
            _FailedRequest = request;
            self.url = [NSURL URLWithString:requestString];
            self.webView = (JSWebView *)webView;
            NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
            [urlConnection start];
            self.urlConnection = urlConnection;
            [urlConnection release];
            
            return result;
        }
    }
    return YES;
}



////////////////////////////使UIwebView可以加载https网页内容===begin////////////////////////////

#pragma mark - NSURLConnectionDelegate

-(void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        NSURL* baseURL = _url;
        if ([challenge.protectionSpace.host isEqualToString:baseURL.host]) {
            NSLog(@"trusting connection to host %@", challenge.protectionSpace.host);
            [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
        } else
            NSLog(@"Not trusting connection to host %@", challenge.protectionSpace.host);
    }
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)pResponse {
    _Authenticated = YES;
    [connection cancel];
    [_webView loadRequest:_FailedRequest];
}

////////////////////////////使UIwebView可以加载https网页内容===end////////////////////////////

@end

/*********************************************************************
 文件名称 : JSDataFunction.m
 作   者 :
 创建时间 : 
 文件描述 :
 *********************************************************************/
//

#import "JSDataFunction.h"

@implementation JSDataFunction

- (id)initWithWebView:(JSWebView *)aWebView
{
    if (self = [super init])
    {
        self.webView = aWebView;
    }
    return self;
}

- (NSString *)execute
{
    return [self executeWithParams:nil];
}

- (NSString *)executeWithParam:(NSString*)param
{
    NSMutableArray *params = [NSMutableArray arrayWithObjects:param, nil];
    return [self executeWithParams:params];
}

- (NSString*)executeWithParams:(NSArray*)params
{
    NSMutableString *injection = [NSMutableString string];
    
    [injection appendFormat:@"EasyJS.invokeCallback(\"%@\", %@", self.funcID, self.removeAfterExecute ? @"true" : @"false"];
    
    if (params)
    {
        for (int i = 0; i < params.count; i++)
        {
            NSString *arg = [params objectAtIndex:i];
            CFStringRef encodedArg = CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)arg, NULL, (CFStringRef) @"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
            [injection appendFormat:@", \"%@\"", encodedArg];
            CFRelease(encodedArg);
        }
    }
    
    [injection appendString:@");"];
    
    if (_webView)
    {
        return [_webView stringByEvaluatingJavaScriptFromString:injection];
    }
    else
    {
        return nil;
    }
}

@end

/*********************************************************************
 文件名称 : JavaScriptBridge.h
 作   者 :
 创建时间 : 2015-5-5
 文件描述 :
 *********************************************************************/

#import <Foundation/Foundation.h>

@interface JavaScriptBridge : NSObject

@property (nonatomic, retain) NSMutableDictionary *javascriptInterfaces;
- (void)addJavascriptInterface:(NSObject *)interface withName:(NSString *)name;
@end

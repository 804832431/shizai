/*********************************************************************
 文件名称 : JSDataFunction.h
 作   者 :
 创建时间 : 
 文件描述 :
 *********************************************************************/
//

#import <Foundation/Foundation.h>
#import "JSWebView.h"

@interface JSDataFunction : NSObject

@property (nonatomic, retain) NSString *funcID;
@property (nonatomic, retain) JSWebView *webView;
@property (nonatomic, assign) BOOL removeAfterExecute;

- (id)initWithWebView:(JSWebView *)aWebView;

- (NSString *)execute;
- (NSString *)executeWithParam:(NSString*)param;
- (NSString *)executeWithParams:(NSArray*)params;

@end

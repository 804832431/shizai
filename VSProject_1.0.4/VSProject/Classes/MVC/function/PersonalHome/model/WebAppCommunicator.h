/*********************************************************************
 文件名称 : WebAppCommunicator.h
 作   者 : xu_liang
 创建时间 : 2015-5-5
 文件描述 : js交互接口方法
 *********************************************************************/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WebAppCommunicator : NSObject

- (id)initWithContainerViewController:(UIViewController *)containerViewController webView:(UIWebView *)webView;

@end

@interface DocumentSport : WebAppCommunicator

@end
@interface WebAppInterface : WebAppCommunicator

//打电话
- (void)toCall:(NSString *)string;
//去购物车（跳转）
- (void)toCart:(NSString *)string;
//去支付
- (void)toOrder:(NSString *)string;
//缓存购物车
- (void)toProInfo:(NSString *)string;
//预约
- (void)toPoint:(NSString *)string;
//预约
- (void)toShare:(NSString *)string;
// 空间预约，产品预约
- (void)toSubscribe:(NSString *)string;
// 空间预订
- (void)toBook:(NSString *)string;
// 金融 立即申请
- (void)toApply:(NSString *)string;
// 企业家详情页跳转
- (void)toEnterpriceInfo:(NSString *)string;
//获取缓存购物车的数据
- (NSString *)getCartInfo:(NSString *)key;
//刷新页面
- (void)refreshPage;
//根据key取数据,getDatas配对使用
- (NSString *)getDatas:(NSString *)key;
//根据key取数据，key格式为ecid+accountid+appid+key，与setDatas配对使用
- (void)setDatas:(NSString *)key :(NSString *)value;
@end

//
//  DiscoverViewController.h
//  VSProject
//
//  Created by pangchao on 16/12/27.
//  Copyright © 2016年 user. All rights reserved.
//

#import "VSBaseViewController.h"

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

typedef enum {
    
    DISCOVER_NEARBY = 0, // 附近项目
    DICOVER_SHARE = 1, // 分享
    DISCOVER_ENTERPRISE_CHANNEL = 2, // 企业频道
    DISCOVER_ENTERPENEUR_CLUB = 3, // 企业家俱乐部
} DISCOVER_PAGE;

@interface DiscoverViewController : VSBaseViewController

- (void)selectTabPageeWithIndex:(NSInteger)index;

@end

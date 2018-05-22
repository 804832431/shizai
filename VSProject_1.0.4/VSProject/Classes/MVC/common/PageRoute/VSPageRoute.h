//
//  VSPageRoute.h
//  VSProject
//
//  Created by apple on 1/4/17.
//  Copyright © 2017 user. All rights reserved.
//

#import <Foundation/Foundation.h>

#define VS_LOGIN_SUCCEED @"VS_LOGIN_SUCCEED"
#define VS_LOGOUT_SUCCEED @"VS_LOGOUT_SUCCEED"

@interface VSPageRoute : NSObject

+(void)routeToTarget:(id)object;

+(NSString*)dictionaryToJson:(NSDictionary *)dic;

+ (void)routeToSZFX;

+ (UINavigationController *)currentNav;

@end

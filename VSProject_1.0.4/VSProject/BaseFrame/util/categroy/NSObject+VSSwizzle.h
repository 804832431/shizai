//
//  NSObject+LCSwizzle.h
//  WuxianchangPro
//
//  Modify by ZT on 14-12-18.
//  Copyright (c) 2013年 Wuxiantai Developer ( http://www.wuxiantai.com ). All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark -

@interface UIView (VSSwizzle)

@end

#pragma mark -

@interface NSArray (VSSwizzle)

@end

#pragma mark -

@interface NSDictionary (VSSwizzle)

@end

#pragma mark -

@interface NSMutableDictionary (VSSwizzle)

@end

#pragma mark -

@interface NSObject (VSSwizzle)

+ (BOOL) swizzleAll;

@end

#pragma mark -


//
//  VSResultData.h
//  VSProject
//
//  Created by tiezhang on 15/1/12.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

#define INVALID_CODE        -1

@interface VSResultData : NSObject

@property(nonatomic, strong)NSString *message;              //错误信息
@property(nonatomic, strong)NSString *resultCode;           //返回code
@property(nonatomic, assign, readonly)BOOL     bsuccess;    //是否成功标示


+ (VSResultData*)createResultDataMessage:(NSString*)message resultCode:(NSString*)code;

@end

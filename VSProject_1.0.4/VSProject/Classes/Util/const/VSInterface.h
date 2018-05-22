//
//  VSInterface.h
//  VSProject
//
//  Created by tiezhang on 15/1/14.
//  Copyright (c) 2015年 user. All rights reserved.
//

#ifndef VSProject_VSInterface_h
#define VSProject_VSInterface_h

#define URLSTRINGFORMAT(STRA,STRB)                                      [NSString stringWithFormat:@"%@/%@",STRA,STRB]

#define URLSTRINGPATHFORMAT(__server__, __path__, __action__)           [NSString stringWithFormat:@"%@/%@/%@", __server__, __path__, __action__]

#define API_USER                @"user"

#pragma mark -- account
//登陆接口
#define API_LOGIN               URLSTRINGPATHFORMAT(SERVER_IP, API_USER, @"login.ashx")






#endif

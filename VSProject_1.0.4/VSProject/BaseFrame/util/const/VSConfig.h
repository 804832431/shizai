//
//  VSConfig.h
//  VSProject
//
//  Created by tiezhang on 15/1/13.
//  Copyright (c) 2015年 user. All rights reserved.
//

/*
 *打包注意事项
 *1.检测证书，bunldid
 *2.检查KVERSION_SHOW
 *3.检测配置文件版本号
 */

#ifndef VSProject_VSConfig_h
#define VSProject_VSConfig_h

//app配置版本号
#define KVERSION_APP                6.0
#define MAX_IMG_SIZE                1200.0f
#define RATE_IMG                    0.35
#define Socket_HeartInterval         6
//app展示版本号
#define KVERSION_SHOW

//server
#define SERVER_IP           @"http://www.dzbxk.com"
#define API_PATH            @"bestjoy"
#define IMG_PATH            @"proimg"

#define FAPIAO_PATH         @"fapiao"

#define MINGDOWN_SERVER     @"http://www.mingdown.com"

#define SERVER_IMAGE        @"http://115.29.231.29"

#define BESTJOY_SERVER      @"http://www.dzbxk.com/bestjoy"

#define REGEX_ONECODEFORMAT      @"[0-9a-zA-Z]{20}"
//#define REGEX_DZBXKFORMAT        @"http://c.dzbxk.com/"
#define REGEX_HAIERCODE          @"http://oid.haier.com/oid?ewm="
#define API_WuYiCodePath         @"http://www.dzbxk.com/bestjoy/Deal.ashx?para="




#define StarServ_HaierCodePath               @"http://115.29.231.29/haier/TransCode.ashx?oid="
#define StarServ_WYOneCodePath               @"http://115.29.231.29/haier/TransOne.ashx?oid="


#define SERVER_DOMAIN       URLSTRINGFORMAT(SERVER_IP, API_PATH)

#define IMG_DOMAIN          URLSTRINGFORMAT(SERVER_IP, IMG_PATH)

#define FAPIAO_DOMAIN       URLSTRINGFORMAT(SERVER_IP, FAPIAO_PATH)

#endif

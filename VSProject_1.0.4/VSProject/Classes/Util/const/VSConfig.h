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


/*-----------------***研发***-----------------*/
//#define PIC_SERVER_IP           @"http://172.16.31.135"
//#define SERVER_IP_H5            [NSString stringWithFormat:@"%@:8082",PIC_SERVER_IP]
//#define SERVER_IP               [NSString stringWithFormat:@"%@/api/jsonws",SERVER_IP_H5]
//
//
//#define USERNAME    @"admin"
//#define PASSWORD    @"ruiXZTDN76"
//
////DES密钥
//#define APP_DES_PASSWORDKEY     @"RUI12321"
//
//#define PUSH_SUFFIX    @"_dev"
/*-------------------------------------*/

//
/*-----------------***测试***-----------------*/
#define PIC_SERVER_IP           @"http://101.201.151.21"
#define SERVER_IP_H5            [NSString stringWithFormat:@"%@:8088",PIC_SERVER_IP]
#define SERVER_IP               [NSString stringWithFormat:@"%@/api/jsonws",SERVER_IP_H5]


#define USERNAME    @"admin"
#define PASSWORD    @"ruiXZTDN76"

//DES密钥
#define APP_DES_PASSWORDKEY     @"RUI12321"

#define PUSH_SUFFIX    @""
/*-------------------------------------*/



/*-----------------***生产ip**单版本号*-----------------*/
//#define PIC_SERVER_IP           @"http://182.92.31.87"
//#define SERVER_IP_H5            [NSString stringWithFormat:@"%@:8088",PIC_SERVER_IP]
//#define SERVER_IP               [NSString stringWithFormat:@"%@/api/jsonws",SERVER_IP_H5]
//
//
//#define USERNAME    @"admin"
//#define PASSWORD    @"ruiXZTDN76"
//
////DES密钥
//#define APP_DES_PASSWORDKEY     @"RUI12321"
//
//#define PUSH_SUFFIX    @""

/*-------------------------------------*/



/*-----------------***域名**双版本号*-----------------*/
//#define PIC_SERVER_IP           @"http://apib.rtianxia.com"
//#define SERVER_IP_H5            [NSString stringWithFormat:@"%@:8080",PIC_SERVER_IP]
//#define SERVER_IP               [NSString stringWithFormat:@"%@/api/jsonws",SERVER_IP_H5]
//
//
//#define USERNAME    @"admin"
//#define PASSWORD    @"ruiXZTDN76"
//
////DES密钥
//#define APP_DES_PASSWORDKEY     @"RUI12321"
//
//#define PUSH_SUFFIX    @""
/*-------------------------------------*/


#warning ===待正式上架前修改id
#define kAppCommentUrl       [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", @"sssss"]


#define SERVER_DOMAIN       URLSTRINGFORMAT(SERVER_IP, API_PATH)

#define IMG_DOMAIN          URLSTRINGFORMAT(SERVER_IP, IMG_PATH)

#define FAPIAO_DOMAIN       URLSTRINGFORMAT(SERVER_IP, FAPIAO_PATH)

//列表每页长度
#define KLISTREQUESTLENGTH  50

#endif

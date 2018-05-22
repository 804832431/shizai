//
//  VSInterface.h
//  VSProject
//
//  Created by tiezhang on 15/1/14.
//  Copyright (c) 2015年 user. All rights reserved.
//

#ifndef VSProject_VSInterface_h
#define VSProject_VSInterface_h

#define URLSTRINGFORMAT(STRA,STRB)                  [NSString stringWithFormat:@"%@/%@",STRA,STRB]

//版本检测
#define API_VERSION             URLSTRINGFORMAT(MINGDOWN_SERVER, @"mobile/getVersion.ashx")

#define API_REGISTERDEV         URLSTRINGFORMAT(SERVER_DOMAIN, @"Apple/RegisterDevice.ashx")

#define UCENTER                 URLSTRINGFORMAT(BESTJOY_SERVER,@"Ucenter.ashx")
//首页接口
#define API_GETADS              URLSTRINGFORMAT(BESTJOY_SERVER, @"ads.ashx")

#define API_GETIPWEATHER        URLSTRINGFORMAT(BESTJOY_SERVER, @"Weather/GetIPWeather.ashx")
//汽车接口
#define API_GETCARLIST          URLSTRINGFORMAT(BESTJOY_SERVER, @"Car/GetCar.ashx")

#define API_ADDCARPHONE            URLSTRINGFORMAT(BESTJOY_SERVER, @"Car/updatecarphone.ashx")

#define API_DELETECAR           URLSTRINGFORMAT(BESTJOY_SERVER, @"car/DeleteBaoXiuByCIDUID.ashx")

#define API_ADDCAR              URLSTRINGFORMAT(BESTJOY_SERVER, @"car/AddCar.ashx")

#define API_UPDATECAR           URLSTRINGFORMAT(BESTJOY_SERVER, @"car/updateCar.ashx")
//附近接口
#define API_GetNearbyxq         URLSTRINGFORMAT(BESTJOY_SERVER, @"GetNearbyxq.ashx")

//家当接口
#define API_CANREPAIR           URLSTRINGFORMAT(BESTJOY_SERVER,@"CanRepair.ashx")
//预约
#define API_ADDYUYUE            URLSTRINGFORMAT(BESTJOY_SERVER,@"CRM/AddYuYueWeiXiu.ashx")
//保修卡
#define API_ADDBX               URLSTRINGFORMAT(BESTJOY_SERVER,@"20140625/AddBaoXiu.ashx")

#define API_TYPEGET             URLSTRINGFORMAT(BESTJOY_SERVER,@"NGetXinHaoByPinPai.ashx")

#define API_UPDATEBX            URLSTRINGFORMAT(BESTJOY_SERVER,@"20140625/updateBaoXiu.ashx")

#define API_DELETEBX            URLSTRINGFORMAT(BESTJOY_SERVER,@"DeleteBaoXiuByBIDUID.ashx")

#define API_NEARBYBAOXIU        URLSTRINGFORMAT(BESTJOY_SERVER,@"GetNearby.ashx")

#define API_CHECKADD            URLSTRINGFORMAT(BESTJOY_SERVER,@"checkaddress.ashx")
//家接口
#define API_CREATEHOME          URLSTRINGFORMAT(BESTJOY_SERVER,@"Addaddr.ashx")

#define API_GetPhone            URLSTRINGFORMAT(BESTJOY_SERVER,@"Xiaoqu/GetXiaoQuAround.ashx")

#define API_ADDPHONE            URLSTRINGFORMAT(BESTJOY_SERVER, @"Xiaoqu/addPhone.ashx")

#define API_UPDATEHOME          URLSTRINGFORMAT(BESTJOY_SERVER,@"UpdateAddrByID.ashx")

#define API_ADDXIAOQU           URLSTRINGFORMAT(BESTJOY_SERVER,@"xiaoqu/addXiaoQuDetail.ashx")

#define API_DELDTEHOME          URLSTRINGFORMAT(BESTJOY_SERVER,@"DeleteAddressByAID.ashx")

//聊天
#define API_GETSERVICE          URLSTRINGFORMAT(BESTJOY_SERVER,@"Start/GetServiceUserByUID.ashx")

#define API_GETHISTORY          URLSTRINGFORMAT(BESTJOY_SERVER,@"Start/GetMessageByUIDByTID.ashx")
//注册
#define API_REGISTER            URLSTRINGFORMAT(BESTJOY_SERVER,@"20140718/Register.ashx")

//质保卡列表
#define API_ZBKLIST             URLSTRINGFORMAT(BESTJOY_SERVER,@"CRM/GetRangeZhibao.ashx")

//ucenter
#define API_ZBKUCENTER          URLSTRINGFORMAT(BESTJOY_SERVER,@"Ucenter.ashx")

//查单
#define API_CHADAN              URLSTRINGFORMAT(BESTJOY_SERVER,@"crm/GetYuyueRecord.ashx")







#endif

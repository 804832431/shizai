//
//  VSEnum.h
//  VSProject
//
//  Created by tiezhang on 15/1/13.
//  Copyright (c) 2015年 user. All rights reserved.
//

#ifndef VSProject_VSEnum_h
#define VSProject_VSEnum_h

//表单提交类型
typedef enum _SUBMIT_TYPE
{
    SUBMIT_TYPE_CREATE  = 1,    //创建
    SUBMIT_TYPE_UPDATE,         //更新
}SUBMIT_TYPE;
typedef enum _SCAN_RESULT_TYPE
{
    SCAN_RESULT_UNKNOW      = -1,
    
    SCAN_RESULT_HAIER,
    SCAN_RESULT_ONECODE,
    SCAN_RESULT_DZBXK,
    SCAN_RESULT_VCARD,
    SCAN_RESULT_NORMALURL,
    SCAN_RESULT_DZZBK,
}SCAN_RESULT_TYPE;
//VC类型
typedef enum _VC_TYPE
{
    _VC_TYPE_HomePage      = -1,
    _VC_TYPE_Jiadang,
    _VC_TYPE_Car,
}VC_TYPE;


typedef enum _ZBK_PushType
{
    _ZBK_PushType_Detail      = -1,
    _ZBK_PushType_Create,
    
}_ZBK_PushType;

typedef enum _PUSH_TYPE
{
    PUSH_TYPE_NONE = -1,
    
    PUSH_TYPE_TEXT = 1,
    PUSH_TYPE_URL,
    
    PUSH_TYPE_MAX,
}PUSH_TYPE;

#endif

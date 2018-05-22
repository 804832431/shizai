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

//性别类型
typedef enum _SEX_TYPE
{
    SEX_TYPE_MALE,              //男
    SEX_TYPE_FEMALE,            //女
}SEX_TYPE;

//出租类型
typedef enum _RENT_TYPE
{
    RENT_TYPE_REQUIRED = 1,      //求
    RENT_TYPE_POST,              //出租自己
}RENT_TYPE;

//出租类型
typedef enum _RENT_CATEGORY_TYPE
{
    RENT_CATEGORY_ALL,
    RENT_CATEGORY_BIRTHDAY = 1,         //生日
    RENT_CATEGORY_HOLIDAY,              //节日
    RENT_CATEGORY_OTHER,                //其他
}RENT_CATEGORY_TYPE;

//出租类型
typedef enum _VIP_TYPE
{
    VIP_TYPE_NONE   = 0,         //非会员
    
    VIP_TYPE_NO1,               //1级会员
    VIP_TYPE_NO2,               //2级会员
    VIP_TYPE_NO3,               //3级会员
    VIP_TYPE_NO4,               //4级会员
}VIP_TYPE;

//remote push type
typedef enum _PUSH_TYPE
{
    PUSH_TYPE_NONE = -1,
    
    PUSH_TYPE_TEXT = 1,
    PUSH_TYPE_URL,
    
    PUSH_TYPE_MAX,
}PUSH_TYPE;

//消息发送状态
typedef NS_ENUM(long, MsgSendStatus)
{
    MsgsendNoResult    = 4,
    MsgIsReadyToSend   = 3,
    MsgIsSending       = 2,
    MsgSendSuccess     = 1,
    MsgSendFailed      = 0,
};

//登录返回类型
typedef NS_ENUM(long,LOGIN_BACK) {
    LOGIN_BACK_DEFAULT = 0,
    LOGIN_BACK_HOME,
    LOGIN_BACK_TAB_HOME,
    LOGIN_BACK_TAB_MANAGE,
    LOGIN_BACK_CENTER,
    
};



//================枚举类型================

//	订单状态枚举
#define ORDER_CREATED           @"ORDER_CREATED"//O2O、B2C订单初始状态
#define ORDER_APPROVED          @"ORDER_APPROVED"//O2O已支付
#define ORDER_PROCESSING        @"ORDER_PROCESSING"//商家接单（O2O）B2C已支付状态
#define ORDER_CANCLEING         @"ORDER_CANCLEING"//客户申请取消
#define ORDER_CANCELLED         @"ORDER_CANCELLED"//取消成功
#define ORDER_SENT              @"ORDER_SENT"//已发货
#define ORDER_REJECTED          @"ORDER_REJECTED"//商家拒单
#define ORDER_COMPLETED         @"ORDER_COMPLETED"//订单完成

#define ORDER_REFUND_CREATED    @"ORDER_REFUND_CREATED"//申请退货（退款）
#define ORDER_REFUND_REJECTED   @"ORDER_REFUND_REJECTED"//拒绝退货（退款）
#define ORDER_REFUND_PROCESSING @"ORDER_REFUND_PROCESSING"//退款中（同意退款）
#define ORDER_REFUND_COMPLETED  @"ORDER_REFUND_COMPLETED"//退货（退款）完成

//新状态 "申请退款"
#define RETURN_REQUESTED @"RETURN_REQUESTED"

/**
 * 拒绝退货（退款）
 */
#define RETURN_MAN_REFUND @"RETURN_MAN_REFUND"


/**
 * 退款中（同意退款）
 */
#define RETURN_ACCEPTED @"RETURN_ACCEPTED"

/**
 * 退货（退款）完成 "退款成功"
 */
#define RETURN_COMPLETED @"RETURN_COMPLETED"

//订单类型枚举
#define SALES_ORDER_O2O_SALE @"SALES_ORDER_O2O_SALE" //020订单
#define SALES_ORDER_O2O_SERVICE @"SALES_ORDER_O2O_SERVICE" //020预约
#define SALES_ORDER_B2C @"SALES_ORDER_B2C" //B2C订单
#define SALES_ORDER_O2O_SERVICE_PAY @"SALES_ORDER_O2O_SERVICE_PAY"//020预约支付

//通知代办返回的枚举
#define NAGENT_SUBMIT               @"submit"//待受理
#define NAGENT_CANCELED             @"canceled"//已取消
#define NAGENT_PROCESSING           @"processing"//处理中
#define NAGENT_REJECT               @"reject"//预约失败
#define NAGENT_CONFIRM              @"confirm"//预约成功


//改版使用订单宏定义
#define  SZ_ORDER_CREATED       @"ORDER_CREATED"   //已创建
#define  SZ_ORDER_APPROVED      @"ORDER_APPROVED"  //已核准：
#define  SZ_ORDER_PROCESSING    @"ORDER_PROCESSING" //已处理
#define  SZ_ORDER_SENT          @"ORDER_SENT"   //已发送
#define  SZ_ORDER_COMPLETED     @"ORDER_COMPLETED"   //已完成

#define  SZ_RETURN_REQUESTED    @"RETURN_REQUESTED"   //退款申请中
#define  SZ_RETURN_ACCEPTED     @"RETURN_ACCEPTED"    //退款已同意
#define  SZ_RETURN_MAN_REFUND   @"RETURN_MAN_REFUND"    //拒绝退款
#define  SZ_RETURN_COMPLETED    @"RETURN_COMPLETED"   //退款成功,已退款

#define  SZ_ORDER_CANCELLED       @"ORDER_CANCELLED"   //已取消



//购买类：
#define SZ_SALES_ORDER_O2O_SALE         @"SALES_ORDER_O2O_SALE"
#define SZ_SPACE_ORDER_BOOK             @"SPACE_ORDER_BOOK"
//服务类：
#define SZ_SALES_ORDER_O2O_SERVICE_PAY  @"SALES_ORDER_O2O_SERVICE_PAY"
//预约类
#define SZ_SALES_ORDER_SUBSCRIBE @"SALES_ORDER_SUBSCRIBE"
#define SZ_SPACE_ORDER_SUBSCRIBE @"SPACE_ORDER_SUBSCRIBE"






#endif

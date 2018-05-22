//
//  VSConst.h
//  VSProject
//
//  Created by user on 15/1/10.
//  Copyright (c) 2015年 user. All rights reserved.
//

#ifndef VSProject_VSConst_h
#define VSProject_VSConst_h


/*******************************************常用的色值***************************************************************/

#define  _Colorhex(hex) ColorWithHex(hex,1)
#define  ColorWithHex(hex,alp) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 \
green:((float)((hex & 0xFF00) >> 8)) / 255.0 \
blue:((float)(hex & 0xFF)) / 255.0 \
alpha:alp]

#define kColor_808080       ColorWithHex(0x808080, 1)

#define kColor_ffffff       ColorWithHex(0xffffff, 1)

#define kColor_f2f2f2       ColorWithHex(0xf2f2f2, 1)

#define kColor_fff6db       ColorWithHex(0xfff6db, 1)

#define kColor_e4e4e4       ColorWithHex(0xe4e4e4, 1)

#define kColor_eeeeee       ColorWithHex(0xeeeeee, 1)

#define kColor_000000       ColorWithHex(0x000000, 1)

#define kColor_333333       ColorWithHex(0x333333, 1)

#define kColor_7a2b99       ColorWithHex(0x7a2b99, 1)

#define kColor_008ffe       ColorWithHex(0x008ffe, 1)

#define kColor_0d0d0d       ColorWithHex(0x0d0d0d, 1)

#define kColor_cccccc       ColorWithHex(0xcccccc, 1)

#define kColor_bbbbbb       ColorWithHex(0xbbbbbb, 1)

#define kColor_666666       ColorWithHex(0x666666, 1)

#define kColor_999999       ColorWithHex(0x999999, 1)

#define kColor_d9d9d9       ColorWithHex(0xd9d9d9, 1)

#define kColor_dbdbdb       ColorWithHex(0xdbdbdb, 1)

#define kColor_3690ed       ColorWithHex(0x3690ed, 1)

#define kColor_b5b5b5       ColorWithHex(0xb5b5b5, 1)

#define kColor_222222       ColorWithHex(0x222222, 1)

#define kColor_56554e       ColorWithHex(0x56554e, 1)

#define kColor_717171       ColorWithHex(0x717171, 1)

//绿地Add --start
#define kColor_efae24       ColorWithHex(0xefae24, 1)
#define kColor_24bdef       ColorWithHex(0x24bdef, 1)
#define kColor_b2b2b2       ColorWithHex(0xb2b2b2, 1)
#define kColor_717171       ColorWithHex(0x717171, 1)
#define kColor_0065ff       ColorWithHex(0x0065ff, 1)

//绿地Add --end
#define kColor_Male         _RGB_A(23.f, 180.f, 255.f, 1)

#define kColor_FeMale       _RGB_A(255.f, 62.f, 240.0f, 1)

#define kColor_MainTheme    _RGB_A(101.f, 20.0, 135.0, 1)

#define kColor_MainBGColor  ColorWithHex(0xf4f4f4, 1.0)

#define kColor_Clear        [UIColor clearColor]

#define _COLOR_GRAY_LINE                            [Util getColor:@"D5D5D5"]
#define _COLOR_MAINBLUE                             _COLOR_HEX(0x4794e9)
#define _COLOR_RED                                  [UIColor redColor]
#define _COLOR_BLUE                                 [UIColor blueColor]
#define _COLOR_YELLOW                               [UIColor yellowColor]
#define _COLOR_GREEN                                [UIColor greenColor]
#define _COLOR_BLACK                                [UIColor blackColor]
#define _COLOR_WHITE                                [UIColor whiteColor]
#define _COLOR_CLEAR                                [UIColor clearColor]
#define _COLOR_DARK_GRAY                            [UIColor darkGrayColor]
#define _COLOR_GRAY                                 [UIColor grayColor]
#define _COLOR_LIGHT_GRAY                           [UIColor lightGrayColor]

/*******************************************常用的色值***************************************************************/

/*******************************************常用的字号字体************************************************************/

#define kSysFont_10     __FONT_TITLE__(10)

#define kSysFont_11     __FONT_TITLE__(11)

#define kSysFont_12     __FONT_TITLE__(12)

#define kSysFont_13     __FONT_TITLE__(13)

#define kSysFont_14     __FONT_TITLE__(14)

#define kSysFont_15     __FONT_TITLE__(15)

#define kSysFont_16     __FONT_TITLE__(16)

#define kBoldFont_10    __BOLD_FONT_TITLE__(10)

#define kBoldFont_11    __BOLD_FONT_TITLE__(11)

#define kBoldFont_12    __BOLD_FONT_TITLE__(12)

#define kBoldFont_13    __BOLD_FONT_TITLE__(13)

#define kBoldFont_14    __BOLD_FONT_TITLE__(14)

#define kBoldFont_15    __BOLD_FONT_TITLE__(15)

#define kBoldFont_16    __BOLD_FONT_TITLE__(16)

#define kBoldFont_18    __BOLD_FONT_TITLE__(18)

#define kBoldFont_25    __BOLD_FONT_TITLE__(25)

#define kBoldFont_30    __BOLD_FONT_TITLE__(30)

/*******************************************常用的字号字体************************************************************/

/*******************************************项目中的通知名************************************************************/

#define kNotification_name_loginSuccess     @"kNotification_name_loginSuccess"

#define NoticeName_ReSendMsg     @"notificationResendMsg"
#define NoticeName_WebViewDidBeginLoadMsg     @"notificationWebViewDidBeginLoad"
#define NoticeName_WebViewDidLoadMsg     @"notificationWebViewDidLoad"
#define NoticeName_WebViewDidFailLoadMsg     @"notificationWebViewDidFailLoad"
#define NoticeName_WebViewShouldStartLoadMsg     @"notificationWebViewShouldStartLoadMsg"

#define KNotificationCenter            [NSNotificationCenter defaultCenter]


#define kALPaySucNotification @"kALPaySucNotification"
#define kALPayFailNotification @"kALPayFailNotification"
#define kWXPaySucNotification @"kWXPaySucNotification"
#define kWXPayFailNotification @"kWXPayFailNotification"

#define kOrderStatusNotification @"kOrderStatusNotification"

#define kHome_BackHomeC @"kBackHomeC"


#define BannerHeight (320/750.0 * [UIScreen mainScreen].bounds.size.width)

/*******************************************项目中的通知名************************************************************/

//placeholderimage
#define kPlaceHolderImage   __IMAGENAMED__(@"usercenter_defaultpic")

#define kDefaultHeadImage   __IMAGENAMED__(@"icon_head_default")

#define kERROR_MESSAGE      @"网络异常"

/*******************************************tag分配区域************************************************************/

#define kTagWindowStart         100000

/*******************************************tag分配区域************************************************************/

/*******************************************常用时间格式************************************************************/

#define kTimeFormat_YMDHMS      @"yyyy-MM-dd HH:mm:ss"

#define kTimeFormat_YMD         @"yyyy-MM-dd"

/*******************************************常用时间格式************************************************************/

/*****************************************************常量提示文本**************************************************/

#define kminPassWord            6
#define kmaxPassWord            16
#define kpasswordNote           [NSString stringWithFormat:@"%d-%d位的数字字母", kminPassWord, kmaxPassWord]

/*****************************************************常量提示文本**************************************************/

#endif

//
//  VSDefine.h
//  VSProject
//
//  Created by user on 15/1/10.
//  Copyright (c) 2015年 user. All rights reserved.
//

#ifndef VSProject_VSDefine_h
#define VSProject_VSDefine_h

#import "UIView+InitUI.h"
#import "VSJsonHelper.h"

#ifdef DEBUG
#define DBLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DBLog(xx, ...)  ((void)0)
#endif

#define __IMAGENAMED__(__imagename__)                   [UIImage imageNamed:__imagename__]
//请求

#define   VSBaseHttpManager_Class            [VSBaseHttpManager class]

#define  RETINA_1PX                          1.f/[UIScreen mainScreen].scale

//数据类型描述宏
#define  __dataitem_typeof__(...)

#define FONT_TITLE(X) __FONT_TITLE__(X) 

#define __FONT_TITLE__(X)                               [UIFont systemFontOfSize:X]

#define __BOLD_FONT_TITLE__(X)                          [UIFont boldSystemFontOfSize:X]

#define _CGP(x, y)                                      CGPointMake(x, y)
#define _CGS(w, h)                                      CGSizeMake(w, h)
#define _CGR(x, y, w, h)                                CGRectMake(x, y, w, h)
#define _CGC(__Frame__)                                 CGPointMake(CGRectGetMidX(__Frame__),CGRectGetMidY(__Frame__))
#define _RGB_A(r, g, b, a)                              [UIColor colorWithRed:r/256.0f green:g/256.0f blue:b/256.0f alpha:a]
#define _UIColorFromRGB(rgbValue)                       [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define __SCREEN_WIDTH__                                [UIScreen mainScreen].bounds.size.width
#define __SCREEN_HEIGHT__                                [UIScreen mainScreen].bounds.size.height

//UI 动态布局
#define GetWidth(UI)                                    CGRectGetWidth(UI.frame)
#define GetHeight(UI)                                   CGRectGetHeight(UI.frame)
#define OffSetX(UI)                                     CGRectGetMaxX(UI.frame)
#define OffSetY(UI)                                     CGRectGetMaxY(UI.frame)
#define MainWidth [UIScreen mainScreen].bounds.size.width
#define MainHeight [UIScreen mainScreen].bounds.size.height

//适配
#define Get750Height(h)                                 (h) * MainWidth / 750
#define Get750Width(w)                                  (w) * MainWidth / 750

//解析字典
#define VSGetElemForKeyFromDict(__key, __dict)          [VSJsonHelper getElementForKey:__key fromDict:__dict]
#define VSGetObjFromDict(__key, __dict, __class)        [VSJsonHelper getElementForKey:__key fromDict:__dict forClass:__class]
#define PUGetElemForKeyFromDict(__key, __dict)   [[VSJsonHelper class] getElementForKey:__key fromDict:__dict]
#define PUGetObjFromDict(__key, __dict, __class) [[VSJsonHelper class] getElementForKey:__key fromDict:__dict forClass:__class]

#define WMGetElemForKeyFromDict(__key, __dict)          [VSJsonHelper getElementForKey:__key fromDict:__dict]

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#define VS_TEXTSIZE(text, font) [text length] > 0 ? [text sizeWithAttributes:@{NSFontAttributeName:font}] : CGSizeZero;
#else
#define VS_TEXTSIZE(text, font) [text length] > 0 ? [text sizeWithFont:font] : CGSizeZero;
#endif

///声明为单例类
///需要在@interface中声明以下函数原型
///+ (className *)sharedInstance
#define DECLARE_SINGLETON_B(className) \
static className *singletonInstance = nil; \
\
+ (className *)shareInstance { \
@synchronized (self) { \
if (!singletonInstance) { \
[[self alloc] init]; \
} \
} \
return singletonInstance; \
} \
\
+ (id)allocWithZone:(NSZone *)zone { \
@synchronized (self) { \
if (!singletonInstance) { \
singletonInstance = [super allocWithZone:zone]; \
return singletonInstance; \
} \
} \
return nil; \
} \
\
- (id)copyWithZone:(NSZone *)zone; { \
return self; \
} \


#define DECLARE_SINGLETON_A(className) \
static className *singletonInstance = nil; \
+ (className *)shareInstance { \
@synchronized (self) { \
if (!singletonInstance) { \
singletonInstance = [[self alloc] init]; \
} \
return singletonInstance; \
} \
} \

#ifdef DEBUG
#define DECLARE_SINGLETON DECLARE_SINGLETON_A
#else
#define DECLARE_SINGLETON DECLARE_SINGLETON_B
#endif


#define _REMOVEALLSUBVIEWS_(__superview__) \
do {[__superview__.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];} while(0)

#define INVALIDATE_TIMER(__timer__) do{ [__timer__ invalidate]; __timer__ = nil; } while(0)

#ifndef _CLEAR_BACKGROUND_COLOR_
#define _CLEAR_BACKGROUND_COLOR_(_view_) \
do {[_view_ setBackgroundColor:[UIColor clearColor]];} while(0)
#endif


#ifndef _ALLOC_OBJ_
#define _ALLOC_OBJ_(__obj_class__) \
[[__obj_class__ alloc]init]
#endif

#ifndef _ALLOC_OBJ_WITHFRAME_
#define _ALLOC_OBJ_WITHFRAME_(__obj_class__, __frame__) \
[[__obj_class__ alloc]initWithFrame:__frame__]
#endif

#ifndef _ALLOC_VC_CLASS_
#define _ALLOC_VC_CLASS_(__vc_class__)\
_ALLOC_VC_CLASS_XIB_(__vc_class__, NSStringFromClass(__vc_class__))
#endif

#ifndef _ALLOC_VC_CLASS_XIB_
#define _ALLOC_VC_CLASS_XIB_(__vc_class__, __xib_name__)\
[[__vc_class__ alloc]initWithNibName:__xib_name__ bundle:nil];
#endif

#ifndef _ALLOC_VIEW_CLASS_XIB_
#define _ALLOC_VIEW_CLASS_XIB_(__view_class__)\
[[UIView class] wm_loadViewXib:__view_class__]

#endif

#define _LOADVC_FROMSTORYBORAD_(__storyboardname__, __vc_name__)\
[[UIStoryboard storyboardWithName:__storyboardname__ bundle:nil] instantiateViewControllerWithIdentifier:__vc_name__];
//****************************************create****************************************/
#define _CREATELINEinSUPERVIEW(y,_superView)\
{\
    UIView *line=[[UIView alloc]initWithFrame:_CGR(0, y-1, MainWidth, 0.5)];\
    line.backgroundColor = _Colorhex(0xdedede);\
    [_superView addSubview:line];\
}

#define _COLOR_HEX(x) _Colorhex(x)

#define _COLOR_MAINBLUE _COLOR_HEX(0x4794e9)

#define _COLOR_WHITE  [UIColor whiteColor]
//****************************************property****************************************/
#define _PROPERTY_NONATOMIC_READONLY(__class__, __property__)\
@property(nonatomic, readonly)__class__  * __property__;

#define _PROPERTY_NONATOMIC_ASSIGN(__class__, __property__)\
@property (nonatomic, assign)__class__  __property__;

#define _PROPERTY_NONATOMIC_COPY(__class__, __property__)\
@property (nonatomic, copy)__class__  *__property__;

#define _PROPERTY_NONATOMIC_WEAK(__class__, __property__)\
@property (nonatomic, weak)__class__    __property__;

#define _PROPERTY_NONATOMIC_STRONG(__class__, __property__)\
@property (nonatomic, strong) __class__ *__property__;

#define _PROPERTY_NONATOMIC_STRONG_IGNORE(__class__, __property__)\
_PROPERTY_NONATOMIC_STRONG(__class__<Ignore>, __property__);

#define _PROPERTY_NONATOMIC_STRONG_OPTION(__class__, __property__)\
_PROPERTY_NONATOMIC_STRONG(__class__<Optional>, __property__);

//****************************************GETTER****************************************/
#define _GETTER_BEGIN(__class__, __property__) \
- (__class__*)__property__ \
{\
if(!_##__property__)\
{\


#define _GETTER_ALLOC_BEGIN(__class__, __property__) \
- (__class__*)__property__ \
{\
if(!_##__property__)\
{\
_##__property__ = _ALLOC_OBJ_(__class__);


#define _GETTER_ALLOC_FRAME_BEGIN(__class__, __property__, __frame__) \
- (__class__*)__property__ \
{\
if(!_##__property__)\
{\
_##__property__ = _ALLOC_OBJ_WITHFRAME_(__class__, __frame__);


#define _GETTER_END(__property__) \
}\
return _##__property__;\
}
//****************************************getter宏****************************************/

//****************************************setter宏****************************************/
#define __SETTER_STRONG__(__property__)\
{\
if(_##__property__ != __property__)\
{\
_##__property__ = nil;\
_##__property__ = __property__;\
}\
}

#define _SETTER_COPY(__property__)\
{\
if(_##__property__ != __property__)\
{\
_##__property__  = nil;\
_##__property__ = [__property__ copy];\
}\
}
//=========setter宏============
#define _SETLABEL_STYLE(_label,font,textcolor,text)\
if([_label isKindOfClass:[UILabel class]])\
{\
    [_label setFont:[UIFont systemFontOfSize:font]];\
    [_label setTextColor:textcolor];\
    [_label setText:text];\
}
#define _CREATE_LABEL_AND_ADDSUBVIEW(__label__, __frame__, __align__, __font__,__superView__,__text__,__color__)\
{\
__label__ = _ALLOC_OBJ_WITHFRAME_(UILabel, __frame__);\
[__label__ setBackgroundColor:[UIColor clearColor]];\
[__label__ setTextAlignment:__align__];\
[__label__ setFont:__font__];\
[__superView__ addSubview:__label__];\
[__label__ setText:__text__];\
[__label__ setTextColor:[Util getColor:__color__]];\
}
//UIButton
#define _CREATE_ALLOC_BUTTON(__btn__, __frame__, __selector__)\
{\
__btn__       = _ALLOC_OBJ_WITHFRAME_(UIButton, __frame__);\
[__btn__ addTarget:self action:__selector__ forControlEvents:UIControlEventTouchUpInside];\
}

#define _CREATE_BUTTON(__btn__, __frame__, __title__, __titlefontsize__, __selector__)\
{\
__btn__       = [UIButton buttonWithType:UIButtonTypeCustom];\
__btn__.frame = __frame__;\
[__btn__ addTarget:self action:__selector__ forControlEvents:UIControlEventTouchUpInside];\
[__btn__ setTitle:__title__ forState:UIControlStateNormal];\
[__btn__.titleLabel setFont:FONT_TITLE(__titlefontsize__)];\
}

#ifndef _SETDEFAULT_VIEW_STYLE_
#define _SETDEFAULT_VIEW_STYLE_(__view, __borderColor, __radius)\
if([__view isKindOfClass:[UIView class]])\
{\
__view.layer.cornerRadius  = __radius;\
__view.layer.borderWidth   = 1.0f;\
__view.layer.masksToBounds = YES;\
__view.layer.borderColor   = __borderColor.CGColor;\
}
#endif

#endif
//安全释放
#define RELEASE_SAFELY(__POINTER) do{  __POINTER = nil; } while(0)
//#define INVALIDATE_TIMER(__TIMER) do{ [__TIMER invalidate]; RELEASE_SAFELY(__TIMER); } while(0)
#define RELEASE_SUPER_DEALLOC     do{  } while(0)

#define RELEASE_SAFELY_NILDELEGATE(__POINTER__) \
do{  \
if([__POINTER__ respondsToSelector:@selector(delegate)])\
{\
[__POINTER__ performSelector:@selector(setDelegate:) withObject:nil];\
}\
RELEASE_SAFELY(__POINTER__);\
} while(0)

#define _SIMPLE_ALERT_(__title, __message, __btnTitle)\
{\
UIAlertView* __alert__ = [[UIAlertView alloc] initWithTitle:__title message:__message delegate:nil cancelButtonTitle:__btnTitle otherButtonTitles:nil,nil];\
[__alert__ show];\
}


//===========iphone相关==========
#define __IOS_VERSION__                               [[[UIDevice currentDevice] systemVersion] doubleValue]
#define __APP_VERSION__                               [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define __BUILD_VERSION__                               [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]


//===========iphone相关==========
#define _SET_RETAINPARM_(__property__, __key__)\
{\
[self setParm:__property__ forKey:__key__];\
}

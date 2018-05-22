//
//  BusinessAccountModel.h
//  VSProject
//
//  Created by XuLiang on 15/11/2.
//  Copyright © 2015年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusinessAccountModel : NSObject

@property (nonatomic, strong) NSString * m_title;
@property (nonatomic, strong) NSString * m_content;
@property (nonatomic, retain) UIColor  * m_tintcolor;
@property (nonatomic, assign) BOOL       m_isNeedAccessory;

@end

//
//  EnterpriseInfoViewController.h
//  VSProject
//
//  Created by CertusNet on 16/3/15.
//  Copyright © 2016年 user. All rights reserved.
//

#import "VSBaseViewController.h"

typedef enum : NSUInteger {
    ROLE_employee = 0,
    ROLE_admin,
} ROLE_TYLE;
@interface EnterpriseInfoViewController : VSBaseViewController
@property (nonatomic,strong)NSString *titleName;
@property (nonatomic,strong)NSString *resourceName;
@property (nonatomic,assign)ROLE_TYLE roleType;

@end

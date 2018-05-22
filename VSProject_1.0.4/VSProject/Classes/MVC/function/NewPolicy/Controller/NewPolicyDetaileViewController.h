//
//  NewPolicyDetaileViewController.h
//  VSProject
//
//  Created by apple on 11/6/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "NewShareWebViewController.h"
#import "NewPolicyModel.h"

@interface NewPolicyDetaileViewController : NewShareWebViewController

_PROPERTY_NONATOMIC_STRONG(NewPolicyModel, p_model);

_PROPERTY_NONATOMIC_COPY(NSString, selectedAreaId);

@end

//
//  OneKeyConsignManager.h
//  VSProject
//
//  Created by apple on 9/3/17.
//  Copyright © 2017 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OneKeyConsignManager : NSObject

+ (OneKeyConsignManager *)sharedOneKeyConsignManager;

- (void)showConsignView;

- (void)showCustomServiceView;

@end

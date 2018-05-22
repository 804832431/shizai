//
//  DetaileAdressViewController.h
//  VSProject
//
//  Created by certus on 15/11/17.
//  Copyright © 2015年 user. All rights reserved.
//

#import "VSBaseViewController.h"


typedef void(^DetaileAdressBlock) (NSString *adress);

@interface DetaileAdressViewController : VSBaseViewController

@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) DetaileAdressBlock adrtessBlock;
@property (strong, nonatomic) NSString *adreess;
@property (strong, nonatomic) NSString *titleLabel;

@end

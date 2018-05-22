//
//  OneConsignView.h
//  VSProject
//
//  Created by apple on 9/3/17.
//  Copyright © 2017 user. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickBlock)(NSDictionary *dic);

@interface OneConsignView : UIView
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UIView *labelView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelViewHight;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *labelArray;

@property (nonatomic, strong) ClickBlock clickBlock;

- (void)setDataSource:(NSArray *)array;

@end

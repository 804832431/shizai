//
//  HomeShareLineView.h
//  VSProject
//
//  Created by apple on 12/30/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeShareLineView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *shareImageView;
@property (weak, nonatomic) IBOutlet UILabel *shareLabel;
@property (weak, nonatomic) IBOutlet UILabel *shareTimeLabel;
@property (weak, nonatomic) IBOutlet UITextView *shareTextView;

- (void)onSetTime:(NSNumber *)time;

@end

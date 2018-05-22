//
//  PlaceholderTextView.h
//  VSProject
//
//  Created by pangchao on 16/12/26.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceholderTextView : UITextView
{
    NSString    *_placeholder;
    
    UIColor     *_placeholderColor;
    
    UILabel     *_placeHolderLabel;
}

@property(nonatomic,strong) UILabel     *placeHolderLabel;
@property(nonatomic,strong) NSString    *placeholder;
@property(nonatomic,strong) UIColor     *placeholderColor;

- (void)textChanged:(NSNotification*)notification;

@end

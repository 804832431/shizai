//
//  MessageCell.h
//  VSProject
//
//  Created by certus on 16/1/19.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIImageView *m_imageView;

@property (strong, nonatomic) IBOutlet UILabel *m_timeLabel;

@property (strong, nonatomic) IBOutlet UILabel *m_titleLabel;

- (void)vp_updateUIWithModel:(id)model;

@end

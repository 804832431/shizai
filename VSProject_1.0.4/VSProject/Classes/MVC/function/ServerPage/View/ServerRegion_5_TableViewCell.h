//
//  ServerRegion_5_TableViewCell.h
//  VSProject
//
//  Created by pangchao on 17/6/26.
//  Copyright © 2017年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicDTO.h"

typedef void (^ServerRgion_5_Block)(TopicProductDTO *topicDTO);

@interface ServerRegion_5_TableViewCell : UITableViewCell

@property (nonatomic, strong) TopicDTO *topicDTO;

@property (nonatomic, strong) ServerRgion_5_Block serverRgion_5_Block;

- (void)setDataSource:(TopicDTO *)topicDTO;

+ (CGFloat)getHeight;

@end

//
//  ServerRegion_2_TableViewCell.h
//  VSProject
//
//  Created by pangchao on 17/6/26.
//  Copyright © 2017年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicDTO.h"
#import "TopicProductDTO.h"

typedef void (^ServerRgion_2_Block)(TopicProductDTO *topicDTO);

@interface ServerRegion_2_TableViewCell : UITableViewCell

@property (nonatomic, strong) TopicDTO *topicDTO;

@property (nonatomic, strong) ServerRgion_2_Block serverRgion_2_Block;

- (void)setDataSource:(TopicDTO *)topicDTO;

+ (CGFloat)getHeight;

@end

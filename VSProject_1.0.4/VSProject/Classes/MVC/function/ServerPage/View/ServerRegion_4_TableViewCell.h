//
//  ServerRegion_4_TableViewCell.h
//  VSProject
//
//  Created by pangchao on 17/6/26.
//  Copyright © 2017年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicDTO.h"

typedef void (^ServerRgion_4_Block)(TopicProductDTO *topicDTO);

@interface ServerRegion_4_TableViewCell : UITableViewCell

@property (nonatomic, strong) TopicDTO *topicDTO;

@property (nonatomic, strong) ServerRgion_4_Block serverRgion_4_Block;

- (void)setDataSource:(TopicDTO *)topicDTO;

+ (CGFloat)getHeight;

@end

//
//  ServerRegion_3_TableViewCell.h
//  VSProject
//
//  Created by pangchao on 17/6/26.
//  Copyright © 2017年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicDTO.h"

typedef void (^ServerRgion_3_Block)(TopicProductDTO *topicDTO);

@interface ServerRegion_3_TableViewCell : UITableViewCell

@property (nonatomic, strong) TopicDTO *topicDTO;

@property (nonatomic, strong) ServerRgion_3_Block serverRgion_3_Block;

- (void)setDataSource:(TopicDTO *)topicDTO;

+ (CGFloat)getHeight;

@end

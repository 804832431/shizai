//
//  ServerTheme_250_375_View.h
//  VSProject
//
//  Created by pangchao on 17/6/25.
//  Copyright © 2017年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TopicProductDTO;

@protocol Server_250_375_TopicClickedDelegate <NSObject>

- (void)topic_250_375_ClickedAction:(TopicProductDTO *)dto;

@end

@interface ServerTheme_250_375_View : UIView

@property (nonatomic, strong) TopicProductDTO *topicProductDTO;

@property (nonatomic, weak) id<Server_250_375_TopicClickedDelegate> delegate;

- (void)setData:(TopicProductDTO *)dto;

@end

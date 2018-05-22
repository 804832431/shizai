//
//  TagsSelectViewController.h
//  VSProject
//
//  Created by pch_tiger on 16/12/21.
//  Copyright © 2016年 user. All rights reserved.
//

#import "VSBaseViewController.h"

typedef void(^SelectTagsSkipBlock)();

typedef enum
{
    TAGS_FROM_REGISTER = 0,
    TAGS_FROM_MECENTER = 1,
} TAGS_FROM;

typedef enum
{
    
    TAGS_TYPE_INDUSTRY = 0, // 行业标签
    TAGS_TYPE_IDENTITY = 1, // 身份标签
    TAGS_TYPE_COMPANY = 2,  // 企业标签
} TAGS_SELECT_TYPE;

@interface TagsSelectViewController : VSBaseViewController

@property (nonatomic, strong) NSMutableArray<NSArray *> *tagsAllArray;

@property (nonatomic, strong) NSArray *headTitleArray;

@property (nonatomic, assign) TAGS_SELECT_TYPE tagsType;

@property (nonatomic, assign) TAGS_FROM tagsFrom;

@property (nonatomic, strong) SelectTagsSkipBlock skipBlock;

- (void)vs_back;

@end

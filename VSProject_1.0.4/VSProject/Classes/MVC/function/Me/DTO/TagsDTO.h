//
//  TagsDTO.h
//  VSProject
//
//  Created by pch_tiger on 16/12/25.
//  Copyright © 2016年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TagsDTO : NSObject

@property (nonatomic, copy) NSString *tagsId; // 标签ID

@property (nonatomic, copy) NSString *tagsName; // 标签名称

@property (nonatomic, copy) NSString *isMarking; // 是否打标 Y:是; N:否

- (id)initWithDic:(NSDictionary *)dic;

@end

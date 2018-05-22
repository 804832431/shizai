//
//  PolicyModel.h
//  VSProject
//
//  Created by certus on 16/3/24.
//  Copyright © 2016年 user. All rights reserved.
//  老版本资讯实体，用于1.5.0版本的时在头条、时在分享功能
//

#import "JSONModel.h"

@interface PolicyModel : JSONModel

@property (nonatomic,strong)NSString <Optional>*createTime;
@property (nonatomic,strong)NSString <Optional>*introduction;
@property (nonatomic,strong)NSString <Optional>*image;
@property (nonatomic,strong)NSString <Optional>*title;
@property (nonatomic,strong)NSString <Optional>*visitURL;

@end

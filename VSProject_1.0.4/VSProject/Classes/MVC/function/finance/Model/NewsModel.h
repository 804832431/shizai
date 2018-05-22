//
//  NewsModel.h
//  VSProject
//
//  Created by pangchao on 17/1/5.
//  Copyright © 2017年 user. All rights reserved.
//

#import "VSBaseDataModel.h"

@interface NewsModel : VSBaseDataModel

@property (nonatomic,strong)NSString <Optional>*title;
@property (nonatomic,strong)NSString <Optional>*introduction;
@property (nonatomic,strong)NSString <Optional>*image;
@property (nonatomic,strong)NSString <Optional>*visitURL;
@property (nonatomic,strong)NSString <Optional>*createTime;

@end

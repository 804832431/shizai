//
//  BidWebViewController.h
//  VSProject
//
//  Created by 陈 海涛 on 16/9/22.
//  Copyright © 2016年 user. All rights reserved.
//


#import "NewShareWebViewController.h"
#import "BidWebOperationView.h"
#import "BidProject.h"

@interface BidWebViewController : NewShareWebViewController

@property (nonatomic,assign) BOOL isCollectionList;//从收藏列表里来

@property (nonatomic,assign) BOOL isHomeList;//从首页列表来

@property (nonatomic,assign) BOOL isMyBidList;//从我的投标列表来


@property (nonatomic,strong) BidWebOperationView *operationView;

@property (nonatomic,strong) BidProject *dto;

@end

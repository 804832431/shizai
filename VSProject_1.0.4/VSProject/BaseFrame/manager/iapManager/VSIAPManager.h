//
//  VSIAPManager.h
//  VSProject
//
//  Created by tiezhang on 15/3/9.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseManager.h"
#import <StoreKit/StoreKit.h>

@interface VSIAPManager : VSBaseManager


//购买商品
- (void) vs_buy:(NSString*)buyProductID;

- (bool) vs_canMakePay;

//获取产品信息
- (void) vs_requestProductData:(NSString*)buyProductIDTag;

//- (void) vs_provideContent:(NSString *)product;
- (void) vs_recordTransaction:(NSString *)product;

- (void) vs_requestProUpgradeProductData:(NSString*)buyProductIDTag;
- (void) vs_purchasedTransaction: (SKPaymentTransaction *)transaction;
- (void) vs_completeTransaction: (SKPaymentTransaction *)transaction;
- (void) vs_failedTransaction: (SKPaymentTransaction *)transaction;
- (void) vs_restoreTransaction: (SKPaymentTransaction *)transaction;

@end

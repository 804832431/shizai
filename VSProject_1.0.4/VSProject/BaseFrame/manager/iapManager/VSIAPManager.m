//
//  VSIAPManager.m
//  VSProject
//
//  Created by tiezhang on 15/3/9.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSIAPManager.h"
#import "NSData+TPCategory.h"


@interface VSIAPManager ()<SKProductsRequestDelegate, SKPaymentTransactionObserver>
{
    NSString* _buyProductIDTag;
}

_PROPERTY_NONATOMIC_STRONG(NSString, buyProductIDTag);

_PROPERTY_NONATOMIC_STRONG(NSArray, productIDs);

- (void)vs_loadProductIDs;

- (void) vs_initialStore;
- (void) vs_releaseStore;

@end

@implementation VSIAPManager

DECLARE_SINGLETON(VSIAPManager)

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self vs_loadProductIDs];
        
        [self vs_initialStore];
    }
    return self;
}

//获取在售产品ID
- (void)vs_loadProductIDs
{
    //TODO:获取产品IDS
}


-(void)vs_initialStore
{
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
}

-(void)vs_releaseStore
{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

-(void)vs_buy:(NSString*)buyProductIDTag
{
    [self vs_requestProductData:buyProductIDTag];
}

-(bool)vs_canMakePay
{
    return [SKPaymentQueue canMakePayments];
}

-(void)vs_requestProductData:(NSString*)buyProductIDTag
{
    DBLog(@"---------Request product information------------\n");
    self.buyProductIDTag = buyProductIDTag;
    NSArray *product     = [[NSArray alloc] initWithObjects:buyProductIDTag,nil];
    NSSet *nsset = [NSSet setWithArray:product];
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers: nsset];
    request.delegate = self;
    [request start];
}

#pragma mark -- SKProductsRequestDelegate
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    
    DBLog(@"-----------Getting product information--------------\n");
    NSArray *myProduct = response.products;
    DBLog(@"Product ID:%@\n",response.invalidProductIdentifiers);
    DBLog(@"Product count: %ld\n", (long)[myProduct count]);
    if (myProduct.count == 0)
    {
        NSAssert(0, @"无法获取产品信息，购买失败。");
        return;
    }
    else
    {
        // populate UI
        for(SKProduct *product in myProduct)
        {
            DBLog(@"Detail product info\n");
            DBLog(@"SKProduct description: %@\n", [product description]);
            DBLog(@"Product localized title: %@\n" , product.localizedTitle);
            DBLog(@"Product localized descitption: %@\n" , product.localizedDescription);
            DBLog(@"Product price: %@\n" , product.price);
            DBLog(@"Product identifier: %@\n" , product.productIdentifier);
        }
        SKPayment *payment = nil;
        payment = [SKPayment paymentWithProduct:[response.products objectAtIndex:0]];
        DBLog(@"---------Request payment------------\n");
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
    
}

- (void)vs_requestProUpgradeProductData:(NSString*)buyProductIDTag
{
    DBLog(@"------Request to upgrade product data---------\n");
    NSSet *productIdentifiers = [NSSet setWithObject:buyProductIDTag];
    SKProductsRequest* productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers];
    productsRequest.delegate = self;
    [productsRequest start];
    
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error
{
    DBLog(@"-------Show fail message----------\n");
    UIAlertView *alerView =  [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alert",NULL) message:[error localizedDescription]
                                                       delegate:nil cancelButtonTitle:NSLocalizedString(@"Close",nil) otherButtonTitles:nil];
    [alerView show];
}

-(void)requestDidFinish:(SKRequest *)request
{
    DBLog(@"----------Request finished--------------\n");
    
}

-(void)vs_purchasedTransaction: (SKPaymentTransaction *)transaction
{
    DBLog(@"-----Purchased Transaction----\n");
    NSArray *transactions =[[NSArray alloc] initWithObjects:transaction, nil];
    [self paymentQueue:[SKPaymentQueue defaultQueue] updatedTransactions:transactions];
}

- (void)vs_completeTransaction: (SKPaymentTransaction *)transaction
{
    DBLog(@"-----completeTransaction--------\n");
    // Your application should implement these two methods.
    NSString *productIdentifier = transaction.payment.productIdentifier;
    if ([productIdentifier length] > 0)
    {
        NSString * receipt = [transaction.transactionReceipt base64EncodedString];
        if ([productIdentifier length] > 0) {
            // 向自己的服务器验证购买凭证
        }
        NSArray *tt = [productIdentifier componentsSeparatedByString:@"."];
        NSString *bookid = [tt lastObject];
        if ([bookid length] > 0)
        {
            [self vs_recordTransaction:bookid];
            [self provideContent:bookid];
        }
    }
    
    // Remove the transaction from the payment queue.
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
}

-(void)vs_recordTransaction:(NSString *)product
{
    DBLog(@"-----Record transcation--------\n");
    // Todo: Maybe you want to save transaction result into plist.
}

-(void)provideContent:(NSString *)product
{
    DBLog(@"-----Download product content--------\n");
}

- (void)vs_failedTransaction: (SKPaymentTransaction *)transaction
{
    DBLog(@"Failed\n");
    if(transaction.error.code != SKErrorPaymentCancelled)
    {
        NSLog(@"购买失败");
    }
    else
    {
        NSLog(@"用户取消交易");
    }
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

- (void) vs_restoreTransaction: (SKPaymentTransaction *)transaction
{
    DBLog(@"-----Restore transaction--------\n");
    
    // 对于已购商品，处理恢复购买的逻辑
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

#pragma mark -- SKPaymentTransactionObserver
-(void) paymentQueueRestoreCompletedTransactionsFinished: (SKPaymentTransaction *)transaction
{
    
}

-(void) paymentQueue:(SKPaymentQueue *) paymentQueue restoreCompletedTransactionsFailedWithError:(NSError *)error
{
    DBLog(@"-------Payment Queue----\n");
}

- (void)paymentQueue:(SKPaymentQueue *)queue removedTransactions:(NSArray *)transactions
{
    
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedDownloads:(NSArray *)downloads
{
    
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    DBLog(@"-----Payment result--------\n");
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:    //交易完成
            {
                [self vs_completeTransaction:transaction];
                DBLog(@"-----Transaction purchased--------\n");
                UIAlertView *alerView =  [[UIAlertView alloc] initWithTitle:@"Congratulation"
                                                                    message:@"Transaction suceed!"
                                                                   delegate:nil cancelButtonTitle:NSLocalizedString(@"Close",nil) otherButtonTitles:nil];
                
                [alerView show];
            }break;
            case SKPaymentTransactionStateFailed:
            {
                [self vs_failedTransaction:transaction];
                DBLog(@"-----Transaction Failed--------\n");
                UIAlertView *alerView2 =  [[UIAlertView alloc] initWithTitle:@"Failed"
                                                                     message:@"Sorry, your transcation failed, try again."
                                                                    delegate:nil cancelButtonTitle:NSLocalizedString(@"Close",nil) otherButtonTitles:nil];
                
                [alerView2 show];
            }break;
            case SKPaymentTransactionStateRestored: //已经购买过该商品
            {
                [self vs_restoreTransaction:transaction];
                DBLog(@"----- Already buy this product--------\n");
            }break;
            case SKPaymentTransactionStatePurchasing:   //商品添加进列表 
                DBLog(@"-----Transcation puchasing商品添加进列表--------\n");
                break;
            default:
                break;
        }
    }
}


#pragma mark connection delegate
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    DBLog(@"%@\n",  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    switch([(NSHTTPURLResponse *)response statusCode]) {
        case 200:
        case 206:
            break;
        case 304:
            break;
        case 400:
            break;
        case 404:
            break;
        case 416:
            break;
        case 403:
            break;
        case 401:
        case 500:
            break;
        default:
            break;
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    DBLog(@"test\n");
}




@end

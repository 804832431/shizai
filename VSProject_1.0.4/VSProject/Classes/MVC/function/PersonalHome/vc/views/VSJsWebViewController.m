//
//  VSJsWebViewController.m
//  VSProject
//
//  Created by XuLiang on 15/11/3.
//  Copyright © 2015年 user. All rights reserved.
//

#import "VSJsWebViewController.h"
#import "JSWebView.h"
#import "WebAppCommunicator.h"
#import "DBHelpQueueManager.h"
#import "UINavigationController+HomePushVC.h"
#import "ShoppingCartViewController.h"
#import "BCNetWorkTool.h"
#import "VSUserLoginViewController.h"
#import "RTXAppointmentViewController.h"
#import "MessageViewController.h"
#import "VSUserLoginViewController.h"
#import "MessageManager.h"
#import "TelPhoneCallAlertView.h"
#import "AppointmentViewController.h"
#import "FinancingViewController.h"
#import "GuQuanRongZiViewController.h"
#import "FinanceOtherJoinViewController.h"
#import "EnterpriceInfoViewController.h"
#import "SpaceCheckOrderViewController.h"
#import "ChanYeJiJingViewController.h"
#import "ShangShiFuWuViewController.h"
#import "QiYeDaiKuanViewController.h"
#import "QiYeLiCaiViewController.h"

#define DEFAULT_WEBTITLE        @""

@interface VSJsWebViewController ()
{
    JSWebView *_webView;
    id m_shopCart;
}
@property(nonatomic, strong)UIActivityIndicatorView *loadingView;

@end

@implementation VSJsWebViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        [self wm_setInit];
    }
    
    return self;
}

- (id)init
{
    self = [super init];
    if(self)
    {
        [self wm_setInit];
    }
    return self;
}

- (void)wm_setInit
{
    //
}

- (id)initWithUrl:(NSURL *)url
{
    DBLog(@"================openwebview-url:%@================", url);
    return [self initWithWebTitle:DEFAULT_WEBTITLE url:url];
}

- (id)initWithWebTitle:(NSString*)webTitle url:(NSURL*)url
{
    self = [super init];
    
    if(self)
    {
        self.webUrl   = url;
        self.webTitle = webTitle;
        [self wm_setInit];
    }
    
    return self;
}
- (void)dealloc{
    _webView = nil;
    _webView.delegate = nil;
    //
    NSLog(@"NoticeName_WebViewDidLoadMsg－－dealloc");
    [KNotificationCenter removeObserver:self name:NoticeName_WebViewDidLoadMsg object:nil];
    //    [KNotificationCenter removeObserver:self name:NoticeName_WebViewDidFailLoadMsg object:nil];
    //    [KNotificationCenter removeObserver:self name:NoticeName_WebViewShouldStartLoadMsg object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    //
    if (!_webView) {
        [self.view addSubview:self.webView];
        [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
            
        }];
    }
    WebAppInterface *interface = [[WebAppInterface alloc] initWithContainerViewController:self webView:_webView];
    [_webView addJavascriptInterface:interface withName:@"Greenland"];
    [KNotificationCenter addObserver:self selector:@selector(WebViewDidFinishLoad) name:NoticeName_WebViewDidLoadMsg object:nil];
    //    [KNotificationCenter addObserver:self selector:@selector(WebViewDidFailLoad) name:NoticeName_WebViewDidFailLoadMsg object:nil];
    //    [KNotificationCenter addObserver:self selector:@selector(WebViewShouldStartLoad) name:NoticeName_WebViewShouldStartLoadMsg object:nil];
    [self reloadWebView];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [KNotificationCenter removeObserver:self name:NoticeName_WebViewDidLoadMsg object:nil];
    [KNotificationCenter removeObserver:self name:NoticeName_WebViewDidFailLoadMsg object:nil];
    [KNotificationCenter removeObserver:self name:NoticeName_WebViewShouldStartLoadMsg object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self requesthaveNewMessage];
}

-(void)webViewLoadURL:(NSURL*)url
{
    [_webView loadRequest:[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.f]];
}
#pragma mark -- 业务方法

- (void)toOrder:(id)data{
    
    if (![self isUserLogin]) {
        
        [self.navigationController pushViewController:[VSUserLoginViewController new] animated:YES];
        return;
    }
    
    if ([data isKindOfClass:[NSArray class]]) {
        
        NSArray *arr = (NSArray *)data;
        NSString *storeid = nil;
        
        NSMutableArray *productArr = [NSMutableArray array];
        for (NSDictionary *dic in arr) {
            NSString *pid = [dic objectForKey:@"productId"];
            NSString *count = [dic objectForKey:@"quantity"];
            storeid = [dic objectForKey:@"categoryId"];
            NSDictionary *itemDic = @{@"productId":pid,@"quantity": count};
            [productArr addObject:itemDic];
        }
        
        NSString *productStoreId =@"9000";
        NSString *orderTypeId = [[VSUserLogicManager shareInstance] userDataInfo].vm_orderTypeId;
        NSString *catalogId = [[VSUserLogicManager shareInstance] userDataInfo].vm_catalogId;
        
        //        if ([orderTypeId isEqualToString:SALES_ORDER_B2C]) {
        //            storeid = @"Gshop";
        //        }
        
        NSArray *prodList = productArr;
        
        NSArray *tmpArr = @[@{@"categoryId":storeid,@"prodList":prodList}];
        
        NSData *contentData = (NSData *)[NSJSONSerialization dataWithJSONObject:tmpArr options:NSJSONWritingPrettyPrinted error:nil];
        
        NSString* jsonContent = [[NSString alloc] initWithData:contentData encoding:NSUTF8StringEncoding];
        
        NSDictionary * contentDic = [NSDictionary dictionaryWithObjectsAndKeys:jsonContent,@"content", nil];
        
        
        [self vs_showLoading];
        [BCNetWorkTool executePostNetworkWithParameter:contentDic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.order/get-shopping-carts" withSuccess:^(id callBackData) {
            
            
            
            NSDictionary *dic = (NSDictionary *)callBackData;
            NSArray *categoryVOList = [dic objectForKey:@"categoryVOList"];
            NSMutableArray *tmpArr = [NSMutableArray array];
            
            
            
            for (NSDictionary *itemDic in categoryVOList) {
                CategoryDTO *dto = [[CategoryDTO alloc] initWithDictionary:itemDic error:nil];
                dto.catalogId = catalogId;
                dto.productStoreId = productStoreId;
                //                dto.orderTypeId = orderTypeId;
                [[VSUserLogicManager shareInstance] userDataInfo].vm_orderTypeId = dto.orderTypeId;
                
                [tmpArr addObject:dto];
            }
            
            [self goToCheckOrder:[tmpArr lastObject]];
            
            
            [self vs_hideLoadingWithCompleteBlock:nil];
            
        } orFail:^(id callBackData) {
            
            [self.view showTipsView:[callBackData domain]];
            
            [self vs_hideLoadingWithCompleteBlock:nil];
            
        }];
        
        
    }
    
    
    
}


- (void)goToCheckOrder:(CategoryDTO *)categoryDTO{
    
    
    NSMutableArray *proArr = [NSMutableArray array];
    for (ProductDTO *dto in categoryDTO.prodsList) {
        NSDictionary *dic = @{@"quantity":dto.quantity,@"productId":dto.productId};
        [proArr addObject:dic];
    }
    NSDictionary *dic = nil;
    
    
    
    //    dic = @{ @"promoCode":@"",@"userLoginId":[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.username,
    //             @"productStoreId":categoryDTO.productStoreId.length==0?@"":categoryDTO.productStoreId,
    //             @"catalogId":[[VSUserLogicManager shareInstance] userDataInfo].vm_catalogId.length==0?@"":[[VSUserLogicManager shareInstance] userDataInfo].vm_catalogId,
    //             @"categoryId":categoryDTO.categoryId.length==0?@"":categoryDTO.categoryId ,
    //             @"productItems":proArr,
    //             @"orderTypeId":[[VSUserLogicManager shareInstance] userDataInfo].vm_orderTypeId.length==0?@"":[[VSUserLogicManager shareInstance] userDataInfo].vm_orderTypeId};
    
    dic = @{ @"promoCode":@"",@"userLoginId":[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.username,
             @"productStoreId":categoryDTO.productStoreId.length==0?@"":categoryDTO.productStoreId,
             @"catalogId":categoryDTO.catalogId.length==0?@"":categoryDTO.catalogId,
             @"categoryId":categoryDTO.categoryId.length==0?@"":categoryDTO.categoryId ,
             @"productItems":proArr,
             @"orderTypeId":categoryDTO.orderTypeId.length==0?@"":categoryDTO.orderTypeId
             
             };
    
    NSData *contentData = (NSData *)[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString* jsonContent = [[NSString alloc] initWithData:contentData encoding:NSUTF8StringEncoding];
    
    NSDictionary * contentDic = [NSDictionary dictionaryWithObjectsAndKeys:jsonContent,@"content", nil];
    
    
    [BCNetWorkTool executePostNetworkWithParameter:contentDic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.order/confirm-order" withSuccess:^(id callBackData) {
        
        NSDictionary *dic = (NSDictionary *)callBackData;
        
        ShoppingCartInfoDTO *dto = [[ShoppingCartInfoDTO alloc] initWithDictionary:dic[@"shoppingCartInfo"] error:nil];
        
        CheckOrderViewController *vc = [CheckOrderViewController new];
        
        vc.orderDemand = dic[@"orderDemand"];
        
        vc.selectedCategoryDTO = categoryDTO;
        
        vc.selectedProductDTOList = [NSMutableArray arrayWithArray:categoryDTO.prodsList];
        
        vc.shoppingCartInfo = dto;
        
        
        
        [self.navigationController pushViewController:vc animated:YES];
        
        [self vs_hideLoadingWithCompleteBlock:nil];
        
    } orFail:^(id callBackData) {
        
        [self.view showTipsView:[callBackData domain]];
        
        [self vs_hideLoadingWithCompleteBlock:nil];
    }];
    
    
}
- (void)toPoint:(id)data{
    //Modify by Thomas [H5 跳转预约]2015-11-27---start
    if (![self isUserLogin]) {
        
        [self.navigationController pushViewController:[VSUserLoginViewController new] animated:YES];
        return;
    }
    //查询物品信息--start
    if ([data isKindOfClass:[NSArray class]]) {
        
        NSArray *arr = (NSArray *)data;
        NSString *storeid = nil;
        
        NSMutableArray *productArr = [NSMutableArray array];
        for (NSDictionary *dic in arr) {
            NSString *pid = [dic objectForKey:@"productId"];
            NSString *count = [dic objectForKey:@"quantity"];
            storeid = [dic objectForKey:@"categoryId"];
            NSDictionary *itemDic = @{@"productId":pid,@"quantity": count};
            [productArr addObject:itemDic];
        }
        
        NSString *productStoreId =@"9000";
        NSString *orderTypeId = [[VSUserLogicManager shareInstance] userDataInfo].vm_orderTypeId;
        NSString *catalogId = [[VSUserLogicManager shareInstance] userDataInfo].vm_catalogId;
        
        
        NSArray *prodList = productArr;
        
        NSArray *tmpArr = @[@{@"categoryId":storeid,@"prodList":prodList}];
        
        NSData *contentData = (NSData *)[NSJSONSerialization dataWithJSONObject:tmpArr options:NSJSONWritingPrettyPrinted error:nil];
        
        NSString* jsonContent = [[NSString alloc] initWithData:contentData encoding:NSUTF8StringEncoding];
        
        NSDictionary * contentDic = [NSDictionary dictionaryWithObjectsAndKeys:jsonContent,@"content", nil];
        
        
        [self vs_showLoading];
        [BCNetWorkTool executePostNetworkWithParameter:contentDic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.order/get-shopping-carts" withSuccess:^(id callBackData) {
            
            
            
            NSDictionary *dic = (NSDictionary *)callBackData;
            NSArray *categoryVOList = [dic objectForKey:@"categoryVOList"];
            NSMutableArray *tmpArr = [NSMutableArray array];
            
            for (NSDictionary *itemDic in categoryVOList) {
                CategoryDTO *dto = [[CategoryDTO alloc] initWithDictionary:itemDic error:nil];
                dto.catalogId = catalogId;
                dto.productStoreId = productStoreId;
                dto.orderTypeId = orderTypeId;
                
                [tmpArr addObject:dto];
            }
            
            [self goToCheckAppointment:[tmpArr lastObject]];
            
            
            [self vs_hideLoadingWithCompleteBlock:nil];
            
        } orFail:^(id callBackData) {
            
            [self.view showTipsView:[callBackData domain]];
            
            [self vs_hideLoadingWithCompleteBlock:nil];
            
        }];
        
        
    }
    //查询物品信息---end
    //Modify by Thomas [H5 跳转预约]2015-11-27---end
}

- (void)toShare:(id)data{
    
    
}

//确认预约订单

- (void)goToCheckAppointment:(CategoryDTO *)categoryDTO{
    NSMutableArray *proArr = [NSMutableArray array];
    for (ProductDTO *dto in categoryDTO.prodsList) {
        NSDictionary *dic = @{@"quantity":dto.quantity,@"productId":dto.productId};
        [proArr addObject:dic];
    }
    NSDictionary *dic = nil;
    
    dic = @{ @"promoCode":@"",@"userLoginId":[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.username,
             @"productStoreId":categoryDTO.productStoreId,
             @"catalogId":[[VSUserLogicManager shareInstance] userDataInfo].vm_catalogId?:@"",
             @"categoryId":categoryDTO.categoryId,
             @"productItems":proArr,
             @"orderTypeId":[[VSUserLogicManager shareInstance] userDataInfo].vm_orderTypeId};
    
    NSData *contentData = (NSData *)[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString* jsonContent = [[NSString alloc] initWithData:contentData encoding:NSUTF8StringEncoding];
    
    NSDictionary * contentDic = [NSDictionary dictionaryWithObjectsAndKeys:jsonContent,@"content", nil];
    
    
    [BCNetWorkTool executePostNetworkWithParameter:contentDic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.order/confirm-order" withSuccess:^(id callBackData) {
        
        NSDictionary *dic = (NSDictionary *)callBackData;
        
        ShoppingCartInfoDTO *dto = [[ShoppingCartInfoDTO alloc] initWithDictionary:dic[@"shoppingCartInfo"] error:nil];
        
        RTXAppointmentViewController *appointmentVC = [RTXAppointmentViewController new];
        
        appointmentVC.selectedCategoryDTO = categoryDTO;
        
        appointmentVC.selectedProductDTOList = [NSMutableArray arrayWithArray:categoryDTO.prodsList];
        
        appointmentVC.shoppingCartInfo = dto;
        
        [self.navigationController pushViewController:appointmentVC animated:YES];
        
        [self vs_hideLoadingWithCompleteBlock:nil];
        
    } orFail:^(id callBackData) {
        
        [self.view showTipsView:[callBackData domain]];
        [self vs_hideLoadingWithCompleteBlock:nil];
    }];
    
}
- (void)toProInfo:(id)data{
    //modify by Thomas [存为网页缓存，暂不入数据库]2015-12-15－－－start
    if ([data isKindOfClass:[NSString class]]) {
        m_shopCart = (NSString *)data;
    }
    
    //    //Modify by Thomas [H5 购物车数据写入db]2015-11-14（待连调）---start
    //    if (data) {
    //        NSString *sqldeleteStr = nil;
    //        sqldeleteStr = [NSString stringWithFormat:@"DELETE from ld_cart"];
    //        
    //        [[DBHelpQueueManager shareInstance]db_updateSql:sqldeleteStr];
    //        if([data isKindOfClass:[NSArray class]]){
    //            for (NSDictionary *dic in data)
    //            {
    //                NSString *pid = [dic objectForKey:@"productId"];
    //                NSString *count = [dic objectForKey:@"quantity"];
    //                NSString *storeid = [dic objectForKey:@"categoryId"];
    //                NSString *userid = [self getUserPartyId]?:@"visitor";
    //                NSString *productStoreId =@"9000";
    //                NSString *orderTypeId = [[VSUserLogicManager shareInstance] userDataInfo].vm_orderTypeId;
    //                NSString *catalogId = [[VSUserLogicManager shareInstance] userDataInfo].vm_catalogId;
    //                NSString *sqlStr = nil;
    //                sqlStr = [NSString stringWithFormat:@"insert into ld_cart (productid, storeid,count,userid,productStoreId,orderTypeId,catalogId) values(%@,\'%@\',%@,'%@',\'%@\',\'%@\',\'%@\')",pid,storeid,count,userid,productStoreId,orderTypeId,catalogId];
    //                
    //                [[DBHelpQueueManager shareInstance]db_updateSql:sqlStr];
    //            }
    //        }
    //    }
    //    //Modify by Thomas [H5 购物车数据写入db]---end
    
    //modify by Thomas [存为网页缓存，暂不入数据库]－－－end
    
}

- (NSString *)getCartInfo:(NSString *)key{
    //modify by Thomas [读取网页缓存，不读数据库,如果页面购物车缓存为空则读取数据库]2015-12-15－－－start
    
    if(!m_shopCart){
        NSString *sql = nil;
        if ([VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId.length > 0) {
            sql =  [NSString stringWithFormat:@"select * from ld_cart where userid ='%@' or userid ='visitor'",[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId];
        }else{
            sql =  @"select * from ld_cart where userid ='visitor'";
        }
        NSMutableArray *tmpArr = [NSMutableArray array];
        [[DBHelpQueueManager shareInstance].rsFMDBQueue inDatabase:^(FMDatabase *db) {
            
            [db open];
            FMResultSet *set = [db executeQuery:sql];
            
            while ([set next]) {
                
                NSString *productId =  [set stringForColumn:@"productid"];
                NSString *categoryId =   [set stringForColumn:@"storeid"];
                NSString *quantity =  [set stringForColumn:@"count"];
                
                NSDictionary *dic = @{@"productId":productId,@"quantity":quantity,@"categoryId":categoryId};
                [tmpArr addObject:dic];
            }
            [db close];
            
        }];
        
        if (tmpArr.count == 0) {
            return nil;
        }
        NSData *jsonData = [NSJSONSerialization
                            dataWithJSONObject:tmpArr options:NSJSONWritingPrettyPrinted error:nil];
        NSString * returnDataStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        m_shopCart = returnDataStr;
        return m_shopCart;
    }else{
        return m_shopCart;
    }
    return nil;
    //modify by Thomas [存为网页缓存，暂不入数据库]－－－end
}

- (void)toCart:(id)data{
    //    [self.view showTipsView:[NSString stringWithFormat:@"%@",data] afterDelay:3.0];
    //Modify by Thomas [H5 购物车数据写入db]2015-11-14（待连调）---start
    //Modify by Thomas [H5 购物车数据写入db]只覆盖传回商家的数据（2015-12-15）---start
    if (data) {
        NSString *sqldeleteStr = nil;
        //        sqldeleteStr = [NSString stringWithFormat:@"DELETE from ld_cart"];
        
        //        [[DBHelpQueueManager shareInstance]db_updateSql:sqldeleteStr];
        if([data isKindOfClass:[NSArray class]]){
            
            NSMutableString *str = [NSMutableString string];
            for (NSInteger i = 0 ; i < [(NSArray *)data count]; i++) {
                NSDictionary *dic = data[i];
                NSString *pid = [dic objectForKey:@"productId"];
                [str appendFormat:@"'%@",pid ];
                if (i != [(NSArray *)data count]-1) {
                    [str appendString:@"',"];
                }
            }
            [str appendString:@"'"];
            NSString *userid = [self getUserPartyId]?:@"visitor";
            //modify by Thomas [当用户未登录，userid为visitor，删除失败导致的数据插入异常]－－－start
            sqldeleteStr = [NSString stringWithFormat:@"DELETE from ld_cart where productid in (%@) and userid = \'%@\'",str,userid];
            //modify by Thomas [当用户未登录，userid为visitor，删除失败导致的数据插入异常]－－－end
            BOOL  issuccess = [[DBHelpQueueManager shareInstance]db_updateSql:sqldeleteStr];
            //modify by Thomas [（异常状态处理）如果删除失败则直接情况购物车]－－－start
            if (!issuccess) {
                NSString *sqldeleteAllStr = [NSString stringWithFormat:@"DELETE from ld_cart"];
                [[DBHelpQueueManager shareInstance]db_updateSql:sqldeleteStr];
            }
            //modify by Thomas [如果删除失败则直接情况购物车]－－－end
            for (NSDictionary *dic in data)
            {
                NSString *pid = [dic objectForKey:@"productId"];
                NSString *count = [dic objectForKey:@"quantity"];
                NSString *storeid = [dic objectForKey:@"categoryId"];
                NSString *userid = [self getUserPartyId]?:@"visitor";
                NSString *productStoreId =@"9000";
                NSString *orderTypeId = [[VSUserLogicManager shareInstance] userDataInfo].vm_orderTypeId;
                
                if ([orderTypeId isEqualToString:SALES_ORDER_B2C]) {
                    storeid = @"Gshop";
                }
                NSString *catalogId = [[VSUserLogicManager shareInstance] userDataInfo].vm_catalogId?:@"";
                NSString *sqlStr = nil;
                sqlStr = [NSString stringWithFormat:@"insert into ld_cart (productid, storeid,count,userid,productStoreId,orderTypeId,catalogId) values('%@',\'%@\',%@,'%@',\'%@\',\'%@\',\'%@\')",pid,storeid,count,userid,productStoreId,orderTypeId,catalogId];
                
                [[DBHelpQueueManager shareInstance]db_updateSql:sqlStr];
            }
        }
        
        //跳转购物车
        ShoppingCartViewController *vc = [ShoppingCartViewController new];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    //Modify by Thomas [H5 购物车数据写入db]---end
}


//H5种拨打电话
- (void)toCall:(id) data{
    
    NSString *phone = (NSString *)data;
    
    [TelPhoneCallAlertView showWithTelPHoneNum:phone];
}

- (void)toSubscribe:(id)data {
    
    NSDictionary *dic = (NSDictionary *)data;
    AppointmentViewController *vc = [[AppointmentViewController alloc] init];
    vc.productId = [dic objectForKey:@"productId"];
    vc.quantity = [dic objectForKey:@"quantity"];
    vc.categoryId = [dic objectForKey:@"categoryId"];
    vc.orderType = [dic objectForKey:@"orderType"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)toBook:(id)data {
    
    if (![self isUserLogin]) {
        
        [self.navigationController pushViewController:[VSUserLoginViewController new] animated:YES];
        return;
    }
    
    NSDictionary *dic = (NSDictionary *)data;
    NSString *productId = [dic objectForKey:@"productId"];
    NSString *quantity = [dic objectForKey:@"quantity"];
    NSString *categoryId = [dic objectForKey:@"categoryId"];
    NSString *orderType = [dic objectForKey:@"orderType"];
    
    CategoryDTO *dto = [[CategoryDTO alloc] init];
    dto.categoryId = categoryId;
    dto.categoryName = @"";
    ProductDTO *productDTO = [ProductDTO new];
    productDTO.productId = productId;
    productDTO.quantity = quantity;
    dto.prodsList = @[productDTO];
    dto.productStoreId = @"9000";
    dto.orderTypeId = orderType;
    dto.catalogId = [[VSUserLogicManager shareInstance] userDataInfo].vm_catalogId;
    
    [self gotoSpaceChckOrder:dto];
}

- (void)gotoSpaceChckOrder:(CategoryDTO *)categoryDTO {
 
    NSMutableArray *proArr = [NSMutableArray array];
    for (ProductDTO *dto in categoryDTO.prodsList) {
        NSDictionary *dic = @{@"quantity":dto.quantity,@"productId":dto.productId};
        [proArr addObject:dic];
    }
    NSDictionary *dic = nil;
    dic = @{ @"promoCode":@"",@"userLoginId":[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.username,
             @"productStoreId":categoryDTO.productStoreId.length==0?@"":categoryDTO.productStoreId,
             @"catalogId":categoryDTO.catalogId.length==0?@"":categoryDTO.catalogId,
             @"categoryId":categoryDTO.categoryId.length==0?@"":categoryDTO.categoryId ,
             @"productItems":proArr,
             @"orderTypeId":categoryDTO.orderTypeId.length==0?@"":categoryDTO.orderTypeId
             
             };
    
    NSData *contentData = (NSData *)[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString* jsonContent = [[NSString alloc] initWithData:contentData encoding:NSUTF8StringEncoding];
    
    NSDictionary * contentDic = [NSDictionary dictionaryWithObjectsAndKeys:jsonContent,@"content", nil];
    
    
    [BCNetWorkTool executePostNetworkWithParameter:contentDic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.order/confirm-order" withSuccess:^(id callBackData) {
        
        NSDictionary *dic = (NSDictionary *)callBackData;
        
        ShoppingCartInfoDTO *dto = [[ShoppingCartInfoDTO alloc] initWithDictionary:dic[@"shoppingCartInfo"] error:nil];
        
        SpaceCheckOrderViewController *vc = [SpaceCheckOrderViewController new];
        
        vc.orderDemand = dic[@"orderDemand"];
        
        vc.selectedCategoryDTO = categoryDTO;
        
        vc.selectedProductDTOList = [NSMutableArray arrayWithArray:categoryDTO.prodsList];
        
        vc.shoppingCartInfo = dto;
        
        [self.navigationController pushViewController:vc animated:YES];
        
        [self vs_hideLoadingWithCompleteBlock:nil];
        
    } orFail:^(id callBackData) {
        
        [self.view showTipsView:[callBackData domain]];
        
        [self vs_hideLoadingWithCompleteBlock:nil];
    }];
}

- (void)toApply:(id)data {
    
    if (![self isUserLogin]) {
        
        [self.navigationController pushViewController:[VSUserLoginViewController new] animated:YES];
        return;
    }
    
    NSDictionary *dic = (NSDictionary *)data;
    NSString *cooperationType = [dic objectForKey:@"cooperationType"];
    
    if ([cooperationType isEqualToString:@"41"]) {
        if ([self.labelTitle.text isEqualToString:@"债权融资"]) {
            FinancingViewController *vc = [[FinancingViewController alloc] init];
            vc.cooperationType = cooperationType;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([self.labelTitle.text isEqualToString:@"股权融资"]) {
            GuQuanRongZiViewController *vc = [[GuQuanRongZiViewController alloc] init];
            vc.cooperationType = cooperationType;
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else if ([cooperationType isEqualToString:@"43"]) {
        ChanYeJiJingViewController *vc = [[ChanYeJiJingViewController alloc] init];
        vc.cooperationType = cooperationType;
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([cooperationType isEqualToString:@"42"]) {
        ShangShiFuWuViewController *vc = [[ShangShiFuWuViewController alloc] init];
        vc.cooperationType = cooperationType;
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([cooperationType isEqualToString:@"44"]) {
        if ([self.labelTitle.text isEqualToString:@"企业贷款"]) {
            QiYeDaiKuanViewController *vc = [[QiYeDaiKuanViewController alloc] init];
            vc.cooperationType = cooperationType;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([self.labelTitle.text isEqualToString:@"企业理财"]) {
            QiYeLiCaiViewController *vc = [[QiYeLiCaiViewController alloc] init];
            vc.cooperationType = cooperationType;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }

    else {
        FinanceOtherJoinViewController *othervc = [[FinanceOtherJoinViewController alloc] init];
        othervc.cooperationType = cooperationType;
        [self.navigationController pushViewController:othervc animated:YES];
    }
}

#pragma mark - Functions-privary
-(void)WebViewDidFinishLoad{
    [self vs_hideLoadingWithCompleteBlock:nil];
    [self refreshTitle];
    [self setNavBarItems];
    [self recoverRightButton];
    [self.webView stringByEvaluatingJavaScriptFromString:@"cartInfoFromPhone()"];
}
//- (void)WebViewDidFailLoad{
//    [self vs_hideLoadingWithCompleteBlock:nil];
//}
//- (void)WebViewShouldStartLoad{
//    [self vs_showLoading];
//}
//
-(void)setNavBarItems{
    //    NSString *from = [[VSUserLogicManager shareInstance] userDataInfo].vm_from;
    //    if ([from isEqualToString:@"B"]) {
    //        [self.vm_rightButton setImage:[UIImage imageNamed:@"home_icon"] forState:UIControlStateNormal];
    //        [self.vm_rightButton setImage:[UIImage imageNamed:@"home_icon"] forState:UIControlStateHighlighted];
    //    }else {
    //        [self recoverRightButton];
    //    }
    //    [self vs_showRightButton:YES];
}

- (void)requesthaveNewMessage {
    
    MessageManager *messageManager = [[MessageManager alloc]init];
    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    
    if ([partyId isEmptyString]) {
        return;
    }
    [messageManager requesthaveNewMessage:nil success:^(NSDictionary *responseObj) {
        
        NSNumber *hasNewMessage = [responseObj objectForKey:@"hasNewMessage"];
        //        [self vs_showRightButton:YES];
        [VSUserLogicManager shareInstance].userDataInfo.vm_haveNewMessage = hasNewMessage.boolValue;
        //        [self recoverRightButton];
    } failure:^(NSError *error) {
        //
    }];
    
}
- (void)message {
    
    //判断是否登录
    [self userlogin:LOGIN_BACK_DEFAULT popVc:self animated:YES LoginSucceed:^{
        MessageViewController *controller = [[MessageViewController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
    } cancel:^{
        
    }];
}

-(void)recoverRightButton {
    
    //    self.navigationItem.rightBarButtonItem =nil;
    //    [self vs_showRightButton:YES];
    //    
    //    BOOL havNewMessage = [VSUserLogicManager shareInstance].userDataInfo.vm_haveNewMessage;
    //    if (havNewMessage) {
    //        [self.vm_rightButton setImage:[UIImage imageNamed:@"more_red"] forState:0];
    //    }else {
    //        [self.vm_rightButton setImage:[UIImage imageNamed:@"more"] forState:0];
    //    }
    
}
//重写右侧按钮点击事件
- (void)vs_rightButtonAction:(id)sender
{
    NSString *from = [[VSUserLogicManager shareInstance] userDataInfo].vm_from;
    NSString *orderType = [[VSUserLogicManager shareInstance] userDataInfo].vm_orderTypeId;
    NSString *visitType = [[VSUserLogicManager shareInstance] userDataInfo].vm_visitType;
    //    if ([from isEqualToString:@"B"]) {
    //        [self.navigationController popToRootViewControllerAnimated:YES];
    //    }else {
    NSArray *titles = @[@"个人首页",@"消息"];
    NSArray *images = @[@"home_icon",@"message_icon"];
    BOOL havNewMessage = [VSUserLogicManager shareInstance].userDataInfo.vm_haveNewMessage;
    if (havNewMessage) {
        images = @[@"home_icon",@"message_icon_red"];
    }else {
        images = @[@"home_icon",@"message_icon"];
    }
    
    /**
     *  为H5的则需要分享
     *
     */
    //        if (([visitType isEqualToString:@"H5"]) && ([orderType isEqualToString:SALES_ORDER_O2O_SALE] || [orderType isEqualToString:SALES_ORDER_B2C] || [orderType isEqualToString:SALES_ORDER_O2O_SERVICE])) {
    //            titles = @[@"个人中心",@"导航",@"分享"];
    //            images = @[@"centerhead",@"Compass",@"nav_share"];
    //        }
    if ([visitType isEqualToString:@"H5"]) {
        titles = @[@"个人首页",@"消息"];
        if (havNewMessage) {
            images = @[@"home_icon",@"message_icon_red"];
        }else {
            images = @[@"home_icon",@"message_icon"];
        }
        
    }
    PopoverView *tmppopoverView = [[PopoverView alloc] initWithPoint:CGPointMake(MainWidth - self.vm_rightButton.frame.size.width, self.navigationController.navigationBar.frame.origin.y + self.vm_rightButton.frame.origin.y + self.vm_rightButton.frame.size.height - 1.0f) titles:titles images:images];
    tmppopoverView.selectRowAtIndex = ^(NSInteger index){
        if (index == 0) {
            [self vs_back];
        }else if(index == 1){
            //消息
            [self message];
        }else if(index == 2){
            //分享
            NSLog(@"document.img----%@",[_webView stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"slider\").children[0].children[0]"]);
            NSString *shareURL = _webView.request.URL.absoluteString;
            if ([shareURL hasString:@"gproduct4phone"]) {
                shareURL = [shareURL stringByReplacingOccurrencesOfString:@"gproduct4phone" withString:@"excludeButGproduct4phone"];
            }else if ([shareURL hasString:@"product4phone"]) {
                shareURL = [shareURL stringByReplacingOccurrencesOfString:@"product4phone" withString:@"excludeButProduct4phone"];
            }else if ([shareURL hasString:@"productInfo4phone"]) {
                shareURL = [shareURL stringByReplacingOccurrencesOfString:@"productInfo4phone" withString:@"excludeButProductInfo4phone"];
            }
            [self shareClickedWithContent:[_webView stringByEvaluatingJavaScriptFromString:@"document.title"] Title:[_webView stringByEvaluatingJavaScriptFromString:@"document.title"] shareInviteUrl:[NSString stringWithFormat:@"%@",shareURL]];
        }
        else {
            NSLog(@"have no action");
        }
        
    };
    [tmppopoverView show];
    //    }
    
}
//重写左侧按钮点击事件
- (void)vs_leftButtonActon
{
    //    NSString *orderTypeId = [[VSUserLogicManager shareInstance] userDataInfo].vm_orderTypeId;
    if ([self.webTitle isEqualToString:@"快递查询"])
    {
        [self vs_back];
    }else if ([_webView canGoBack])
    {
        for (int i =0; i <= 10; i++)
        {
            [_webView goBack];
        }
        //modify by Thomas ［睿天下RUI-917：返回时不刷新title的问题］－－－start
        __weak __typeof(self)weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf refreshTitle];
        });
        //modify by Thomas ［返回时不刷新title的问题］－－－end
    }else
    {
        [self vs_back];
    }
    
    
    //    if ([self.webTitle isEqualToString:@"快递查询"]) {
    //        [self vs_back];
    //    }else if([orderTypeId isEqualToString:SALES_ORDER_O2O_SERVICE]){
    //        //如是预约类则直接返回首页
    ////        [self.navigationController popToRootViewControllerAnimated:YES];
    //        [self vs_back];
    //    }else{
    //        [self goBack];
    //    }
    
}

-(void)reloadWebViewByHtmlString2:(NSString*)string
{
    [_webView loadHTMLString:string baseURL:nil];
}

-(void)reloadWebViewByHtmlString:(NSDictionary*)dic
{
    [_webView loadHTMLString:[dic valueForKey:@"webAppData"] baseURL:nil];
}
#pragma mark --Functions-public
- (void)reloadWebView
{
    [self webViewLoadURL:self.webUrl];
}
- (void)refreshTitle
{
    if (self.webTitle && ![self.webTitle isEqualToString:@""] && ![self.webTitle isEqualToString:@"默认标题"]) {
        [self vs_setTitleText:self.webTitle];
    }else{
        NSString *theTitle = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
        
        [self vs_setTitleText:(theTitle.length > 0)? theTitle : self.webTitle];
    }
    
}



/*刷新*/
- (void)refresh
{
    //    [self showWebLoading];
    [_webView reload];
    [self refreshTitle];
}

/*前进*/
- (void)goForward
{
    if([_webView canGoForward])
    {
        [self refreshTitle];
        [_webView goForward];
    }
}
/*后退*/
- (void)goBack
{
    if([_webView canGoBack])
    {
        [self refreshTitle];
        [_webView goBack];
    }else{
        [self vs_back];
    }
}

- (BOOL)webViewCanGoBack {
    if ([_webView canGoBack]) {
        return YES;
    } else {
        return NO;
    }
}

- (void)showLoading
{
    [self.loadingView setHidden:NO];
    [self.loadingView startAnimating];
}

- (void)hideLoading
{
    [self.loadingView setHidden:YES];
    [self.loadingView stopAnimating];
}

- (void)clearCaches
{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

#pragma mark -- getter
_GETTER_ALLOC_BEGIN(UIActivityIndicatorView, loadingView)
{
    _CLEAR_BACKGROUND_COLOR_(_loadingView);
    [self.view addSubview:_loadingView];
    [_loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        make.width.equalTo(@(20));
        make.height.equalTo(@(20));
        
    }];
}
_GETTER_END(loadingView)

_GETTER_ALLOC_BEGIN(JSWebView,webView)
{
    _webView.clipsToBounds   = YES;
    _webView.scalesPageToFit = YES;
    
}
_GETTER_END(webView)

@end

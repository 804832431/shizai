//
//  ShoppingCartViewController.m
//  VSProject
//
//  Created by 陈 海涛 on 15/11/11.
//  Copyright © 2015年 user. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "ShoppingCartShopTableViewCell.h"
#import "O2OOrderDetailViewController.h"
#import "DBHelpQueueManager.h"
#import "BCNetWorkTool.h"
#import "OrderDetailViewController.h"
#import "CategoryDTO.h"
#import "ProductDTO.h"
#import "VSUserLoginViewController.h"
#import "ShoppingCartInfoDTO.h"
#import "CartItemDTO.h"

static NSString *ShopCellIdentifier = @"ShopCellIdentifier";
static NSString *ProductCellIdentifier = @"ProductCellIdentifier";

@interface ShoppingCartViewController ()

@property (nonatomic,strong) CategoryDTO *selectedCategoryDTO;

@property (nonatomic,strong) NSMutableArray *selectedProductDTOList;

@property (nonatomic,strong) NSMutableArray *otherParamsArr;//其他与订单相关的参数

@end

@implementation ShoppingCartViewController

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSMutableArray *)selectedProductDTOList{
    
    if (_selectedProductDTOList == nil) {
        _selectedProductDTOList = [NSMutableArray array];
    }
    
    return _selectedProductDTOList;
}

- (ShoppingCartBottomView *)bottomView{
    if (_bottomView == nil) {
        _bottomView = (ShoppingCartBottomView *)[[[NSBundle mainBundle] loadNibNamed:@"ShoppingCartBottomView" owner:nil options:nil] lastObject];
    }
    return _bottomView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self vs_setTitleText:@"购物车"];
    
    self.navigationController.navigationBarHidden = NO;
    
    __weak typeof(&*self) weakSelf = self;
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.view);
        make.trailing.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view).with.offset(-50);
    }];
    
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view);
        make.height.mas_equalTo(50);
    }];
    
    
    UINib *nib = [UINib nibWithNibName:@"ShoppingCartShopTableViewCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forCellReuseIdentifier:ShopCellIdentifier];
    nib = [UINib nibWithNibName:@"ShoppingCartProductTableViewCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forCellReuseIdentifier:ProductCellIdentifier];
    
    
    //去结算按钮处理事件
    [self.bottomView setOkBlock:^{
        
        if (![weakSelf isUserLogin]) {
            
            [weakSelf.navigationController pushViewController:[VSUserLoginViewController new] animated:YES];
            
        }else{
            
            if (weakSelf.selectedCategoryDTO == nil) {
                
                [weakSelf.view showTipsView:@"请选择商品"];
                
                return ;
            }
            
            
            [weakSelf vs_showLoading];
            
            CategoryDTO *category = weakSelf.selectedCategoryDTO;
            
            NSMutableArray *proArr = [NSMutableArray array];
            for (ProductDTO *dto in weakSelf.selectedProductDTOList) {
                
                if (dto.quantity.integerValue == 0) {
                    continue;
                }
                
                NSDictionary *dic = @{@"quantity":dto.quantity,@"productId":dto.productId};
                
                [proArr addObject:dic];
            }
            
            if (proArr.count == 0) {
                
                [weakSelf.view showTipsView:@"请查看商品数量"];
                
                [weakSelf vs_hideLoadingWithCompleteBlock:nil];
                
                return;
            }
            NSDictionary *dic = nil;
            
            dic = @{ @"promoCode":@"",@"userLoginId":[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.username,@"productStoreId":category.productStoreId,@"catalogId":category.catalogId?:@"",@"categoryId":category.categoryId,@"productItems":proArr,@"orderTypeId":category.orderTypeId};
            
            NSData *contentData = (NSData *)[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
            
            NSString* jsonContent = [[NSString alloc] initWithData:contentData encoding:NSUTF8StringEncoding];
            
            NSDictionary * contentDic = [NSDictionary dictionaryWithObjectsAndKeys:jsonContent,@"content", nil];
            
            
            [BCNetWorkTool executePostNetworkWithParameter:contentDic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.order/confirm-order" withSuccess:^(id callBackData) {
                
                NSDictionary *dic = (NSDictionary *)callBackData;
                
                ShoppingCartInfoDTO *dto = [[ShoppingCartInfoDTO alloc] initWithDictionary:dic[@"shoppingCartInfo"] error:nil];
                
                
                
                CheckOrderViewController *vc = [CheckOrderViewController new];
                
                vc.orderDemand = dic[@"orderDemand"];
                
                vc.fromShoppingCart = YES;
                
                vc.selectedCategoryDTO = weakSelf.selectedCategoryDTO;
                
                vc.selectedProductDTOList = [weakSelf.selectedProductDTOList copy];
                
                vc.shoppingCartInfo = dto;
                
                
                
                [weakSelf.navigationController pushViewController:vc animated:YES];
                
                [weakSelf vs_hideLoadingWithCompleteBlock:nil];
                
            } orFail:^(id callBackData) {
                
                NSError *error = (NSError *)callBackData;
                
                [weakSelf.view showTipsView:[error domain]];
                
                [weakSelf vs_hideLoadingWithCompleteBlock:nil];
            }];
        }
        
        
        
        
    }];
    
    
    //清除按钮处理事件
    [self.bottomView setClearBlock:^{
        
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您确认清除购物车吗？" delegate:weakSelf cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        
        [alertView show];
        
        
    }];
    
    [self loadDataFormDB];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(createOrderSuccess:) name:@"kOrderCreatedSuccess" object:nil];
}

#pragma mark -
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        
        
        self.selectedCategoryDTO = nil;
        
        [self.selectedProductDTOList removeAllObjects];
        
        self.dataSource = nil;
        
        [self.tableView reloadData];
        
        NSString *sql = nil;
        
        if ([VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId.length > 0) {
            sql =  [NSString stringWithFormat:@"delete from ld_cart  WHERE  userid = '%@' or userid ='visitor'",[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId];
        }else{
            sql =  [NSString stringWithFormat:@"delete from ld_cart WHERE  userid = 'visitor'"];
        }
        
        
        
        
        [[DBHelpQueueManager shareInstance].rsFMDBQueue inDatabase:^(FMDatabase *db) {
            
            [db open];
            
            [db executeUpdate:sql];
            
            [db close];
            
            
        }];
        
    }
}


#pragma mark -

- (void)createOrderSuccess:(NSNotification *)notification{
    
    NSDictionary *dic = [notification userInfo];
    NSString *proList = @"";
    for (NSDictionary *item in dic[@"proList"]) {
        
        if (proList.length == 0) {
            proList = [NSString stringWithFormat:@"%@",item[@"productId"]];
        }else{
            proList = [NSString stringWithFormat:@"%@,%@",proList,item[@"productId"]];
        }
        
    }
    
    NSMutableArray *deleteArr = [NSMutableArray array];
    for (ProductDTO *dto in self.selectedCategoryDTO.prodsList) {
        NSArray *productIdList = [proList componentsSeparatedByString:@","];
        if ([productIdList containsObject:dto.productId] ) {
            [deleteArr addObject:dto];
        }
    }
    
    if (deleteArr.count > 0) {
        NSMutableArray *tmpArr = [NSMutableArray arrayWithArray:self.selectedCategoryDTO.prodsList];
        [tmpArr removeObjectsInArray:deleteArr];
        self.selectedCategoryDTO.prodsList = [NSArray arrayWithArray:tmpArr];
        
        [self.selectedProductDTOList removeObjectsInArray:deleteArr];
        
        if (self.selectedCategoryDTO.prodsList.count == 0) {
            NSMutableArray *tmpArr = [NSMutableArray arrayWithArray:self.dataSource];
            [tmpArr removeObject:self.selectedCategoryDTO];
            self.dataSource = [NSArray arrayWithArray:tmpArr];
            self.selectedCategoryDTO = nil;
        }
        
        
        [self.tableView reloadData];
    }
    
    NSString *sql = @"";
    
    if ([VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId.length > 0) {
        sql =  [NSString stringWithFormat:@"DELETE from ld_cart  WHERE productid in (%@) and userid = '%@' or userid = 'visitor'",proList,[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId];
    }else{
        sql =  [NSString stringWithFormat:@"DELETE from ld_cart WHERE productid in (%@) and userid = 'visitor'",proList];
    }
    
    
    
    
    [[DBHelpQueueManager shareInstance].rsFMDBQueue inDatabase:^(FMDatabase *db) {
        
        [db open];
        
        [db executeUpdate:sql];
        
        [db close];
        
        
    }];
    
    
    
    
}

- (void)loadDataFormDB{
    
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
            
            NSDictionary *otherPar = @{@"productStoreId":[set stringForColumn:@"productStoreId"].length > 0?[set stringForColumn:@"productStoreId"]:@"",@"orderTypeId":[set stringForColumn:@"orderTypeId"].length > 0?[set stringForColumn:@"orderTypeId"]:@"",@"catalogId":[set stringForColumn:@"catalogId"].length>0?[set stringForColumn:@"catalogId"]:@"",@"categoryId":categoryId};
            if (self.otherParamsArr == nil) {
                self.otherParamsArr = [NSMutableArray array];
                [self.otherParamsArr addObject:otherPar];
            }else{
                [self.otherParamsArr addObject:otherPar];
            }
            
            
            
            NSDictionary *dic = @{@"productId":productId,@"quantity":quantity};
            
            NSMutableDictionary *itemDic = nil;
            
            for (NSMutableDictionary *tmpDic in tmpArr) {
                
                if ([[tmpDic objectForKey:@"categoryId"] isEqualToString:categoryId]) {
                    itemDic = tmpDic;
                    break;
                }
                
            }
            
            if (itemDic == nil) {
                itemDic = [NSMutableDictionary dictionary];
                [itemDic setObject:categoryId forKey:@"categoryId"];
                [tmpArr addObject:itemDic];
                
            }
            
            NSMutableArray *proList = [itemDic objectForKey:@"prodList"];
            if (proList == nil) {
                proList = [NSMutableArray array];
                [itemDic setObject:proList forKey:@"prodList"];
            }
            
            [proList addObject:dic];
            
            
        }
        [db close];
        
        
    }];
    
    if (tmpArr.count == 0) {
        return;
    }
    
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
            
            NSDictionary *resultDic = nil;
            for (NSDictionary *dic in self.otherParamsArr) {
                if ([dic[@"categoryId"] isEqualToString:dto.categoryId]) {
                    resultDic = dic;
                    break;
                }
            }
            
            if (resultDic) {
                dto.catalogId = resultDic[@"catalogId"];
                dto.productStoreId = resultDic[@"productStoreId"];
                dto.orderTypeId = resultDic[@"orderTypeId"];
            }
            
            
            [tmpArr addObject:dto];
        }
        
        self.dataSource = tmpArr;
        
        [self.tableView reloadData];
        
        [self vs_hideLoadingWithCompleteBlock:nil];
        
    } orFail:^(id callBackData) {
        [self vs_hideLoadingWithCompleteBlock:nil];
    }];
    
    
}

#pragma mark -- UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    [self calulateProductMoney];
    
    return self.dataSource.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    CategoryDTO *dto = [self.dataSource objectAtIndex:section];
    
    return  dto.prodsList.count + 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CategoryDTO *categoryDTO = [self.dataSource objectAtIndex:indexPath.section];
    
    __weak typeof(&*self) weakSelf = self;
    
    if (indexPath.row == 0) {
        
        ShoppingCartShopTableViewCell *shopCell = [tableView dequeueReusableCellWithIdentifier:ShopCellIdentifier forIndexPath:indexPath];
        
        
        shopCell.selectedCategoryDTO = self.selectedCategoryDTO;
        shopCell.selectedProductDTOList = self.selectedProductDTOList;
        shopCell.data = categoryDTO;
        
        
        
        
        [shopCell setBlock:^(ShoppingCartShopTableViewCell *cell){
            
            if (weakSelf.selectedCategoryDTO == nil) {
                weakSelf.selectedCategoryDTO = categoryDTO;
                [weakSelf.selectedProductDTOList removeAllObjects];
                [weakSelf.selectedProductDTOList addObjectsFromArray:categoryDTO.prodsList];
            }else if([weakSelf.selectedCategoryDTO.categoryId isEqualToString:categoryDTO.categoryId]){
                
                if (weakSelf.selectedProductDTOList.count == weakSelf.selectedCategoryDTO.prodsList.count) {
                    weakSelf.selectedCategoryDTO = nil;
                    [weakSelf.selectedProductDTOList removeAllObjects];
                }else{
                    weakSelf.selectedCategoryDTO = categoryDTO;
                    [weakSelf.selectedProductDTOList removeAllObjects];
                    [weakSelf.selectedProductDTOList addObjectsFromArray:categoryDTO.prodsList];
                }
                
            }
            
            [weakSelf.tableView reloadData];
            
            
        }];
        
        return shopCell;
        
    }else{
        
        ShoppingCartProductTableViewCell *productCell = [tableView dequeueReusableCellWithIdentifier:ProductCellIdentifier forIndexPath:indexPath];
        NSInteger num = [self tableView:tableView numberOfRowsInSection:indexPath.section];
        
        productCell.categoryDTO = categoryDTO;
        productCell.selectedCategoryDTO = self.selectedCategoryDTO;
        productCell.selectedProductDTOList = self.selectedProductDTOList;
        
        NSArray *proList = categoryDTO.prodsList;
        ProductDTO *dto = proList[indexPath.row - 1];
        productCell.data = dto;
        
        if (indexPath.row == num -1) {
            productCell.lastBottomLineview.hidden = NO;
            productCell.bottomLineView.hidden = YES;
        }else{
            productCell.lastBottomLineview.hidden = YES;
            productCell.bottomLineView.hidden = NO;
        }
        
        [productCell setBlock:^(ShoppingCartProductTableViewCell *cell) {
            
            if (weakSelf.selectedCategoryDTO == nil) {
                weakSelf.selectedCategoryDTO = categoryDTO;
                [weakSelf.selectedProductDTOList removeAllObjects];
                [weakSelf.selectedProductDTOList addObject:dto];
            }else if([weakSelf.selectedCategoryDTO.categoryId isEqualToString:categoryDTO.categoryId]){
                if ([weakSelf.selectedProductDTOList containsObject:dto]) {
                    [weakSelf.selectedProductDTOList removeObject:dto];
                    if (weakSelf.selectedProductDTOList.count == 0) {
                        weakSelf.selectedCategoryDTO = nil;
                    }
                }else{
                    [weakSelf.selectedProductDTOList addObject:dto];
                }
            }
            
            [weakSelf.tableView reloadData];
            
            
        }];
        
        [productCell setReductionBlock:^(ProductDTO *product) {
            
            [weakSelf changeProduction:product isAdd:NO withSuccess:^(NSDictionary *dic, NSError *error) {
                if (dic) {
                    NSString *flag = dic[@"flag"];
                    if ([flag isEqualToString:@"true"]) {
                        
                        NSString *sql = nil;
                        
                        if ([VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId.length > 0) {
                            sql =  [NSString stringWithFormat:@"UPDATE ld_cart SET count = '%zi' WHERE productid = '%@' and userid = '%@'",product.quantity.integerValue - 1,product.productId,[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId];
                        }else{
                            sql =  [NSString stringWithFormat:@"UPDATE ld_cart SET count = '%zi' WHERE productid = '%@' and userid = 'visitor'",product.quantity.integerValue - 1,product.productId];
                        }
                        
                        [[DBHelpQueueManager shareInstance].rsFMDBQueue inDatabase:^(FMDatabase *db) {
                            
                            [db open];
                            
                            [db executeUpdate:sql];
                            
                            [db close];
                            product.quantity = [NSString stringWithFormat:@"%zi",product.quantity.integerValue - 1];
                            [weakSelf.tableView reloadData];
                        }];
                        
                    }else{
                        [weakSelf.view showTipsView:@"库存不足"];
                    }
                }else{
                    [weakSelf.view showTipsView:@"操作失败"];
                }
            }];
            
        }];
        
        [productCell setAddBlock:^(ProductDTO *product) {
            
            [weakSelf changeProduction:product isAdd:YES withSuccess:^(NSDictionary *dic, NSError *error) {
                
                if (dic) {
                    NSString *flag = dic[@"flag"];
                    if ([flag isEqualToString:@"true"]) {
                        
                        NSString *sql = nil;
                        
                        if ([VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId.length > 0) {
                            sql =  [NSString stringWithFormat:@"UPDATE ld_cart SET count = '%zi' WHERE productid = '%@' and userid = '%@'",product.quantity.integerValue + 1,product.productId,[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId];
                        }else{
                            sql =  [NSString stringWithFormat:@"UPDATE ld_cart SET count = '%zi' WHERE productid = '%@' and userid = 'visitor'",product.quantity.integerValue + 1,product.productId];
                        }
                        
                        [[DBHelpQueueManager shareInstance].rsFMDBQueue inDatabase:^(FMDatabase *db) {
                            
                            [db open];
                            
                            [db executeUpdate:sql];
                            
                            [db close];
                            product.quantity = [NSString stringWithFormat:@"%zi",product.quantity.integerValue + 1];
                            [weakSelf.tableView reloadData];
                        }];
                        
                    }else{
                        [weakSelf.view showTipsView:@"库存不足"];
                    }
                }else{
                    [weakSelf.view showTipsView:@"操作失败"];
                }
                
            }];
            
        }];
        
        
        return productCell;
    }
    
}

//进行增加，减少购买商品数量
- (void)changeProduction:(ProductDTO *)product isAdd:(BOOL)add withSuccess:(void (^)(NSDictionary *dic,NSError *error))completionBlock {
    
    [self vs_showLoading];
    
    NSDictionary *dic;
    
    if (add) {
        dic = @{@"productId":product.productId,@"quantity":[NSString stringWithFormat:@"%zi",product.quantity.integerValue +1]};
    }else{
        if ([product.quantity isEqualToString:@"0"]) {
            
            [self vs_hideLoadingWithCompleteBlock:nil];
            
            return;
        }
        dic = @{@"productId":product.productId,@"quantity":[NSString stringWithFormat:@"%zi",product.quantity.integerValue - 1]};
    }
    
    
    
    
    [BCNetWorkTool executeGETNetworkWithParameter:dic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.order/check-inventory" withSuccess:^(id callBackData) {
        
        
        NSDictionary *dic = (NSDictionary *)callBackData;
        
        if (completionBlock) {
            completionBlock(dic,nil);
        }
        
        [self vs_hideLoadingWithCompleteBlock:nil];
        
    } orFail:^(id callBackData) {
        
        if (completionBlock) {
            completionBlock(nil,callBackData);
        }
        
        [self vs_hideLoadingWithCompleteBlock:nil];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 50;
    }else{
        return 71;
    }
    
    
}

- (CGFloat) tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
    
}

- (void)calulateProductMoney{
    
    CGFloat allMoney = 0.0;
    
    for (ProductDTO *dto  in self.selectedProductDTOList) {
        
        allMoney += dto.unitPrice.floatValue * dto.quantity.integerValue;
    }
    
    self.bottomView.totalMoney.text = [NSString stringWithFormat:@"合计:¥ %.2f",allMoney];
    
}

@end

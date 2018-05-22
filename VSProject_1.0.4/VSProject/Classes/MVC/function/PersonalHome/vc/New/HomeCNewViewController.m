//
//  HomeCNewViewController.m
//  VSProject
//
//  Created by certus on 16/3/8.
//  Copyright © 2016年 user. All rights reserved.
//

#import "HomeCNewViewController.h"
#import "HomeManger.h"
#import "HomeCCollectionViewCell.h"
#import "RTXCAppModel.h"

#define top_height (MainHeight/4)

@interface HomeCNewViewController (){
    
    UILabel *titleLabel;
    UIButton *locateView;
    HomeManger *manger;
    NSArray *dataList;
    
}

@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)UIImageView *topimageView;

@end

@implementation HomeCNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    manger = [[HomeManger alloc]init];
    self.view.backgroundColor = _COLOR_HEX(0xdedede);
    
    [self addCollectionView];
    
    [self buildNavigationItem];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self requestCustomerApplications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - request

- (void)requestCustomerApplications {
    
    [self vs_showLoading];
    [manger requestCustomerApplications:nil success:^(NSDictionary *responseObj) {
        [self vs_hideLoadingWithCompleteBlock:nil];
        [_collectionView headerEndRefreshing];
        
        dataList  = [NSArray arrayWithArray:[responseObj objectForKey:@"layout"]];
        [_collectionView reloadData];
        [self resetTitle];
        
    } failure:^(NSError *error) {
        [self vs_hideLoadingWithCompleteBlock:nil];
        [self.view showTipsView:[error domain]];
        [_collectionView headerEndRefreshing];
    }];
}

#pragma mark - private

- (void)buildNavigationItem {
    
    UIButton *titleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, (MainWidth-84)/2, 64)];
    titleButton .backgroundColor = [UIColor clearColor];
    locateView = [[UIButton alloc]initWithFrame:CGRectMake(10, 12, 40, 40)];
    [locateView setImage:[UIImage imageNamed:@"location"] forState:0];
    [titleButton addSubview:locateView];
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 12, 80, 40)];
    
    [self resetTitle];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    [titleButton addSubview:titleLabel];
    self.navigationItem.titleView = titleButton;
}

- (void)resetTitle{
    
    NSString *name = [VSUserLogicManager shareInstance].userDataInfo.vm_projectInfo.name;
    if (name) {
        titleLabel.text = name;
    }else {
        titleLabel.text = @"房山绿地";
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RTXCAppModel *model = [dataList objectAtIndex:indexPath.row];
    
    HomeCCollectionViewCell *cell = (HomeCCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCCollectionViewCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.c_titleLabel.text = model.appName;
    cell.c_subLabel.text = model.appIntroduction;
    
    NSString *imagePath = [NSString stringWithFormat:@"%@%@",model.appIcon,@"_ios_3l.png"];
    [cell.c_imageView sd_setImageWithString:imagePath placeholderImage:[UIImage imageNamed:@"syjz_ios_l"]];
    if ([model.visitkeyword isEqualToString:@"fwzl"]) {
        BOOL hasUnreadFWZL=[VSUserLogicManager shareInstance].userDataInfo.vm_hasUnreadFWZL;
        if (hasUnreadFWZL) {
            [cell.c_red setHidden:NO];
        }
    }else {
        [cell.c_red setHidden:YES];
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeCCollectionViewHeader" forIndexPath:indexPath];
    
    [headerView addSubview:self.topimageView];
    
    return headerView;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RTXCAppModel *model = dataList[indexPath.row];
    [self toApplication:model fromController:self];
    
}

- (UIImageView *)topimageView {
    
    if (!_topimageView) {
        _topimageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, top_height)];
        _topimageView.image = [UIImage imageNamed:@"csbg"];
        _topimageView.clipsToBounds = YES;
        _topimageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _topimageView;
}

- (void)addCollectionView{
    
    float itemgap = 9;
    float itemHeight = (MainHeight-top_height-120)/4-itemgap;
    itemHeight = itemHeight >= 70 ? itemHeight:70;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.itemSize = CGSizeMake((MainWidth-3*itemgap)/2, itemHeight);
    flowLayout.minimumLineSpacing = itemgap;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.headerReferenceSize = CGSizeMake(MainWidth, top_height+9);
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(8, 0, MainWidth-16, MainHeight-itemgap) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = _COLOR_HEX(0xdedede);
    _collectionView.delegate = (id<UICollectionViewDelegate>)self;
    _collectionView.dataSource = (id<UICollectionViewDataSource>)self;
    _collectionView.showsVerticalScrollIndicator = NO;
    [_collectionView registerClass:[HomeCCollectionViewCell class] forCellWithReuseIdentifier:@"HomeCCollectionViewCell"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeCCollectionViewHeader"];
    [self.view addSubview:_collectionView];
    __weak typeof(self)weakself = self;
    [_collectionView addHeaderWithCallback:^{
        [weakself requestCustomerApplications];
    }];
    
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

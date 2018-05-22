//
//  ServerButtonView.m
//  VSProject
//
//  Created by pangchao on 17/6/25.
//  Copyright © 2017年 user. All rights reserved.
//

#import "ServerButtonView.h"
#import "ServerCollectionCell.h"

@interface ServerButtonView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ServerButtonView

- (void)setDataSource:(NSArray *)dataList {
    
    self.dataList = [NSArray arrayWithArray:dataList];
    
    if (self.collectionView.superview) {
        [self.collectionView removeFromSuperview];
    }
    [self addSubview:self.collectionView];
    [self.collectionView reloadData];
}

-  (UICollectionView *)collectionView {
    
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        flowLayout.itemSize = CGSizeMake((MainWidth - Get750Width(16.0f))/4.000000f, cellHeight);
        flowLayout.minimumLineSpacing = 0.0f;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.headerReferenceSize = CGSizeMake(0, 0);
        flowLayout.footerReferenceSize = CGSizeMake(0, 0);
        flowLayout.minimumInteritemSpacing = 0.0f;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(Get750Width(8.0f), 0, MainWidth - Get750Width(16.0f), MainHeight) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = (id<UICollectionViewDelegate>)self;
        _collectionView.dataSource = (id<UICollectionViewDataSource>)self;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[ServerCollectionCell class] forCellWithReuseIdentifier:@"ServerCollectionCell"];
        _collectionView.scrollEnabled = NO;
        
    }
    
    return _collectionView;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RTXBapplicationInfoModel *model = [self.dataList objectAtIndex:indexPath.row];
    
    ServerCollectionCell *cell = (ServerCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ServerCollectionCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.nameLabel.text = model.appName;
    
    NSString *imagePath = [NSString stringWithFormat:@"%@",model.appIcon];
    
    [cell.imageView sd_setImageWithString:imagePath placeholderImage:[UIImage imageNamed:@"usercenter_defaultpic"]];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RTXBapplicationInfoModel *model = self.dataList[indexPath.row];
    if (self.clickedDelegate) {
        [self.clickedDelegate clickedButtonAction:model];
    }
}

+ (CGFloat)getHeighWithIconCount:(NSInteger)iconCount {
    
    CGFloat height = 0.0f;
    
    if (iconCount < 4) {
        height = Get750Width(188.0f);
    }
    else {
        height = Get750Width(350.0f);
    }
    
    return height;
}

@end

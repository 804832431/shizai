//
//  HomeBNewViewController.m
//  VSProject
//
//  Created by certus on 16/3/8.
//  Copyright © 2016年 user. All rights reserved.
//

#import "HomeBNewViewController.h"
#import "ManagementManger.h"
#import "HomeBCollectionViewCell.h"
#import "RTXBapplicationInfoModel.h"
#import "ActivityModel.h"
#import "ActivitiesManager.h"
#import "GreatActivityDetailViewController.h"
#import "EnterpriseInfoViewController.h"
#import "VSUserLoginViewController.h"
#import "EnterpriseJoinViewController.h"
#import "LDResisterManger.h"

#define header_height  (MainWidth/4.9)
#define footer_height  (MainWidth/4.75)

@interface HomeBNewViewController () <UICollectionViewDelegate,UITableViewDataSource> {
    
    ManagementManger *manger;
    NSArray *dataList;
    
}
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)UIButton *topButton;
@property (nonatomic, strong)UIButton *bottomButton;
@property (nonatomic, strong)UIImageView *t_imageView;
@property (nonatomic, strong)UILabel *t_companyLabel;
@property (nonatomic, strong)UILabel *t_nameLabel;
@property (nonatomic, strong)UILabel *t_phoneLabel;
@property (nonatomic, strong)UILabel *line;

@end

@implementation HomeBNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    manger = [[ManagementManger alloc]init];
    
    [self vs_setTitleText:[VSUserLogicManager shareInstance].userDataInfo.vm_projectInfo.name ?:@"房山绿地"];
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    [leftButton addTarget:self action:@selector(actionBack) forControlEvents:UIControlEventTouchUpInside];
    leftButton.imageView.tintColor = [UIColor whiteColor];
    leftButton.backgroundColor = [UIColor clearColor];
    [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftButton setTitle:@"个人" forState:UIControlStateNormal];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = rightBarButton;
    
    [self addCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self requestBusinessApplications];
    self.t_companyLabel.text = @"";
    self.t_nameLabel.text = @"";
    self.t_phoneLabel.text = @"";
    
}


#pragma mark - request

- (void)requestBusinessApplications {
    
    [self vs_showLoading];
    [manger requestBusinessApplications:nil success:^(NSDictionary *responseObj) {
        [self vs_hideLoadingWithCompleteBlock:nil];
        
        NSMutableArray *aar = [NSMutableArray arrayWithArray:[responseObj objectForKey:@"layout"]];
        dataList  = [NSArray arrayWithArray:aar];
        [_collectionView reloadData];
        [self reloadTopView:[responseObj objectForKey:@"companyInfo"] relationship:[responseObj objectForKey:@"relationship"]];
        
        [_collectionView headerEndRefreshing];
    } failure:^(NSError *error) {
        [self vs_hideLoadingWithCompleteBlock:nil];
        [self.view showTipsView:[error domain]];
        [_collectionView headerEndRefreshing];
    }];
}


- (void)requestCheckPermissonToBApplication:(NSString *)applicationId canPush:(void(^)())canPush{
    
    [self vs_showLoading];
    
    NSString *partyId =[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId;
    
    NSMutableDictionary *para=[NSMutableDictionary dictionary];
    [para setObject:partyId forKey:@"partyId"];
    [para setObject:applicationId forKey:@"applicationId"];
    
    [manger requestCheckPermissonToBApplication:para success:^(NSDictionary *responseObj) {
        [self vs_hideLoadingWithCompleteBlock:nil];
        canPush();
    } failure:^(NSError *error) {
        [self vs_hideLoadingWithCompleteBlock:nil];
        //        [self.view showTipsView:[error domain]];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:[error domain] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
    }];
}


- (void)requestGreatActivityList {
    
    ActivitiesManager *amange = [[ActivitiesManager alloc]init];
    [self vs_showLoading];
    NSDictionary *para = @{@"page":@"1",@"row":@"1"};
    [amange requestGreatActivityList:para success:^(NSDictionary *responseObj) {
        //
        NSArray *arr = [responseObj objectForKey:@"activityList"];
        if (arr.count > 0) {
            ActivityModel *amodel = [[ActivityModel alloc]initWithDictionary:[arr  firstObject] error:nil];
            GreatActivityDetailViewController *vcontroller = [[GreatActivityDetailViewController alloc]init];
            vcontroller.a_model = amodel;
            [self.navigationController pushViewController:vcontroller animated:YES];
            
        }else {
            [self vs_hideLoadingWithCompleteBlock:nil];
            [self.view showTipsView:@"暂无最新活动！"];
        }
    } failure:^(NSError *error) {
        //
        [self vs_hideLoadingWithCompleteBlock:nil];
        [self.view showTipsView:[error domain]];
    }];
}

#pragma mark - action

- (void)actionBack {
    
    [self.navigationController dismissViewControllerAnimated:NO completion:^{
        [KNotificationCenter postNotificationName:kHome_BackHomeC object:nil];
    }];
}
- (void)topAction:(UIButton *)sender {
    
    NSString *partyId =[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId;
    
    if (partyId && ![partyId isEmptyString]) {
        NSDictionary *dic = @{@"partyId":partyId};
        LDResisterManger *roleManger = [[LDResisterManger alloc]init];
        [self vs_showLoading];
        [roleManger requestInviaterRole:dic success:^(NSDictionary *responseObj) {
            [self vs_hideLoadingWithCompleteBlock:nil];
            [self judgeRole];
        } failure:^(NSError *error) {
            [self vs_hideLoadingWithCompleteBlock:nil];
            [self judgeRole];
        }];
    }else {
        [self judgeRole];
    }
    
}

- (void)bottomAction:(UIButton *)sender {
    
    [self requestGreatActivityList];
}

#pragma mark - private

- (void)judgeRole {
    NSString *roleInCompany = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.roleInCompany;
    if (roleInCompany && [roleInCompany isEqualToString:@"admin"]) {
        EnterpriseInfoViewController *vc = [[EnterpriseInfoViewController alloc]init];
        vc.roleType = ROLE_admin;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (roleInCompany && [roleInCompany isEqualToString:@"employee"]) {
        EnterpriseInfoViewController *vc = [[EnterpriseInfoViewController alloc]init];
        vc.roleType = ROLE_employee;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self userlogin:LOGIN_BACK_DEFAULT popVc:self animated:YES LoginSucceed:^{
            EnterpriseJoinViewController *vc = [[EnterpriseJoinViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        } cancel:^{
            
        }];
    }
    
}

- (void)reloadTopView:(NSDictionary *)companyInfo relationship:(NSDictionary *)relationship{
    
    if ([companyInfo isKindOfClass:[NSDictionary class]]) {
        self.t_companyLabel.text = [companyInfo objectForKey:@"name"];
        [self topButtonShouldShow:YES];
    }else {
        [self topButtonShouldShow:NO];
    }
    if ([relationship isKindOfClass:[NSDictionary class]]) {
        self.t_nameLabel.text = [relationship objectForKey:@"name"];
        self.t_phoneLabel.text = [relationship objectForKey:@"userLoginId"];
    }
}

- (void)topButtonShouldShow:(BOOL)inCpmpany {
    if (inCpmpany) {
        [self.t_companyLabel setHidden:NO];
        [self.t_nameLabel setHidden:NO];
        [self.t_phoneLabel setHidden:NO];
        [self.line setHidden:NO];
        [_topButton setImage:[UIImage imageNamed:@""] forState:0];
        [_topButton setImage:[UIImage imageNamed:@""] forState:1];
    }else {
        [self.t_companyLabel setHidden:YES];
        [self.t_nameLabel setHidden:YES];
        [self.t_phoneLabel setHidden:YES];
        [self.line setHidden:YES];
        _topButton.clipsToBounds = YES;
        _topButton.contentMode = UIViewContentModeScaleAspectFill;
        [_topButton setImage:[UIImage imageNamed:@"companyJoin"] forState:0];
        [_topButton setImage:[UIImage imageNamed:@"companyJoin"] forState:1];
    }
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RTXBapplicationInfoModel *model = [dataList objectAtIndex:indexPath.row];
    
    HomeBCollectionViewCell *cell = (HomeBCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"HomeBCollectionViewCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.nameLabel.text = model.appName;
    
    NSString *imagePath = [NSString stringWithFormat:@"%@%@",model.appIcon,@"_ios_b.png"];
    [cell.imageView sd_setImageWithString:imagePath placeholderImage:[UIImage imageNamed:@"syjz_ios_l"]];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeCCollectionViewHeader" forIndexPath:indexPath];
        
        [headerView addSubview:self.topButton];
        [self addTopButtonSubviews];
        
        return headerView;
    }else {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"HomeCCollectionViewFooter" forIndexPath:indexPath];
        
        [headerView addSubview:self.bottomButton];
        
        return headerView;
    }
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self userlogin:LOGIN_BACK_DEFAULT popVc:self animated:YES LoginSucceed:^{
        RTXBapplicationInfoModel *model = dataList[indexPath.row];
        __weak typeof(self)weakself = self;
        [self requestCheckPermissonToBApplication:model.m_id canPush:^{
            [weakself toApplication:model fromController:self];
        }];
    } cancel:^{
        
    }];
}

#pragma mark - getter

- (UIImageView *)t_imageView {
    
    if (!_t_imageView) {
        _t_imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        _t_imageView.contentMode = UIViewContentModeScaleAspectFit;
        _t_imageView.layer.cornerRadius = 10.f;
        _t_imageView.layer.borderWidth = 1.f;
        _t_imageView.layer.borderColor = _COLOR_HEX(0x8ebdee).CGColor;
    }
    return _t_imageView;
}

- (UILabel *)t_companyLabel {
    
    if (!_t_companyLabel) {
        _t_companyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        _t_companyLabel.textColor = _COLOR_HEX(0x454545);
        _t_companyLabel.backgroundColor = [UIColor clearColor];
        _t_companyLabel.font = [UIFont systemFontOfSize:18];
    }
    return _t_companyLabel;
}

- (UILabel *)t_nameLabel {
    
    if (!_t_nameLabel) {
        _t_nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        _t_nameLabel.numberOfLines = 0;
        _t_nameLabel.backgroundColor = [UIColor clearColor];
        _t_nameLabel.textColor = _COLOR_HEX(0x737171);
        _t_nameLabel.font = [UIFont systemFontOfSize:13];
    }
    return _t_nameLabel;
}

- (UILabel *)t_phoneLabel {
    
    if (!_t_phoneLabel) {
        _t_phoneLabel= [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        _t_phoneLabel.numberOfLines = 0;
        _t_phoneLabel.backgroundColor = [UIColor clearColor];
        _t_phoneLabel.textColor = _COLOR_HEX(0x737171);
        _t_phoneLabel.font = [UIFont systemFontOfSize:13];
    }
    return _t_phoneLabel;
}

- (UILabel *)line {
    
    if (!_line) {
        _line= [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        _line.backgroundColor = _COLOR_HEX(0xd3d3d3);
    }
    return _line;
}

- (UIButton *)topButton {
    
    if (!_topButton) {
        _topButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MainWidth, header_height)];
        [_topButton addTarget:self action:@selector(topAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _topButton;
}


- (void)addTopButtonSubviews {
    
    [_topButton addSubview:self.t_imageView];
    
    [_topButton addSubview:self.t_companyLabel];
    
    [_topButton addSubview:self.t_nameLabel];
    
    [_topButton addSubview:self.t_phoneLabel];
    
    [_topButton addSubview:self.line];
    
    UIImageView *arrow = [[UIImageView alloc]initWithFrame:CGRectMake(MainWidth-37, (_topButton.frame.size.height-30)/2, 30, 30)];
    arrow.image = [UIImage imageNamed:@"arrow_right"];
    arrow.backgroundColor = [UIColor clearColor];
    [_topButton addSubview:arrow];
    
    [self.t_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topButton.mas_left).offset(18);
        make.top.equalTo(_topButton.mas_top).offset(18);
        make.width.equalTo(@0);
        make.width.equalTo(@0);
    }];
    [self.t_companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.t_imageView.mas_right).offset(17);
        make.right.equalTo(_topButton.mas_right).offset(-40);
        make.top.equalTo(_topButton.mas_top).offset(18);
        make.height.equalTo(@20);
    }];
    [self.t_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.t_imageView.mas_right).offset(17);
        make.width.equalTo(@50);
        make.top.equalTo(_topButton.mas_top).offset(43);
    }];
    [self.t_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.t_nameLabel.mas_right).offset(15);
        make.right.equalTo(_topButton.mas_right).offset(-40);
        make.top.equalTo(_topButton.mas_top).offset(43);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topButton.mas_left);
        make.right.equalTo(_topButton.mas_right);
        make.bottom.equalTo(_topButton.mas_bottom).offset(-1);
        make.height.equalTo(@1);
    }];
}
- (void)addCollectionView{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 1, 0);
    flowLayout.itemSize = CGSizeMake(homeb_cellheight-7, homeb_cellheight);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.headerReferenceSize = CGSizeMake(MainWidth, header_height);
    flowLayout.footerReferenceSize = CGSizeMake(MainWidth, footer_height);
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.delegate = (id<UICollectionViewDelegate>)self;
    _collectionView.dataSource = (id<UICollectionViewDataSource>)self;
    _collectionView.showsVerticalScrollIndicator = NO;
    [_collectionView registerClass:[HomeBCollectionViewCell class] forCellWithReuseIdentifier:@"HomeBCollectionViewCell"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeCCollectionViewHeader"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"HomeCCollectionViewFooter"];
    //    _collectionView.autoresizesSubviews = NO;
    [self.view addSubview:_collectionView];
    __weak typeof(self)weakself = self;
    [_collectionView addHeaderWithCallback:^{
        [weakself requestBusinessApplications];
    }];
    
}

- (UIButton *)bottomButton {
    
    if (!_bottomButton) {
        _bottomButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MainWidth, footer_height)];
        [_bottomButton setImage:[UIImage imageNamed:@"banner"] forState:0];
        _bottomButton.contentMode = UIViewContentModeScaleAspectFit;
        [_bottomButton addTarget:self action:@selector(bottomAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomButton;
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

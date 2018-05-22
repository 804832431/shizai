//
//  TagsSelectViewController.m
//  VSProject
//
//  Created by pch_tiger on 16/12/21.
//  Copyright © 2016年 user. All rights reserved.
//

#import "TagsSelectViewController.h"
#import "TagSelectView.h"
#import "TagsDTO.h"
#import "CenterManger.h"
#import "LDCompleteRegisterViewController.h"

@interface TagsSelectViewController () <TagSelectDelegate>
{
    CenterManger *centerManger;
    dispatch_group_t requestGroup;
}

@property (nonatomic, strong) UIView *backgroupView;

@property (nonatomic, strong) UIImageView *backgroupImageView;

@property (nonatomic, strong) UIImageView *headIconImageView;
@property (nonatomic, strong) UILabel *headTitleLabel;
@property (nonatomic, strong) UIImageView *headBottomLineImageView;

@property (nonatomic, strong) TagSelectView *tagsView;

@property (nonatomic, strong) UIButton *nextButton;

@end

@implementation TagsSelectViewController

- (id)init {
    
    self = [super init];
    if (self) {
        self.tagsFrom = TAGS_FROM_MECENTER;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = _COLOR_HEX(0xf3f3f3);
    self.title = @"标签选择";
    
    requestGroup = dispatch_group_create();
    centerManger = [[CenterManger alloc] init];
    
    if (self.tagsFrom == TAGS_FROM_REGISTER) {
        [self recoverRightButton];
    }

    [self.view addSubview:self.backgroupView];
    [self.view addSubview:self.nextButton];
    
    self.tagsType = TAGS_TYPE_INDUSTRY;
    
    [self requestTagsWithType:[NSString stringWithFormat:@"%d", self.tagsType]]; // 行业标签
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)recoverRightButton {
    
    self.navigationItem.rightBarButtonItem = nil;
    [self vs_showRightButton:YES];
    
    [self.vm_rightButton setFrame:_CGR(0, 0, 40, 28)];
    self.vm_rightButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [self.vm_rightButton setTitleColor:_COLOR_HEX(0x000000) forState:UIControlStateNormal];
    [self.vm_rightButton setTitle:@"跳过" forState:UIControlStateNormal];
}

- (void)vs_rightButtonAction:(id)sender
{
    
    if (self.tagsType != TAGS_TYPE_COMPANY) {
        [self skipNextPage];
    }
    else {
        if (self.tagsFrom == TAGS_FROM_REGISTER) {
            LDCompleteRegisterViewController *crc = [[LDCompleteRegisterViewController alloc]init];
            [self.navigationController pushViewController:crc animated:YES];
        } else {
            [self.navigationController popViewControllerAnimated:NO];
        }
    }
}

- (void)requestTagsWithType:(NSString *)type {
    
    dispatch_group_enter(requestGroup);
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:type forKey:@"type"];
    __weak typeof(self)weakself = self;
    [centerManger getTagsList:dic success:^(NSDictionary *responseObj) {
        
        NSMutableArray *tagsList = [NSMutableArray arrayWithArray:[responseObj objectForKey:@"labelList"]];
        NSMutableArray *tagsArray = [NSMutableArray array];
        for (NSInteger index=0; index<tagsList.count; ++index) {
            TagsDTO *tagsDto = [[TagsDTO alloc] initWithDic:[tagsList objectAtIndex:index]];
            [tagsArray addObject:tagsDto];
        }
        
        [weakself.tagsAllArray insertObject:tagsArray atIndex:[type integerValue]];
        dispatch_group_leave(requestGroup);
        [weakself reloadData];
        
    } failure:^(NSError *error) {
        
        dispatch_group_leave(requestGroup);
    }];
}

- (void)tagsMakeWithType:(NSString *)type {
    
    dispatch_group_enter(requestGroup);
    
    NSMutableArray *selTagsId = [NSMutableArray array];
    NSArray *allArray = [self.tagsAllArray objectAtIndex:self.tagsType];
    NSArray *selTagsTitle = [NSArray arrayWithArray:[self.tagsView selectedTags]];
    for (int i=0; i<allArray.count; ++i) {
        TagsDTO *dto = [allArray objectAtIndex:i];
        for (int j=0; j<selTagsTitle.count; j++) {
            if ([dto.tagsName isEqualToString:[selTagsTitle objectAtIndex:j]]) {
                [selTagsId addObject:dto.tagsId];
            }
        }
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:type forKey:@"type"];
    NSString *labelList = [selTagsId componentsJoinedByString:@","];
    [dic setObject:labelList forKey:@"labelIdList"];
    __weak typeof(self)weakself = self;
    [centerManger updateMakeTags:dic success:^(NSDictionary *responseObj) {
        
        if (self.tagsType == TAGS_TYPE_COMPANY) {
//            [weakself.view showTipsView:@"标签选择已完成"];
        }
        dispatch_group_leave(requestGroup);
    } failure:^(NSError *error) {
        
        dispatch_group_leave(requestGroup);
    }];
}

- (void)reloadData {
    
    NSMutableArray *tagsName = [NSMutableArray array];
    NSMutableArray *selTagsName = [NSMutableArray array];
    
    NSArray *tagsArr = [self.tagsAllArray objectAtIndex:self.tagsType];
    for (int i=0; i<tagsArr.count; i++) {
        
        TagsDTO *dto = [tagsArr objectAtIndex:i];
        [tagsName addObject:dto.tagsName];
        
        if ([dto.isMarking isEqualToString:@"Y"]) {
            [selTagsName addObject:dto.tagsName];
        }
    }
    
    self.tagsView.defaultSelctArray = selTagsName;
    [self.tagsView setTags:tagsName];
    self.backgroupView.frame = CGRectMake(9.0f, 7.5f, MainWidth - 9.0f*2, 47.0f+30.0f+[self.tagsView fittedSize].height + 23.0f);
    self.nextButton.frame = CGRectMake((MainWidth - 100.0f)/2, self.backgroupView.frame.origin.y + self.backgroupView.frame.size.height + 88.0f, 100.0f, 40.0f);
    
    [self configView];
}

- (void)configView {
    
    self.headTitleLabel.text = [self.headTitleArray objectAtIndex:TAGS_TYPE_INDUSTRY];
    [self.headTitleLabel sizeToFit];
    CGRect headFrame = self.headTitleLabel.frame;
    CGFloat headWidth = headFrame.size.width + 14.0f + 5.0f;
    self.headIconImageView.frame = CGRectMake((self.backgroupView.frame.size.width - headWidth)/2, (48.0f - 14.0f)/2, 14.0f, 14.0f);
    self.headTitleLabel.frame = CGRectMake(self.headIconImageView.frame.origin.x + GetWidth(self.headIconImageView) + 5.0f, (48.0f - 12.0f)/2, headFrame.size.width, 12.0f);
    
    if (self.tagsType == TAGS_TYPE_INDUSTRY || self.tagsType == TAGS_TYPE_IDENTITY) {
        [self.nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    }
    else {
        [self.nextButton setTitle:@"完成" forState:UIControlStateNormal];
    }
}

- (NSMutableArray<NSArray *> *)tagsAllArray {
    
    if (!_tagsAllArray) {
        _tagsAllArray = [NSMutableArray array];
        
        //NSArray *industryArray = @[@"互联网", @"金融", @"房地产", @"电子商务", @"旅游", @"医疗医药", @"文化创意", @"体育健身", @"影视传媒", @"广告资讯", @"网络营销", @"机关机构", @"快速消费", @"培训", @"贸易"];
        [_tagsAllArray insertObject:[NSMutableArray array]  atIndex:TAGS_TYPE_INDUSTRY];
        
        //NSArray *identityArray = @[@"人事", @"行政", @"市场", @"财务", @"法务", @"销售", @"职业经理人", @"自由职业者", @"公司高管", @"老板", @"创业者", @"投资者"];
        [_tagsAllArray insertObject:[NSMutableArray array]  atIndex:TAGS_TYPE_IDENTITY];
        
        //NSArray *companyArray = @[@"初创期", @"扩张阶段", @"成熟期", @"下滑期", @"未融资", @"已融资", @"已上市", @"新三板"];
        [_tagsAllArray insertObject:[NSMutableArray array]  atIndex:TAGS_TYPE_COMPANY];
    }
    return _tagsAllArray;
}

- (NSArray *)headTitleArray {
    
    if (!_headTitleArray) {
        _headTitleArray = @[@"选择你的行业标签", @"选择和您身份相关的标签", @"选择和您企业相关的标签"];
    }
    return _headTitleArray;
}

- (UIView *)backgroupView {
    
    if (!_backgroupView) {
        _backgroupView = [[UIView alloc] initWithFrame:CGRectMake(9.0f, 7.5f, MainWidth - 9.0f*2, 322.0f)];
        _backgroupView.backgroundColor = [UIColor whiteColor];
        
        _backgroupView.layer.masksToBounds = NO;
        _backgroupView.layer.cornerRadius = 10.0f;
        _backgroupView.layer.shadowOpacity = 0.2; // 阴影透明度
        _backgroupView.layer.shadowColor = _COLOR_HEX(0x282828).CGColor;
        _backgroupView.layer.shadowRadius = 10.0f;
        _backgroupView.layer.shadowOffset  = CGSizeMake(-2, 2);
        
        [_backgroupView addSubview:self.headIconImageView];
        [_backgroupView addSubview:self.headTitleLabel];
        [_backgroupView addSubview:self.headBottomLineImageView];
        [_backgroupView addSubview:self.tagsView];
    }
    return _backgroupView;
}

- (UIImageView *)backgroupImageView {
    
    if (!_backgroupImageView) {
        _backgroupImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MainWidth - 9.0f*2, 322.0f)];
        _backgroupImageView.image = [UIImage imageNamed:@"me_tags_bg"];
        _backgroupImageView.backgroundColor = [UIColor whiteColor];
    }
    return _backgroupImageView;
}

- (UIImageView *)headIconImageView {
    
    if (!_headIconImageView) {
        _headIconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _headIconImageView.image = [UIImage imageNamed:@"me_tagselect_icon"];
    }
    return _headIconImageView;
}

- (UILabel *)headTitleLabel {
    
    if (!_headTitleLabel) {
        _headTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _headTitleLabel.font = [UIFont systemFontOfSize:12.0f];
        _headTitleLabel.textColor = _COLOR_HEX(0x333333);
        _headTitleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _headTitleLabel;
}

- (UIImageView *)headBottomLineImageView {
    
    if (!_headBottomLineImageView) {
        _headBottomLineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 47.5f, MainWidth - 9.5f*2, 0.5f)];
        _headBottomLineImageView.image = [UIImage imageNamed:@"me_tags_line"];
        _headBottomLineImageView.backgroundColor = [UIColor blackColor];
    }
    return _headBottomLineImageView;
}

- (TagSelectView *)tagsView {
    
    if (!_tagsView) {
        _tagsView = [[TagSelectView alloc] initWithFrame:CGRectMake(9.0f, 48.0f + 30.0f, MainWidth - 10.0f*2, 322.0f - 48.0f)];
    }
    return _tagsView;
}

- (UIButton *)nextButton {
    
    if (!_nextButton) {
        _nextButton = [[UIButton alloc] initWithFrame:CGRectMake((MainWidth - 100.0f)/2, MainHeight - 140.0f - 40.0f, 100.0f, 40.0f)];
        _nextButton.titleLabel.font = [UIFont systemFontOfSize:18.0f];
        _nextButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_nextButton setTitleColor:_COLOR_HEX(0x080808) forState:UIControlStateNormal];
        _nextButton.layer.cornerRadius = 10.0f;
        _nextButton.layer.borderColor = _COLOR_HEX(0xa0a0a0).CGColor;
        _nextButton.layer.masksToBounds = YES;
        _nextButton.layer.borderWidth = 0.5f;
        [_nextButton addTarget:self action:@selector(nextClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}

- (void)nextClicked:(UIButton *)button {
    
    if ([[self.tagsView selectedTags] count] <= 0) {
        [self.view showTipsView:@"您还没选择标签"];
        return;
    }
    
    // 上传选中标签
    [self tagsMakeWithType:[NSString stringWithFormat:@"%d", self.tagsType]];
    
    [self skipNextPage];
    
    [self requestTagsWithType:[NSString stringWithFormat:@"%d", self.tagsType]];
}

- (void)skipNextPage {
    
    switch (self.tagsType) {
        case TAGS_TYPE_INDUSTRY: // 行业标签
            self.tagsType = TAGS_TYPE_IDENTITY;
            break;
        case TAGS_TYPE_IDENTITY: // 身份标签
            self.tagsType = TAGS_TYPE_COMPANY;
            break;
        case TAGS_TYPE_COMPANY: // 企业标签
            // 已完成
            if (self.tagsFrom == TAGS_FROM_REGISTER) {
                LDCompleteRegisterViewController *crc = [[LDCompleteRegisterViewController alloc]init];
                [self.navigationController pushViewController:crc animated:YES];
            } else {
                [self.navigationController popViewControllerAnimated:NO];
            }
            break;
            
        default:
            break;
    }
    
    [self requestTagsWithType:[NSString stringWithFormat:@"%d", self.tagsType]];
}

- (void)vs_back {
    
    [self tagsMakeWithType:[NSString stringWithFormat:@"%d", self.tagsType]];
    switch (self.tagsType) {
        case TAGS_TYPE_INDUSTRY: // 行业标签
            [super vs_back];
            break;
        case TAGS_TYPE_IDENTITY: // 身份标签
            self.tagsType = TAGS_TYPE_INDUSTRY;
            break;
        case TAGS_TYPE_COMPANY: // 企业标签
            self.tagsType = TAGS_TYPE_IDENTITY;
            break;
            
        default:
            break;
    }
    
    [self requestTagsWithType:[NSString stringWithFormat:@"%d", self.tagsType]];
}

- (void)TagSelectBtnClicked:(UIButton *)sender btnTagList:(TagSelectView *)tagSelectView index:(NSInteger) index {
    
}

@end

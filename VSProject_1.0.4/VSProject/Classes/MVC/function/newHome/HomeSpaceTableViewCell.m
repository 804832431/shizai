//
//  HomeSpaceTableViewCell.m
//  VSProject
//
//  Created by apple on 12/28/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "HomeSpaceTableViewCell.h"

#define RatioForH_W 440/750

@interface HomeSpaceTableViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *space1Button;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height1;
@property (weak, nonatomic) IBOutlet UIButton *space2Button;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height2;
@property (weak, nonatomic) IBOutlet UIButton *space3Button;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height3;
@property (weak, nonatomic) IBOutlet UIButton *space4Button;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width4;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height4;

@property (weak, nonatomic) IBOutlet UIButton *gray1Button;
@property (weak, nonatomic) IBOutlet UIButton *gray2Button;
@property (weak, nonatomic) IBOutlet UIButton *gray3Button;
@property (weak, nonatomic) IBOutlet UIButton *gray4Button;

@property (nonatomic, strong) NSMutableArray *spaceList;

@property (nonatomic, strong) UIImageView *leaseImageView;

@end

@implementation HomeSpaceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSMutableArray *)spaceList {
    
    if (!_spaceList) {
        
        _spaceList = [NSMutableArray array];
    }
    return _spaceList;
}

- (void)setDataSource:(NSArray *)spaceList {
    [self updateConstraints];
    
    for (SpaceModel *spaceModel in spaceList) {
        if (![spaceModel.classId isEqualToString:@"spaceLease"]) {
            [self.spaceList addObject:spaceModel];
        }
    }
    
    for (NSInteger i = 0; i < self.spaceList.count; i++) {
        SpaceModel *model = [self.spaceList objectAtIndex:i];
        
        switch (i) {
            case 0:
            {
                self.width1.constant = (__SCREEN_WIDTH__- 24 -6)/2;
                self.height1.constant = ((__SCREEN_WIDTH__- 24 -6)/2) * (202.0 / 340.0);
                
                [self.space1Button setHidden:NO];
                [self.space1Button.layer setCornerRadius:5.0];
                [self.space1Button setClipsToBounds:YES];
                [self.space1Button sd_setBackgroundImageWithURL:[NSURL URLWithString:model.image] forState:UIControlStateNormal];
                [self.space1Button sd_setBackgroundImageWithURL:[NSURL URLWithString:model.image] forState:UIControlStateHighlighted];
                
                [self.gray1Button setHidden:NO];
                [self.gray1Button setTitle:model.name forState:UIControlStateNormal];
                [self.gray1Button setTitle:model.name forState:UIControlStateHighlighted];
                [self.gray1Button.layer setCornerRadius:5.0];
                [self.gray1Button setClipsToBounds:YES];
                [self.gray1Button setTag:i];
                [self.gray1Button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
                
                if ([model.classId isEqualToString:@"spaceLeaseNew"]) {
                    [self.leaseImageView removeFromSuperview];
                    [self.gray1Button addSubview:self.leaseImageView];
                }
            }
                break;
            case 1:
            {
                self.width2.constant = (__SCREEN_WIDTH__- 24 -6)/2;
                self.height2.constant = ((__SCREEN_WIDTH__- 24 -6)/2) * (202.0 / 340.0);
                
                [self.space2Button setHidden:NO];
                [self.space2Button.layer setCornerRadius:5.0];
                [self.space2Button setClipsToBounds:YES];
                [self.space2Button sd_setBackgroundImageWithURL:[NSURL URLWithString:model.image] forState:UIControlStateNormal];
                [self.space2Button sd_setBackgroundImageWithURL:[NSURL URLWithString:model.image] forState:UIControlStateHighlighted];
                
                [self.gray2Button setHidden:NO];
                [self.gray2Button setTitle:model.name forState:UIControlStateNormal];
                [self.gray2Button setTitle:model.name forState:UIControlStateHighlighted];
                [self.gray2Button.layer setCornerRadius:5.0];
                [self.gray2Button setClipsToBounds:YES];
                [self.gray2Button setTag:i];
                [self.gray2Button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
                
                if ([model.classId isEqualToString:@"spaceLeaseNew"]) {
                    [self.leaseImageView removeFromSuperview];
                    [self.gray2Button addSubview:self.leaseImageView];
                }
            }
                break;
            case 2:
            {
                self.width3.constant = (__SCREEN_WIDTH__- 24 -6)/2;
                self.height3.constant = ((__SCREEN_WIDTH__- 24 -6)/2) * (202.0 / 340.0);
                
                [self.space3Button setHidden:NO];
                [self.space3Button.layer setCornerRadius:5.0];
                [self.space3Button setClipsToBounds:YES];
                [self.space3Button sd_setBackgroundImageWithURL:[NSURL URLWithString:model.image] forState:UIControlStateHighlighted];
                [self.space3Button sd_setBackgroundImageWithURL:[NSURL URLWithString:model.image] forState:UIControlStateNormal];
                
                [self.gray3Button setHidden:NO];
                [self.gray3Button setTitle:model.name forState:UIControlStateNormal];
                [self.gray3Button setTitle:model.name forState:UIControlStateHighlighted];
                [self.gray3Button.layer setCornerRadius:5.0];
                [self.gray3Button setClipsToBounds:YES];
                [self.gray3Button setTag:i];
                [self.gray3Button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
                
                if ([model.classId isEqualToString:@"spaceLeaseNew"]) {
                    [self.leaseImageView removeFromSuperview];
                    [self.gray3Button addSubview:self.leaseImageView];
                }
            }
                break;
            case 3:
            {
                self.width4.constant = (__SCREEN_WIDTH__- 24 - 6)/2;
                self.height4.constant = ((__SCREEN_WIDTH__- 24 -6)/2) * (202.0 / 340.0);
                
                [self.space4Button setHidden:NO];
                [self.space4Button.layer setCornerRadius:5.0];
                [self.space4Button setClipsToBounds:YES];
                [self.space4Button sd_setBackgroundImageWithURL:[NSURL URLWithString:model.image] forState:UIControlStateHighlighted];
                [self.space4Button sd_setBackgroundImageWithURL:[NSURL URLWithString:model.image] forState:UIControlStateNormal];
                
                [self.gray4Button setHidden:NO];
                [self.gray4Button setTitle:model.name forState:UIControlStateNormal];
                [self.gray4Button setTitle:model.name forState:UIControlStateHighlighted];
                [self.gray4Button.layer setCornerRadius:5.0];
                [self.gray4Button setClipsToBounds:YES];
                [self.gray4Button setTag:i];
                [self.gray4Button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
                
                if ([model.classId isEqualToString:@"spaceLeaseNew"]) {
                    [self.leaseImageView removeFromSuperview];
                    [self.gray4Button addSubview:self.leaseImageView];
                }
            }
                break;
                
            default:
                break;
        }
    }
}

- (void)clickAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSInteger tag = button.tag;
    SpaceModel *spaceModel = [self.spaceList objectAtIndex:tag];
    [VSPageRoute routeToTarget:spaceModel];
}

- (UIImageView *)leaseImageView {
    
    if (!_leaseImageView) {
        
        _leaseImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Get750Width(94.0f), Get750Width(96.0f))];
        _leaseImageView.image = [UIImage imageNamed:@"home_lease_flag"];
    }
    return _leaseImageView;
}

@end

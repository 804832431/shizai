//
//  ProjectTableViewCell.m
//  VSProject
//
//  Created by 陈 海涛 on 16/9/1.
//  Copyright © 2016年 user. All rights reserved.
//

#import "ProjectTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation ProjectTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSeparatorStyleNone;
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.data) {
        self.contentTitleLabel.text = [NSString stringWithFormat:@"为您推荐%li : %@",self.indexPath.row+1,self.data.projectName];
        [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:self.data.picture ] placeholderImage:[UIImage imageNamed:@"usercenter_defaultpic"]];
        self.projectNameLabel.text = self.data.city;
        self.distanceLabel.text = [NSString stringWithFormat:@"%.2fkm",self.data.distance.integerValue/1000.0];
    }
    
    
    
}


- (void)setData:(Project *)data {
    _data = data;
    
    [self setNeedsLayout];
}

@end

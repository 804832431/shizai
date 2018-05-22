//
//  CenterCell.m
//  VSProject
//
//  Created by certus on 15/11/2.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CenterCell.h"

@implementation CenterCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier cellType:(CenterCellType)cellType{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = _COLOR_HEX(0xf1f1f1);
        _celltype = cellType;
        //top
        _topButton = [[TopButton alloc]initWithFrame:CGRectMake(0, 40/3, MainWidth, 144/3)];
        [self addSubview:_topButton];

        switch (cellType) {
            case 0: {
                //button
                float buttonWidth = MainWidth/4;
                
                _button1 = [[CenterButton alloc]initWithFrame:CGRectMake(0, OffSetY(_topButton), buttonWidth, 186/3)];
                [self addSubview:_button1];
                _button2 = [[CenterButton alloc]initWithFrame:CGRectMake(buttonWidth, OffSetY(_topButton), buttonWidth, 186/3)];
                [self addSubview:_button2];
                _button3 = [[CenterButton alloc]initWithFrame:CGRectMake(buttonWidth*2, OffSetY(_topButton), buttonWidth, 186/3)];
                [self addSubview:_button3];
                _button4 = [[CenterButton alloc]initWithFrame:CGRectMake(buttonWidth*3, OffSetY(_topButton), buttonWidth, 186/4)];
                [self addSubview:_button4];

                //line
                UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, (40+144+186)/3-1, MainWidth, 1)];
                line.backgroundColor = _COLOR_HEX(0xdfdfdf);
                [self addSubview:line];

            }
                break;
                
            case 2: {
                //button
                float buttonWidth = MainWidth/4;
                
                _button1 = [[CenterButton alloc]initWithFrame:CGRectMake(0, OffSetY(_topButton), buttonWidth, 186/3)];
                [self addSubview:_button1];
//                _button2 = [[CenterButton alloc]initWithFrame:CGRectMake(buttonWidth, OffSetY(_topButton), buttonWidth, 186/3)];
//                [self addSubview:_button2];
                [_button1.superscriptLabel setHidden:YES];

                //line
                UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, (40+144+186)/3-1, MainWidth, 1)];
                line.backgroundColor = _COLOR_HEX(0xdfdfdf);
                [self addSubview:line];

            }
                break;
                
            default: {
//                _bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(50/3+8, OffSetY(_topButton), MainWidth, 180/3)];
//                _bottomLabel.backgroundColor = [UIColor clearColor];
//                _bottomLabel.textAlignment =NSTextAlignmentLeft;
//                _bottomLabel.textColor = _COLOR_HEX(0x666666);
//                _bottomLabel.font = FONT_TITLE(16);
//                [self addSubview:_bottomLabel];

            }
                break;
        }


    }
    
    return self;
    
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    switch (_celltype) {
        case 0: {
            //button

            _button1.buttonImageView.image = [UIImage imageNamed:[_picArray objectAtIndex:0]];
            _button1.buttonLabel.text = [_nameArray objectAtIndex:0];
            NSString *angle1 = [_superscriptArray objectAtIndex:0];
            [_button1.superscriptLabel setHidden:(angle1.intValue == 0)];
            _button1.superscriptLabel.text = angle1;

            _button2.buttonImageView.image = [UIImage imageNamed:[_picArray objectAtIndex:1]];
            _button2.buttonLabel.text = [_nameArray objectAtIndex:1];
            NSString *angle2 = [_superscriptArray objectAtIndex:1];
            [_button2.superscriptLabel setHidden:(angle2.intValue == 0)];
            _button2.superscriptLabel.text = angle2;

            _button3.buttonImageView.image = [UIImage imageNamed:[_picArray objectAtIndex:2]];
            _button3.buttonLabel.text = [_nameArray objectAtIndex:2];
            NSString *angle3 = [_superscriptArray objectAtIndex:2];
            [_button3.superscriptLabel setHidden:(angle3.intValue == 0)];
            _button3.superscriptLabel.text = angle3;

            _button4.buttonImageView.image = [UIImage imageNamed:[_picArray objectAtIndex:3]];
            _button4.buttonLabel.text = [_nameArray objectAtIndex:3];
            NSString *angle4 = [_superscriptArray objectAtIndex:3];
            [_button4.superscriptLabel setHidden:(angle4.intValue == 0)];
            _button4.superscriptLabel.text = angle4;
        }
            break;
            
        case 2: {
            //button
            _button1.countLabel.text = [_picArray objectAtIndex:0];
            _button1.buttonLabel.text = [_nameArray objectAtIndex:0];
//            _button2.countLabel.text = [_picArray objectAtIndex:1];
//            _button2.buttonLabel.text = [_nameArray objectAtIndex:1];
            
        }
            break;
            
        default: {
//            _bottomLabel.text = [_nameArray objectAtIndex:0];
        }
            break;
    }

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

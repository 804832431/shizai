//
//  VSTabbarView.m
//  VSProject
//
//  Created by bestjoy on 15/1/26.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSTabbarView.h"

@implementation VSTabbarView
- (instancetype)initWithText:(NSString*)text andImage:(UIImage*)image withBlock:(VSTabbarViewBlock)block
{
    self = [super init];
    if (self)
    {
        self.backgroundColor=[UIColor whiteColor];
        self.icon=_ALLOC_OBJ_(VSImageView);
        self.textlbl=_ALLOC_OBJ_(VSLabel);
        [self addSubview:self.icon];
        [self addSubview:self.textlbl];
        self.icon.image=image;
        [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@0);
            make.top.equalTo(@4);
            make.width.equalTo(@22);
            make.height.equalTo(@22);
        }];
        [self.textlbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@0);
            make.top.equalTo(self.icon.mas_bottom).offset(4);
            make.width.equalTo(self.mas_width);
            make.height.equalTo(@15);
        }];
        _SETLABEL_STYLE(self.textlbl, 10, _Colorhex(0x6c6c6c), text);
        self.textlbl.textAlignment=NSTextAlignmentCenter;
        VSView *tapView=_ALLOC_OBJ_WITHFRAME_(VSView, self.bounds);
        [self addSubview:tapView];
        [tapView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [tapView addGestureRecognizer:tap];
        self.block=block;
    }
    return self;
}
-(void)tap
{
    if ([_delegate respondsToSelector:@selector(vs_TabbarSelect:)])
    {
        [_delegate performSelector:@selector(vs_TabbarSelect:) withObject:self];
    }
    if (self.block) {
        self.block();
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

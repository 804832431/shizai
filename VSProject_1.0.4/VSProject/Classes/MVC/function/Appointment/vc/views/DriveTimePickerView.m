//
//  DriveTimePickerView.m
//  Modify by Thomas on 15-12-03.
//

#import "DriveTimePickerView.h"

@interface DriveTimePickerView ()
{
    UIPickerView *m_timePicker;
    UIView *m_upBgView;
    UIButton *m_cancelBtn;
    UIButton *m_selectBtn;
}

@end

@implementation DriveTimePickerView
@synthesize m_timePicker,m_delegate;

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        m_upBgView = [[UIView alloc] init];
        m_upBgView.backgroundColor = kColor_e4e4e4;
        m_upBgView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:m_upBgView];
        
        m_cancelBtn = [[UIButton alloc] init];
        m_cancelBtn.backgroundColor = _COLOR_CLEAR;
        m_cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [m_cancelBtn setTitleColor:_COLOR_BLACK forState:UIControlStateNormal];
        [m_cancelBtn setTitle:NSLocalizedString(@"取消", nil) forState:UIControlStateNormal];
        [m_cancelBtn addTarget:self action:@selector(cancelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        m_cancelBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [m_upBgView addSubview:m_cancelBtn];
        
        m_selectBtn = [[UIButton alloc] init];
        m_selectBtn.backgroundColor = _COLOR_CLEAR;
        m_selectBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [m_selectBtn setTitleColor:_COLOR_BLACK forState:UIControlStateNormal];
        [m_selectBtn setTitle:NSLocalizedString(@"确定", nil) forState:UIControlStateNormal];
        [m_selectBtn addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        m_selectBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [m_upBgView addSubview:m_selectBtn];
        
        self.m_timePicker = [[UIPickerView alloc] init];
        m_timePicker.backgroundColor = kColor_f2f2f2;
        m_timePicker.showsSelectionIndicator = YES;
        m_timePicker.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:m_timePicker];
        
        [self setSubviewsConstraints];
    }
    return self;
}

- (void)setSubviewsConstraints{
    NSDictionary *viewsDic = NSDictionaryOfVariableBindings(m_timePicker,m_upBgView,m_cancelBtn,m_selectBtn);
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[m_upBgView]|" options:0 metrics:nil views:viewsDic]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[m_timePicker]|" options:0 metrics:nil views:viewsDic]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[m_upBgView][m_timePicker]|" options:0 metrics:nil views:viewsDic]];
    [m_upBgView addConstraint:[NSLayoutConstraint constraintWithItem:m_upBgView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:35.f]];
    
    [m_upBgView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[m_cancelBtn]" options:0 metrics:nil views:viewsDic]];
    [m_upBgView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[m_selectBtn]-10-|" options:0 metrics:nil views:viewsDic]];
    [m_upBgView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[m_cancelBtn]-5-|" options:0 metrics:nil views:viewsDic]];
    [m_upBgView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[m_selectBtn]-5-|" options:0 metrics:nil views:viewsDic]];
    [m_cancelBtn addConstraint:[NSLayoutConstraint constraintWithItem:m_cancelBtn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:50.f]];
    [m_selectBtn addConstraint:[NSLayoutConstraint constraintWithItem:m_selectBtn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:50.f]];
}

- (void)cancelBtnAction:(UIButton *)sender{
    if (m_delegate && [m_delegate respondsToSelector:@selector(cancelTimeChoose)]) {
        [m_delegate cancelTimeChoose];
    }
}

- (void)selectBtnAction:(UIButton *)sender{
    if (m_delegate && [m_delegate respondsToSelector:@selector(selectTime)]) {
        [m_delegate selectTime];
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

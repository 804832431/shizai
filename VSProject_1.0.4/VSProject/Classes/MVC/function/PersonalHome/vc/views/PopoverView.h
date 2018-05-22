/*********************************************************************
 文件名称 : PopoverView.h
 作   者 : 
 创建时间 : 2013-10-31
 文件描述 : 本地弹框界面
 *********************************************************************/

#import <UIKit/UIKit.h>

//@protocol PopoverViewDelegate <NSObject>
//
//- (void)selectRowAtIndex:(NSInteger)index;
//
//@end

#define kArrowHeight 10.f
#define kArrowCurvature 6.f
#define SPACE 2.f
#define ROW_HEIGHT 40.f
#define TITLE_FONT [UIFont systemFontOfSize:15]
#define RGB(r, g, b)    [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]
#define kColor_a4_000000       ColorWithHex(0x000000, 0.8)

@interface PopoverView : UIView

//@property (nonatomic, assign) id <PopoverViewDelegate>m_delegate;
@property (nonatomic, strong) NSArray *titleArray;

-(id)initWithPoint:(CGPoint)point titles:(NSArray *)titles images:(NSArray *)images;
-(void)show;
-(void)dismiss;
-(void)dismiss:(BOOL)animate;

@property (nonatomic, copy) UIColor *borderColor;
@property (nonatomic, copy) void (^selectRowAtIndex)(NSInteger index);

@end

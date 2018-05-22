//
//  WorkTableView.h
//  jmportal_iphone_grid
//
//  Created by Jerry on 14-5-13.
//
//

#import <UIKit/UIKit.h>
@protocol WorkTableViewDelegate <NSObject>
- (void)tableView:(UIView *)view WithSelectedObj:(id)obj;
@end

@interface WorkTableView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *workTableView;
    UIButton *bottomButton;
}
@property (nonatomic, assign) NSUInteger showNumbers;    //显示行数
@property (nonatomic, assign) float cellHeight;   //行高
@property (nonatomic, retain) NSArray *dataArray;
@property (nonatomic, assign) id<WorkTableViewDelegate> delegate;
@property (nonatomic, retain)UITableView *workTableView;


- (id)initFrame:(CGRect)frame;

- (void)showInView:(UIView *)view;
- (void)show;
- (void)close;
@end

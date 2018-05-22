//
//  WorkTableView.m
//  jmportal_iphone_grid
//
//  Created by Jerry on 14-5-13.
//
//

#import "WorkTableView.h"

@implementation WorkTableView
@synthesize workTableView;
- (id)initFrame:(CGRect)frame;
{
    self = [super init];
    if (self) {
        bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        bottomButton.backgroundColor = [UIColor clearColor];
        [bottomButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bottomButton];

        workTableView = [[UITableView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 0)];
        workTableView.layer.borderColor = [UIColor colorWithRed:205/255.f green:205/255.f blue:205/255.f alpha:1].CGColor;
        workTableView.backgroundColor = [UIColor whiteColor];
        workTableView.layer.borderWidth = 0.5f;
        workTableView.bounces = NO;
        [workTableView.layer setCornerRadius:5.f];
        workTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        workTableView.showsVerticalScrollIndicator = NO;
        workTableView.dataSource = self;
        workTableView.delegate = self;
        [self addSubview:workTableView];
            
        self.hidden = YES;
    }
    return self;
}


- (void)showInView:(UIView *)view
{
    if (!self.cellHeight) {
        self.cellHeight = 30.f;
    }
    if (!self.showNumbers) {
        self.showNumbers = 10;
    }
    if ([self.dataArray count] < self.showNumbers) {
        self.showNumbers = [self.dataArray count];
    }
    
    self.frame = view.bounds;
    bottomButton.frame = view.bounds;
    [view addSubview:self];
}
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        
        UIView *lines = [[UIView alloc] initWithFrame:CGRectMake(0, self.cellHeight-0.5, workTableView.frame.size.width, 0.5f)];
        lines.backgroundColor = [UIColor colorWithRed:205/255.f green:205/255.f blue:205/255.f alpha:1];
        [cell.contentView addSubview:lines];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:15.];;
    cell.textLabel.textColor = _COLOR_HEX(0x999999);
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
    if ([dic isKindOfClass:[NSDictionary class]]) {
        cell.textLabel.text = [dic objectForKey:@"name"];
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(tableView:WithSelectedObj:)]) {
        [self.delegate tableView:self WithSelectedObj:dic];
    }
    [self close];
}

- (void)show{
    self.hidden = NO;
    [UIView animateWithDuration:0.1 animations:^(void){
        workTableView.frame = CGRectMake(workTableView.frame.origin.x, workTableView.frame.origin.y, workTableView.frame.size.width, self.cellHeight * self.showNumbers);
    }];

}
- (void)close{
    [UIView animateWithDuration:0.1f animations:^(void){
        workTableView.frame = CGRectMake(workTableView.frame.origin.x, workTableView.frame.origin.y, workTableView.frame.size.width, 0);
    }completion:^(BOOL finished){
        self.hidden = YES;
    }];
}

@end

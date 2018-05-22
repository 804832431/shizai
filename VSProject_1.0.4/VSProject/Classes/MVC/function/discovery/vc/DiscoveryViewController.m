//
//  DiscoveryViewController.m
//  VSProject
//
//  Created by certus on 16/3/7.
//  Copyright © 2016年 user. All rights reserved.
//

#import "DiscoveryViewController.h"
#import "DiscoveryCell.h"
#import "RTXShakeViewController.h"

@interface DiscoveryViewController ()

@end

@implementation DiscoveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    [self vs_setTitleText:@"发现"];
    
    _datalist = @[
                  @{@"imageName":@"yaoyiyao",@"title":@"摇一摇",@"subtitle":@"摇出特惠精选商品"}];
    [self.view addSubview:self.tableView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case DISCOVERY_AROUNND: {
        
            
        }
            break;
            
        case DISCOVERY_SHARK: {
            
            RTXShakeViewController *shakevc = [[RTXShakeViewController alloc] init];
            [self.navigationController pushViewController:shakevc animated:YES];
        }
            break;

        default:
            break;
    }
}

#pragma mark -- UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _datalist.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 65;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    DiscoveryCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"DiscoveryCell" owner:nil options:nil] lastObject];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSDictionary *dic = _datalist[indexPath.row];
    cell.d_imageView.image = [UIImage imageNamed:[dic objectForKey:@"imageName"]];
    cell.d_titleLabel.text = [dic objectForKey:@"title"];
    cell.d_subLabel.text = [dic objectForKey:@"subtitle"];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

_GETTER_ALLOC_BEGIN(UITableView, tableView) {
    
    _tableView.frame = CGRectMake(0, 0, GetWidth(self.view), GetHeight(self.view));
    _tableView.backgroundColor = _COLOR_HEX(0xf1f1f1);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = (id<UITableViewDelegate>)self;
    _tableView.dataSource = (id<UITableViewDataSource>)self;
}
_GETTER_END(tableView)

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

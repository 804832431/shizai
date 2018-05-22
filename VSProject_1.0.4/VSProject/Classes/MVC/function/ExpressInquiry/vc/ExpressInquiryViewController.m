//
//  ExpressInquiryViewController.m
//  VSProject
//
//  Created by certus on 15/12/1.
//  Copyright © 2015年 user. All rights reserved.
//

#import "ExpressInquiryViewController.h"
#import "ExpressCell.h"

@interface ExpressInquiryViewController ()

@end

@implementation ExpressInquiryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self rejustViews];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rejustViews {

    [self vs_setTitleText:@"快递查询"];
    
    _leftButton.layer.cornerRadius = 5.;
    _leftButton.layer.borderWidth = 1.f;
    _leftButton.layer.borderColor = _Colorhex(0x35b38d).CGColor;
    _rightButton.layer.cornerRadius = 5.;
    _rightButton.layer.borderWidth = 1.f;
    _rightButton.layer.borderColor = _Colorhex(0x35b38d).CGColor;
    _baseLabel.layer.cornerRadius = 5.;
    _baseLabel.layer.borderWidth = 1.f;
    _baseLabel.layer.borderColor = _Colorhex(0xdbdbdb).CGColor;
}


#pragma mark -- UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSDictionary *dic = [_datalist objectAtIndex:indexPath.row];
//    NSString *adress = [dic objectForKey:@"address"];
//    
//    CGRect adressRect = [adress boundingRectWithSize:CGSizeMake(MainWidth-34, 200) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]} context:nil];
    CGFloat height = 1;//adressRect.size.height;
    
    return 150 + height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    ExpressCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ExpressCell" owner:nil options:nil] lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.titleLabel.text = @"公司业务模式的更改也导致冲突加剧。以美团为例，该公司现正在考虑进入影片发行领域，这样就将与阿里巴巴的阿里影业竞争。这导致阿里巴巴高管对投资人说，他们认为美团创始人王兴是“忘恩负义”。在中国，每10张电影票里有4张是通过美团售出的。";
    cell.subLabel.text = @"2015-08-28 20:09";
    cell.imageView.backgroundColor = _Colorhex(0x23b28d);
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

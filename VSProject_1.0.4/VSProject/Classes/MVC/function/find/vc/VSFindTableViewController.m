//
//  VSFindTableViewController.m
//  VSProject
//
//  Created by tiezhang on 15/2/26.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSFindTableViewController.h"
#import "UINavigationController+FindPush.h"
#import "VSFindItemTableViewCell.h"
#import "VSSpaceCell.h"
#import "VSFindItemData.h"

typedef enum _FIND_TYPE
{
    FIND_TYPE_SUCCESSCASE = 0,
    FIND_TYPE_JOB,
    FIND_TYPE_MEMBER,
    FIND_TYPE_ENJOY,
}FIND_TYPE;

@interface VSFindTableViewController ()


@end

@implementation VSFindTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self vs_setTitleText:@"发现"];
    
    VSView *headView = _ALLOC_OBJ_WITHFRAME_(VSView, _CGR(0, 0, GetWidth(self.tableView), 20));
    self.tableView.tableHeaderView = headView;
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    [self vs_setExtraCellLineHidden];
    
    VSFindItemData *item0 = [[VSFindItemData alloc]initWithIconName:@"icon0" title:@"导师在这,你在哪" desc:@"导师，职场大牛在这，你在哪..."];
    VSFindItemData *item1 = [[VSFindItemData alloc]initWithIconName:@"icon0" title:@"招聘/宣讲会" desc:@"职业人生从这开始..."];
    
    VSFindItemData *item2 = [[VSFindItemData alloc]initWithIconName:@"icon0" title:@"成功案例" desc:@"他已经成功走上职场，你还在犹豫吗..."];
    VSFindItemData *item3 = [[VSFindItemData alloc]initWithIconName:@"icon0" title:@"新注册会员" desc:@"她，他进来了，来看看吧..."];
    VSFindItemData *item4 = [[VSFindItemData alloc]initWithIconName:@"icon0" title:@"娱乐空间" desc:@"施工中,敬请期待..."];

    self.dataSource = @[@[item0, item1], @[@""], @[item2, item3], @[@""], @[item4]];
}

#pragma mark -- TableViewControllerProtocol
- (NSArray*)vp_mutCellClasses
{
    return self.cellNameClasses;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger sectionIndex = indexPath.section;
    
    NSInteger rowIndex = indexPath.row;
    if(sectionIndex == 0)
    {
        if(rowIndex == 0)
        {//to 导师
            [self.navigationController vs_pushToTeacherVC];
        }
        else
        {//to 宣讲会
            [self.navigationController vs_pushToJobVC];
        }
    }
    else if (sectionIndex == 1)
    {//space
        
    }
    else if (sectionIndex == 2)
    {
        if(rowIndex == 0)
        {//to 成功案例
            [self.navigationController vs_pushToSuccessCaseVC];
        }
        else
        {//to 会员
            [self.navigationController vs_pushToNewMemberVC];
        }
        
    }
    else if (sectionIndex == 3)
    {//space
        
    }
    else if(sectionIndex == 4)
    {
        //to 娱乐
        [self.navigationController vs_pushToEnjoyVC];
    }
    else
    {
         //TODO:NONE
    }
}

#pragma mark -- getter
_GETTER_BEGIN(NSArray, cellNameClasses)
{
    _cellNameClasses = @[
                        [VSFindItemTableViewCell class],
                        [VSSpaceCell class],
                        [VSFindItemTableViewCell class],
                        [VSSpaceCell class],
                        [VSFindItemTableViewCell class]
                            ];
}
_GETTER_END(cellNameClasses)

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

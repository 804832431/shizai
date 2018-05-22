//
//  VSChatMsgListViewController.m
//  VSProject
//
//  Created by tiezhang on 15/3/2.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSChatMsgListViewController.h"
#import "VSMsgChatManager.h"
#import "VSChatMsgData.h"
#import "VSInputBar.h"
#import "VSChatingCell.h"

#define InputViewHeight          46

@interface VSChatMsgListViewController ()<VSInputBarDelegate, VSChatingCellDelegate>

_PROPERTY_NONATOMIC_STRONG(VSInputBar, inputBar);

_PROPERTY_NONATOMIC_STRONG(NSMutableArray, vm_msgArrs);

@end

@implementation VSChatMsgListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self vs_setTitleText:@"聊天"];
    
    self.dataSource = @[self.vm_msgArrs];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.bottom.equalTo(@(-InputViewHeight));
        make.left.equalTo(@0);
        make.right.equalTo(@(0));
    }];
    
    _inputBar = [[VSInputBar alloc] init];
    _inputBar.delegate = self;
    [self.view addSubview:_inputBar];
    [_inputBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(0));
        make.left.equalTo(@0);
        make.bottom.equalTo(@(0));
        make.height.equalTo(@(InputViewHeight));
    }];
    
    [self vs_addTapGuesture];
    
    [[VSMsgChatManager shareInstance] vs_loadLoadMsgForSourceUID:@"123" desUID:@"456" callBack:^(BOOL sqlFlag, NSArray *resultData) {
       
        if(resultData)
        {
            [self.vm_msgArrs addObjectsFromArray:resultData];        //先添加到数组，
            
            [self vs_reloadData];
        }
    }];
    
}

#pragma mark -- InputBarDelegate
- (void)vp_sendMessageClicked
{
    [self vs_sendMsgRequest];
}

#pragma mark -- 
- (void)vp_rendMsgChatingCell:(VSChatingCell *)sender
{
    [self vs_sendMsgRequest];
}

- (void)vs_sendMsgRequest
{
    VSChatMsgData *chatModel    = [[VSChatMsgData alloc] init];
    chatModel.vm_sourceUID      = @"123";//[VSUserLogicManager shareInstance].userDataInfo.vm_memberData.vm_userID;
    chatModel.vm_sourceName     = @"xiao";
    chatModel.vm_desUID         = @"456";
    chatModel.vm_desName        = @"小绵羊";
    chatModel.vm_msgContent     = self.inputBar.inputTextView.text;
    chatModel.vm_msgTime        = [NSDate localTimeIntervalInAccurateMSEL];
//    chatModel.sendStatus = MsgIsSending;
//    chatModel.readStatus = MsgHaveReaded;
//    chatModel.isMine     = YES;
    
    BOOL successFlag = YES;
    if(successFlag)
    {
        [self.vm_msgArrs addObject:chatModel];        //先添加到数组，
    
        [[VSMsgChatManager shareInstance] vs_msgSaveToLocal:@[chatModel]];
        
        [self vs_reloadData];
    }
}

#pragma mark - 键盘通知
//键盘弹出
- (void)vp_wyInputKeyBoardWasShown:(CGFloat)keyboardHeight
{
    if ([self getAllCellHeightSum]<(MainHeight-64-InputViewHeight-keyboardHeight))
    {
        [UIView animateWithDuration:0.25 animations:^{
            [_inputBar mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(@(0));
                make.left.equalTo(@0);
                make.bottom.equalTo(@(-keyboardHeight));
                make.height.equalTo(@(InputViewHeight));
            }];
        }];
    }
    else
    {
        [UIView animateWithDuration:0.25 animations:^{
            [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@(-keyboardHeight));
                make.bottom.equalTo(@(-InputViewHeight-keyboardHeight));
                make.left.equalTo(@0);
                make.right.equalTo(@(0));
            }];
            
        }];
    }
}

//键盘收回
- (void)vp_wyInputKeyBoardWWillBeHidden:(CGFloat)keyboardHeight
{
    [self.inputBar.inputTextView resignFirstResponder];
    [UIView animateWithDuration:0.25 animations:^{
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.bottom.equalTo(@(-InputViewHeight));
            make.left.equalTo(@0);
            make.right.equalTo(@(0));
        }];
    }];
    
}

#pragma mark - 计算当前所有聊天行的总高度
- (float)getAllCellHeightSum
{
    float cellheight = 0;
    NSMutableArray *harray= [NSMutableArray array];
    for (VSChatMsgData *model in self.vm_msgArrs)
    {
        cellheight = [NSString caculateTextSize:model.vm_msgContent width:GetWidth(self.tableView) - 120 fontSize:15].height+27;
        NSString *str = [NSString stringWithFormat:@"%f",cellheight];
        [harray addObject:str];
    }
    
    float allHeight = 0;
    for (NSInteger i=0; i<harray.count; ++i)
    {
        float cheight = [harray[i] floatValue];
        allHeight+=cheight;
    }
    return allHeight;
}

#pragma mark -- TableViewControllerProtocol
- (Class)vp_cellClass
{
    return [VSChatingCell class];
}

#pragma mark -- getter
_GETTER_ALLOC_BEGIN(NSMutableArray, vm_msgArrs)
{
}
_GETTER_END(vm_msgArrs)

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

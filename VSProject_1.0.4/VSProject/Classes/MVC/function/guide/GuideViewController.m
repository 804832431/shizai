//
//  GuideViewController.m
//  VSProject
//
//  Created by certus on 15/12/2.
//  Copyright © 2015年 user. All rights reserved.
//

#import "GuideViewController.h"

@interface GuideViewController ()
{
    NSArray *array;
    CGPoint oldOffset;
    BOOL toRight;
}

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    array = @[[UIImage imageNamed:@"引导页01.jpg"],[UIImage imageNamed:@"引导页02.jpg"],[UIImage imageNamed:@"引导页03.jpg"]];
    
    [self.view addSubview:self.scrollView];
    [self addGuides];
    [self.view addSubview:self.pageControl];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;

}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addGuides {

    for (int index=0;index < array.count;index++) {
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(index*MainWidth, 0, MainWidth, MainHeight)];
        imageView.image = [array objectAtIndex:index];
        imageView.backgroundColor = [UIColor yellowColor];
        [_scrollView addSubview:imageView];
        
        if (index == array.count-1) {
            imageView.userInteractionEnabled = YES;
            if (_needDisapperButton) {
                [self addDisappearButton:imageView];
            }
        }
    }
}
- (void)addDisappearButton:(UIView *)baseView {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setFrame:CGRectMake(0, 0, MainWidth, MainHeight)];
    [btn setTitleColor:_Colorhex(0x006ab9) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(scrollViewDisappear) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius = 5.f;
    [btn setTitle:@"" forState:0];
    [baseView addSubview:btn];
    
}


- (void)scrollViewDisappear {
    
    if (_nextRoot) {
        NSUserDefaults *loginDefaults = [NSUserDefaults standardUserDefaults];
        [loginDefaults setObject:@"NO" forKey:@"isFirst"];
        [loginDefaults synchronize];
        AppDelegate  *appDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
        appDelegate.window.rootViewController=_nextRoot;
    }else {
        [self.navigationController popViewControllerAnimated:NO];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if (scrollView.contentOffset.x > oldOffset.x) {
        NSLog(@"%f",scrollView.contentOffset.x);
        if (scrollView.contentOffset.x > __SCREEN_WIDTH__ * 2) {
            [self scrollViewDisappear];
        }
        toRight = YES;
    }else {
        toRight = NO;
    }
    oldOffset = scrollView.contentOffset;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    [self serScrollViewRightLocation:scrollView];
    
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    
    [self serScrollViewRightLocation:scrollView];
}

- (void)serScrollViewRightLocation:(UIScrollView *)scrollView {

    NSInteger index = scrollView.contentOffset.x/MainWidth;
    float offsetx = scrollView.contentOffset.x/MainWidth;
    float singleOffsetx = scrollView.contentOffset.x/MainWidth-floorf(offsetx);
    
    if (offsetx > array.count-1 && !_needDisapperButton) {
        [self scrollViewDisappear];
        return;
    }
    if ((singleOffsetx > 0.1 && toRight) || (singleOffsetx > 0.9 && !toRight)) {//后一页
        index = floorf(offsetx)+1;
    }else {
        index = floorf(offsetx);
    }

    _pageControl.currentPage = index;
    CGPoint offsetPoint = CGPointMake(MainWidth*index, 0);
    [_scrollView setContentOffset:offsetPoint animated:YES];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (UIScrollView *)scrollView {

    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.delegate = (id<UIScrollViewDelegate>)self;
        _scrollView.contentSize = CGSizeMake(MainWidth*array.count+1, 0);
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;

    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, MainHeight-50, MainWidth, 20)];
        [_pageControl setBackgroundColor:[UIColor clearColor]];
        _pageControl.currentPage = 0;
        _pageControl.numberOfPages = array.count;
    }
    return _pageControl;
}

@end

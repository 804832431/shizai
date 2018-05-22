//
//  VSWebViewController.m
//  VSProject
//
//  Created by user on 15/1/26.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSWebViewController.h"

#define DEFAULT_WEBTITLE        @"默认标题"

@interface VSWebViewController ()
{
    UIWebView *_webView;
}


@property(nonatomic, strong)UIView      *viewBottom;
@property(nonatomic, strong)UIButton    *btnForward;
@property(nonatomic, strong)UIButton    *btnBack;
@property(nonatomic, strong)UIButton    *btnRefresh;

@property(nonatomic, strong)UIActivityIndicatorView *loadingView;

@end

@implementation VSWebViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        [self wm_setInit];
    }
    
    return self;
}

- (id)init
{
    self = [super init];
    if(self)
    {
        [self wm_setInit];
    }
    return self;
}

- (id)initWithUrl:(NSURL *)url
{
    DBLog(@"================openwebview-url:%@================", url);
    return [self initWithWebTitle:DEFAULT_WEBTITLE url:url];
}

- (id)initWithWebTitle:(NSString*)webTitle url:(NSURL*)url
{
    self = [super init];
    
    if(self)
    {
        self.webUrl   = url;
        self.webTitle = webTitle;
        
        [self wm_setInit];
    }
    
    return self;
}

- (void)wm_setInit
{
    
    self.showToolBar = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    if(!_webView)
    {
        [self.view addSubview:self.webView];
        [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(self.view);
            
        }];
    }
    
    [self refreshTitle];
    
    self.webView.delegate     = self;
    
    [self reloadWebView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(self.showToolBar)
    {
        [self.view addSubview:self.viewBottom];
        
        [self.view addSubview:self.btnBack];
        
        [self.view addSubview:self.btnForward];
        
        [self.view addSubview:self.btnRefresh];
        
        [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@(0));
            make.right.equalTo(@(0));
            make.top.equalTo(@(0));
            make.bottom.equalTo(self.viewBottom.mas_top);
            
        }];
        
    }
    else
    {
        [_viewBottom    setHidden:!self.showToolBar];
        [_btnBack       setHidden:!self.showToolBar];
        [_btnForward    setHidden:!self.showToolBar];
        [_btnRefresh    setHidden:!self.showToolBar];
    }
}

- (void)reloadWebView
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.webUrl];
    [self.webView loadRequest:request];
}

- (void)setShowToolBar:(BOOL)showToolBar
{
    _showToolBar = showToolBar;
    
    //自定义操作
    [_viewBottom    setHidden:!showToolBar];
    [_btnBack       setHidden:!showToolBar];
    [_btnForward    setHidden:!showToolBar];
    [_btnRefresh    setHidden:!showToolBar];
}

- (void)refreshTitle
{
    NSString *theTitle = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    [self vs_setTitleText:(theTitle.length > 0)? theTitle : self.webTitle];
}

/*刷新*/
- (void)refresh
{
    //    [self showWebLoading];
    [self.webView reload];
    [self refreshTitle];
}

/*前进*/
- (void)goForward
{
    if([self.webView canGoForward])
    {
        [self refreshTitle];
        [self.webView goForward];
    }
}

/*后退*/
- (void)goBack
{
    if([self.webView canGoBack])
    {
        [self refreshTitle];
        [self.webView goBack];
    }
}

- (void)showLoading
{
    [self.loadingView setHidden:NO];
    [self.loadingView startAnimating];
}

- (void)hideLoading
{
    [self.loadingView setHidden:YES];
    [self.loadingView stopAnimating];
}

- (void)clearCaches
{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

#pragma mark -- UIWebviewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self showLoading];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    [self handleShouldStartLoadWithRequest:request];
    
    return YES;
}

- (void)handleShouldStartLoadWithRequest:(NSURLRequest *)request
{
    [self refreshTitle];
}

- (void)webView:(UIWebView *)webView failLoadWithError:(NSError *)error
{
    [self handleFailLoadWithError:error];
}

- (void)handleFailLoadWithError:(NSError *)error
{
    [self hideLoading];
    
    [self refreshBtnStatus];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self handleDidFinishLoad];
}

- (void)handleDidFinishLoad
{
    [self hideLoading];
    
    [self refreshTitle];
    
    [self refreshBtnStatus];
}

- (void)refreshBtnStatus
{
    if(self.showToolBar)
    {
        _btnBack.enabled    = [self.webView canGoBack];
        _btnForward.enabled = [self.webView canGoForward];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- getter
_GETTER_ALLOC_BEGIN(UIWebView, webView)
{
    _webView.clipsToBounds   = YES;
    _webView.scalesPageToFit = YES;
    //    _webView.scrollView.delegate = self;
    
}
_GETTER_END(webView)

_GETTER_ALLOC_BEGIN(UIView, viewBottom)
{
    [_viewBottom setUserInteractionEnabled:YES];
    [_viewBottom setBackgroundColor:[UIColor blackColor]];
    [_viewBottom setAlpha:0.7];
    [self.view addSubview:_viewBottom];
    [_viewBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(0));
        make.height.equalTo(@(40));
    }];
}
_GETTER_END(viewBottom)

_GETTER_BEGIN(UIButton, btnBack)
{
    UIImage *img    = __IMAGENAMED__(@"icon_back");
    _btnBack        = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnBack setImage:img forState:UIControlStateNormal];
    [_btnBack setEnabled:NO];
    [_btnBack addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnBack];
    [_btnBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(self.viewBottom.mas_top).mas_offset(1);
        make.width.equalTo(@(52));
        make.height.equalTo(@(40));
    }];
}
_GETTER_END(btnBack)

_GETTER_BEGIN(UIButton, btnForward)
{
    UIImage *img    = __IMAGENAMED__(@"icon_foward");
    _btnForward     = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnForward setImage:img forState:UIControlStateNormal];
    [_btnForward setEnabled:NO];
    [_btnForward addTarget:self action:@selector(goForward) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnForward];
    [_btnForward mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnBack.mas_left).mas_offset(40);
        make.top.equalTo(self.btnBack.mas_top);
        make.width.equalTo(self.btnBack.mas_width);
        make.height.equalTo(self.btnBack.mas_height);
    }];
}
_GETTER_END(btnForward)

_GETTER_BEGIN(UIButton, btnRefresh)
{
    UIImage *img    = __IMAGENAMED__(@"icon_refresh");
    _btnRefresh     = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnRefresh addTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
    [_btnRefresh setBackgroundColor:[UIColor clearColor]];
    [_btnRefresh setImage:img forState:UIControlStateNormal];
    [self.view addSubview:_btnRefresh];
    [_btnRefresh mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(0));
        make.top.equalTo(self.btnBack.mas_top);
        make.width.equalTo(self.btnBack.mas_width);
        make.height.equalTo(self.btnBack.mas_height);
    }];
}
_GETTER_END(btnRefresh)

_GETTER_ALLOC_BEGIN(UIActivityIndicatorView, loadingView)
{
    _CLEAR_BACKGROUND_COLOR_(_loadingView);
    [self.view addSubview:_loadingView];
    [_loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        make.width.equalTo(@(20));
        make.height.equalTo(@(20));
        
    }];
}
_GETTER_END(loadingView)
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

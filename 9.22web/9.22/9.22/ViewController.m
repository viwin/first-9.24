//
//  ViewController.m
//  9.22
//
//  Created by 张稳 on 15/9/22.
//  Copyright (c) 2015年 nlg. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myWebView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 375, self.view.frame.size.height-44)];
    self.myWebView.delegate=self;
    [self.view addSubview:self.myWebView];
    
    self.lbTitle=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 350, 10)];
    self.lbTitle.text=@"title";
    self.lbTitle.textAlignment=NSTextAlignmentCenter;
        [self.navigationController.navigationBar addSubview:self.lbTitle];
//    [self.myWebView addSubview:self.lbTitle];
    
    self.txtUrl=[[UITextField alloc]initWithFrame:CGRectMake(20, 10, 350, 34)];
    self.txtUrl.borderStyle=UITextBorderStyleLine;
    self.txtUrl.delegate=self;
    self.txtUrl.autocapitalizationType=UITextAutocapitalizationTypeNone;
    //自动更正
    self.txtUrl.autocorrectionType=UITextAutocorrectionTypeYes;
    //自动检查
    self.txtUrl.spellCheckingType=UITextSpellCheckingTypeYes;
    self.txtUrl.keyboardType=UIKeyboardTypeURL;
    self.txtUrl.returnKeyType=UIReturnKeyGo;
    [self.navigationController.navigationBar addSubview:self.txtUrl];
//    [self.myWebView addSubview:self.txtUrl];
    
    
    
    NSString*path=@"http://m.baidu.com";
    NSURL*url=[NSURL URLWithString:path];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [self.myWebView loadRequest:request];
    
    
    UIBarButtonItem *forward=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(forwardTest)];
    
    UIBarButtonItem *f=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *stop=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(stopTest)];
    
    UIBarButtonItem *reload=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadTest)];

    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(backTest)];
    
    [self.navigationController setToolbarHidden:NO animated:YES];
    self.toolbarItems=@[forward,f,stop,f,reload,f,back];//f为空格，每个按钮中间加一个空格
    

//    [self.navigationController setToolbarHidden:NO];
}
-(void)forwardTest
{
    NSLog(@"goforward");
    [self.myWebView goForward];
}
-(void)reloadTest
{
    [self.myWebView reload];
}
-(void)stopTest
{
    [self.myWebView stopLoading];
}
-(void)backTest
{
    [self.myWebView goBack];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"%s",__func__);

//    request.URL.absoluteString
//    NSURL*url=[NSURL URLWithString:path];
//    NSURLRequest *request=[NSURLRequest requestWithURL:url];
//    [self.myWebView loadRequest:request];
    
    //网址若为空，自动添加原来的网址
    if(self.txtUrl.text.length<=0)
    {
        self.txtUrl.text=request.URL.absoluteString;
    }
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    //加载数据时的风火轮
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:YES];
    NSLog(@"start");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //加载完成停止风火轮
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];

    
    self.lbTitle.text=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
     NSLog(@"stop");
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%@",error);
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //自动添加 http://
    if([self.txtUrl.text rangeOfString:@"http://"].location==NSNotFound)
    {
        self.txtUrl.text=[NSString stringWithFormat:@"http://%@",self.txtUrl.text];
    }
    NSLog(@"%@",self.txtUrl.text);
    
//    NSString *path=self.txtUrl.text;
//    NSURL*url=[NSURL URLWithString:path];
//    NSURLRequest *request=[NSURLRequest requestWithURL:url];
//    [self.myWebView loadRequest:request];
    if([textField isFirstResponder])
    {
        [textField resignFirstResponder];
    }
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

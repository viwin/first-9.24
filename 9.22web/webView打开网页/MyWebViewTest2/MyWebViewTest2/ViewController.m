//
//  ViewController.m
//  MyWebViewTest2
//
//  Created by 杨 国俊 on 15/9/18.
//  Copyright (c) 2015年 sdzy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.lblTitle=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 375, 14)];
    self.lblTitle.font=[UIFont systemFontOfSize:12];
    self.lblTitle.backgroundColor=[UIColor clearColor];
    self.lblTitle.textAlignment=NSTextAlignmentCenter;
    self.lblTitle.text=@"title";
    [self.navigationController.navigationBar addSubview:self.lblTitle];
    self.txtInfo=[[UITextField alloc] initWithFrame:CGRectMake(10, 14, 360, 30)];
    self.txtInfo.borderStyle=2;
    self.txtInfo.delegate=self;
    //    设置大小写和拼音检查
    //    自动大写
    self.txtInfo.autocapitalizationType=UITextAutocapitalizationTypeNone;
    //    自动更正
    self.txtInfo.autocorrectionType=UITextAutocorrectionTypeNo;
    //    拼写检查
    self.txtInfo.spellCheckingType=UITextSpellCheckingTypeNo;
    
    self.txtInfo.keyboardType=UIKeyboardTypeURL;
    self.txtInfo.returnKeyType=UIReturnKeyGo;
    [self.navigationController.navigationBar addSubview:self.txtInfo];
    
    self.myWebView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 375, self.view.bounds.size.height-44)];
    self.myWebView.delegate=self;
    [self.view addSubview:self.myWebView];
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://i.ifeng.com"]]];
    
    self.toolBar=[[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-44, self.view.bounds.size.width, 44)];
    [self.view addSubview:self.toolBar];
    
     UIBarButtonItem *rewind=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(forward)];
    
    UIBarButtonItem *forward=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(back)];
    
     UIBarButtonItem *refresh=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
    
     UIBarButtonItem *stop=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(stop)];
    
    
    UIBarButtonItem *flex=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:@selector(forward)];
    
    [self.navigationController setToolbarHidden:NO animated:YES];
    self.toolbarItems=@[flex,rewind,flex,forward,flex,refresh,flex,stop,flex];
    
    
    
}

-(void)forward
{
    NSLog(@"forward   forward");
    [self.myWebView goForward];
}
-(void)back
{
    NSLog(@"back");
    [self.myWebView goBack];
}
-(void)refresh
{
    NSLog(@"refresh");
    [self.myWebView reload];
}
-(void)stop
{
    NSLog(@"stop");
    [self.myWebView stopLoading];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self.txtInfo.text rangeOfString:@"http://"].location==NSNotFound) {
        self.txtInfo.text=[NSString stringWithFormat:@"http://%@",self.txtInfo.text];
    }
    
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.txtInfo.text]]];
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark webView Delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    if (self.txtInfo.text.length<=0) {
        self.txtInfo.text=request.URL.absoluteString;
    }
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];
    self.lblTitle.text=[self.myWebView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%@",error);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

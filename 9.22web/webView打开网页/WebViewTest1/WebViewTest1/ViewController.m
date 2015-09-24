//
//  ViewController.m
//  WebViewTest1
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
    
    self.lblTitle=[[UILabel alloc] initWithFrame:CGRectMake(0, 20, 375, 40)];
    self.lblTitle.text=@"title";
    [self.view addSubview:self.lblTitle];
    self.txtInfo=[[UITextField alloc] initWithFrame:CGRectMake(0, 45, 375, 44)];
    self.txtInfo.borderStyle=1;
    self.txtInfo.delegate=self;
    [self.view addSubview:self.txtInfo];
    
    self.myWebView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 90, 375, 400)];
    self.myWebView.delegate=self;
    [self.view addSubview:self.myWebView];
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://i.ifeng.com"]]];
}

#pragma mark textfield 代理方法
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
//    验证URL 路径
    if ([self.txtInfo.text rangeOfString:@"http://"].location==NSNotFound) {
        self.txtInfo.text=[NSString stringWithFormat:@"http://%@",self.txtInfo.text];
    }
    
//    加载路径
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.txtInfo.text]]];
    [textField resignFirstResponder];
   
    return YES;
}

#pragma mark web delegate should start load with request
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    if (self.txtInfo.text.length<=0) {
//        绝对路径
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

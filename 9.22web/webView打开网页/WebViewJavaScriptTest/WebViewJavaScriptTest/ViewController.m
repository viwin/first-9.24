//
//  ViewController.m
//  WebViewJavaScriptTest
//
//  Created by 杨 国俊 on 15/9/18.
//  Copyright (c) 2015年 sdzy. All rights reserved.
//

#import "ViewController.h"
#import "WebViewJavascriptBridge.h"
@interface ViewController ()
@property(strong,nonatomic) WebViewJavascriptBridge *bridge;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myWebView=[[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.myWebView];
    self.myWebView.delegate=self;
    self.bridge=[WebViewJavascriptBridge bridgeForWebView:self.myWebView handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"返回的js消息,%@",data);
        responseCallback(@"Right ok");
    }];
    [self loadWebViewData];
    
    [self.bridge send:@"我的OCtoJS"];
    [self.bridge send:@{@"name":@"lisi"}];
    [self.bridge send:@"测试信息" responseCallback:^(id responseData) {
        NSLog(@"responseData,%@",responseData);
    }];
    
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return  YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"start");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"end");
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%@",error);
}
-(void)loadWebViewData
{
    NSString *path=[[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
    NSString *appHTML=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSURL *url=[NSURL fileURLWithPath:path];
    [self.myWebView loadHTMLString:appHTML baseURL:url];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

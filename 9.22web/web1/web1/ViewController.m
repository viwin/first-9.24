//
//  ViewController.m
//  web1
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
    
    self.lbTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, 375, 20)];
    self.lbTitle.text=@"title";
    self.lbTitle.textAlignment=NSTextAlignmentCenter;
    [self.view  addSubview:self.lbTitle];
    
    self.txtInfo=[[UITextField alloc]initWithFrame:CGRectMake(0, 45, 375, 44)];
    self.txtInfo.delegate=self;
    self.txtInfo.borderStyle=1;
    [self.view addSubview:self.txtInfo];
    
    self.myWebView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 90, 375, 400)];
    self.myWebView.delegate=self;
    [self.view addSubview:self.myWebView];
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://i.ifeng.com"]]];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if([self.txtInfo.text rangeOfString:@"http://"].location==NSNotFound)
    {
        self.txtInfo.text=[NSString stringWithFormat:@"http://%@",self.txtInfo.text];
    }
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.txtInfo.text]]];
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if(self.txtInfo.text.length<=0)
    {
        //绝对路径
        self.txtInfo.text=request.URL.absoluteString;
    }
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:YES];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];
    self.lbTitle.text=[self.myWebView stringByEvaluatingJavaScriptFromString:@"document.title"];
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

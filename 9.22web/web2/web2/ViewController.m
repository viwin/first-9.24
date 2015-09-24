//
//  ViewController.m
//  web2
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
    self.labTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 375, 14)];
    self.labTitle.font=[UIFont systemFontOfSize:12];
    self.labTitle.text=@"title";
    self.labTitle.textAlignment=NSTextAlignmentCenter;
    [self.navigationController.navigationBar addSubview:self.labTitle];
    
    self.textInfo=[[UITextField alloc]initWithFrame:CGRectMake(0, 14, 375, 30)];
    self.textInfo.borderStyle=1;
    self.textInfo.delegate=self;
    self.textInfo.autocapitalizationType=UITextAutocapitalizationTypeNone;
    self.textInfo.autocorrectionType=UITextAutocorrectionTypeNo;
    self.textInfo.spellCheckingType=UITextSpellCheckingTypeNo;
    self.textInfo.keyboardType=UIKeyboardTypeURL;
    self.textInfo.returnKeyType=UIReturnKeyGo;
    [self.navigationController.navigationBar addSubview:self.textInfo];
    
    self.myWebView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 375, self.view.bounds.size.height-44)];
    self.myWebView.delegate=self;
    [self.view addSubview:self.myWebView];
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.baidu.com"]]];
    
    UIBarButtonItem *reload=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(_reload)];
    
    UIBarButtonItem *stop=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(_stop)];
    
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(_goback)];
    
    UIBarButtonItem *forward=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(_forward)];
    
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    [self.navigationController setToolbarHidden:NO animated:YES];
    self.toolbarItems=@[reload,space,stop,space,back,space,forward];
    
    
}
-(void)_reload
{
    [self.myWebView reload];
}
-(void)_stop
{
    [self.myWebView stopLoading];
}
-(void)_goback
{
    [self.myWebView goBack];
}
-(void)_forward
{
    [self.myWebView goForward];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if([self.textInfo.text rangeOfString:@"http://"].location==NSNotFound)
    {
        self.textInfo.text=[NSString stringWithFormat:@"http://%@",self.textInfo.text];
    }
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.textInfo.text]]];
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if(self.textInfo.text.length<=0)
    {
        self.textInfo.text=request.URL.absoluteString;
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
    self.labTitle.text=[self.myWebView stringByEvaluatingJavaScriptFromString:@"document.title"];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"error");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

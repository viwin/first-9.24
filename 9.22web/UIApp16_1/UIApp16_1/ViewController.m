//
//  ViewController.m
//  UIApp16_1
//
//  Created by 杨 国俊 on 15/9/22.
//  Copyright (c) 2015年 sdzy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.myWebView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 375, self.view.frame.size.height-44)];
    self.myWebView.delegate=self;
    
    [self.view addSubview:self.myWebView];
    
    self.lblTitle=[[UILabel alloc]initWithFrame:CGRectMake(20, 60, 350, 30)];
    self.lblTitle.text=@"title";
    [self.view addSubview:self.lblTitle];
    
    self.txtURL=[[UITextField alloc] initWithFrame:CGRectMake(20,100, 350, 44)];
    self.txtURL.borderStyle=1;
    self.txtURL.delegate=self;
    [self.view addSubview:self.txtURL];
    
    NSString *path=@"http://m.baidu.com";
    NSURL *url=[NSURL URLWithString:path];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [self.myWebView loadRequest:request];
    
    
    UIBarButtonItem *forward=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(forwardTest)];
    
    UIBarButtonItem *flex=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    
    self.toolbarItems=@[forward,flex,forward,flex,forward,flex];
    
    
    [self.navigationController setToolbarHidden:NO];

    
    
}

-(void)forwardTest
{
    [self.myWebView goForward];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    
    if (self.txtURL.text.length<=0) {
        self.txtURL.text=request.URL.absoluteString;
    }
    
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"start");
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
   self.lblTitle.text =[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
     [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    NSLog(@"stop");
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%@",error);
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    
    if ([self.txtURL.text rangeOfString:@"http://"].location==NSNotFound) {
        self.txtURL.text=[NSString stringWithFormat:@"http://%@",self.txtURL.text];
    }
    NSURL *url=[NSURL URLWithString:self.txtURL.text];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [self.myWebView loadRequest:request];

 
       if ([textField isFirstResponder]) {
        [textField resignFirstResponder];
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

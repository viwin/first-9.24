//
//  ViewController.m
//  WebViewAndJavaScriptTest2
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
    
    self.webView=[[UIWebView alloc] initWithFrame:self.view.frame   ];
    [self.view addSubview:self.webView];
    self.webView.delegate=self;
    NSString * path = [[NSBundle mainBundle] bundlePath];
    NSURL * baseURL = [NSURL fileURLWithPath:path];
    NSString * htmlFile = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSString * htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:(NSUTF8StringEncoding) error:nil];
    [self.webView loadHTMLString:htmlString baseURL:baseURL];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL * url = [request URL];
    if ([[url scheme] isEqualToString:@"sdzy"]) {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"系统消息" message:[url absoluteString] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] ;
        [alertView show];
        return NO;
    }
    
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

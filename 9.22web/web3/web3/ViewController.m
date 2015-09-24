//
//  ViewController.m
//  web3
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
    
    self.title=@"webview";
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.toolbarHidden=NO;
    self.myWebView=[[UIWebView alloc]initWithFrame:self.view.bounds];
    self.myWebView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.myWebView.delegate=self;
    
    [self.view addSubview:self.myWebView];
    
    self.activitor=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    
    UIBarButtonItem *flex=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *pdf=[[UIBarButtonItem alloc] initWithTitle:@"pdf" style:UIBarButtonItemStylePlain target:self action:@selector(pdf)];
    UIBarButtonItem *png=[[UIBarButtonItem alloc] initWithTitle:@"png" style:UIBarButtonItemStylePlain target:self action:@selector(png)];
    
    UIBarButtonItem *word=[[UIBarButtonItem alloc] initWithTitle:@"word" style:UIBarButtonItemStylePlain target:self action:@selector(word)];
    UIBarButtonItem *html=[[UIBarButtonItem alloc] initWithTitle:@"html" style:UIBarButtonItemStylePlain target:self action:@selector(html)];
    
    self.toolbarItems=@[flex,pdf,flex,png,flex,word,flex,html,flex];
    

    
}
-(void)pdf
{
    NSString *path=[[NSBundle mainBundle]
                    pathForResource:@"sogou" ofType:@"pdf"];
    if(path)
    {
        NSData*data=[NSData dataWithContentsOfFile:path];
        [self.myWebView loadData:data MIMEType:@"application/pdf" textEncodingName:nil baseURL:nil];
        
        
    }
    else
    {
        NSLog(@"not find");
    }
}
-(void)png
{
    NSString *path=[[NSBundle mainBundle]pathForResource:@"qq120" ofType:@"png"];
    if(path)
    {
        NSData *data=[NSData dataWithContentsOfFile:path];
        [self.myWebView loadData:data MIMEType:@"image/png" textEncodingName:nil baseURL:nil];
    }
    else
    {
        NSLog(@"not find");
    }
}
-(void)word
{
    NSString *path=[[NSBundle mainBundle]pathForResource:@"ui课程大纲" ofType:@"docx"];
    if(path)
    {
        NSURL*url=[NSURL URLWithString:path];
        NSURLRequest *request=[NSURLRequest requestWithURL:url];
        [self.myWebView loadRequest:request];
    }
    else
    {
        NSLog(@"not find");
    }

}
-(void)html
{
    
    [self.myWebView loadData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"main" ofType:@"html"]] MIMEType:@"text/html" textEncodingName:@"utf-8" baseURL:nil];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.baidu.com"]]];
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.activitor startAnimating];
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:YES];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activitor stopAnimating];
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (navigationType==UIWebViewNavigationTypeLinkClicked) {
        NSString *url=[[request URL] path];
        NSLog(@"%@",[[url  pathComponents] lastObject]);
        [self loadHtml:url];
        
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

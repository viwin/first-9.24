//
//  ViewController.h
//  web3
//
//  Created by 张稳 on 15/9/22.
//  Copyright (c) 2015年 nlg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIWebViewDelegate>

@property(nonatomic,strong)UIWebView *myWebView;
@property(nonatomic,strong)UIActivityIndicatorView *activitor;

@end


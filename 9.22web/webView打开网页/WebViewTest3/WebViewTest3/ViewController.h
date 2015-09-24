//
//  ViewController.h
//  WebViewTest3
//
//  Created by 杨 国俊 on 15/9/18.
//  Copyright (c) 2015年 sdzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
@interface ViewController : UIViewController<UIWebViewDelegate>
@property(strong,nonatomic) UIWebView *myWebView;
@property(strong,nonatomic) UIActivityIndicatorView *activitor;
@end


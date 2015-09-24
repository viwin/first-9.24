//
//  ViewController.h
//  WebViewTest1
//
//  Created by 杨 国俊 on 15/9/18.
//  Copyright (c) 2015年 sdzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIWebViewDelegate,UITextFieldDelegate>

@property(strong,nonatomic) UILabel *lblTitle;
@property(strong,nonatomic) UITextField *txtInfo;
@property(strong,nonatomic) UIWebView *myWebView;
@end


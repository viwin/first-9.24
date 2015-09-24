//
//  ViewController.h
//  UIApp16_1
//
//  Created by 杨 国俊 on 15/9/22.
//  Copyright (c) 2015年 sdzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIWebViewDelegate,UITextFieldDelegate>

@property(strong,nonatomic) UIWebView *myWebView;

@property(strong,nonatomic) UITextField *txtURL;
@property(strong,nonatomic) UILabel *lblTitle;

@end


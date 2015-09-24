//
//  ViewController.h
//  web2
//
//  Created by 张稳 on 15/9/22.
//  Copyright (c) 2015年 nlg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIWebViewDelegate,UITextFieldDelegate>

@property(nonatomic,strong)UILabel *labTitle;
@property(nonatomic,strong)UITextField *textInfo;
@property(nonatomic,strong)UIWebView *myWebView;
@end


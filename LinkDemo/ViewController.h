//
//  ViewController.h
//  LinkDemo
//
//  Created by SYETC02 on 15/5/26.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBYGameView.h"
#import "ZDProgressView.h"
#import "UIBarButtonItem+Badge.h"

@interface ViewController : UIViewController <UIAlertViewDelegate, DBYGameViewDelegate>
//代理在DBYGameView的文件中定义
@property (strong, nonatomic) UIButton * pauseBtn;
@property (strong, nonatomic) UIButton * searchBtn;
@property (strong, nonatomic) UIButton * exploBtn;
@property (strong, nonatomic) UIButton * refreshBtn;

@property (strong, nonatomic) UIBarButtonItem * searcLbl;
@property (strong, nonatomic) UIBarButtonItem * exploLbl;
@property (strong, nonatomic) UIBarButtonItem * refreshLbl;

@property (strong, nonatomic) ZDProgressView *zdProgressView;

@end


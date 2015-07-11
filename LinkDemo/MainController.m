//
//  MainController.m
//  LinkDemo
//
//  Created by 丁博洋 on 15/5/30.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "MainController.h"
#import "AppDelegate.h"
@interface MainController ()

@end

@implementation MainController

@synthesize classicBtn;
@synthesize timeBtn;

//游戏背景
UIImageView * bgImgView;

UIImageView * titleImg;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 使用Default作为游戏背景图片
    bgImgView =[[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    bgImgView.image = [UIImage imageNamed:@"Default"];;
    bgImgView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:bgImgView];
    
    
    titleImg = [[UIImageView alloc]initWithFrame:CGRectMake(32.5f, 80, 300, 60)];
    titleImg.image = [UIImage imageNamed:@"title"];
    [self.view addSubview:titleImg];
    
    classicBtn = [[UIButton alloc]initWithFrame:CGRectMake(85.5f, 200, 200, 60)];
    classicBtn.tag=1;
    // 为startBn按钮设置图片
    [self.classicBtn setBackgroundImage:[UIImage imageNamed:@"menu-classic-mode"]
                               forState:UIControlStateNormal];
    // 为startBn的Touch Up Inside事件绑定事件处理方法
    [self.classicBtn addTarget:self action:@selector(onClick:)
              forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:classicBtn];
    
    timeBtn = [[UIButton alloc]initWithFrame:CGRectMake(75.5f, 300, 200, 60)];
    timeBtn.tag=2;
    // 为startBn按钮设置图片
    [self.timeBtn setBackgroundImage:[UIImage imageNamed:@"menu-time-mode"]
                               forState:UIControlStateNormal];

    // 为startBn的Touch Up Inside事件绑定事件处理方法
    [self.timeBtn addTarget:self action:@selector(onClick:)
              forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:timeBtn];
}


- (void)onClick:(id)sender
{
    AppDelegate * appDelegate = [UIApplication sharedApplication].delegate;
    UIButton* btn = (UIButton*)sender;
    switch (btn.tag) {
        case 1:
            [appDelegate LevelSceneView];
            break;
        case 2:
            count=2;
            [appDelegate gameView];
            break;
            
        default:
            break;
    }
}
@end

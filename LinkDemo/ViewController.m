//
//  ViewController.m
//  LinkDemo
//
//  Created by SYETC02 on 15/5/26.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "ViewController.h"
#import "DBYGameView.h"
#import "DBYPiece.h"
#import "ConfigHeader.h"
#import "AppDelegate.h"
#import "UserDefaultsUtils.h"
#define YML_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define YML_SYSTEM_VERSION_GREATER_LESS_THEN(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == kCFCompareLessThan)

@interface ViewController ()

@end

@implementation ViewController

@synthesize pauseBtn;
@synthesize searchBtn;
@synthesize refreshBtn;
@synthesize exploBtn;

@synthesize searcLbl;
@synthesize exploLbl;
@synthesize refreshLbl;
@synthesize zdProgressView;
//游戏背景
UIImageView * bgImgView;

UIImageView * headerImgView;
// 游戏界面类
DBYGameView* gameView;
AppDelegate * appDelegate;
NSInteger refreshCount = REFRESH;
NSInteger exploCount = BOMB;
NSInteger searchCount = SEARCH;

// 游戏剩余时间
NSInteger leftTime;
// 定时器
NSTimer* timer;

BOOL isPlaying;
UIAlertView* lostAlert;
UIAlertView* successAlert;
//刷新分数
NSTimer* nowTimer;
UILabel * highestLbl;
UILabel * nowLbl;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDelegate =[UIApplication sharedApplication].delegate;
    
    CGRect frame = [self getApplicationRealBounds ];
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height;
    DLog(@"width=%i height=%i",(int)width,(int)height);
    
    // 使用Default作为游戏背景图片
    bgImgView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Default"]];
    bgImgView.frame = frame;
    [self.view addSubview:bgImgView];
    //标题头部
    headerImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 50)];
    headerImgView.image = [UIImage imageNamed:@"header.png"];
    [self.view addSubview:headerImgView];
    
    //暂停按钮
    pauseBtn=[[UIButton alloc] initWithFrame:CGRectMake(300,7, 35, 35)];
    // 为MapLayer_BtnPause按钮设置图片
    [self.pauseBtn setBackgroundImage:[UIImage imageNamed:@"MapLayer_BtnPause"]
                            forState:UIControlStateNormal];
    [self.pauseBtn setBackgroundImage:[UIImage imageNamed:@"MapLayer_BtnPause_2"]
                            forState:UIControlStateHighlighted];
    // 为MapLayer_BtnPause的Touch Up Inside事件绑定事件处理方法
    [self.pauseBtn addTarget:self action:@selector(menuClick:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pauseBtn];
    
    //刷新按钮
    refreshBtn=[[UIButton alloc] initWithFrame:CGRectMake(250,7, 35, 35)];
    // 为startBn按钮设置图片
    [self.refreshBtn setBackgroundImage:[UIImage imageNamed:@"refresh"]
                             forState:UIControlStateNormal];
    [self.refreshBtn setBackgroundImage:[UIImage imageNamed:@"refresh_hover"]
                             forState:UIControlStateHighlighted];
    // 为startBn的Touch Up Inside事件绑定事件处理方法
    [self.refreshBtn addTarget:self action:@selector(refreshClick)
            forControlEvents:UIControlEventTouchUpInside];
    refreshLbl= [[UIBarButtonItem alloc] initWithCustomView:refreshBtn];
    [self.view addSubview:refreshBtn];
    
    //炸弹按钮
    exploBtn=[[UIButton alloc] initWithFrame:CGRectMake(200,7, 35, 35)];
    // 为startBn按钮设置图片
    [self.exploBtn setBackgroundImage:[UIImage imageNamed:@"explo"]
                             forState:UIControlStateNormal];
    [self.exploBtn setBackgroundImage:[UIImage imageNamed:@"explo_hover"]
                             forState:UIControlStateHighlighted];
    // 为startBn的Touch Up Inside事件绑定事件处理方法
    [self.exploBtn addTarget:self action:@selector(exploClick)
            forControlEvents:UIControlEventTouchUpInside];
     exploLbl= [[UIBarButtonItem alloc] initWithCustomView:exploBtn];
    [self.view addSubview:exploBtn];
 
    
    //查询按钮
    searchBtn=[[UIButton alloc] initWithFrame:CGRectMake(150,7, 35, 35)];
    // 为startBn按钮设置图片
    [self.searchBtn setBackgroundImage:[UIImage imageNamed:@"search"]
                             forState:UIControlStateNormal];
    [self.searchBtn setBackgroundImage:[UIImage imageNamed:@"search_hover"]
                             forState:UIControlStateHighlighted];
    // 为startBn的Touch Up Inside事件绑定事件处理方法
    [self.searchBtn addTarget:self action:@selector(searchClick)
            forControlEvents:UIControlEventTouchUpInside];
     searcLbl= [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    [self.view addSubview:searchBtn];

    //分数背景
    UIImageView *portionImg =[[UIImageView alloc]initWithFrame:CGRectMake(10,4,125, 40)];
    portionImg.image = [UIImage imageNamed:@"combo.png"];;
    portionImg.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:portionImg];
    //最高分
    UILabel * highestlabel = [[UILabel alloc] initWithFrame:CGRectMake(20,7, 55, 20)];
    [self label:highestlabel test:@"    最高分" color:[UIColor colorWithRed:1 green:0.817 blue:0.296 alpha:1]];
    highestLbl = [[UILabel alloc] initWithFrame:CGRectMake(80,7, 55, 20)];
    [self label:highestLbl test:@"0" color:[UIColor blackColor]];

    //分数
    UILabel * nowlabel = [[UILabel alloc] initWithFrame:CGRectMake(20,22, 55, 20)];
    [self label:nowlabel test:@"分   数" color:[UIColor colorWithRed:1 green:0.817 blue:0.296 alpha:1]];
    nowLbl = [[UILabel alloc] initWithFrame:CGRectMake(80,22, 55, 20)];
    [self label:nowLbl test:@"0" color:[UIColor blackColor]];
    
    //定义一个进度条
    self.zdProgressView = [[ZDProgressView alloc] initWithFrame:CGRectMake(0, 80, width, 20)];
    self.zdProgressView.progress = DEFAULT_TIME/100;
    self.zdProgressView.textFont = [UIFont boldSystemFontOfSize:12];
    self.zdProgressView.noColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"MapLayer_TimeBar_2.png"]];
    self.zdProgressView.prsColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"MapLayer_TimeBar_1.png"]];
    [self.view addSubview:self.zdProgressView];
    

    // 创建DBYGameView控件
    gameView = [[DBYGameView alloc] initWithFrame:CGRectMake(-45, 120, width+45, 470)];

    // 创建DBYGameService对象
    gameView.gameService = [[DBYGameService alloc] init];
    gameView.delegate = self;
    gameView.backgroundColor = [UIColor colorWithHue:0.565 saturation:0.257 brightness:0.501 alpha:0.7];
    gameView.layer.cornerRadius = 5.0f;// 设置圆角
    gameView.layer.borderColor = [UIColor colorWithRed:0.372 green:0.45 blue:0.501 alpha:1].CGColor;
    gameView.layer.borderWidth = 1.0f;//边框粗细
    
    [self.view addSubview:gameView];
    
#ifdef __IPHONE_7_0
    if ([[[UIDevice currentDevice] systemVersion] intValue] >= 7) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
#endif
    // Do any additional setup after loading the view, typically from a nib.
    //设置广告点击后的回调，可以不写。
    [YouMiNewSpot clickYouMiSpotAction:^(BOOL flag){
        //广告被点击的回调。
    }];

    // 初始化游戏胜利的对话框
    successAlert = [[UIAlertView alloc] initWithTitle:@"竞速模式"
                                              message:nil delegate:self
                                    cancelButtonTitle:@"返回菜单" otherButtonTitles:@"重新开始",@"回到游戏",nil];
 
    
     [self startGame];
}

-(NSString *)newNow
{
   
    if(now>[UserDefaultsUtils IntvalueWithKey:@"highestNow"]){
        [UserDefaultsUtils saveIntValue:now forKey:@"highestNow"];
        return [[NSString alloc] initWithFormat:@"新的记录\n分数：%i",now];
    }else{
        return [[NSString alloc] initWithFormat:@"分数：%i",now];
    }
}
//初始化道具
-(void)initProperty
{
    NSString * nowStr = [NSString stringWithFormat:@"%d",[UserDefaultsUtils IntvalueWithKey:@"highestNow"]];
    highestLbl.text=nowStr;
    //重置道具数量
    refreshCount = REFRESH;
    exploCount = BOMB;
    searchCount = SEARCH;
    [self barButtonItemBadge:refreshLbl badgeValue:refreshCount];
    [self barButtonItemBadge:exploLbl badgeValue:exploCount];
    [self barButtonItemBadge:searcLbl badgeValue:searchCount];
}

-(BOOL)isXCodeAutoRotation {
    CGRect bounds = [UIScreen mainScreen].bounds;
    
    if ( (bounds.size.height > bounds.size.width &&
          YML_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) ||
           YML_SYSTEM_VERSION_GREATER_LESS_THEN(@"8.0")
        ) {//7要转,8不用,且xcode5和xcode6编译也有区别.
        return YES;
    }
    return NO;
}
- (CGRect)getApplicationRealBounds {
    CGRect bounds = [UIScreen mainScreen].bounds;
    
    if ([self isXCodeAutoRotation]&&UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) ) {
        CGFloat width = bounds.size.width;
        bounds.size.width = bounds.size.height;
        bounds.size.height = width;
    }
    
    return CGRectMake(0, 0, bounds.size.width, bounds.size.height);
}

- (void) startGame
{
    // 如果之前的timer还未取消，取消timer
    if (timer != nil)
    {
        [timer invalidate];//有效的，时间开启
    }
    // 重新设置游戏时间
    leftTime = DEFAULT_TIME;
    [self initProperty];
    // 开始新的游戏游戏
    [gameView startGame];
    isPlaying = YES;
    timer = [NSTimer scheduledTimerWithTimeInterval:1
                                             target:self selector:@selector(refreshView) userInfo:self repeats:YES];
    
    nowTimer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                target:self selector:@selector(refreshNow) userInfo:self repeats:YES];
    // 将选中方块设为nil。
    gameView.selectedPiece = nil;
}
- (void)menuClick:(id)sender
{
    [timer setFireDate:[NSDate distantFuture]];
    // 游戏胜利
    [successAlert show];
}

- (void)refreshClick
{
    
    if(refreshCount>0){
        refreshCount--;
        [self barButtonItemBadge:refreshLbl badgeValue:refreshCount];
        [gameView randomOccurrence];
    }else{
         [self spotSDKAction];
    }
    
    
}

- (void)exploClick
{
    
    if(exploCount>0){
        if ([gameView bombIdentical]) {
            exploCount--;
            [self barButtonItemBadge:exploLbl badgeValue:exploCount];
        }
    }else{
        [self spotSDKAction];
    }

}
- (void)searchClick
{
    if(searchCount>0){
        searchCount--;
        [self barButtonItemBadge:searcLbl badgeValue:searchCount];
        [gameView searchIdentical];
    }else{
        [self spotSDKAction];
    }

}
//刷新游戏时间
- (void)refreshView
{
    self.zdProgressView.progress =(float)leftTime/100;
    NSString * str = [[NSString alloc]initWithFormat:@"%ld",(long)leftTime];
    self.zdProgressView.text =str;
    leftTime--;
    
    // 时间小于0, 游戏失败
    if (leftTime < 0)
    {
        [timer invalidate];
        // 更改游戏的状态
        isPlaying = NO;
        // 初始化游戏失败的对话框
        lostAlert = [[UIAlertView alloc] initWithTitle:@"游戏结束！"
                                               message:[self newNow] delegate:self
                                     cancelButtonTitle:nil otherButtonTitles:@"返回菜单",@"重新开始", nil];
        [lostAlert show];

        return;
    }
}
//刷新当前分数
- (void)refreshNow
{
    nowLbl.text=[[NSString alloc] initWithFormat:@"%i",now];

}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    DLog(@"%i",(int)buttonIndex);
    // 如果用户选中的“确定”按钮
    switch (buttonIndex) {
        case 0:
            [appDelegate mainView];
            now=0;
            break;
        case 1:
            now=0;
            [self startGame];
            break;
        case 2:
             [timer setFireDate:[NSDate date]];
            break;
            
        default:
            break;
    }

}

- (void)checkWin:(DBYGameView *)gameView
{
    // 判断是否还有剩下的方块, 如果没有, 游戏胜利
    if (![gameView.gameService hasPieces])
    {
        // 游戏胜利
        //[successAlert show];
        // 停止定时器
        [timer invalidate];
        // 更改游戏状态
        isPlaying = NO;
        [self startGame];

    }
}

- (void)spotSDKAction
{
    [YouMiNewSpot showYouMiSpotAction:^(BOOL flag){
        if (flag) {
            NSLog(@"log添加展示成功的逻辑");
        }
        else{
            NSLog(@"log添加展示失败的逻辑");
        }
    }];
}

- (void)barButtonItemBadge:(UIBarButtonItem*)ButtonItem badgeValue:(NSInteger)count
{
    self.navigationItem.leftBarButtonItem = ButtonItem;
    self.navigationItem.leftBarButtonItem.badgeValue =  [NSString stringWithFormat: @"%i", (int)count];
    self.navigationItem.leftBarButtonItem.badgeBGColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_number.png"]];
}

- (void)label:(UILabel*)label test:(NSString*)str color:(UIColor*)color
{
    label.font = [UIFont systemFontOfSize:12.0f];
    label.text = str;
    label.textColor = color;
    [self.view addSubview:label];
    
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}

-(BOOL)shouldAutorotate{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

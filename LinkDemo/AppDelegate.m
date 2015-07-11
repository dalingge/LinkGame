//
//  AppDelegate.m
//  LinkDemo
//
//  Created by SYETC02 on 15/5/26.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "AppDelegate.h"
#import "MainController.h"
#import "ViewController.h"
#import "ConfigHeader.h"
#import "LevelSceneController.h"
#import "UserDefaultsUtils.h"
#import "DBYPass.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
//背景音乐
AVAudioPlayer * audioPlayerBg;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSURL* bgUrl = [[NSBundle mainBundle]
                     URLForResource:@"Zombies on your Lawn" withExtension:@"mp3"];
    audioPlayerBg =[[AVAudioPlayer alloc] initWithContentsOfURL:bgUrl error:nil];
    audioPlayerBg.numberOfLoops=-1;
    [audioPlayerBg play];
    
    //初始化关数
    NSMutableArray * nma = [[NSMutableArray alloc] init];
    for (int i =1 ; i<=250; i++) {
        DBYPass * pass = [[DBYPass alloc] init];
        
        if(i<3){
            pass.passId=[NSNumber numberWithInt:i];
            pass.isPass=[NSNumber numberWithBool:YES];
        }else if(i==4){
            pass.passId=[NSNumber numberWithInt:i];
            pass.isPass=[NSNumber numberWithBool:NO];
            
        }else if(i==5){
            pass.passId=[NSNumber numberWithInt:i];
            pass.isPass=[NSNumber numberWithBool:NO];
        }else{
            pass.passId=[NSNumber numberWithInt:i+6];
            pass.isPass=[NSNumber numberWithBool:NO];
        }
        [nma addObject:pass];
    }
    [UserDefaultsUtils saveValue:[NSKeyedArchiver archivedDataWithRootObject:nma] forKey:@"PASSARRAY"];
    
    NSString *appid = @"375b2e9b2cc626cb";
    NSString *secretId = @"b5f818cfe34d88c8";
    [YouMiNewSpot initYouMiDeveloperParams:appid YM_SecretId:secretId];
    //使用前先初始化一下插屏
    [YouMiNewSpot initYouMiDeveLoperSpot:kSPOTSpotTypePortrait];//填上你对应的横竖屏模式
    
    self.window=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor clearColor];
    [self.window makeKeyAndVisible];
    
    [self mainView];
    
    return YES;
}

- (void) mainView{
    MainController * mc = [[MainController alloc] init];
    self.window.rootViewController = mc;
}

- (void) gameView{
    ViewController * vc=[[ViewController alloc] init];
    self.window.rootViewController=vc;
}

- (void)LevelSceneView{
    LevelSceneController * lsc = [[LevelSceneController alloc]init];
    self.window.rootViewController = lsc;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

//
//  LevelSceneController.m
//  LinkDemo
//
//  Created by 丁博洋 on 15/6/1.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "LevelSceneController.h"
#import "AppDelegate.h"
#import "UserDefaultsUtils.h"
#import "DBYPass.h"

#define YML_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define YML_SYSTEM_VERSION_GREATER_LESS_THEN(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == kCFCompareLessThan)

@interface LevelSceneController ()


@end

@implementation LevelSceneController

@synthesize backBtn;

AppDelegate * appDelegate;
//游戏背景
UIImageView * bgImgView;
//水平视图背景
UIImageView * levelImgView;
//标题图片
UIImageView * selectImgView;

MSGridView * levelGridView;
NSArray *passArray;

- (void)viewDidLoad {
    [super viewDidLoad];
     appDelegate =[UIApplication sharedApplication].delegate;
    
    NSData* data  = [UserDefaultsUtils valueWithKey:@"PASSARRAY"];
    passArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];

    CGRect frame = [self getApplicationRealBounds ];
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height;
    
    // 使用Default作为游戏背景图片
    bgImgView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Default"]];
    bgImgView.frame = frame;
    [self.view addSubview:bgImgView];
    
    levelImgView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"level_bg.png"]];
    levelImgView.frame = CGRectMake(40, 150, width-80, height-250);
    [self.view addSubview:levelImgView];
    
    selectImgView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"select_CN.png"]];
    selectImgView.frame = CGRectMake(50, 115, width-100, 50);
    [self.view addSubview:selectImgView];
    
    backBtn = [[UIButton alloc] initWithFrame:CGRectMake(35, 120, 40, 40)];
    backBtn.tag=101;
    // 为backBtn按钮设置图片
    [self.backBtn setBackgroundImage:[UIImage imageNamed:@"btnBack"]
                             forState:UIControlStateNormal];
    [self.backBtn setBackgroundImage:[UIImage imageNamed:@"btnBack_hover"]
                             forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    
    levelGridView= [[MSGridView alloc] initWithFrame:CGRectMake(40, 200, width-100, height-350)];
    //设置Delegate和DataSource：
    levelGridView.gridViewDelegate = self;
    levelGridView.gridViewDataSource = self;
    levelGridView.pagingEnabled=YES;
    [levelGridView setInnerSpacing:CGSizeMake(20, 0)];
    [self.view addSubview:levelGridView];
    
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



-(MSGridViewCell *)cellForIndexPath:(NSIndexPath*)indexPath inGridWithIndexPath:(NSIndexPath *)gridIndexPath;
{
    //DLog(@"%@",indexPath);
    //为单元格定一个静态字符串作为标识符
    static NSString *reuseIdentifier = @"cellId";
    MSGridViewCell *cell = [MSGridView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if(cell == nil) {
        cell = [[MSGridViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:reuseIdentifier];
    }

    DBYPass * pass= (DBYPass*)passArray[indexPath.row];
    DLog(@"%li",(long)indexPath.section);

    UIButton * uiBtn=[[UIButton alloc] initWithFrame:CGRectMake(10, 10, 45, 45)];
    uiBtn.tag=[pass.passId intValue];
    if ([pass.passId intValue]<=3 && gridIndexPath.row==0 && indexPath.section==0) {
        [uiBtn setTitle:[pass.passId stringValue] forState:UIControlStateNormal];
        [uiBtn setBackgroundImage:[UIImage imageNamed:@"pass0.png"]
                         forState:UIControlStateNormal];
    }else{
         uiBtn.enabled=NO;
        [uiBtn setBackgroundImage:[UIImage imageNamed:@"pass1.png"]
                         forState:UIControlStateNormal];
    }
    [uiBtn addTarget:self action:@selector(onClick:)
           forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:uiBtn];
    return cell;
    
}

- (void)onClick:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    switch (btn.tag) {
        case 1:
            count=0;
            [appDelegate gameView];
            break;
        case 2:
            count=1;
            [appDelegate gameView];
            break;
        case 3:
            count=2;
            [appDelegate gameView];
            break;
        case 101:
            [appDelegate mainView];
            break;
        default:
            break;
    }
}
// 返回的行数
-(NSUInteger)numberOfGridRows
{
    return 1;
}

// 返回的列数
-(NSUInteger)numberOfGridColumns
{
    return 10;
}


-(NSUInteger)numberOfColumnsForGridAtIndexPath:(NSIndexPath*)indexPath
{
    
    return 5;
}

-(NSUInteger)numberOfRowsForGridAtIndexPath:(NSIndexPath*)indexPath
{
    return 5;
}

//-(void)didSelectCellWithIndexPath:(NSIndexPath*) indexPath
//{
//    
//    int index = (int)[indexPath indexAtPosition:2]+(int)[indexPath indexAtPosition:3];
//    NSLog(@"index: %i",index);
//    
//    [[[UIAlertView alloc] initWithTitle:@"Tapped" message:[NSString stringWithFormat:@"You tapped cell %i in grid (%lu,%lu)",index,(unsigned long)[indexPath indexAtPosition:0],(unsigned long)[indexPath indexAtPosition:1]] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  DBYGameView.h
//  LinkDemo
//
//  Created by SYETC02 on 15/5/26.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "DBYGameService.h"
#import "DBYLinkInfo.h"
#import "DBYPiece.h"

@class DBYGameView;
//定义一个协议
@protocol DBYGameViewDelegate <NSObject>
- (void) checkWin: (DBYGameView*)gameView;
@end

@interface DBYGameView : UIView

// 游戏逻辑的实现类
@property (nonatomic, strong) DBYGameService* gameService;  //①
// 连接信息对象
@property (nonatomic, strong) DBYLinkInfo* linkInfo;
// 保存当前已经被选中的方块
@property (nonatomic, strong) DBYPiece* selectedPiece;
@property (nonatomic, strong) id<DBYGameViewDelegate> delegate;
// 开始游戏方法
- (void) startGame;
// 随机出现
- (void)randomOccurrence;
// 炸掉相同的
- (BOOL)bombIdentical;
// 查找相同的
- (void)searchIdentical;
@end

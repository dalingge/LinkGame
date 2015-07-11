//
//  DBYGameService.h
//  LinkDemo
//
//  Created by SYETC02 on 15/5/26.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBYPiece.h"
#import "DBYLinkInfo.h"

@interface DBYGameService : NSObject

@property (nonatomic , strong) NSArray* pieces;
/**
 * 控制游戏开始的方法
 */
- (void) start;
/**
 * 重新随机排列顺序
 */
- (void) random;
/**
 * 判断参数FKPiece二维数组中是否还存在非空的FKPiece对象
 * @return 如果还剩FKPiece对象返回YES, 没有返回NO
 */
- (BOOL) hasPieces;
/**
 * 根据触碰点的X座标和Y坐标, 查找出一个FKPiece对象
 * @param touchX 触碰点的X坐标
 * @param touchY 触碰点的Y坐标
 * @return 返回对应的FKPiece对象, 没有返回nil
 */
- (DBYPiece*) findPieceAtTouchX:(CGFloat) touchX touchY:(CGFloat) touchY;
/**
 * 判断两个FKPiece是否可以相连, 可以连接, 返回FKLinkInfo对象
 * @param p1 第一个FKPiece对象
 * @param p2 第二个FKPiece对象
 * @return 如果可以相连，返回FKLinkInfo对象, 如果两个FKPiece不可以连接, 返回nil
 */
- (DBYLinkInfo*) linkWithBeginPiece:(DBYPiece*)p1 endPiece: (DBYPiece*) p2;


@end

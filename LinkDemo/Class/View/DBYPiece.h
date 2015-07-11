//
//  DBYPiece.h
//  LinkDemo
//
//  Created by SYETC02 on 15/5/26.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBYPieceImage.h"
#import "DBYPoint.h"

@interface DBYPiece : NSObject
@property (nonatomic , strong) DBYPieceImage* image;
// 该方块的左上角的x坐标
@property (nonatomic , assign) NSInteger beginX;
// 该方块的左上角的y坐标
@property (nonatomic , assign) NSInteger beginY;
// 该对象在FKPiece二维数组中第一维的索引值
@property (nonatomic , assign) NSInteger indexX;
// 该对象在FKPiece二维数组中第二维的索引值
@property (nonatomic , assign) NSInteger indexY;
- (id)initWithIndexX:(NSInteger) indexX indexY:(NSInteger)indexY;
// 获取该FKPiece的中心
- (DBYPoint*) getCenter;
// 判断两个FKPiece上的图片是否相同
- (BOOL) isEqual:(DBYPiece*) other;
@end

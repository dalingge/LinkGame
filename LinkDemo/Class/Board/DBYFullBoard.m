//
//  DBYFullBoard.m
//  LinkDemo
//
//  Created by SYETC02 on 15/5/26.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "DBYFullBoard.h"
#import "DBYPiece.h"

@implementation DBYFullBoard

- (NSArray*) createPieces: (NSArray*) pieces
{
    // 创建一个NSMutableArray, 该集合里面存放初始化游戏时所需的DBYPiece对象
    NSMutableArray* notNullPieces = [[NSMutableArray alloc] init];
    // i从1开始、小于pieces.count - 1，用于控制最上、最下一行不放方块
    for (int i = 1; i <=pieces.count - 1 ; i++)
    {
        // i从1开始、小于pieces.count - 1，用于控制最左、最右一列不放方块
        for (int j = 1; j <=[[pieces objectAtIndex:i] count] - 1; j++)
        {
            // 先构造一个DBYPiece对象, 只设置它在DBYPiece二维数组中的索引值，
            // 所需要的DBYPieceImage由其父类负责设置。
            DBYPiece * piece = [[DBYPiece alloc] initWithIndexX:i indexY:j];
            // 添加到DBYPiece集合中
            [notNullPieces addObject:piece];
        }
    }
    return notNullPieces;
}

@end

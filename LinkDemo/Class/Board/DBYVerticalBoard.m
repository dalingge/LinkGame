//
//  DBYVerticalBoard.m
//  LinkDemo
//
//  Created by SYETC02 on 15/5/26.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "DBYVerticalBoard.h"
#import "DBYPiece.h"

@implementation DBYVerticalBoard

- (NSArray*) createPieces:(NSArray*) pieces
{
    // 创建一个NSMutableArray集合, 该集合里面存放初始化游戏时所需的DBYPiece对象
    NSMutableArray* notNullPieces = [[NSMutableArray alloc] init];
    for (int i = 0; i < pieces.count; i++)
    {
        for (int j = 0; j < [[pieces objectAtIndex:i] count]; j++)
        {
            // 加入判断, 符合一定条件才去构造DBYPiece对象, 并加到集合中
            // 如果i能被2整除, 即单数列不会创建方块
            if (i % 2 == 0)
            {
                // 先构造一个DBYPiece对象, 只设置它在DBYPiece二维数组中的索引值，
                // 所需要的DBYPieceImage由其父类负责设置。
                DBYPiece* piece = [[DBYPiece alloc] initWithIndexX:i indexY:j];
                // 添加到DBYPiece集合中
                [notNullPieces addObject:piece];
            }
        }
    }
    return notNullPieces;
}

@end

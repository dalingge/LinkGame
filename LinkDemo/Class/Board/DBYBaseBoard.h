//
//  DBYBaseBoard.h
//  LinkDemo
//
//  Created by SYETC02 on 15/5/26.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  基本的面板逻辑
 */
@interface DBYBaseBoard : NSObject
//存放方块的集合
- (NSArray*) createPieces:(NSArray*)pieces;
- (NSArray*) create;


@end

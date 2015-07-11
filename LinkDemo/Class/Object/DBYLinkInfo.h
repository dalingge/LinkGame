//
//  DBYLinkInfo.h
//  LinkDemo
//
//  Created by SYETC02 on 15/5/26.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBYPoint.h"
/**
 *  处理方块之间的连接信息
 */
@interface DBYLinkInfo : NSObject
// 定义一个NSMutableArray 用于保存连接点
@property (nonatomic ,strong) NSMutableArray * points;
//二个连接点
- (id)initWithP1:(DBYPoint*)p1 p2:(DBYPoint*)p2;
//三个连接点
- (id)initWithP1:(DBYPoint*)p1 p2:(DBYPoint*)p2 p3:(DBYPoint*)p3;
//四个连接点
- (id)initWithP1:(DBYPoint*)p1 p2:(DBYPoint*)p2 p3:(DBYPoint*)p3 p4:(DBYPoint*)p4;
@end

//
//  DBYLinkInfo.m
//  LinkDemo
//
//  Created by SYETC02 on 15/5/26.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "DBYLinkInfo.h"

@implementation DBYLinkInfo
// 提供第一个初始化方法, 表示两个FKPoint可以直接相连, 没有转折点
- (id)initWithP1:(DBYPoint*)p1 p2:(DBYPoint*)p2
{
    self = [super init];
    if (self) {
        _points = [[NSMutableArray alloc] init];
        [_points addObject:p1];
        [_points addObject:p2];
    }
    return self;
}
// 提供第二个初始化方法, 表示三个FKPoint可以相连, p2是p1与p3之间的转折点
- (id)initWithP1:(DBYPoint*)p1 p2:(DBYPoint*)p2 p3:(DBYPoint*)p3
{
    self = [super init];
    if (self) {
        _points = [[NSMutableArray alloc] init];
        [_points addObject:p1];
        [_points addObject:p2];
        [_points addObject:p3];
    }
    return self;
}
// 提供第三个初始化方法, 表示四个FKPoint可以相连, p2, p3是p1与p4的转折点
- (id)initWithP1:(DBYPoint*)p1 p2:(DBYPoint*)p2 p3:(DBYPoint*)p3 p4:(DBYPoint*)p4
{
    self = [super init];
    if (self) {
        _points = [[NSMutableArray alloc] init];
        [_points addObject:p1];
        [_points addObject:p2];
        [_points addObject:p3];
        [_points addObject:p4];
    }
    return self;
}
@end

//
//  DBYPoint.m
//  LinkDemo
//
//  Created by SYETC02 on 15/5/26.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "DBYPoint.h"

@implementation DBYPoint 

- (id)initWithX:(NSInteger)x y:(NSInteger)y
{
    self = [super init];
    if (self) {
        _x = x;
        _y = y;
    }
    return self;
}
- (id)copyWithZone:(NSZone *)zone
{
    // 复制一个对象
    DBYPoint* newPt = [[[self class] allocWithZone:zone] init];
    // 将被复制对象的实变量的值赋给新对象的实例变量
    newPt->_x = _x;
    newPt->_y = _y;
    return newPt;
}
- (BOOL)isEqual:(DBYPoint*)other
{
    return _x == other.x && _y == other.y;
}
- (NSUInteger) hash
{
    return _x * 31 + _y;
}
- (NSString*)description
{
    return [NSString stringWithFormat:@"{x=%ld, y=%ld}" , (long)_x , _y];
}
@end

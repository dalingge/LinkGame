
//
//  DBYPiece.m
//  LinkDemo
//
//  Created by SYETC02 on 15/5/26.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "DBYPiece.h"


@implementation DBYPiece

- (id)initWithIndexX:(NSInteger) indexX indexY:(NSInteger)indexY
{
    self = [super init];
    if (self) {
        _indexX = indexX;
        _indexY = indexY;
    }
    return self;
}
// 获取该FKPiece的中心
- (DBYPoint*) getCenter
{
    //_beginX当前的坐标
    return [[DBYPoint alloc] initWithX :self.image.image.size.width / 2 + _beginX
                                     y: self.image.image.size.height / 2 + _beginY];
}
// 判断两个FKPiece上的图片是否相同
- (BOOL) isEqual:(DBYPiece*) other
{
    if (self.image == nil)
    {
        if (other.image != nil)
            return NO;
    }
    // 只要FKPiece封装图片ID相同，即可认为两个FKPiece相等。
    return self.image.imageId == other.image.imageId;
}
@end

//
//  DBYPoint.h
//  LinkDemo
//
//  Created by SYETC02 on 15/5/26.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  定义一个代表屏幕上点的FKPoint，它包含x、y两个属性
 */
@interface DBYPoint : NSObject<NSCopying>
@property (nonatomic, assign) NSInteger x;
@property (nonatomic, assign) NSInteger y;
- (id)initWithX:(NSInteger)x y:(NSInteger)y;
@end

//
//  DBYImageUitl.h
//  LinkDemo
//
//  Created by SYETC02 on 15/5/26.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  图片工具类
 */
@interface DBYImageUitl : NSObject
/**
 *  获取连连看所有图片的ID（约定所有图片ID以p_开头）
 *
 *  @return 图片名集合
 */
+ (NSArray*) imageValues;
/**
 *  随机从sourceValues的集合中获取size个图片ID, 返回结果为图片ID的集合
 *
 *  @param sourceValues 从中获取的集合
 *  @param size         需要获取的个数
 *
 *  @return size个图片ID的集合
 */
+ (NSMutableArray*) getRandomValues :(NSArray*)sourceValues :(NSInteger)size;
/**
 *  随机获取size个图片资源ID(以p_为前缀的资源名称), 其中size为游戏数量
 *
 *  @param size 需要获取的图片ID的数量
 *
 *  @return size个图片ID的集合
 */
+ (NSArray*) getPlayValues :(NSInteger) size;

/**
 *  随机获取size个图片资源包装成的FKPieceImage对象
 *
 *  @param size 需要获取的图片的数量
 *
 *  @return size个图片包装成的FKPieceImage对象的集合
 */
+ (NSArray*) getPlayImages :(NSInteger) size;
@end

//
//  DBYPieceImage.h
//  LinkDemo
//
//  Created by SYETC02 on 15/5/26.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  方块图片类
 */
@interface DBYPieceImage : NSObject
//图片
@property (nonatomic, strong) UIImage* image;
//图片编号
@property (nonatomic, copy) NSString* imageId;
//图片初始化方法
- (id)initWithImage:(UIImage*)image imageId:(NSString*)imageId;
@end

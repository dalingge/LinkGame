//
//  DBYPieceImage.m
//  LinkDemo
//
//  Created by SYETC02 on 15/5/26.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "DBYPieceImage.h"

@implementation DBYPieceImage

- (id)initWithImage:(UIImage*)image imageId:(NSString*)imageId
{
    self = [super init];
    if (self) {
        _image = image;
        _imageId = [imageId copy];
    }
    return self;
}
@end

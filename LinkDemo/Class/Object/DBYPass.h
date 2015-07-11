//
//  DBYPass.h
//  LinkDemo
//
//  Created by SYETC02 on 15/6/2.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBYPass : NSObject<NSCoding,NSCopying>

@property(strong,nonatomic) NSNumber * passId;
@property(strong,nonatomic) NSNumber * isPass;

@end

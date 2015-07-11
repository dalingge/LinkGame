//
//  DBYPass.m
//  LinkDemo
//
//  Created by SYETC02 on 15/6/2.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "DBYPass.h"

@implementation DBYPass

@synthesize passId;
@synthesize isPass;

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.passId forKey:@"passId"];
    [aCoder encodeObject:self.isPass forKey:@"isPass"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    
    if(self = [super init])
    {
        self.passId = [aDecoder decodeObjectForKey:@"passId"];
        self.isPass = [aDecoder decodeObjectForKey:@"isPass"];

    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone{
    return  self;
}
@end

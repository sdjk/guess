//
//  XFPEdificeMode.m
//  猜古建
//
//  Created by Hsiao on 16/9/1.
//  Copyright © 2016年 HS. All rights reserved.
//

#import "XFPEdificeMode.h"

@implementation XFPEdificeMode

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)edificeWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

+ (NSArray *)edificeModes
{
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"edifice" ofType:@"plist"]];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array)
    {
        [arrayM addObject:[self edificeWithDictionary:dict]];
    }
    return arrayM;
}

@end

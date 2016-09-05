//
//  XFPEdificeMode.m
//  猜古建
//
//  Created by Hsiao on 16/9/1.
//  Copyright © 2016年 HS. All rights reserved.
//

#import "XFPEdificeMode.h"

@implementation XFPEdificeMode

// 打乱顺序
- (void)randomOptions
{
    self.options = [self.options sortedArrayUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2)
    {
        int seed = arc4random_uniform(2);
        if (seed)
        {
            return [str1 compare:str2];
        }
        else
        {
            return [str2 compare:str1];
        }
        
    }];
}


- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
        
        // 进行乱序
        [self randomOptions];
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

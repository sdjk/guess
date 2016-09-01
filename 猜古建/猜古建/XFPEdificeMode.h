//
//  XFPEdificeMode.h
//  猜古建
//
//  Created by Hsiao on 16/9/1.
//  Copyright © 2016年 HS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFPEdificeMode : NSObject

@property (nonatomic, copy) NSString *answer;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSArray *options;


- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)edificeWithDictionary:(NSDictionary *)dict;
+ (NSArray *)edificeModes;

@end

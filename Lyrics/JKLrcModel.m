//
//  JKLrcModel.m
//  Lyrics
//
//  Created by 宋旭 on 16/4/5.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "JKLrcModel.h"

@implementation JKLrcModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)JKLrcModelWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end

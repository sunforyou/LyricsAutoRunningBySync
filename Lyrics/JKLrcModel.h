//
//  JKLrcModel.h
//  Lyrics
//
//  Created by 宋旭 on 16/4/5.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKLrcModel : NSObject

@property (nonatomic, copy) NSString *music;

@property (nonatomic, copy) NSString *lyric;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)JKLrcModelWithDict:(NSDictionary *)dict;

@end

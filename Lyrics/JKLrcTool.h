//
//  JKLrcTool.h
//  Lyrics
//
//  Created by 宋旭 on 16/3/31.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKLrcModel.h"

@interface JKLrcTool : NSObject

/**
 * 加载plist文件中的模型
 */
@property (nonatomic, strong) NSMutableArray *arrayForContent;

/**
 * 解析歌词
 */
- (NSInteger)parseLrcAtIndex:(NSInteger)index withCurrentTime:(double)currentTime;

/**
 * 获取歌曲播放路径
 */
- (NSURL *)getMusicURL:(NSInteger)index;

/**
 * 时间
 */
@property (nonatomic,copy) NSMutableArray *timeArray;

/**
 * 歌词
 */
@property (nonatomic,copy) NSMutableArray *wordArray;

@end

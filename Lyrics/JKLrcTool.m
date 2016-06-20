//
//  JKLrcTool.m
//  Lyrics
//
//  Created by 宋旭 on 16/3/31.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "JKLrcTool.h"


@implementation JKLrcTool

- (instancetype)init
{
    self = [super init];
    if (self) {
        _timeArray = [NSMutableArray array];
        _wordArray = [NSMutableArray array];
    }
    return self;
}

- (NSMutableArray *)arrayForContent {
    
    if (!_arrayForContent) {
        
        _arrayForContent = [NSMutableArray array];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"JKLrc" ofType:@"plist"];
        
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        
        for (NSDictionary *dict in array) {
            JKLrcModel *model = [JKLrcModel JKLrcModelWithDict:dict];
            [_arrayForContent addObject:model];
        }
        [_arrayForContent copy];
    }
    return _arrayForContent;
}

- (NSInteger)parseLrcAtIndex:(NSInteger)index withCurrentTime:(double)currentTime {
    
    JKLrcModel *model = self.arrayForContent[index];
    
    NSString *content = [NSString stringWithContentsOfFile:
                         [[NSBundle mainBundle] pathForResource:model.lyric
                                                         ofType:@"lrc"]
                                                  encoding:NSUTF8StringEncoding
                                                     error:nil];
    
    NSArray *sepArray = [content componentsSeparatedByString:@"["];
    
    for (int i = 5; i < sepArray.count; i++) {
        
        NSArray *arr = [sepArray[i] componentsSeparatedByString:@"]"];
        
        [self.timeArray addObject:arr[0]];
        [self.wordArray addObject:arr[1]];
        
    }
    
    NSInteger currentRow = 0;
    for (int j = 0; j < self.timeArray.count; j++) {
        
        NSInteger index = (j + 1) % self.timeArray.count;
        NSArray *arr = [self.timeArray[j] componentsSeparatedByString:@":"];
        NSArray *arrM = [self.timeArray[index] componentsSeparatedByString:@":"];
        
        double startTime = [arr[0] integerValue] * 60 + [arr[1] floatValue];
        double endTime = [arrM[0] integerValue] * 60 + [arrM[1] floatValue];
        
        if (currentTime > startTime)
        {
            if (currentTime < endTime) {
                currentRow = j;
            }
        }
        else
        {
            break;
        }
    }
    return currentRow;
}

- (NSURL *)getMusicURL:(NSInteger)index {
    
    JKLrcModel *model = self.arrayForContent[index];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:model.music ofType:@"wmv"];
    
    NSURL *url = [NSURL fileURLWithPath:path];
    
    return url;
}

@end

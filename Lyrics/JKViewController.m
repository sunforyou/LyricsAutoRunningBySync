//
//  JKViewController.m
//  Lyrics
//
//  Created by 宋旭 on 16/3/31.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "JKViewController.h"

static const NSInteger kMusicNumber = 0;

@interface JKViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation JKViewController

- (JKLrcTool *)lrcTool {
    
    if (!_lrcTool) {
        
        _lrcTool = [[JKLrcTool alloc] init];
    }
    return _lrcTool;
}

- (AVAudioPlayer *)player {
    if (!_player) {
        
        NSURL *url = [self.lrcTool getMusicURL:kMusicNumber];
        
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    }
    return _player;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupPlayer];
    
    //侦听当前时间
    [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(updateTime)
                                   userInfo:nil
                                    repeats:YES];
    
    [self setupMainView];
    
}
/**
 * 设置player
 */
- (void)setupPlayer {
    
    //声道
    _player.pan = 0;
    
    //音量:0~1
    _player.volume = 1;
    
    //单曲循环
    _player.numberOfLoops = -1;
    
}

/**
 * 更新时间轴
 */
- (void)updateTime {

    //当前播放进度
    NSInteger currentTime = _player.currentTime;
    _currentTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld",
                              currentTime / 60, currentTime % 60];
    //总时长
    NSInteger totalSeconds = _player.duration;
    _totalTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld",
                            totalSeconds / 60, totalSeconds % 60];
    
    _timeSlider.value = self.player.currentTime / totalSeconds;
    
    [self.lrcTableView reloadData];
    
    _currentRow = [_lrcTool parseLrcAtIndex:kMusicNumber withCurrentTime:currentTime];
    
    if ( _currentRow > 0 ) {
        
        NSIndexPath *path = [NSIndexPath indexPathForRow:_currentRow inSection:0];
        
        [self.lrcTableView scrollToRowAtIndexPath:path
                                 atScrollPosition:UITableViewScrollPositionMiddle
                                         animated:YES];
    }
}

/**
 * 初始化音乐播放器
 */
- (void)setupMainView {
    
    [self.lrcTableView registerClass:[UITableViewCell class] forCellReuseIdentifier: @"CELL"];
    
    self.lrcTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.lrcTableView reloadData];
}

/**
 * 播放/暂停按钮
 */
- (IBAction)playBtnClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        [_player prepareToPlay];
        [_player play];
    }else{
        [_player pause];
    }
}

/**
 * 进度条
 */
- (IBAction)valueChange:(UISlider *)sender {
    _player.currentTime = _player.duration * sender.value;
}

#pragma mark - TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.lrcTool.wordArray.count - 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    
    if (indexPath.row == _currentRow)
    {
        cell.textLabel.textColor = [UIColor redColor];
    }
    else
    {
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    cell.backgroundColor = [UIColor lightGrayColor];
    
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    cell.textLabel.text = self.lrcTool.wordArray[indexPath.row];
    
    return cell;
}

@end

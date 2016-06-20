//
//  JKViewController.h
//  Lyrics
//
//  Created by 宋旭 on 16/3/31.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKLrcTool.h"
#import <AVFoundation/AVFoundation.h>

@interface JKViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *lrcTableView;

@property (weak, nonatomic) IBOutlet UISlider *timeSlider;

@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;

@property (nonatomic, assign) NSInteger currentRow;

@property (nonatomic, strong) JKLrcTool *lrcTool;

@property (nonatomic, strong) AVAudioPlayer *player;

- (IBAction)playBtnClick:(UIButton *)sender;

- (IBAction)valueChange:(UISlider *)sender;


@end

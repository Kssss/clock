//
//  WorkclockViewController.m
//  STClockDemo
//
//  Created by zhenlintie on 15/7/27.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import "WorkclockViewController.h"
#import "STSystemClockView.h"
#import <AVFoundation/AVFoundation.h>

@interface WorkclockViewController ()

@property (strong, nonatomic) STSystemClockView *clockView;

@property (strong, nonatomic) UIButton *leftButton;
@property (strong, nonatomic) UIButton *rightButton;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@end

@implementation WorkclockViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        self.title = @"世界时钟";
    }
    return self;
}

- (void)loadView{
    [super loadView];
    self.leftButton = [UIButton infoTypeButton];
    [self.topBar addSubview:_leftButton];
    self.rightButton = [UIButton addTypeButton];
    _rightButton.right = self.topBar.width;
    [self.topBar addSubview:_rightButton];
    
    self.clockView = [[STSystemClockView alloc] initWithFrame:self.view.bounds];
    [self.view insertSubview:self.clockView belowSubview:self.topBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 1.加载本地的音乐文件
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"秒针嘀嗒声.mp3" withExtension:nil];
    // 2. 创建音乐播放对象
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    // 3.准备播放 (音乐播放的内存空间的开辟等功能)  不写这行代码直接播放也会默认调用prepareToPlay
    [self.audioPlayer prepareToPlay];
    self.audioPlayer.numberOfLoops = 100;
    [self.audioPlayer play];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.clockView.frame = self.view.bounds;
}

#pragma mark - transition

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.clockView willShow];
}

- (void)transitionToHide:(void (^)())completion{
    [_clockView transitionToHide:completion];
    [@[self.titleLabel, self.leftButton, self.rightButton] alphaTo:0 duration:STCLOCK_ALPHA_ANIMATION_DURATION completion:nil];
}

- (void)transitionToShow:(void (^)())completion{
    [_clockView transitionToShow:completion];
    [@[self.titleLabel, self.leftButton, self.rightButton] alphaTo:1 duration:STCLOCK_ALPHA_ANIMATION_DURATION completion:nil];
}

#pragma mark - tabbar item

- (STTabbarButton *)tabbarButtonItem{
    STTabbarButton *item = [super tabbarButtonItem];
    item.image = [UIImage imageNamed:@"icon_worldclock_off"];
    item.selectedImage = [UIImage imageNamed:@"icon_worldclock_on"];
    return item;
}

@end

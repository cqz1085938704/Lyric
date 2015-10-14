//
//  LyricView.h
//  Lyric
//
//  Created by caiyao's Mac on 15/8/6.
//  Copyright (c) 2015年 core's Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Line.h"
#import <AVFoundation/AVFoundation.h>

@protocol LyricDelegate <NSObject>

- (void)didFinishPlaying;

@end

@interface LyricView : UITableView<UITableViewDataSource, UITableViewDelegate, AVAudioPlayerDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) id<LyricDelegate>lyricDelegate;

- (void)updateLyricWithFileName:(NSString *)lyricFileName musicFileName:(NSString *)musicFileName;

@end

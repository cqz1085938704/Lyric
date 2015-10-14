//
//  ViewController.h
//  Lyric
//
//  Created by caiyao's Mac on 15/8/6.
//  Copyright (c) 2015年 core's Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LyricView.h"
#import "HTTPConnectionUtility.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "CustomCell.h"
#import "ImageViewController.h"

@interface lyricViewController : UIViewController<LyricDelegate, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;
@property (nonatomic, strong) NSArray *musics;
@property (weak, nonatomic) IBOutlet LyricView *lyricView;
@property (weak, nonatomic) IBOutlet UIButton *btnPlayMusic;
@property (nonatomic, copy) NSString *musicFileName;
@property (weak, nonatomic) IBOutlet UISlider *slider;

- (IBAction)slider:(UISlider *)sender;
- (IBAction)actionPreviousMusic:(UIButton *)sender;
- (IBAction)actionPlayMusic:(UIButton *)sender;
- (IBAction)actionNextMusic:(UIButton *)sender;

@end


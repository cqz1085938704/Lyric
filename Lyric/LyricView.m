//
//  LyricView.m
//  Lyric
//
//  Created by caiyao's Mac on 15/8/6.
//  Copyright (c) 2015年 core's Mac. All rights reserved.
//

#import "LyricView.h"

@interface LyricView ()
{
    NSMutableArray *lines;
    NSInteger currentIndex;
    BOOL forbiden;
}
@end

@implementation LyricView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setup];
}

- (void)setup
{
    //self.scrollEnabled = NO;
    forbiden = NO;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.dataSource = self;
    self.delegate = self;

    if (!self.displayLink)
    {
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(action:)];
        [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

-(void)updateLyricWithFileName:(NSString *)lyricFileName musicFileName:(NSString *)musicFileName
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:musicFileName withExtension:@"mp3"];

    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    self.audioPlayer.delegate = self;
    if ([self.audioPlayer prepareToPlay])
    {
        [self.audioPlayer play];
    }
    
    NSString *lyricFilePath = [[NSBundle mainBundle] pathForResource:lyricFileName ofType:@"lrc"];
    NSString *lyric = [NSString stringWithContentsOfFile:lyricFilePath encoding:NSUTF8StringEncoding error:nil];
    NSArray *components = [lyric componentsSeparatedByString:@"\n"];
    
    lines = [NSMutableArray arrayWithCapacity:1];
    
    for (NSString *str in components)
    {
        if ([str containsString:@"[ti"] || [str containsString:@"[ar"] || [str containsString:@"al"] || [str isEqualToString:@""])
        {
            continue;
        }
        
        NSArray *arr = [str componentsSeparatedByString:@"]"];
        NSString *time = [arr[0] substringFromIndex:1];
        NSString *text = [arr lastObject];
        
        Line *line = [[Line alloc] init];
        line.time = [self calTime:time];
        line.text = text;
        
        [lines addObject:line];
    }
    
    [self reloadData];
}

-(NSTimeInterval)calTime:(NSString *)time
{
    // 00:03.82
    NSTimeInterval total = 0;
    NSArray *arr = [time componentsSeparatedByString:@":"];
    NSString *min = arr[0];
    NSArray *arr2 = [[arr lastObject] componentsSeparatedByString:@"."];
    NSString *sec = [arr2 objectAtIndex:0];
    NSString *miliSec = [arr2 lastObject];
    
    total = (double)[min integerValue] * 60 + (double)[sec integerValue] + (double)[miliSec integerValue]/1000;
    
    return total;
}

- (void)action:(CADisplayLink *)sender
{
    for (Line *line in lines)
    {
        NSInteger index = [lines indexOfObject:line];
        
        double lineTime = line.time;
        double currentTime = self.audioPlayer.currentTime;
        
        Line *nextLine = nil;
        if ((index + 1) < lines.count)
        {
            nextLine = lines[index + 1];
        }
        double nextTime = nextLine.time;
        
        if (!(lineTime > currentTime) && !(currentTime > nextTime))
        {
            currentIndex = index;
            
            if (!forbiden)
            {
                [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            }
            
            [self reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                    
            break;
        }
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return lines.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (currentIndex == indexPath.row)
    {
        cell.textLabel.textColor = [UIColor redColor];
    }
    else
    {
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    Line *line = lines[indexPath.row];
    cell.textLabel.text = line.text;
    
    return cell;
}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (flag)
    {
        if (_lyricDelegate && [_lyricDelegate respondsToSelector:@selector(didFinishPlaying)])
        {
            [_lyricDelegate didFinishPlaying];
        }
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    forbiden = YES;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.audioPlayer setCurrentTime:self.contentOffset.y * self.audioPlayer.duration/self.contentSize.height];
    [self.displayLink setPaused:NO];
    forbiden = NO;
}

@end

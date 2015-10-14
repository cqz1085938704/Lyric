//
//  ViewController.m
//  Lyric
//
//  Created by caiyao's Mac on 15/8/6.
//  Copyright (c) 2015年 core's Mac. All rights reserved.
//

#import "lyricViewController.h"

#define WIN_SIZE [UIScreen mainScreen].bounds.size

@interface lyricViewController ()
{
    NSInteger index;
    ALAssetsLibrary *library;
    NSMutableArray *images;
    UIPageControl *pageControl;
    UIScrollView *scrollView;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation lyricViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    self.lyricView.lyricDelegate = self;
//    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateSliderValue) userInfo:nil repeats:YES];
//    
//    self.musics = @[@"235319", @"255319", @"309769", @"339744", @"10405520", @"10736444", @"12309111", @"14945107", @"120125029"];
//    
//    [self.lyricView updateLyricWithFileName:self.musics[0] musicFileName:self.musics[0]];
//    index = 0;
//    [self setDuration];
    
//    NSMutableURLRequest *request = [HTTPConnectionUtility createFormRequestWithURLString:@"https://120.24.70.17:8443/staff/news/listNewsActivitys" requestParametersInfo:@{@"pager.pageNo":@"1", @"pager.pageSize":@"5", @"type":@"newsroom"} requestMethod:@"POST" needHSBCHeader:NO];
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        
//        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//        NSLog(@"%@", result);
//        
//        scrollView
//    }];

    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIN_SIZE.width, WIN_SIZE.height)];
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    //scrollView.showsVerticalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(WIN_SIZE.width * 30, WIN_SIZE.height);
    scrollView.bounces = YES;
    //scrollView.directionalLockEnabled = YES;
    scrollView.pagingEnabled = YES;
    scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:scrollView];
    
    for (int i = 0; i < 10; i ++)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i * WIN_SIZE.width, 0, WIN_SIZE.width, WIN_SIZE.height)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:25];
        label.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
        label.text = [NSString stringWithFormat:@"第%i页", i];
        [scrollView addSubview:label];
    }
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    pageControl.numberOfPages = 10;
    pageControl.center = CGPointMake(self.view.center.x, WIN_SIZE.height - 40);
    [pageControl addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    pageControl.userInteractionEnabled = YES;
    [self.view addSubview:pageControl];
    
    
    
    
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
//    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.apple.com"]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        
//        NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
//        
//    }];
//    
//    images = [NSMutableArray arrayWithCapacity:1];
//    library = [[ALAssetsLibrary alloc] init];
//    [library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
//        
//        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
//            
//            UIImage *image = [[UIImage alloc] initWithCGImage:result.thumbnail];
//            
//            if (image)
//            {
//                [images addObject:image];
//                [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:images.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
//            }
//            
//        }];
//
//    } failureBlock:^(NSError *error) {
//        
//        NSLog(@"%@", error);
//        
//    }];
    
}

//-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
//{
//    
//}

-(void)valueChanged:(UIPageControl *)sender
{
    scrollView.contentOffset = CGPointMake(sender.currentPage * WIN_SIZE.width, 0);
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageControl.currentPage = scrollView.contentOffset.x/320;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return images.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell)
    {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.imageView.image = images[indexPath.row];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage *image = images[indexPath.row];
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ImageViewController *imageViewController = [storyBoard instantiateViewControllerWithIdentifier:@"ImageViewController"];
    imageViewController.title = @"Detail";
    imageViewController.image = image;
    [self.navigationController pushViewController:imageViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateSliderValue
{
    self.slider.value = self.lyricView.audioPlayer.currentTime/self.lyricView.audioPlayer.duration;
    [self updateCurrentTime];
}

- (IBAction)slider:(UISlider *)sender
{
    [self.lyricView.audioPlayer setCurrentTime:sender.value * self.lyricView.audioPlayer.duration];
    
    [self updateCurrentTime];
}

-(void)updateCurrentTime
{
    if (self.lyricView.audioPlayer.duration > 59)
    {
        double minute = self.lyricView.audioPlayer.currentTime/60;
        double sec = (NSInteger)self.lyricView.audioPlayer.currentTime%60;
        self.currentTimeLabel.text = [NSString stringWithFormat:@"%li:%li", (long)minute, (long)sec];
    }
    else
    {
        self.currentTimeLabel.text = [NSString stringWithFormat:@"%li", (long)self.lyricView.audioPlayer.currentTime];
    }
}

-(void)setDuration
{
    double minute = self.lyricView.audioPlayer.duration/60;
    double sec = (NSInteger)self.lyricView.audioPlayer.duration%60;
    self.totalTimeLabel.text = [NSString stringWithFormat:@"%li:%li", (long)minute, (long)sec];
}

- (IBAction)actionPreviousMusic:(UIButton *)sender
{
    index--;
    if ((index) < 0)
    {
        index = self.musics.count - 1;
    }
    [self.lyricView updateLyricWithFileName:self.musics[index] musicFileName:self.musics[index]];
    [self setDuration];
}

- (IBAction)actionPlayMusic:(UIButton *)sender
{
    if (self.lyricView.audioPlayer.playing)
    {
        [self.lyricView.displayLink setPaused:YES];
        [self.lyricView.audioPlayer pause];
        [self.btnPlayMusic setImage:[UIImage imageNamed:@"play@2x"] forState:UIControlStateNormal];
    }
    else
    {
        [self.lyricView.displayLink setPaused:NO];
        [self.lyricView.audioPlayer play];
        [self.btnPlayMusic setImage:[UIImage imageNamed:@"pause@2x"] forState:UIControlStateNormal];
    }
}

-(void)didFinishPlaying
{
    [self actionNextMusic:nil];
    [self setDuration];
}

- (IBAction)actionNextMusic:(UIButton *)sender
{
    index ++;
    if (index > self.musics.count - 1)
    {
        index = 0;
    }
    [self.lyricView updateLyricWithFileName:self.musics[index] musicFileName:self.musics[index]];
    [self setDuration];
}

@end

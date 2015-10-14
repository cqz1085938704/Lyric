//
//  HomeViewController.m
//  Lyric
//
//  Created by caiyao's Mac on 15/8/17.
//  Copyright (c) 2015年 core's Mac. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()
{
    NSArray *musics;
}
@end

@implementation HomeViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return musics.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.imageView.layer.cornerRadius = 10;
    
    return cell;
}
@end

//
//  ViewController.m
//  LSMarqueeView
//
//  Created by WangBiao on 2017/7/19.
//  Copyright © 2017年 LSRain. All rights reserved.
//

#import "ViewController.h"
#import "LSMarqueeView.h"

@interface ViewController ()

@property (nonatomic, strong) LSMarqueeView *marqueeView;

@end

@implementation ViewController


#pragma mark - self Life cycle

- (void)viewDidAppear:(BOOL)animated{
    [self.marqueeView  startCountdown];
}

- (void)viewWillDisappear:(BOOL)animated{
    dispatch_source_cancel(self.marqueeView.timer);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    // >>>>>> dataSorce >>>>>
    NSMutableArray *tempArr = @[].mutableCopy;
    UILabel *labelOne = [UILabel new];
    labelOne.font = [UIFont systemFontOfSize:14];
    labelOne.text = @"☺ 这是一个广告标题1~";
    labelOne.textColor = [UIColor blackColor];
    
    UILabel *labelTwo = [UILabel new];
    labelTwo.font = [UIFont systemFontOfSize:14];
    labelTwo.text = @"☺ 这是一个广告标题2~~";
    labelTwo.textColor = [UIColor blackColor];
    
    UILabel *labelThree = [UILabel new];
    labelThree.font = [UIFont systemFontOfSize:14];
    labelThree.text = @"☺ 这是一个广告标题3~~~";
    labelThree.textColor = [UIColor blackColor];
    
    [tempArr addObject:labelOne];
    [tempArr addObject:labelTwo];
    [tempArr addObject:labelThree];
    // >>>>>> dataSorce >>>>>
    
    self.marqueeView = [[LSMarqueeView alloc] initWithFrame:CGRectMake(10, 100, 354, 60) andLableArr:tempArr];
    [self.view addSubview:self.marqueeView];
    
    self.marqueeView.clickBlock = ^(id sender){
        NSLog(@"sender %@", sender);
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

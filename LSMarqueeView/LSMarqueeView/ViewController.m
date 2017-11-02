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

- (void)stopMarquee{
    dispatch_source_cancel(self.marqueeView.timer);
}

- (void)startMarquee{
    [self.marqueeView  startCountdown];
}

#pragma mark - self Life cycle

- (void)viewDidAppear:(BOOL)animated{
    [self startMarquee];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self stopMarquee];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    // >>>>>> dataSorce >>>>>
    NSMutableArray *tempArr = @[].mutableCopy;
    UILabel *labelOne = [UILabel new];
    labelOne.font = [UIFont systemFontOfSize:14];
    labelOne.text = @"🤩这是第一个广告内容~";
    labelOne.textColor = [UIColor blackColor];
    
    UILabel *labelTwo = [UILabel new];
    labelTwo.font = [UIFont systemFontOfSize:14];
    labelTwo.text = @"😍这是第二个广告内容~~";
    labelTwo.textColor = [UIColor blackColor];
    
    UILabel *labelThree = [UILabel new];
    labelThree.font = [UIFont systemFontOfSize:14];
    labelThree.text = @"😜这是第三个广告内容~~~";
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
    
    UIButton *stopMarqueeBtn = [[UIButton alloc] initWithFrame:CGRectMake(210, 400, 60, 60)];
    [stopMarqueeBtn setTitle:@"Stop" forState:UIControlStateNormal];
    [stopMarqueeBtn setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
    [stopMarqueeBtn setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:stopMarqueeBtn];
    [stopMarqueeBtn addTarget:self action:@selector(stopMarquee) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *startMarqueeBtn = [[UIButton alloc] initWithFrame:CGRectMake(210, 500, 60, 60)];
    [startMarqueeBtn setTitle:@"Start" forState:UIControlStateNormal];
    [startMarqueeBtn setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
    [startMarqueeBtn setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:startMarqueeBtn];
    [startMarqueeBtn addTarget:self action:@selector(startMarquee) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

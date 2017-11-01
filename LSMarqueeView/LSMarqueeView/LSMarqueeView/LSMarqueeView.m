//
//  LSMarqueeView.m
//  LSMarqueeView
//
//  Created by WangBiao on 2017/7/19.
//  Copyright © 2017年 LSRain. All rights reserved.
//

#import "LSMarqueeView.h"

@interface LSMarqueeView ()

@property (nonatomic, assign) NSInteger seconds;
@property (nonatomic, strong) UIView *backView;

@end

@implementation LSMarqueeView


#pragma mark - Action

-(void)labelClick:(UITapGestureRecognizer *)tap {
    if (self.clickBlock) {
        self.clickBlock((UILabel *)tap.view);
    }
}

#pragma mark - Lasy load

- (NSMutableArray *)lsLabelArr{
    if (!_lsLabelArr) {
        _lsLabelArr = @[].mutableCopy;
    }
    return _lsLabelArr;
}

- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:self.bounds];
        _backView.backgroundColor = [UIColor whiteColor];
        UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:_backView.bounds];
        bgImgView.image = [UIImage imageNamed:@"topup_banner"];
        [_backView addSubview:bgImgView];
        _backView.clipsToBounds = YES;
        _backView.userInteractionEnabled = YES;
        [self addSubview:_backView];
    }
    return _backView;
}

#pragma mark - init Data

- (void)initLabels{
    [self.lsLabelArr enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.backView addSubview:obj];
        obj.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)];
        [obj addGestureRecognizer:tap];
    }];
}

#pragma mark - 定时器start

- (void)startCountdown {
    // GCD Timer
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 6 * NSEC_PER_SEC, 0); // 每6S
    dispatch_source_set_event_handler(_timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self timerRepeat];
            _seconds++;
        });
    });
    dispatch_resume(_timer);
}

#pragma mark - 定时执行方法

- (void)timerRepeat {
    UILabel *targetLab = [self.lsLabelArr objectAtIndex:_seconds % self.lsLabelArr.count];
    if (_seconds <= self.lsLabelArr.count) {
        targetLab.frame = CGRectMake(10, self.backView.frame.size.height, self.backView.frame.size.width, self.backView.frame.size.height);
    }
    [UIView animateWithDuration:.75f animations:^{
        targetLab.frame = CGRectMake(10, self.backView.frame.origin.y, self.backView.frame.size.width, self.backView.frame.size.height);
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:.75f animations:^{
                targetLab.frame = CGRectMake(10, -self.backView.frame.size.height, self.backView.frame.size.width, self.backView.frame.size.height);
            } completion:^(BOOL finished) {
                targetLab.frame = CGRectMake(10, self.backView.frame.size.height, self.backView.frame.size.width, self.backView.frame.size.height);
            }];
        });
    }];
}

#pragma mark - 自定义构造函数

- (instancetype)initWithFrame:(CGRect)frame andLableArr:(NSMutableArray *)labels
{
    self = [super initWithFrame:frame];
    if (self) {
        self.lsLabelArr = labels;
        [self initLabels];
    }
    return self;
}

@end

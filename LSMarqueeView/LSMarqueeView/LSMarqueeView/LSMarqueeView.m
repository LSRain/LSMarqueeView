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
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation LSMarqueeView


#pragma mark - Action

- (void)beginShowAdd{
    _timer.fireDate = [NSDate distantPast];
}

- (void)stopShowAdd{
    _timer.fireDate = [NSDate distantFuture];
}

- (void)closeShowAdd{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

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
        UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:_backView.bounds];
        bgImgView.image = [UIImage imageNamed:@"topup_banner"];
        [_backView addSubview:bgImgView];
        _backView.clipsToBounds = YES;
        _backView.userInteractionEnabled = YES;
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

#pragma mark - UI setup

- (void)initUI{
    _seconds = 0;
    [self addSubview:self.backView];
    __weak typeof(self) weakSelf = self;
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.6f target:weakSelf selector:@selector(timerRepeat) userInfo:nil repeats:YES];
    _timer.fireDate = [NSDate distantFuture];
}

- (void)timerRepeat {
    !_seconds ? [self initLabels] : nil;
    
    UILabel *targetLab = [self.lsLabelArr objectAtIndex:_seconds % self.lsLabelArr.count];
    [_backView bringSubviewToFront:targetLab];
    [UIView animateWithDuration:.3f animations:^{
        targetLab.frame = CGRectMake(10, self.backView.frame.origin.y, self.backView.frame.size.width, self.backView.frame.size.height);
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:.3f animations:^{
                targetLab.frame = CGRectMake(10, -self.backView.frame.size.height, self.backView.frame.size.width, self.backView.frame.size.height);
            } completion:^(BOOL finished) {
                targetLab.frame = CGRectMake(10, self.backView.frame.size.height, self.backView.frame.size.width, self.backView.frame.size.height);
            }];
        });
    }];
    _seconds++;
}

#pragma self Life cycle

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

@end

//
//  LSMarqueeView.h
//  LSMarqueeView
//
//  Created by WangBiao on 2017/7/19.
//  Copyright © 2017年 LSRain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSMarqueeView : UIView

@property (nonatomic, strong) dispatch_source_t timer;

/// Label数组
@property (nonatomic, strong) NSMutableArray<UILabel *> *lsLabelArr;
/// 点击事件block
@property(nonatomic,strong)void (^clickBlock)(id sender);

/**
 自定义构造函数

 @param frame view frame
 @param labels labels Array
 @return Self
 */
- (instancetype)initWithFrame:(CGRect)frame andLableArr:(NSMutableArray *)labels;
/**
 开启定时器
 */
- (void)startCountdown;

@end

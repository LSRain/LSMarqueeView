//
//  LSMarqueeView.h
//  LSMarqueeView
//
//  Created by WangBiao on 2017/7/19.
//  Copyright © 2017年 LSRain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSMarqueeView : UIView

/// Label数组
@property (nonatomic, strong) NSMutableArray<UILabel *> *lsLabelArr;
/// 点击事件block
@property(nonatomic,strong)void (^clickBlock)(id sender);

/**
 关闭定时器
 */
- (void)closeShowAdd;
/**
 停止定时器
 */
- (void)stopShowAdd;
/**
 开启定时器
 */
- (void)beginShowAdd;

@end

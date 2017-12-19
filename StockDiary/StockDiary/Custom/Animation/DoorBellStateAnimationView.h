//
//  DoorBellStateAnimationView.h
//  StockDiary
//
//  Created by SaturdayNight on 2017/11/29.
//  Copyright © 2017年 SaturdayNight. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoorBellStateAnimationView : UIView

#pragma mark 开始睡眠动画
-(void)beginAnimationSleep;
#pragma mark 结束睡眠动画
-(void)stopAnimationSleep;

#pragma mark 开始唤醒动画
-(void)beginAnimationWakeUp;
#pragma mark 结束唤醒动画
-(void)stopAnimationWakeUp;

-(void)stopAnimationAll;

@end

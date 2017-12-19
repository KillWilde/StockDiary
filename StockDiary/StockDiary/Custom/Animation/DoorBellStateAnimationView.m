//
//  DoorBellStateAnimationView.m
//  StockDiary
//
//  Created by SaturdayNight on 2017/11/29.
//  Copyright © 2017年 SaturdayNight. All rights reserved.
//

#import "DoorBellStateAnimationView.h"
#import <Masonry.h>

@interface DoorBellStateAnimationView() <CAAnimationDelegate>

@property (nonatomic,strong) UIImageView *imageViewRing;
#pragma mark 睡眠动画用到的视图
@property (nonatomic,strong) UIImageView *imageViewZSmall;
@property (nonatomic,strong) UIImageView *imageViewZMiddle;
@property (nonatomic,strong) UIImageView *imageViewZMax;

#pragma mark 唤醒动画用到的视图
@property (nonatomic,strong) UIImageView *imageViewHalf_TurnFirst;
@property (nonatomic,strong) UIImageView *imageViewHalf_TurnSecond;

@end

@implementation DoorBellStateAnimationView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.imageViewRing];
        
        [self addSubview:self.imageViewZSmall];
        [self addSubview:self.imageViewZMiddle];
        [self addSubview:self.imageViewZMax];
        
        [self addSubview:self.imageViewHalf_TurnFirst];
        [self addSubview:self.imageViewHalf_TurnSecond];
        
        [self masLayout];
    }
    
    return self;
}

#pragma mark - Event Action
#pragma mark 睡眠动画操作
-(void)beginAnimationSleep
{
    //1.创建核心动画
     CAKeyframeAnimation *keyAnima = [CAKeyframeAnimation animation];
     //平移
     keyAnima.keyPath = @"opacity";
     //1.1告诉系统要执行什么动画
     NSValue *value1 = @(1);
     NSValue *value2 = @(0);
     NSValue *value3 = @(1);
     NSValue *value4 = @(0);
     keyAnima.values = @[value1,value2,value3,value4];
     //1.2设置动画执行完毕后，不删除动画
     keyAnima.removedOnCompletion = NO;
     //1.3设置保存动画的最新状态
     keyAnima.keyTimes = @[@(0.2),@(0.4),@(0.6),@(0.8),@(1)];
     keyAnima.fillMode = kCAFillModeForwards;
     keyAnima.duration = 6;
     keyAnima.repeatCount = MAXFLOAT;
    
     //1.5设置动画的节奏
     keyAnima.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];

     //设置代理，开始—结束
     keyAnima.delegate = self;
    
    // 貌似动画移出需要一点时间 如果移除后马上添加动画 会失败0
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        keyAnima.beginTime = CACurrentMediaTime()+ 0.1;
        
        [self.imageViewZSmall.layer addAnimation:keyAnima forKey:nil];
        
        keyAnima.beginTime = CACurrentMediaTime() + 0.75;
        
        [self.imageViewZMiddle.layer addAnimation:keyAnima forKey:nil];
        
        keyAnima.beginTime = CACurrentMediaTime() + 1.5;
        
        [self.imageViewZMax.layer addAnimation:keyAnima forKey:nil];
    });
}

-(void)stopAnimationSleep
{
    [self.imageViewZSmall.layer removeAllAnimations];
    [self.imageViewZMiddle.layer removeAllAnimations];
    [self.imageViewZMax.layer removeAllAnimations];
}

#pragma mark 唤醒动画操作
-(void)beginAnimationWakeUp
{
    //1.创建核心动画
    CAKeyframeAnimation *keyAnima = [CAKeyframeAnimation animation];
    //平移
    keyAnima.keyPath = @"opacity";
    //1.1告诉系统要执行什么动画
    NSValue *value1 = @(1);
    NSValue *value2 = @(1);
    NSValue *value3 = @(0);
    keyAnima.values = @[value1,value2,value3];
    //1.2设置动画执行完毕后，不删除动画
    keyAnima.removedOnCompletion = NO;
    //1.3设置保存动画的最新状态
    keyAnima.keyTimes = @[@(0.33),@(0.66),@(1)];
    keyAnima.fillMode = kCAFillModeForwards;
    keyAnima.duration = 2;
    keyAnima.repeatCount = MAXFLOAT;
    
    //1.5设置动画的节奏
    keyAnima.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    
    //设置代理，开始—结束
    keyAnima.delegate = self;
    
    //1.创建核心动画
    CAKeyframeAnimation *keyAnima2 = [CAKeyframeAnimation animation];
    //平移
    keyAnima2.keyPath = @"opacity";
    //1.1告诉系统要执行什么动画
    NSValue *value21 = @(0);
    NSValue *value22 = @(1);
    NSValue *value23 = @(0);
    keyAnima2.values = @[value21,value22,value23];
    //1.2设置动画执行完毕后，不删除动画
    keyAnima2.removedOnCompletion = NO;
    //1.3设置保存动画的最新状态
    keyAnima2.keyTimes = @[@(0.33),@(0.66),@(1)];
    keyAnima2.fillMode = kCAFillModeForwards;
    keyAnima2.duration = 2;
    keyAnima2.repeatCount = MAXFLOAT;
    
    //1.5设置动画的节奏
    keyAnima2.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    
    //设置代理，开始—结束
    keyAnima2.delegate = self;
    
    [self.imageViewHalf_TurnFirst.layer addAnimation:keyAnima forKey:nil];
    [self.imageViewHalf_TurnSecond.layer addAnimation:keyAnima2 forKey:nil];
}

-(void)stopAnimationWakeUp
{
    [self.imageViewHalf_TurnFirst.layer removeAllAnimations];
    [self.imageViewHalf_TurnSecond.layer removeAllAnimations];
}

-(void)stopAnimationAll
{
    [self stopAnimationWakeUp];
    [self stopAnimationSleep];
}

#pragma mark - Layout
-(void)masLayout
{
    [self.imageViewRing mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    [self.imageViewZSmall mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    [self.imageViewZMiddle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    [self.imageViewZMax mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    [self.imageViewHalf_TurnFirst mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    [self.imageViewHalf_TurnSecond mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
    }];
}

#pragma mark - LazyLoad
-(UIImageView *)imageViewRing
{
    if (!_imageViewRing) {
        _imageViewRing = [[UIImageView alloc] init];
        _imageViewRing.image = [UIImage imageNamed:@"ring.png"];
    }
    
    return _imageViewRing;
}

-(UIImageView *)imageViewZSmall
{
    if (!_imageViewZSmall) {
        _imageViewZSmall = [[UIImageView alloc] init];
        _imageViewZSmall.image = [UIImage imageNamed:@"zMin.png"];
        _imageViewZSmall.alpha = 0;
    }
    
    return _imageViewZSmall;
}

-(UIImageView *)imageViewZMiddle
{
    if (!_imageViewZMiddle) {
        _imageViewZMiddle = [[UIImageView alloc] init];
        _imageViewZMiddle.image = [UIImage imageNamed:@"zMiddle.png"];
        _imageViewZMiddle.alpha = 0;
    }
    
    return _imageViewZMiddle;
}

-(UIImageView *)imageViewZMax
{
    if (!_imageViewZMax) {
        _imageViewZMax = [[UIImageView alloc] init];
        _imageViewZMax.image = [UIImage imageNamed:@"zMax.png"];
        _imageViewZMax.alpha = 0;
    }
    
    return _imageViewZMax;
}

-(UIImageView *)imageViewHalf_TurnFirst
{
    if (!_imageViewHalf_TurnFirst) {
        _imageViewHalf_TurnFirst = [[UIImageView alloc] init];
        _imageViewHalf_TurnFirst.image = [UIImage imageNamed:@"ring_circle_min.png"];
        _imageViewHalf_TurnFirst.alpha = 0;
    }
    
    return _imageViewHalf_TurnFirst;
}

-(UIImageView *)imageViewHalf_TurnSecond
{
    if (!_imageViewHalf_TurnSecond) {
        _imageViewHalf_TurnSecond = [[UIImageView alloc] init];
        _imageViewHalf_TurnSecond.image = [UIImage imageNamed:@"ring_circle_max.png"];
        _imageViewHalf_TurnSecond.alpha = 0;
    }
    
    return _imageViewHalf_TurnSecond;
}

@end

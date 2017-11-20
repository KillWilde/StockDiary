//
//  StockUserChosedListCell.m
//  StockDiary
//
//  Created by SaturdayNight on 2017/11/20.
//  Copyright © 2017年 SaturdayNight. All rights reserved.
//

#import "StockUserChosedListCell.h"
#import <Masonry.h>

@implementation StockUserChosedListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.lbFUp];
        [self addSubview:self.lbFDown];
        [self addSubview:self.lbMMiddle];
        [self addSubview:self.lbLLast];
        
        [self masLayout];
    }
    
    return self;
}

#pragma mark - Delegate
#pragma mark UITableViewDataSource

#pragma mark UITableViewDelegate

#pragma mark - EventAction

#pragma mark - Layout
-(void)masLayout
{
    [self.lbFUp mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self).offset(10);
        make.width.equalTo(@100);
        make.height.equalTo(@15);
    }];
    
    [self.lbFDown mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self.lbFUp.mas_bottom).offset(10);
        make.width.equalTo(@100);
        make.height.equalTo(@10);
    }];
    
    [self.lbLLast mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.centerY.equalTo(self);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
    }];
    
    [self.lbMMiddle mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.lbLLast.mas_left).offset(-10);
        make.centerY.equalTo(self);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
    }];
}

#pragma mark - LazyLoad
-(UILabel *)lbFUp
{
    if (!_lbFUp) {
        _lbFUp = [[UILabel alloc] init];
        _lbFUp.font = [UIFont systemFontOfSize:15];
    }
    
    return _lbFUp;
}

-(UILabel *)lbFDown
{
    if (!_lbFDown) {
        _lbFDown = [[UILabel alloc] init];
        _lbFDown.font = [UIFont systemFontOfSize:10];
    }
    
    return _lbFDown;
}

-(UILabel *)lbMMiddle
{
    if (!_lbMMiddle) {
        _lbMMiddle = [[UILabel alloc] init];
        _lbMMiddle.font = [UIFont systemFontOfSize:15];
    }
    
    return _lbMMiddle;
}

-(UILabel *)lbLLast
{
    if (!_lbLLast) {
        _lbLLast = [[UILabel alloc] init];
        _lbLLast.font = [UIFont systemFontOfSize:15];
    }
    
    return _lbLLast;
}

@end

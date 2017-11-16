//
//  CrossSlipCollectionViewCell.m
//  StockDiary
//
//  Created by SaturdayNight on 2017/11/16.
//  Copyright © 2017年 SaturdayNight. All rights reserved.
//

#import "CrossSlipCollectionViewCell.h"
#import <Masonry.h>

@implementation CrossSlipCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
        
        [self masLayout];
    }
    
    return self;
}

#pragma mark - Layout
-(void)masLayout
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(50);
    }];
}

#pragma mark - LazyLoad
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _titleLabel;
}
@end

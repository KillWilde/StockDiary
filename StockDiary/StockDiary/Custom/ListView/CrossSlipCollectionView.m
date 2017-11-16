//
//  CrossSlipCollectionView.m
//  StockDiary
//
//  Created by SaturdayNight on 2017/11/16.
//  Copyright © 2017年 SaturdayNight. All rights reserved.
//

#import "CrossSlipCollectionView.h"
#import <Masonry.h>
#import "CrossSlipCollectionViewCell.h"

static  NSString *const identifier = @"CrossSlipCollectionViewCell";

@interface CrossSlipCollectionView () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *slipList;

@end

@implementation CrossSlipCollectionView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.datasource = [@[@"自选",@"预选",@"历史盈亏",@"总计",@"智能分析",@"报警",@"核算",@"预测",@"保底"] mutableCopy];
        self.sIndex = 0;
        
        [self addSubview:self.slipList];
        [self.slipList addSubview:self.sView];
        self.sView.center = CGPointMake(self.sIndex * 80 + 40, 48);
        
        [self masLayout];
    }
    
    return self;
}

#pragma mark - Delegate
#pragma mark UICollectionDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.sIndex = indexPath.row;
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.sView.center = CGPointMake(self.sIndex * 80 + 40, 48);
    } completion:nil];
    
    [self.slipList reloadData];
}

#pragma mark UICollectionDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.datasource.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CrossSlipCollectionViewCell *cell = (CrossSlipCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if (self.sIndex == indexPath.row) {
        cell.titleLabel.font = [UIFont systemFontOfSize:18];
        cell.titleLabel.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:62/255.0 alpha:1];
    }
    else
    {
        cell.titleLabel.font = [UIFont systemFontOfSize:15];
        cell.titleLabel.textColor = [UIColor colorWithRed:133/255.0 green:147/255.0 blue:170/255.0 alpha:1];
    }
    cell.titleLabel.text = self.datasource[indexPath.row];
    
    return cell;
}

#pragma mark - Layout
-(void)masLayout
{
    [self.slipList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.bottom.equalTo(self);
        make.right.equalTo(self);
        make.left.equalTo(self);
    }];
}

#pragma mark - LazyLoad
-(UICollectionView *)slipList
{
    if (!_slipList) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.itemSize = CGSizeMake(80,50);
        
        _slipList = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _slipList.dataSource = self;
        _slipList.delegate = self;
        _slipList.backgroundColor = [UIColor whiteColor];
        _slipList.showsHorizontalScrollIndicator = NO;
        
        [_slipList registerClass:[CrossSlipCollectionViewCell class] forCellWithReuseIdentifier:identifier];
    }
    
    return _slipList;
}

-(UIView *)sView
{
    if (!_sView) {
        _sView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 2)];
        _sView.backgroundColor = [UIColor colorWithRed:252/255.0 green:0 blue:39/255.0 alpha:1];
    }
    
    return _sView;
}

@end

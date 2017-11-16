//
//  StockDiaryListVC.m
//  StockDiary
//
//  Created by SaturdayNight on 2017/11/15.
//  Copyright © 2017年 SaturdayNight. All rights reserved.
//

#import "StockDiaryListVC.h"
#import <Masonry.h>
#import "CrossSlipCollectionView.h"
#import "StockUserChosedListVC.h"

@interface StockDiaryListVC ()

@property (nonatomic,strong) CrossSlipCollectionView *slipListView;
@property (nonatomic,strong) UIView *content;

@property (nonatomic,strong) StockUserChosedListVC *stockUserChosedListVC;

@end

@implementation StockDiaryListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.slipListView];
    [self.view addSubview:self.content];
    [self.content addSubview:self.stockUserChosedListVC.view];
    
    [self masLayout];
}

#pragma mark - Layout
-(void)masLayout
{
    [self.slipListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(20);
        make.height.mas_equalTo(50);
    }];
    
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.slipListView.mas_bottom);
        make.bottom.equalTo(self.view);
    }];
}

#pragma mark - LazyLoad
-(CrossSlipCollectionView *)slipListView
{
    if (!_slipListView) {
        _slipListView = [[CrossSlipCollectionView alloc] initWithFrame:CGRectZero];
    }
    
    return _slipListView;
}

-(UIView *)content
{
    if (!_content) {
        _content = [[UIView alloc] init];
    }
    
    return _content;
}

-(StockUserChosedListVC *)stockUserChosedListVC
{
    if (!_stockUserChosedListVC) {
        _stockUserChosedListVC = [[StockUserChosedListVC alloc] init];
    }
    
    return _stockUserChosedListVC;
}

@end

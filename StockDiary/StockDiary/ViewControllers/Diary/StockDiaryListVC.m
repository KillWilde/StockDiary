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
#import "StockModel.h"
#import "DBManager.h"
#import <FMDB.h>
#import "AddStockInfoVC.h"

@interface StockDiaryListVC () <UIScrollViewDelegate>

@property (nonatomic,strong) CrossSlipCollectionView *slipListView;         // 横向滑动列表
@property (nonatomic,strong) UIButton *btnAdd;          // 添加按钮
@property (nonatomic,strong) UIScrollView *content;         // 内容视图

@property (nonatomic,strong) StockUserChosedListVC *stockUserChosedListVC;
@property (nonatomic,strong) StockUserChosedListVC *stockUserChosedListVC1;
@property (nonatomic,strong) StockUserChosedListVC *stockUserChosedListVC2;
@property (nonatomic,strong) StockUserChosedListVC *stockUserChosedListVC3;
@property (nonatomic,strong) StockUserChosedListVC *stockUserChosedListVC4;

@end

@implementation StockDiaryListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self getLocalDBCache];
    
    [self.view addSubview:self.slipListView];
    [self.view addSubview:self.btnAdd];
    [self.view addSubview:self.content];
    
    [self.content addSubview:self.stockUserChosedListVC.view];
    [self.content addSubview:self.stockUserChosedListVC1.view];
    [self.content addSubview:self.stockUserChosedListVC2.view];
    [self.content addSubview:self.stockUserChosedListVC3.view];
    [self.content addSubview:self.stockUserChosedListVC4.view];
    
    [self masLayout];
}

#pragma mark - DataLogic
-(void)getLocalDBCache
{
    [DBManager createTableStockInfo];
    
    self.stockUserChosedListVC.dataSource = [[DBManager getStockInfoList] mutableCopy];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x >= 0) {
        int page = (int)(((int)scrollView.contentOffset.x) / SCREEN_WIDTH);
        [self.slipListView setSIndexSelected:page];
    }
}

#pragma mark - EventAction
-(void)btnAddClicked:(UIButton *)sender
{
    AddStockInfoVC *vc = [[AddStockInfoVC alloc] init];
    vc.vcStyle = AddStockInfoVCStyleAdd;
    vc.SaveDataCompletedAndRereshNow = ^{
        [self getLocalDBCache];
        
        [self.stockUserChosedListVC refreshList];
    };
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Layout
-(void)masLayout
{
    [self.slipListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view).offset(-50);
        make.top.equalTo(self.view).offset(20);
        make.height.mas_equalTo(50);
    }];
    
    [self.btnAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(50);
        make.left.equalTo(self.slipListView.mas_right);
        make.top.equalTo(self.view).offset(20);
    }];
    
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.slipListView.mas_bottom);
        make.bottom.equalTo(self.view).offset(-self.tabbarHeight);
    }];
    
    [self.stockUserChosedListVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.content);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(SCREEN_HEIGHT - 70 - self.tabbarHeight);
        make.centerY.equalTo(self.content);
    }];
    
    [self.stockUserChosedListVC1.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.content).offset(SCREEN_WIDTH);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(SCREEN_HEIGHT - 70 - self.tabbarHeight);
        make.centerY.equalTo(self.content);
    }];
    
    [self.stockUserChosedListVC2.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.content).offset(SCREEN_WIDTH * 2);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(SCREEN_HEIGHT - 70 - self.tabbarHeight);
        make.centerY.equalTo(self.content);
    }];
    
    [self.stockUserChosedListVC3.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.content).offset(SCREEN_WIDTH * 3);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(SCREEN_HEIGHT - 70 - self.tabbarHeight);
        make.centerY.equalTo(self.content);
    }];
    
    [self.stockUserChosedListVC4.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.content).offset(SCREEN_WIDTH * 4);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(SCREEN_HEIGHT - 70 - self.tabbarHeight);
        make.centerY.equalTo(self.content);
    }];
}

#pragma mark - LazyLoad
-(CrossSlipCollectionView *)slipListView
{
    if (!_slipListView) {
        _slipListView = [[CrossSlipCollectionView alloc] initWithFrame:CGRectZero];
        __weak typeof(self)weakSelf = self;
        _slipListView.CrossSlipCollectionViewSelectedIndex = ^(NSInteger index) {
            [weakSelf.content setContentOffset:CGPointMake(index * SCREEN_WIDTH, 0) animated:YES];
        };
    }
    
    return _slipListView;
}

-(UIButton *)btnAdd
{
    if (!_btnAdd) {
        _btnAdd = [[UIButton alloc] init];
        [_btnAdd setImage:[UIImage imageNamed:@"stocklist_add.png"] forState:UIControlStateNormal];
        [_btnAdd addTarget:self action:@selector(btnAddClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _btnAdd;
}

-(UIView *)content
{
    if (!_content) {
        _content = [[UIScrollView alloc] init];
        _content.delegate = self;
        _content.alwaysBounceHorizontal = YES;
        _content.pagingEnabled = YES;
        _content.showsHorizontalScrollIndicator = NO;
        _content.contentSize = CGSizeMake(5 * SCREEN_WIDTH, SCREEN_HEIGHT - 70 - self.tabbarHeight);
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

-(StockUserChosedListVC *)stockUserChosedListVC1
{
    if (!_stockUserChosedListVC1) {
        _stockUserChosedListVC1 = [[StockUserChosedListVC alloc] init];
    }
    
    return _stockUserChosedListVC1;
}

-(StockUserChosedListVC *)stockUserChosedListVC2
{
    if (!_stockUserChosedListVC2) {
        _stockUserChosedListVC2 = [[StockUserChosedListVC alloc] init];
    }
    
    return _stockUserChosedListVC2;
}

-(StockUserChosedListVC *)stockUserChosedListVC3
{
    if (!_stockUserChosedListVC3) {
        _stockUserChosedListVC3 = [[StockUserChosedListVC alloc] init];
    }
    
    return _stockUserChosedListVC3;
}

-(StockUserChosedListVC *)stockUserChosedListVC4
{
    if (!_stockUserChosedListVC4) {
        _stockUserChosedListVC4 = [[StockUserChosedListVC alloc] init];
    }
    
    return _stockUserChosedListVC4;
}

@end

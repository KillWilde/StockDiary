//
//  StockUserChosedList.m
//  StockDiary
//
//  Created by SaturdayNight on 2017/11/16.
//  Copyright © 2017年 SaturdayNight. All rights reserved.
//

#import "StockUserChosedListVC.h"
#import <Masonry.h>
#import "StockUserChosedListCell.h"

@interface StockUserChosedListVC () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tbList;

@end

@implementation StockUserChosedListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tbList];
    
    [self masLayout];
}

#pragma mark - Delegate
#pragma mark - UITableViewDelegate
#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"StockUserChosedListCell";
    StockUserChosedListCell *cell = (StockUserChosedListCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[StockUserChosedListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.lbFUp.text = @"雄迈集成";
    cell.lbFDown.text = @"610079";
    cell.lbMMiddle.text = @"15.6";
    cell.lbLLast.text = @"17.8";
    
    return cell;
}

#pragma mark - Layout
-(void)masLayout
{
    [self.tbList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

#pragma mark - LazyLoad
-(UITableView *)tbList
{
    if (!_tbList) {
        _tbList = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tbList.delegate = self;
        _tbList.dataSource = self;
        _tbList.rowHeight = 55;
    }
    
    return _tbList;
}

@end

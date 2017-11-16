//
//  StockUserChosedList.m
//  StockDiary
//
//  Created by SaturdayNight on 2017/11/16.
//  Copyright © 2017年 SaturdayNight. All rights reserved.
//

#import "StockUserChosedListVC.h"
#import <Masonry.h>

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
    static NSString *identifier = @"";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
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
    }
    
    return _tbList;
}

@end

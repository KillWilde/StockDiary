//
//  PersonalProfileVC.m
//  StockDiary
//
//  Created by SaturdayNight on 2017/11/15.
//  Copyright © 2017年 SaturdayNight. All rights reserved.
//

#import "PersonalProfileVC.h"
#import <Masonry.h>

@interface PersonalProfileVC () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tbList;

@end

@implementation PersonalProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tbList];
    
    [self masLayout];
}

#pragma mark - Layout
-(void)masLayout
{
    [self.tbList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

#pragma mark - Delegate
#pragma mark UITableViewDelegate

#pragma makr UITableDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 8;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"jjjjjj";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
}

#pragma mark - LazyLoad
-(UITableView *)tbList
{
    if (!_tbList) {
        _tbList = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tbList.backgroundColor = [UIColor whiteColor];
        _tbList.delegate = self;
        _tbList.dataSource = self;
    }
    
    return _tbList;
}

@end

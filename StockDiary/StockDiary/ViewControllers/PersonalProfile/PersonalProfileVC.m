//
//  PersonalProfileVC.m
//  StockDiary
//
//  Created by SaturdayNight on 2017/11/15.
//  Copyright © 2017年 SaturdayNight. All rights reserved.
//

#import "PersonalProfileVC.h"
#import <Masonry.h>
#import "LoginVC.h"
#import "AppDelegate.h"

@interface PersonalProfileVC () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tbList;
@property (nonatomic,strong) UIButton *btnLogout;   // 登出按钮

@end

@implementation PersonalProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tbList];
    [self.view addSubview:self.btnLogout];
    
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
    
    [self.btnLogout mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-50);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(45);
    }];
}

#pragma mark - Action Event
-(void)btnLogoutClicked:(UIButton *)sender
{
    LoginVC *loginVC = [[LoginVC alloc] init];
    
    AppDelegate *appDelegate = (AppDelegate *)([UIApplication sharedApplication].delegate);
    [appDelegate.navMain pushViewController:loginVC animated:YES];
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

-(UIButton *)btnLogout
{
    if (!_btnLogout) {
        _btnLogout = [[UIButton alloc] init];
        [_btnLogout setTitle:@"登出" forState:UIControlStateNormal];
        [_btnLogout setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_btnLogout addTarget:self action:@selector(btnLogoutClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _btnLogout;
}

@end

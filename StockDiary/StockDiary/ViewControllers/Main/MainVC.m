//
//  MainVC.m
//  StockDiary
//
//  Created by SaturdayNight on 2017/11/15.
//  Copyright © 2017年 SaturdayNight. All rights reserved.
//

#import "MainVC.h"
#import "LoginVC.h"
#import "PersonalProfileVC.h"
#import "StockDiaryListVC.h"

@interface MainVC ()

@property (nonatomic,assign) BOOL ifLogin;

@property (nonatomic,strong) PersonalProfileVC *personalVC;
@property (nonatomic,strong) StockDiaryListVC *stockDiaryListVC;

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tabBar.tintColor = [UIColor whiteColor];
    self.tabBar.barStyle = UIBarStyleBlack;
    self.stockDiaryListVC.tabbarHeight = self.tabBar.frame.size.height;
    self.viewControllers = @[self.stockDiaryListVC,self.personalVC];
    
    // 设置push后返回按钮的标题
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain  target:nil action:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    if (!self.ifLogin) {
        LoginVC *loginVC = [[LoginVC alloc] init];
        
        [self.navigationController pushViewController:loginVC animated:NO];
        
        self.ifLogin = YES;
    }
}

#pragma mark - Delegate

#pragma mark - LazyLoad
-(PersonalProfileVC *)personalVC
{
    if (!_personalVC) {
        _personalVC = [[PersonalProfileVC alloc] init];
        _personalVC.tabBarItem.title = @"个人中心";
        _personalVC.tabBarItem.image = [UIImage imageNamed:@"icon_tabbar_setting.png"];
    }
    
    return _personalVC;
}

-(StockDiaryListVC *)stockDiaryListVC
{
    if (!_stockDiaryListVC) {
        _stockDiaryListVC = [[StockDiaryListVC alloc] init];
        _stockDiaryListVC.tabBarItem.title = @"股票记录";
        _stockDiaryListVC.tabBarItem.image = [UIImage imageNamed:@"icon_tabbar_book.png"];
    }
    
    return _stockDiaryListVC;
}
@end

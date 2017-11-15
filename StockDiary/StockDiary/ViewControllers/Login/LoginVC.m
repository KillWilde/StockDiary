//
//  LoginVC.m
//  StockDiary
//
//  Created by SaturdayNight on 2017/11/15.
//  Copyright © 2017年 SaturdayNight. All rights reserved.
//

#import "LoginVC.h"
#import <Masonry.h>
#import "UIImage+Transform.h"
#import <SVProgressHUD.h>
#import "MainVC.h"

@interface LoginVC () <UINavigationControllerDelegate>

@property (nonatomic,strong) UIImageView *imgVBG;
@property (nonatomic,strong) UIButton *btnLogin;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.delegate = self;
    
    [self.view addSubview:self.imgVBG];
    [self.view addSubview:self.btnLogin];
    
    [self masLayout];
}

-(void)viewWillAppear:(BOOL)animated
{
    if (!self.navigationController.navigationBarHidden) {
        [self.navigationController setNavigationBarHidden:YES];
    }
}

#pragma mark - Delegate
#pragma mark UINavigationControllerDelegate
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    if ([viewController isKindOfClass:[MainVC class]]) {
        isShowHomePage = YES;
    }
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

#pragma mark - Event Action
-(void)btnLoginClicked:(UIButton *)sender
{
    [SVProgressHUD showWithStatus:@"努力加载中..."];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [SVProgressHUD dismiss];
        
        [self.navigationController popViewControllerAnimated:YES];
    });
}

#pragma mark - Layout
-(void)masLayout
{
    [self.imgVBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN_WIDTH * 0.65);
        make.height.mas_equalTo(SCREEN_WIDTH * 0.65 * 1.4);
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).mas_offset(-50);
    }];
    
    [self.btnLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.imgVBG).multipliedBy(0.85);
        make.height.mas_equalTo(40);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).mas_offset(-100);
    }];
}

#pragma mark - LazyLoad
-(UIImageView *)imgVBG
{
    if (!_imgVBG) {
        _imgVBG = [[UIImageView alloc] init];
        _imgVBG.image = [UIImage imageNamed:@"loginBG.png"];
    }
    
    return _imgVBG;
}

-(UIButton *)btnLogin
{
    if (!_btnLogin) {
        _btnLogin = [[UIButton alloc] init];
        [_btnLogin setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithRed:40 / 255.0 green:41 / 255.0 blue:42 / 255.0 alpha:1]] forState:UIControlStateNormal];
        [_btnLogin addTarget:self action:@selector(btnLoginClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_btnLogin setTitle:@"登录" forState:UIControlStateNormal];
        [_btnLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    return _btnLogin;
}

@end

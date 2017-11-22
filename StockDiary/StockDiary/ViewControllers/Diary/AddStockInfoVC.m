//
//  AddStockInfoVC.m
//  StockDiary
//
//  Created by SaturdayNight on 2017/11/22.
//  Copyright © 2017年 SaturdayNight. All rights reserved.
//

#import "AddStockInfoVC.h"
#import <Masonry.h>
#import "DBManager.h"
#import "StockModel.h"

@interface AddStockInfoVC () <UINavigationControllerDelegate,UITextFieldDelegate>

@property (nonatomic,strong) UIScrollView *content;     // 容器

@property (nonatomic,strong) UILabel *lbName;           // 名称
@property (nonatomic,strong) UILabel *lbNumber;         // 编号
@property (nonatomic,strong) UILabel *lbCurrentPrice;   // 当前价格
@property (nonatomic,strong) UILabel *lbFloorPrice;     // 最低价格
@property (nonatomic,strong) UILabel *lbBuyingPrice;    // 买入价格

@property (nonatomic,strong) UITextField *txName;           // 名称
@property (nonatomic,strong) UITextField *txNumber;         // 编号
@property (nonatomic,strong) UITextField *txCurrentPrice;   // 当前价格
@property (nonatomic,strong) UITextField *txFloorPrice;     // 最低价格
@property (nonatomic,strong) UITextField *txBuyingPrice;    // 买入价格

@end

@implementation AddStockInfoVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.delegate = self;
    
    if (self.navigationController.navigationBarHidden) {
        [self.navigationController setNavigationBarHidden:NO];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self navigationConfig];
    
    [self.view addSubview:self.content];
    [self.content addSubview:self.lbName];
    [self.content addSubview:self.lbNumber];
    [self.content addSubview:self.lbFloorPrice];
    [self.content addSubview:self.lbCurrentPrice];
    [self.content addSubview:self.lbBuyingPrice];
    [self.content addSubview:self.txName];
    [self.content addSubview:self.txNumber];
    [self.content addSubview:self.txFloorPrice];
    [self.content addSubview:self.txCurrentPrice];
    [self.content addSubview:self.txBuyingPrice];
    
    [self masLayout];
    
    [self loadLocalData];
}

#pragma mark - NavigationConfig
-(void)navigationConfig
{
    self.navigationController.delegate = self;
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    if (self.vcStyle == AddStockInfoVCStyleAdd) {
        self.navigationItem.title = @"手动添加";
    }
    else
    {
        self.navigationItem.title = @"手动修改";
    }
    
    UIBarButtonItem *itemSave = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    
    self.navigationItem.rightBarButtonItem = itemSave;
}

#pragma mark - EventAction
-(void)navBack
{
    
}

-(void)save
{
    if (self.vcStyle == AddStockInfoVCStyleAdd) {
        StockModel *model = [[StockModel alloc] init];
        model.name = self.txName.text;
        model.number = self.txNumber.text;
        model.currentPrice = [self.txCurrentPrice.text floatValue];
        model.floorPrice = [self.txFloorPrice.text floatValue];
        model.buyingPrice = [self.txBuyingPrice.text floatValue];
        
        if ([DBManager addStockModel:model]) {
            if (self.SaveDataCompletedAndRereshNow) {
                self.SaveDataCompletedAndRereshNow();
            }
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else
    {
        self.stockModel.name = self.txName.text;
        self.stockModel.number = self.txNumber.text;
        self.stockModel.currentPrice = [self.txCurrentPrice.text floatValue];
        self.stockModel.floorPrice = [self.txFloorPrice.text floatValue];
        self.stockModel.buyingPrice = [self.txBuyingPrice.text floatValue];
        
        if ([DBManager updateStockModel:self.stockModel]) {
            if (self.SaveDataCompletedAndRereshNow) {
                self.SaveDataCompletedAndRereshNow();
            }
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

-(void)loadLocalData
{
    if (self.vcStyle == AddStockInfoVCStyleEdit) {
        self.txName.text = self.stockModel.name;
        self.txNumber.text = self.stockModel.number;
        self.txFloorPrice.text = [NSString stringWithFormat:@"%0.2f",self.stockModel.floorPrice];
        self.txCurrentPrice.text = [NSString stringWithFormat:@"%0.2f",self.stockModel.currentPrice];
        self.txBuyingPrice.text = [NSString stringWithFormat:@"%0.2f",self.stockModel.buyingPrice];
    }
}

#pragma mark - Delegate
#pragma mark UINavigationControllerDelegate
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:!isShowHomePage animated:YES];
}

#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

#pragma mark - Layout
-(void)masLayout
{
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.bottom.equalTo(self.view);
        make.right.equalTo(self.view);
        make.left.equalTo(self.view);
    }];
    
    [self.lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.content.mas_centerX).offset(-50);
        make.top.equalTo(self.content).offset(50);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
    
    [self.txName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbName.mas_right).offset(10);
        make.top.equalTo(self.lbName);
        make.bottom.equalTo(self.lbName);
        make.width.mas_equalTo(150);
    }];
    
    [self.lbNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.content.mas_centerX).offset(-50);
        make.top.equalTo(self.lbName.mas_bottom).offset(30);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
    
    [self.txNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbNumber.mas_right).offset(10);
        make.top.equalTo(self.lbNumber);
        make.bottom.equalTo(self.lbNumber);
        make.width.mas_equalTo(150);
    }];
    
    [self.lbCurrentPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.content.mas_centerX).offset(-50);
        make.top.equalTo(self.lbNumber.mas_bottom).offset(30);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
    
    [self.txCurrentPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbCurrentPrice.mas_right).offset(10);
        make.top.equalTo(self.lbCurrentPrice);
        make.bottom.equalTo(self.lbCurrentPrice);
        make.width.mas_equalTo(150);
    }];
    
    [self.lbFloorPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.content.mas_centerX).offset(-50);
        make.top.equalTo(self.lbCurrentPrice.mas_bottom).offset(30);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
    
    [self.txFloorPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbFloorPrice.mas_right).offset(10);
        make.top.equalTo(self.lbFloorPrice);
        make.bottom.equalTo(self.lbFloorPrice);
        make.width.mas_equalTo(150);
    }];
    
    [self.lbBuyingPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.content.mas_centerX).offset(-50);
        make.top.equalTo(self.lbFloorPrice.mas_bottom).offset(30);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
    
    [self.txBuyingPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbBuyingPrice.mas_right).offset(10);
        make.top.equalTo(self.lbBuyingPrice);
        make.bottom.equalTo(self.lbBuyingPrice);
        make.width.mas_equalTo(150);
    }];
}

#pragma mark - LazyLoad
-(UIScrollView *)content
{
    if (!_content) {
        _content = [[UIScrollView alloc] init];
        _content.showsVerticalScrollIndicator = NO;
    }
    
    return _content;
}

-(UILabel *)lbName
{
    if (!_lbName) {
        _lbName = [[UILabel alloc] init];
        _lbName.textAlignment = NSTextAlignmentRight;
        _lbName.text = @"名称:";
    }
    
    return _lbName;
}

-(UILabel *)lbNumber
{
    if (!_lbNumber) {
        _lbNumber = [[UILabel alloc] init];
        _lbNumber.textAlignment = NSTextAlignmentRight;
        _lbNumber.text = @"编号:";
    }
    
    return _lbNumber;
}

-(UILabel *)lbFloorPrice
{
    if (!_lbFloorPrice) {
        _lbFloorPrice = [[UILabel alloc] init];
        _lbFloorPrice.textAlignment = NSTextAlignmentRight;
        _lbFloorPrice.text = @"最低价:";
    }
    
    return _lbFloorPrice;
}

-(UILabel *)lbCurrentPrice
{
    if (!_lbCurrentPrice) {
        _lbCurrentPrice = [[UILabel alloc] init];
        _lbCurrentPrice.textAlignment = NSTextAlignmentRight;
        _lbCurrentPrice.text = @"当前价格:";
    }
    
    return _lbCurrentPrice;
}

-(UILabel *)lbBuyingPrice
{
    if (!_lbBuyingPrice) {
        _lbBuyingPrice = [[UILabel alloc] init];
        _lbBuyingPrice.textAlignment = NSTextAlignmentRight;
        _lbBuyingPrice.text = @"购买价格:";
    }
    
    return _lbBuyingPrice;
}

-(UITextField *)txName
{
    if (!_txName) {
        _txName = [[UITextField alloc] init];
        _txName.layer.masksToBounds = YES;
        _txName.layer.borderWidth = 1;
        _txName.layer.cornerRadius = 5;
        _txName.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _txName.delegate = self;
    }
    
    return _txName;
}

-(UITextField *)txNumber
{
    if (!_txNumber) {
        _txNumber = [[UITextField alloc] init];
        _txNumber.layer.masksToBounds = YES;
        _txNumber.layer.borderWidth = 1;
        _txNumber.layer.cornerRadius = 5;
        _txNumber.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _txNumber.delegate = self;
    }
    
    return _txNumber;
}

-(UITextField *)txFloorPrice
{
    if (!_txFloorPrice) {
        _txFloorPrice = [[UITextField alloc] init];
        _txFloorPrice.layer.masksToBounds = YES;
        _txFloorPrice.layer.borderWidth = 1;
        _txFloorPrice.layer.cornerRadius = 5;
        _txFloorPrice.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _txFloorPrice.delegate = self;
    }
    
    return _txFloorPrice;
}

-(UITextField *)txCurrentPrice
{
    if (!_txCurrentPrice) {
        _txCurrentPrice = [[UITextField alloc] init];
        _txCurrentPrice.layer.masksToBounds = YES;
        _txCurrentPrice.layer.borderWidth = 1;
        _txCurrentPrice.layer.cornerRadius = 5;
        _txCurrentPrice.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _txCurrentPrice.delegate = self;
    }
    
    return _txCurrentPrice;
}

-(UITextField *)txBuyingPrice
{
    if (!_txBuyingPrice) {
        _txBuyingPrice = [[UITextField alloc] init];
        _txBuyingPrice.layer.masksToBounds = YES;
        _txBuyingPrice.layer.borderWidth = 1;
        _txBuyingPrice.layer.cornerRadius = 5;
        _txBuyingPrice.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _txBuyingPrice.delegate = self;
    }
    
    return _txBuyingPrice;
}

@end

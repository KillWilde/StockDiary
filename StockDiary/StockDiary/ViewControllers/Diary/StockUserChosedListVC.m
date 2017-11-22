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
#import "StockModel.h"
#import "DBManager.h"
#import "AddStockInfoVC.h"
#import "AppDelegate.h"

@interface StockUserChosedListVC () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tbList;

@end

@implementation StockUserChosedListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tbList];
    
    [self masLayout];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressActionhappened:)];
    
    [self.tbList addGestureRecognizer:longPress];
}

#pragma mark - EventAction
-(void)refreshList
{
    [self.tbList reloadData];
}

-(void)longPressActionhappened:(UILongPressGestureRecognizer *)gesture
{
    CGPoint point = [gesture locationInView:self.tbList];
    NSIndexPath *indexPath = [self.tbList indexPathForRowAtPoint:point];
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"是否确定删除，删除后将不可恢复！" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *actionDelete = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        StockModel *model = self.dataSource[indexPath.row];
        
        if ([DBManager deleteStockModel:model]) {
            [self.tbList beginUpdates];
            
            [self.dataSource removeObjectAtIndex:indexPath.row];
            [self.tbList deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
            
            [self.tbList endUpdates];
        }
        
    }];
    [actionDelete setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
    }];
    [actionCancel setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    
    [alertVC addAction:actionDelete];
    [alertVC addAction:actionCancel];
    alertVC.popoverPresentationController.sourceView = self.view;
    alertVC.popoverPresentationController.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height, 1.0, 1.0);
    [self presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark - Delegate
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddStockInfoVC *vc = [[AddStockInfoVC alloc] init];
    vc.vcStyle = AddStockInfoVCStyleEdit;
    vc.stockModel = self.dataSource[indexPath.row];
    vc.SaveDataCompletedAndRereshNow = ^{
        [self refreshList];
    };
    
    AppDelegate *delegate = (AppDelegate *)([UIApplication sharedApplication].delegate);
    [delegate.navMain pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"StockUserChosedListCell";
    StockUserChosedListCell *cell = (StockUserChosedListCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[StockUserChosedListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    StockModel *model = self.dataSource[indexPath.row];
    cell.lbFUp.text = model.name;
    cell.lbFDown.text = model.number;
    cell.lbMMiddle.text = [NSString stringWithFormat:@"%0.2f",model.buyingPrice];
    cell.lbLLast.text = [NSString stringWithFormat:@"%0.2f",model.currentPrice];
    
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

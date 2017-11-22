//
//  AddStockInfoVC.h
//  StockDiary
//
//  Created by SaturdayNight on 2017/11/22.
//  Copyright © 2017年 SaturdayNight. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StockModel;

@interface AddStockInfoVC : UIViewController

typedef NS_ENUM(NSInteger,AddStockInfoVCStyle)
{
    AddStockInfoVCStyleAdd = 0,
    AddStockInfoVCStyleEdit = 1,
};

@property (nonatomic,copy) void (^SaveDataCompletedAndRereshNow)(void);         // 数据保存成功后 通知对应界面上刷新数据

@property (nonatomic,assign) AddStockInfoVCStyle vcStyle;
@property (nonatomic,strong) StockModel *stockModel;

@end

//
//  StockUserChosedList.h
//  StockDiary
//
//  Created by SaturdayNight on 2017/11/16.
//  Copyright © 2017年 SaturdayNight. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StockModel;

@interface StockUserChosedListVC : UIViewController

@property (nonatomic,strong) NSMutableArray <StockModel *>*dataSource;

-(void)refreshList;

@end

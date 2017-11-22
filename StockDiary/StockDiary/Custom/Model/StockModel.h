//
//  StockModel.h
//  StockDiary
//
//  Created by SaturdayNight on 2017/11/21.
//  Copyright © 2017年 SaturdayNight. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StockModel : NSObject

@property (nonatomic,copy) NSString *name;          // 名称
@property (nonatomic,copy) NSString *number;        // 编号
@property (nonatomic,assign) float currentPrice;    // 当前价格
@property (nonatomic,assign) float floorPrice;      // 最低价
@property (nonatomic,assign) float buyingPrice;     // 买入价格

@end

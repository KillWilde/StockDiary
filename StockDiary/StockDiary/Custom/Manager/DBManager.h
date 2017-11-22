//
//  DBManager.h
//  StockDiary
//
//  Created by SaturdayNight on 2017/11/21.
//  Copyright © 2017年 SaturdayNight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>

@class StockModel;

static NSString *const cStockDB = @"stock.db";
static NSString *const cTNStockInfo = @"t_stockinfo";

@interface DBManager : NSObject

+(FMDatabase *)getDataBaseNamed:(NSString *)name;

#pragma mark - StockInfo处理
+(BOOL)createTableStockInfo;
+(BOOL)addStockModel:(StockModel *)model;
+(BOOL)deleteStockModel:(StockModel *)model;
+(BOOL)updateStockModel:(StockModel *)model;
+(NSMutableArray <StockModel *>*)getStockInfoList;

@end

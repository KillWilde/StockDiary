//
//  DBManager.m
//  StockDiary
//
//  Created by SaturdayNight on 2017/11/21.
//  Copyright © 2017年 SaturdayNight. All rights reserved.
//

#import "DBManager.h"
#import "StockModel.h"

@implementation DBManager

+(FMDatabase *)getDataBaseNamed:(NSString *)name
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:name];
    
    // 需要打开关闭一下 才会创建数据库文件
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    if ([db open]) {
        return db;
    }
    
    return nil;
}

#pragma mark - StockInfo处理
+(BOOL)createTableStockInfo
{
    FMDatabase *db = [DBManager getDataBaseNamed:cStockDB];
    if (db) {
        [db open];
        
        NSString *cmd = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, number text NOT NULL, currentPrice real NOT NULL, floorPrice real NOT NULL, buyingPrice real NOT NULL);",cTNStockInfo];
        
        return [db executeUpdate:cmd];
    }
    
    return NO;
}

+(BOOL)addStockModel:(StockModel *)model
{
    // 开始保存数据
    FMDatabase *db = [DBManager getDataBaseNamed:cStockDB];
    if (db) {
        [db open];
        
        NSString *cmd = [NSString stringWithFormat:@"INSERT INTO %@ (name, number,currentPrice,floorPrice,buyingPrice) VALUES ('%@','%@',%f,%f,%f);",cTNStockInfo,model.name,model.number,model.currentPrice,model.floorPrice,model.buyingPrice];
        
        return [db executeUpdate:cmd];
    }
    
    return NO;
}

+(BOOL)deleteStockModel:(StockModel *)model
{
    FMDatabase *db = [DBManager getDataBaseNamed:cStockDB];
    
    if (db) {
        NSString *cmd = [NSString stringWithFormat:@"DELETE FROM %@ WHERE number == '%@'",cTNStockInfo,model.number];
        
        return [db executeUpdate:cmd];
    }
    
    return NO;
}

+(BOOL)updateStockModel:(StockModel *)model
{
    FMDatabase *db = [DBManager getDataBaseNamed:cStockDB];
    if (db) {
        [db open];
        
        NSString *cmd = [NSString stringWithFormat:@"UPDATE %@ SET (currentPrice,floorPrice,buyingPrice) = (%f,%f,%f) WHERE number == '%@';",cTNStockInfo,model.currentPrice,model.floorPrice,model.buyingPrice,model.name];
        
        return [db executeUpdate:cmd];
    }
    
    return NO;
}

+(NSMutableArray <StockModel *>*)getStockInfoList
{
    FMDatabase *db = [DBManager getDataBaseNamed:cStockDB];
    
    NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:0];
    
    if (db) {
        FMResultSet *resultSet = nil;
        
        NSString *cmd = [NSString stringWithFormat:@"SELECT * FROM %@",cTNStockInfo];
        
        resultSet = [db executeQuery:cmd];
        
        
        while (resultSet.next) {
            StockModel *model = [[StockModel alloc] init];
            model.name = [resultSet stringForColumn:@"name"];
            model.number = [resultSet stringForColumn:@"number"];
            model.currentPrice = [resultSet doubleForColumn:@"currentPrice"];
            model.floorPrice = [resultSet doubleForColumn:@"floorPrice"];
            model.buyingPrice = [resultSet doubleForColumn:@"floorPrice"];
            
            [resultArray addObject:model];
        }
    }
    
    return resultArray;
}

@end


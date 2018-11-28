//
//  DBManager.m
//  ITHouse
//
//  Created by zhifu360 on 2018/11/28.
//  Copyright © 2018 ZZJ. All rights reserved.
//

#import "DBManager.h"
#import "FMDB.h"

static NSString * const kDBName = @"ITHouse.sqlite";

static FMDatabase *_db;

@implementation DBManager

+ (instancetype)sharedManager {
    static DBManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc] init];
    });
    return _manager;
}

+ (void)initialize
{
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *dbPath = [documentPath stringByAppendingPathComponent:kDBName];
    _db = [FMDatabase databaseWithPath:dbPath];
    _db.traceExecution = YES;
}

- (void)createTable {
    
    if (![_db open]) {
        return;
    }
    
    BOOL isSuccess = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS T_CACHE (id INTEGER PRIMARY KEY AUTOINCREMENT,cache_data blob not null,cache_key text)"];
    NSLog(@"%@",isSuccess ? @"create table success" : @"create table failure");
}

- (void)insertItem:(id)item cacheKey:(NSString *)cacheKey {
    
    if (![_db open]) {
        return;
    }
    
    NSData *cacheData = [NSKeyedArchiver archivedDataWithRootObject:item];
    BOOL isSuccess = [_db executeUpdateWithFormat:@"INSERT INTO T_CACHE (cache_data,cache_key) VALUES (%@,%@)",cacheData,cacheKey];
    NSLog(@"%@",isSuccess ? @"insert success" : @"insert failure");
}

- (id)itemWithCacheKey:(NSString *)cacheKey {
    
    if (![_db open] || !cacheKey) {
        return nil;
    }
    
    FMResultSet *s = [_db executeQueryWithFormat:@"SELECT * FROM T_CACHE WHERE cache_key = %@",cacheKey];
    while ([s next]) {
        NSData *data = [s dataForColumn:@"cache_data"];
        id cacheData = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        return cacheData;
    }
    return nil;
}

- (void)clearAll {
    [_db executeUpdate:@"DELETE FROM T_CACHE"];
}

@end

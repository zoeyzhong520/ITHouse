//
//  DBManager.h
//  ITHouse
//
//  Created by zhifu360 on 2018/11/28.
//  Copyright © 2018 ZZJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DBManager : NSObject

+ (instancetype)sharedManager;

///创建表
- (void)createTable;

///使用cacheKey存储数据
- (void)insertItem:(id)item cacheKey:(NSString *)cacheKey;

///通过cacheKey获取数据
- (id)itemWithCacheKey:(NSString *)cacheKey;

///通过cacheKey、item更新数据
- (void)updateItem:(id)item cacheKey:(NSString *)cacheKey resultBlock:(void(^)(bool isSuccess))resultBlock;

///清空数据库
- (void)clearAll;

@end

NS_ASSUME_NONNULL_END

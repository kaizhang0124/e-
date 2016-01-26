//
//  ZKDataCacheTool.m
//  News
//
//  Created by tarena on 16/1/25.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ZKDataCacheTool.h"

static FMDatabaseQueue *_queue;
@implementation ZKDataCacheTool

+ (void)initialize{
    // 创建数据库
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"myNews.sqlite"];
    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
    [_queue inDatabase:^(FMDatabase *db) {
        BOOL success = [db executeUpdate:@"create table if not exists info(ID integer primary key autoincrement,data blob,idstr text)"];
        if (!success) {
            NSLog(@"数据库创建失败");
        }
    }];
}

+ (void)addArr:(NSArray *)arr andID:(NSString *)idstr{
    for (NSDictionary *dic in arr) {
        [self addDict:dic andID:idstr];
    }
}

+ (void)addDict:(NSDictionary *)dict andID:(NSString *)idstr{
    [_queue inDatabase:^(FMDatabase *db) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
       BOOL success =  [db executeUpdate:@"insert into info(data,idstr) values(?,?)",data,idstr];
        if (!success) {
            NSLog(@"添加数据失败");
        }
    }];
}

+ (NSArray*)dataWithID:(NSString*)ID{
    __block NSMutableArray *arr = nil;
    [_queue inDatabase:^(FMDatabase *db) {
        
        FMResultSet *result = [db executeQuery:@"select * from info where idstr=?",ID];
        if (result) {
            arr = [NSMutableArray array];
            while ([result next]) {
                NSData *data = [result dataForColumn:@"data"];
                // 解档
                NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                [arr addObject:dic];
            }
        }
    }];
    return arr;
}

+ (void)deleteWithID:(NSString *)ID{
    [_queue inDatabase:^(FMDatabase *db) {
        BOOL success = [db executeUpdate:@"delete  from info where idstr=?",ID];
        if (!success) {
            NSLog(@"未找到数据, 删除失败");
        }
    }];
}

@end

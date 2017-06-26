//
//  MWClothesDispalySqlite.m
//  MyWardrobe
//
//  Created by Libo on 17/5/18.
//  Copyright © 2017年 残夜孤鸥. All rights reserved.
//

#import "MWClothesDispalySqlite.h"
#import "FMDB.h"

@implementation MWClothesDispalySqlite

/** 数据库实例 */
static FMDatabase *_db;

+ (NSString *)creatPath {
    // 获得数据库文件的路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filename = [doc stringByAppendingPathComponent:@"clothes.sqlite"];
    return filename;
}

+ (BOOL)openDB {
    
    // 得到数据库
    _db = [FMDatabase databaseWithPath:[self creatPath]];
    
    return [_db open];
    

}

+ (void)creatTableName:(NSString *)tableName {
    // 打开数据库成功
    if ([self openDB]) {
        // 4.创表
        BOOL result = [_db executeUpdate:[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id integer PRIMARY KEY AUTOINCREMENT, image blob NOT NULL);",tableName]];
        if (result) {
            NSLog(@"成功创表");
        } else {
            NSLog(@"创表失败");
        }
    }
}

// 保存
+ (void)saveImage:(UIImage *)image toTable:(NSString *)tableName{
    NSData *data = UIImagePNGRepresentation(image);
    BOOL insertSucess = [_db executeUpdate:[NSString stringWithFormat:@"INSERT INTO %@ (image) VALUES (?);",tableName], data];
    if (insertSucess) {
        NSLog(@"插入成功");
    } else {
        NSLog(@"插入失败");
    }
}

// 查询
+ (NSArray *)queryImageFromTable:(NSString *)tableName {
    NSMutableArray *images = [NSMutableArray array];
    
    // 根据请求参数查询数据
    FMResultSet *resultSet = nil;
    resultSet = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@",tableName]];

    // 遍历查询结果
    while (resultSet.next) {
        NSData *imageData = [resultSet objectForColumnName:@"image"];
        UIImage *image = [UIImage imageWithData:imageData];

        [images insertObject:image atIndex:0];
    }
    
    return images;
}

// 删除
+ (void)deleteImage:(UIImage *)image fromTable:(NSString *)tableName {
    NSData *data = UIImagePNGRepresentation(image);

    BOOL res = [_db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@ WHERE image = ?",tableName],data];
    NSLog(@"---%d",res);
}

// 是否存在表格
- (BOOL)isExistTable:(NSString *)tableName {
    FMResultSet *rs = [_db executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
    
    while ([rs next]) {
        NSInteger count = [rs intForColumn:@"count"];
        NSLog(@"isTableOK %ld", count);
        
        if (0 == count) {
            return NO;
        }
        else {
            return YES;
        }
    }
    return NO;
}


@end

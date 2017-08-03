//
//  PFDBManager.h
//  db
//
//  Created by ekhome on 16/12/21.
//  Copyright © 2016年 xiaofei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>
@interface PFDBManager : NSObject
//根据FilePath路径，创建FMDatabase 数据库；
+(FMDatabase *)creatDataBaseWithFilePath:(NSString *)filePath;

//创建一个名字为tableName的表，在数据库db中；
+(void)creatTable:(NSString *)tableName inDataBase:(FMDatabase *)db;

+(void)creatTable:(NSString *)tableName inDataBase:(FMDatabase *)db model:(Class)newclass;

//在数据为db的名字为TableName中插入name和phone sex；
+(void)insertDataBase:(FMDatabase *)db table:(NSString *)tableName name:(NSString *)name phone:(NSString *)phone sex:(NSString *)sex;
+(void)insertDataBase:(FMDatabase *)db table:(NSString *)table model:(NSArray*)keys andValues:(NSArray *)values;
//在数据库为db的名字为tableName的表中 修改id 为index的name
+(void)updataDataBase:(FMDatabase *)db table:(NSString *)tableName name:(NSString *)name id:(NSString *)index;

//在数据库为db的名字为tableName的表中 通过ID  修改指定的字段的值
+(void)updataDataBase:(FMDatabase *)db table:(NSString *)tableName name:(NSString *)name value:(id)value id:(NSString *)index;
//在数据库db的名字weitableName的表中 删除id为index的一行；
+(void)deleteDataBase:(FMDatabase *)db table:(NSString *)tableName id:(NSString *)index;
//查询db中大于index的所有数据
+(NSArray *)queryDataBase:(FMDatabase *)db table:(NSString *)tableName id:(NSString *)index className:(Class)tarGetclassName;
//在db的数据库中的table表中  插入Class累的所有的属性
+(void)insertDataBase:(FMDatabase *)db table:(NSString *)table model:(Class)newclass;



+(NSArray *)getIDDataBase:(FMDatabase *)db table:(NSString *)table keys:(NSArray *)keys values:(NSArray *)values;
/**
 *  根据某些条件查询一个数据 并且返回满足条件的所有的数据的所有的值
 *
 *  @param db         查询数据库
 *  @param tableName  查询数据库中的某一个表
 *  @param keys       某一个表中的要的字段
 *  @param values     某一个表中的字段对应的值
 *  @param class      数据对应的模型
 *
 *  @return 返回满足条件的所有的数据
 */
+(NSArray *)queryDataBase:(FMDatabase *)db table:(NSString *)tableName model:(NSArray*)keys andValues:(NSArray *)values className:(Class)tarGetclassName;
@end

//
//  PFDBManager.m
//  db
//
//  Created by ekhome on 16/12/21.
//  Copyright © 2016年 xiaofei. All rights reserved.
//

#import "PFDBManager.h"
#import <Contacts/Contacts.h>
#import <objc/runtime.h>
#import "Mytest.h"
#import <MessageUI/MessageUI.h>
#import <Foundation/Foundation.h>
#import "MJExtension.h"
static PFDBManager *manage = nil;
@implementation PFDBManager
//根据FilePath路径，创建FMDatabase 数据库；
+(FMDatabase *)creatDataBaseWithFilePath:(NSString *)filePath{
    return [FMDatabase databaseWithPath:filePath];
}
+(void)creatTable:(NSString *)tableName inDataBase:(FMDatabase *)db{
    //2.建表 如果不存在就创建一个名字为user表 integer类型的自增的 i，text类型 不能重复的name， text类型 phone；
    NSString *creatExec=[NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement,name text not null unique, phone text ,sex int not null);",tableName];
    
    BOOL result=[db executeUpdate:creatExec];
    if (result) {
        NSLog(@"建表成功");
        
    }
    else
    {
        NSLog(@"建表失败");
    }
}

+(void)creatTable:(NSString *)tableName inDataBase:(FMDatabase *)db model:(Class)newclass
{
    unsigned int count;// 记录属性个数
    objc_property_t *properties = class_copyPropertyList(newclass, &count);
    // 遍历
    NSMutableArray *mArray = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        
        // An opaque type that represents an Objective-C declared property.
        // objc_property_t 属性类型
        objc_property_t property = properties[i];
        //        [type addObject:(__bridge id _Nonnull)(property)];
        // 获取属性的名称 C语言字符串
        const char *cName = property_getName(property);
        // 转换为Objective C 字符串
        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        [mArray addObject:name];
    }
    NSString *creatExec = [@"create table if not exists " stringByAppendingString:tableName];
    creatExec = [creatExec stringByAppendingString:@" (id integer primary key autoincrement,"];
    for ( int i =0; i<mArray.count; i++)
    {
        
        if (i == mArray.count-1)
        {
            creatExec = [[creatExec stringByAppendingString:mArray[i]] stringByAppendingString:@" text);,"];
        }else{
            creatExec = [[creatExec stringByAppendingString:mArray[i]] stringByAppendingString:@" text,"];
        }
    }
    BOOL result=[db executeUpdate:creatExec];
    if (result) {
        NSLog(@"建表成功");
    }
    else
    {
        NSLog(@"建表失败");
    }
}


//在数据为db的名字为TableName中插入name和phone；
+(void)insertDataBase:(FMDatabase *)db table:(NSString *)tableName name:(NSString *)name phone:(NSString *)phone sex:(NSString *)sex{
    NSString * insertSql=[NSString stringWithFormat:@"insert into %@ (name ,phone ,sex)values('%@','%@','%@');",tableName,name,phone,sex];
    BOOL result=[db executeUpdate:insertSql];
    if (result)
    {
        NSLog(@"插入成功");
        
    }
    else
    {
        NSLog(@"插入失败");
    }
}



+(void)insertDataBase:(FMDatabase *)db table:(NSString *)table model:(NSArray *)keys andValues:(NSArray *)values{
    // 获取当前类的所有属性
        NSString *str = @"insert into ";
    str = [str stringByAppendingString:table];
    str= [str stringByAppendingString:@"("];
    for (int i =0; i<keys.count; i++)
    {
        if (i == keys.count-1)
        {
           str = [[str stringByAppendingString:keys[i]] stringByAppendingString:@")values('"];
        }else{
        str = [[str stringByAppendingString:keys[i]] stringByAppendingString:@" ,"];
        }
    }

    
    
    for (int j =0; j<values.count; j++)
    {
        if (j == values.count-1)
        {
            str = [[str stringByAppendingString:values[j]] stringByAppendingString:@"');"];
        }else{
            str = [[[str stringByAppendingString:@""] stringByAppendingString:values[j]] stringByAppendingString:@"','"];
        }
    }
    
    
    BOOL result=[db executeUpdate:str];
    if (result)
    {
        NSLog(@"插入成功");
    }
    else
    {
        NSLog(@"插入失败");
    }

    
}



//在数据库为db的名字为tableName的表中 修改id 为index的name
+(void)updataDataBase:(FMDatabase *)db table:(NSString *)tableName name:(NSString *)name id:(NSString *)index{
    NSString *updateSql=[NSString stringWithFormat:@"update %@ set name ='%@'where id='%@';",tableName, name,index];
    BOOL result=[db executeUpdate:updateSql];
    if (result) {
        NSLog(@"修改成功");
    }
    else
    {
        NSLog(@"修改失败");
    }
}

+(void)updataDataBase:(FMDatabase *)db table:(NSString *)tableName name:(NSString *)name value:(id)value id:(NSString *)index{
    NSString *updateSql = [NSString stringWithFormat:@"update %@ set %@ = '%@' where id = '%@';",tableName,name,value,index];
    BOOL result = [db executeUpdate:updateSql];
    if (result)
    {
        NSLog(@"修改成功");
    }else{
        NSLog(@"修改失败");
    }
}

//在数据库db的名字weitableName的表中 删除id为index的一行；
+(void)deleteDataBase:(FMDatabase *)db table:(NSString *)tableName id:(NSString *)index{
    NSString *deletSql=[NSString stringWithFormat:@"delete from %@ where id='%@';",tableName,index];
    BOOL result=[db executeUpdate:deletSql];
    if (result) {
        NSLog(@"删除成功");
    }
    else
    {
        NSLog(@"删除失败");
    }
    
}
//查询db中大于index的所有数据
+(NSArray *)queryDataBase:(FMDatabase *)db table:(NSString *)tableName id:(NSString *)index className:(Class)tarGetclassName{
    NSString *sqlString=[NSString stringWithFormat:@"select * from %@ where id >'%@'",tableName,index];
    //1.查询数据
     FMResultSet *rs=[db executeQuery:sqlString];
    //2.遍历结构集
    NSMutableArray *arr = [NSMutableArray new];
    //        //2.遍历结构集
    while (rs.next) {
        Class my = [tarGetclassName copy];
        NSMutableDictionary *targetDic = [NSMutableDictionary dictionary];
        unsigned int count = 0;
        Ivar *ivarList  =   class_copyIvarList(my, &count);
        for (int i =0; i<count; i++) {
            Ivar iv = ivarList[i];
            const char * name = ivar_getName(iv);
            NSString *key = [NSString stringWithUTF8String:name];
            NSString *usefullStr = [key substringFromIndex:1];
            NSString *value = [rs stringForColumn:usefullStr];
            [targetDic setValue:value forKey:usefullStr];
        }
        
        [my mj_objectWithKeyValues:targetDic];
        [arr addObject:targetDic];
    }

    return arr;
}


+(NSArray *)queryDataBase:(FMDatabase *)db table:(NSString *)tableName model:(NSArray *)keys andValues:(NSArray *)values className:(Class)tarGetclassName{
    NSString *sqlString = [NSString stringWithFormat:@"select * from %@ where ",tableName];
    NSMutableArray *arr = [NSMutableArray new];
    for (int i =0; i<keys.count; i++) {
        if (i < keys.count-1) {
         sqlString =   [[[sqlString stringByAppendingString:keys[i]] stringByAppendingString:@" = "] stringByAppendingString:[NSString stringWithFormat:@" '%@' , and",values[i]]];
        }else{
          sqlString =   [[[sqlString stringByAppendingString:keys[i]] stringByAppendingString:@"  "] stringByAppendingString:[NSString stringWithFormat:@" '%@'",values[i]]];
        }
        }
        NSLog(@"查询的sql:   %@",sqlString);
//        //1.查询数据
        FMResultSet *rs=[db executeQuery:sqlString];
//        //2.遍历结构集
        while (rs.next) {
           Class my = [tarGetclassName copy];
            NSMutableDictionary *targetDic = [NSMutableDictionary dictionary];
            unsigned int count = 0;
            Ivar *ivarList  =   class_copyIvarList(my, &count);
            for (int i =0; i<count; i++) {
                Ivar iv = ivarList[i];
                const char * name = ivar_getName(iv);
                NSString *key = [NSString stringWithUTF8String:name];
                NSString *usefullStr = [key substringFromIndex:1];
                NSString *value = [rs stringForColumn:usefullStr];
                [targetDic setValue:value forKey:usefullStr];
            }
            [my mj_objectWithKeyValues:targetDic];
            [arr addObject:targetDic];
    }
    return arr;
    
}

+(NSArray *)getIDDataBase:(FMDatabase *)db table:(NSString *)table keys:(NSArray *)keys values:(NSArray *)values
{
    NSString *sqlString = [NSString stringWithFormat:@"select id from %@ where ",table];
    for (int i =0; i<keys.count; i++) {
        if (i < keys.count-1) {
            sqlString =   [[[sqlString stringByAppendingString:keys[i]] stringByAppendingString:@" = "] stringByAppendingString:[NSString stringWithFormat:@" '%@'  and ",values[i]]];
        }else{
            sqlString =   [[[sqlString stringByAppendingString:keys[i]] stringByAppendingString:@" = "] stringByAppendingString:[NSString stringWithFormat:@" '%@'",values[i]]];
        }
    }
    NSLog(@"查询的sql:   %@",sqlString);
//1.查询数据
    FMResultSet *rs=[db executeQuery:sqlString];
    
    NSMutableArray *arr = [NSMutableArray new];
    
    
    while (rs.next) {
       NSString *aa = [rs stringForColumn:@"id"];
        [arr addObject:aa];
    }
    
    return arr;
}
@end

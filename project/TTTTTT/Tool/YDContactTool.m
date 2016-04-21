//
//  YDContactTool.m
//  shiandianping2.0
//
//  Created by 闫康 on 16/4/19.
//  Copyright © 2016年 程宏愿. All rights reserved.
//

#import "YDContactTool.h"
#import "YDContact.h"
#import "FMDB.h"

@implementation YDContactTool
static FMDatabase *_db;

+(void)initialize
{
    //打开数据库
    NSString *path=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"shianydcontact.sqlite"];
    _db=[FMDatabase databaseWithPath:path];
    [_db open];
    
    //创表
    //id主键 roleID账号 name昵称 iconUrl头像
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS ydcontact (id integer PRIMARY KEY, roleID text NOT NULL ,name text NOT NULL,iconUrl text NOT NULL);"];
}

#pragma mark - 增加、更新联系人信息
+(void)updateContact:(YDContact *)contact{
    //查询语句 FMResultSet *rs = [_db executeQuery:@"select * from ydcontact where roleID = ?",contact.RoleId];
    
    NSString *sql0=[NSString stringWithFormat:@"SELECT * FROM ydcontact WHERE roleID=%@;" ,contact.RoleID];//遍历语句
    FMResultSet *rs = [_db executeQuery:sql0];
    if ([rs next]) {
        //更新联系人信息
//      [_db executeUpdateWithFormat:@"UPDATE ydcontact SET name=%@ WHERE roleID=%@;",contact.name,contact.roleID];//修改昵称
      [_db executeUpdateWithFormat:@"UPDATE ydcontact SET iconUrl=%@ WHERE roleID=%@;",contact.iconUrl,contact.RoleID];//修改头像信息
    }else{
        //增加联系人信息
      [_db executeUpdate:@"insert into ydcontact (roleID,name,iconUrl) values (?,?,?);",contact.RoleID,contact.name,contact.iconUrl];
    }
}

#pragma mark - 根据roleID查询单个联系人
+(YDContact *)getContactByRoleID:(NSString *)roleID{
    YDContact *contact = [[YDContact alloc]init];
    NSString *sql0=[NSString stringWithFormat:@"select * from ydcontact WHERE roleID=%@;" ,roleID];//遍历语句
    FMResultSet *rs = [_db executeQuery:sql0];
    // 1.3.遍历
    while (rs.next) {
        NSString *roleID = [rs objectForColumnName:@"roleID"];
        NSString *name = [rs objectForColumnName:@"name"];
        NSString *iconUrl = [rs objectForColumnName:@"iconUrl"];
        contact.RoleID = roleID;
        contact.name = name;
        contact.iconUrl = iconUrl;
    }
    return contact;
}

#pragma mark - 返回所有联系人信息
+(NSMutableArray *)contactArray{
    NSMutableArray *contacts=[NSMutableArray array];
    FMResultSet *rs = [_db executeQuery:@"select * from ydcontact;"];
    // 1.3.遍历
    while (rs.next) {
        NSString *roleID = [rs objectForColumnName:@"roleID"];
        NSString *name = [rs objectForColumnName:@"name"];
        NSString *iconUrl = [rs objectForColumnName:@"iconUrl"];
        YDContact *contact = [[YDContact alloc]init];
        contact.roleID = roleID;
        contact.name = name;
        contact.iconUrl = iconUrl;
        [contacts addObject:contact];
    }
    return contacts;
}

@end

//
//  YDContactTool.h
//  shiandianping2.0
//
//  Created by 闫康 on 16/4/19.
//  Copyright © 2016年 程宏愿. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YDContact;

@interface YDContactTool : NSObject

+(YDContact *)getContactByRoleID:(NSString *)roleID;

//增加、更新联系人信息RoleId、name、iconUrl
+(void)updateContact:(YDContact *)contact;

//返回联系人列表
+(NSMutableArray *)contactArray;


@end

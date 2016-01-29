//
//  PlistManager.h
//  封装
//
//  Created by 酌晨茗 on 16/1/29.
//  Copyright © 2016年 酌晨茗. All rights reserved.
//

#import <Foundation/Foundation.h>

#define Name @"name"
#define PassWord @"password"

@interface PlistManager : NSObject

//创建
+ (void)createPlistWithName:(NSString *)name;

+ (void)name:(NSString *)name
    password:(NSString *)password;

+ (void)writeToPlistWithKey:(NSString *)key
                      value:(NSString *)value;

//读取
+ (id)readDataWithKey:(NSString *)key;

@end

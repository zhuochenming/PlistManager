//
//  PlistManager.h
//  封装
//
//  Created by 酌晨茗 on 16/1/29.
//  Copyright © 2016年 酌晨茗. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PlistName @"info"

#define Name @"name"
#define PassWord @"password"

@interface PlistManager : NSObject

//fileName不需要后缀名
+ (NSString *)documentDicWithFileName:(NSString *)fileName;

+ (NSString *)libraryDicWithFileName:(NSString *)fileName;

//会自动创建文件夹
+ (NSString *)documentDicWithDic:(NSString *)dicName fileName:(NSString *)fileName;

+ (NSString *)libraryDicWithDic:(NSString *)dicName fileName:(NSString *)fileName;

#pragma mark - 操作自己创建的plist文件
//创建 path是文件路径 要添加plist文件名和后缀
+ (void)createPlistWithPath:(NSString *)path;

//写入其他数据
+ (void)writeToPlistWithKey:(NSString *)key
                      value:(id)value
                       path:(NSString *)path;

+ (void)writeToPlistWithDic:(NSDictionary *)dic
                       path:(NSString *)path;

//读取
+ (id)readDataWithKey:(NSString *)key
                 path:(NSString *)path;

+ (id)readAllDataWithPath:(NSString *)path;

+ (void)removePlistWithPath:(NSString *)path;

#pragma mark - 只能操作默认路径的plist文件
+ (void)createPlist;

+ (void)name:(NSString *)name
    password:(NSString *)password;

//写入其他数据
+ (void)writeToPlistWithKey:(NSString *)key
                      value:(id)value;

+ (void)writeToPlistWithDic:(NSDictionary *)key;

//读取
+ (id)readDataWithKey:(NSString *)key;

+ (id)readAllData;

@end


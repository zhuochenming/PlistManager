//
//  PlistManager.h
//  封装
//
//  Created by 酌晨茗 on 16/1/29.
//  Copyright © 2016年 酌晨茗. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const DefaultPlistName = @"SearchHistory";

@interface PlistManager : NSObject

//fileName不需要后缀名
+ (NSString *)documentDicWithFileName:(NSString *)fileName;

+ (NSString *)libraryDicWithFileName:(NSString *)fileName;

//会自动创建文件夹
+ (NSString *)documentDicWithDic:(NSString *)dicName fileName:(NSString *)fileName;

+ (NSString *)libraryDicWithDic:(NSString *)dicName fileName:(NSString *)fileName;

#pragma mark - 操作默认路径的plist文件
//必须用此初始化方式，单例模式，
+ (instancetype)defaultPlist;

- (void)writeToPlistWithKey:(NSString *)key value:(id)value;

- (void)writeToPlistWithDic:(NSDictionary *)key;

- (id)readDataWithKey:(NSString *)key;

- (id)readAllData;

- (void)removePlist;

#pragma mark - 操作自己创建的plist文件
//创建 path是文件路径 要添加plist路径
- (void)createPlistWithPath:(NSString *)path;

- (void)writeToPlistWithKey:(NSString *)key value:(id)value path:(NSString *)path;

- (void)writeToPlistWithDic:(NSDictionary *)dic path:(NSString *)path;

- (id)readDataWithKey:(NSString *)key path:(NSString *)path;

- (id)readAllDataWithPath:(NSString *)path;

- (void)removePlistWithPath:(NSString *)path;

@end


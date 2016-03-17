//
//  PlistManager.m
//  封装
//
//  Created by 酌晨茗 on 16/1/29.
//  Copyright © 2016年 酌晨茗. All rights reserved.
//

#import "PlistManager.h"

@implementation PlistManager

+ (NSString *)documentDicWithFileName:(NSString *)fileName {
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *plistPath = [documentPath stringByAppendingString:[NSString stringWithFormat:@"/%@.plist", fileName]];
    return plistPath;
}

+ (NSString *)libraryDicWithFileName:(NSString *)fileName {
    NSString *libraryPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
    NSString *plistPath = [libraryPath stringByAppendingString:[NSString stringWithFormat:@"/%@.plist", fileName]];
    return plistPath;
}

+ (NSString *)documentDicWithDic:(NSString *)dicName fileName:(NSString *)fileName {
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *plistPath = [documentPath stringByAppendingString:[NSString stringWithFormat:@"/%@/%@.plist", dicName, fileName]];
    
    NSString *dicPath = [documentPath stringByAppendingString:[NSString stringWithFormat:@"/%@/", dicName]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dicName]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:dicPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return plistPath;
}

+ (NSString *)libraryDicWithDic:(NSString *)dicName fileName:(NSString *)fileName {
    NSString *libraryPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
    NSString *plistPath = [libraryPath stringByAppendingString:[NSString stringWithFormat:@"/%@/%@.plist", dicName, fileName]];
    
    NSString *dicPath = [libraryPath stringByAppendingString:[NSString stringWithFormat:@"/%@/", dicName]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dicName]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:dicPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return plistPath;
}

#pragma mark - 操作自己创建的plist文件
+ (void)createPlistWithPath:(NSString *)path {
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
    }
}

//写入其他数据
+ (void)writeToPlistWithKey:(NSString *)key
                      value:(id)value
                       path:(NSString *)path {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    if (dic == nil) {
        dic = [NSMutableDictionary dictionary];
    }
    [dic setObject:value forKey:key];
    [dic writeToFile:path atomically:YES ];
}

+ (void)writeToPlistWithDic:(NSDictionary *)dic
                       path:(NSString *)path {
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    if (mDic == nil) {
        mDic = [NSMutableDictionary dictionary];
    }
    //    NSArray *allKey = [dic allKeys];
    //    for (int i = 0; i < allKey.count; i++) {
    //        [mDic setObject:[dic objectForKey:allKey[i]] forKey:allKey[i]];
    //    }
    
    [mDic addEntriesFromDictionary:dic];
    
    [dic writeToFile:path atomically:YES];
}

//读取
+ (id)readDataWithKey:(NSString *)key
                 path:(NSString *)path {
    NSData *plistData = [NSData dataWithContentsOfFile:path];
    
    NSString *plistError;
    NSPropertyListFormat format;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        id plist = [NSPropertyListSerialization propertyListFromData:plistData mutabilityOption:NSPropertyListImmutable format:&format errorDescription:&plistError];
        return [(NSArray *)plist valueForKey:key];
#pragma clang diagnostic pop
    } else {
        NSError *error = [NSError new];
        id plist = [NSPropertyListSerialization propertyListWithData:plistData options:NSPropertyListReadCorruptError format:&format error:&error];
        return [(NSArray *)plist valueForKey:key];
    }
}

+ (id)readAllDataWithPath:(NSString *)path {
    NSData *plistData = [NSData dataWithContentsOfFile:path];
    

    NSString *plistError;
    NSPropertyListFormat format;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        id plist = [NSPropertyListSerialization propertyListFromData:plistData mutabilityOption:NSPropertyListImmutable format:&format errorDescription:&plistError];
        return (NSDictionary *)plist;
#pragma clang diagnostic pop
    } else {
        NSError *error = [NSError new];
        id plist = [NSPropertyListSerialization propertyListWithData:plistData options:NSPropertyListReadCorruptError format:&format error:&error];
        return (NSDictionary *)plist;
    }
}

+ (void)removePlistWithPath:(NSString *)path {
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager removeItemAtPath:path error:nil];
}

#pragma mark - 操作默认的plist文件
+ (NSString *)filePath {
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *plistPath = [documentPath stringByAppendingString:[NSString stringWithFormat:@"/%@.plist", PlistName]];
    return plistPath;
}

+ (void)createPlist {
    NSString *plistPath = [self filePath];
    [self createPlistWithPath:plistPath];
}

+ (void)writeToPlistWithKey:(NSString *)key
                      value:(id)value {
    NSString *path = [self filePath];
    [self writeToPlistWithKey:key value:value path:path];
}

+ (void)writeToPlistWithDic:(NSDictionary *)dic {
    NSString *path = [self filePath];
    [self writeToPlistWithDic:dic path:path];
}

+ (void)name:(NSString *)name
    password:(NSString *)password {
    NSString *path = [self filePath];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    if (dic == nil) {
        dic = [NSMutableDictionary dictionary];
    }
    
    [dic setObject:name forKey:Name];
    [dic setObject:password forKey:PassWord];
    
    [dic writeToFile:path atomically:YES];
}

//读取
+ (id)readDataWithKey:(NSString *)key {
    NSString *path = [self filePath];
    return [self readDataWithKey:key path:path];
}

+ (id)readAllData {
    NSString *path = [self filePath];
    return [self readAllDataWithPath:path];
}

@end


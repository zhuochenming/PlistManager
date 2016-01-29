//
//  PlistManager.m
//  封装
//
//  Created by 酌晨茗 on 16/1/29.
//  Copyright © 2016年 酌晨茗. All rights reserved.
//

#import "PlistManager.h"
#import <objc/runtime.h>

static char PathKey;

#define CustomName @"info"

@implementation PlistManager

+ (void)createPlistWithName:(NSString *)name {
    if (name == nil) {
        name = CustomName;
    }
    
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *plistPath = [documentPath stringByAppendingString:[NSString stringWithFormat:@"/%@.plist", name]];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        [[NSFileManager defaultManager] createFileAtPath:plistPath contents:nil attributes:nil];
    }
    
    objc_setAssociatedObject(self, &PathKey, plistPath, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

+ (void)writeToPlistWithKey:(NSString *)key
                      value:(NSString *)value {
    NSString *path = objc_getAssociatedObject(self, &PathKey);
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    [dict setObject:value forKey:key];
    [dict writeToFile:path atomically:YES ];
}

+ (void)name:(NSString *)name
    password:(NSString *)password {
    NSString *path = objc_getAssociatedObject(self, &PathKey);
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    if (dic == nil) {
        dic = [NSMutableDictionary dictionary];
    }
 
    [dic setObject:name forKey:Name];
    [dic setObject:password forKey:PassWord];

    [dic writeToFile:path atomically:YES ];
}

//读取
+ (id)readDataWithKey:(NSString *)key {
    NSString *path = objc_getAssociatedObject(self, &PathKey);
    NSData *plistData = [NSData dataWithContentsOfFile:path];
    
    NSString *plistError;
    NSPropertyListFormat format;
    
    id plist = [NSPropertyListSerialization propertyListFromData:plistData mutabilityOption:NSPropertyListImmutable format:&format errorDescription:&plistError];
    return [(NSArray *)plist valueForKey:key];
}

@end

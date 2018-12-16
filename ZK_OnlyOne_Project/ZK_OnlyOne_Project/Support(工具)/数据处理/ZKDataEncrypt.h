//
//  ZKDataEncrypt.h
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/13.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZKDataEncrypt : NSObject
/** 时间戳 转为时间*/
+ (NSString *)getTimeFromTimesTamp:(NSString *)timeStr;

/** 获取当前时间戳，以毫秒为单位*/
+ (NSString *)getNowTimeTimestamp3:(NSDate *)datenow;

/**获取到昨天的时间*/
+ (NSDate *)getYesTadayFromTimeTamp;

/**过滤掉html标签和特殊字符*/
+ (NSString *)flattenHTML:(NSString *)html;

/**正则去掉网络标签*/
+(NSString *)getZZwithString:(NSString *)string;
@end


NS_ASSUME_NONNULL_END

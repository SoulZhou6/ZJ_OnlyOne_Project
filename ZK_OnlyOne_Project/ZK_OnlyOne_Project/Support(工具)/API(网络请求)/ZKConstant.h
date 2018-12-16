//
//  ZKConstant.h
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/11.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZKConstant : NSObject
/** 用户token*/
extern NSString *const token;

/**新闻接口地址*/
extern NSString * const newsUrl;
/**新闻appKey*/
extern NSString * const newsAppKey;


/**笑话----按更新时间查询笑话---- 接口地址*/
extern NSString * const jokeListUrl;
/**笑话----最新笑话---- 接口地址*/
extern NSString * const jokeTextUrl;

/**笑话----随机获取笑话---- 接口地址*/
extern NSString * const randJokeTextUrl;

/**笑话----AppKey*/
extern NSString * const jokeAppKey;
@end

NS_ASSUME_NONNULL_END

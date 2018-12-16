//
//  ZKConstant.m
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/11.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import "ZKConstant.h"

@implementation ZKConstant
/** 用户token*/
NSString *const token = @"token";

/**新闻接口地址*/
NSString * const newsUrl = @"http://v.juhe.cn/toutiao/index";

/**新闻appKey*/
NSString * const newsAppKey = @"54c0a6a946620b7e5175e5a86b25bb01";


/**笑话----按更新时间查询笑话---- 接口地址*/
NSString * const jokeListUrl = @"http://v.juhe.cn/joke/content/list.php";
/**笑话----最新笑话---- 接口地址*/
NSString * const jokeTextUrl = @"http://v.juhe.cn/joke/content/text.php";

/**笑话----随机获取笑话---- 接口地址*/
NSString * const randJokeTextUrl = @"http://v.juhe.cn/joke/randJoke.php";

/**笑话----AppKey*/
NSString * const jokeAppKey = @"1e9c37d70598e21f56bc2890d36c635e";
@end

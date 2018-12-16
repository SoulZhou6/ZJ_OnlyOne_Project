//
//  ZKDuanziObj.h
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/16.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZKDuanziObj : NSObject<YYModel>
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *hashId;
@property (nonatomic, strong) NSString *unixtime;
@property (nonatomic, strong) NSString *updatetime;
@end

NS_ASSUME_NONNULL_END

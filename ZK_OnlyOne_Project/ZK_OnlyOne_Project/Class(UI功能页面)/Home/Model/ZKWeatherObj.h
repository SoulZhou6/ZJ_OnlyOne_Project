//
//  ZKWeatherObj.h
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/19.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZKWeatherObj : NSObject<YYModel>
@property (nonatomic,strong)NSString * aqi;
@property (nonatomic,strong)NSString * city;
@property (nonatomic,strong)NSArray  * forecast;
@property (nonatomic,strong)NSString * ganmao;
@property (nonatomic,strong)NSString * wendu;
@property (nonatomic,strong)NSDictionary * yesterday;
@end

NS_ASSUME_NONNULL_END

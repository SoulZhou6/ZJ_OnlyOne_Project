//
//  ZKForecastObj.h
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/19.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZKForecastObj : NSObject<YYModel>
@property (nonatomic,strong)NSString * date;
@property (nonatomic,strong)NSString * fengli;
@property (nonatomic,strong)NSString * fengxiang;
@property (nonatomic,strong)NSString * high;
@property (nonatomic,strong)NSString * low;
@property (nonatomic,strong)NSString * type;
@end

NS_ASSUME_NONNULL_END

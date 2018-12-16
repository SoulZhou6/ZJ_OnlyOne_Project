//
//  ZKHomeObj.h
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/13.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZKHomeObj : NSObject<YYModel>

@property (nonatomic, strong) NSObject * uniquekey;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * date;
@property (nonatomic, strong) NSArray * category;
@property (nonatomic, strong) NSObject * author_name;
@property (nonatomic, strong) NSString * url;
@property (nonatomic, strong) NSString * thumbnail_pic_s;
@property (nonatomic, strong) NSString * thumbnail_pic_s02;
@property (nonatomic, strong) NSString * thumbnail_pic_s03;
@end

NS_ASSUME_NONNULL_END

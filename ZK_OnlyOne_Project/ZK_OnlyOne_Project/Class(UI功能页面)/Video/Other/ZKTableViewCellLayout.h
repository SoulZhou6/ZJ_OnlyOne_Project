//
//  ZKTableViewCellLayout.h
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/18.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZKVideoObj.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZKTableViewCellLayout : NSObject
@property (nonatomic, strong) ZKVideoObj *data;
@property (nonatomic, readonly) CGRect headerRect;
@property (nonatomic, readonly) CGRect nickNameRect;
@property (nonatomic, readonly) CGRect videoRect;
@property (nonatomic, readonly) CGRect playBtnRect;
@property (nonatomic, readonly) CGRect titleLabelRect;
@property (nonatomic, readonly) CGRect maskViewRect;
@property (nonatomic, readonly) CGFloat height;
@property (nonatomic, readonly) BOOL isVerticalVideo;

- (instancetype)initWithData:(ZKVideoObj *)data;
@end

NS_ASSUME_NONNULL_END

//
//  ZKTableViewProtocol.h
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/13.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZKTableViewProtocol : NSObject<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray * newsArray;
@end

NS_ASSUME_NONNULL_END

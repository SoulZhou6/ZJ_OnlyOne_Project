//
//  ZKVideoCell.h
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/18.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKTableViewCellLayout.h"
#import "ZKVideoObj.h"
@protocol ZKTableViewCellDelegate <NSObject>

- (void)zk_playTheVideoAtIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_BEGIN

@interface ZKVideoCell : UITableViewCell

@property (nonatomic, strong) ZKTableViewCellLayout *layout;

@property (nonatomic, copy) void(^playCallback)(void);

- (void)setDelegate:(id<ZKTableViewCellDelegate>)delegate withIndexPath:(NSIndexPath *)indexPath;

- (void)showMaskView;

- (void)hideMaskView;

- (void)setNormalMode;
@end

NS_ASSUME_NONNULL_END

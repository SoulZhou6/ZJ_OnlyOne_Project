//
//  ZKBaseTableViewCell.h
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/24.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZKBaseTableViewCell : UITableViewCell
+ (instancetype)initWithTableView:(UITableView *)tableView;

+ (instancetype)initWithTableView:(UITableView *)tableView andIdentifier:(NSString *)identifier;

- (void)setUpSubViews;
@end

NS_ASSUME_NONNULL_END

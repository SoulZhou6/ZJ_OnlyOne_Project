//
//  ZKDuanziCell.h
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/16.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKDuanziObj.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZKDuanziCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *updateDate;

@property (nonatomic,strong)ZKDuanziObj * duanZiObj;
@end

NS_ASSUME_NONNULL_END

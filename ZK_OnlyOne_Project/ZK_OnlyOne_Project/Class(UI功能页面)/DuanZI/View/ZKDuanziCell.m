//
//  ZKDuanziCell.m
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/16.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import "ZKDuanziCell.h"

@implementation ZKDuanziCell


+(instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier{
    
    
    ZKDuanziCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZKDuanziCell" owner:self options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)setDuanZiObj:(ZKDuanziObj *)duanZiObj{
    
    self.content.text = [ZKDataEncrypt getZZwithString:duanZiObj.content];
    
    self.updateDate.text = [NSString stringWithFormat:@"更新时间: %@",[ZKDataEncrypt getTimeFromTimesTamp:duanZiObj.unixtime]];
   
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.content.layer.cornerRadius = 10.0;
    self.content.layer.masksToBounds = YES;
    self.content.layer.shadowOffset =  CGSizeMake(5, 5);
    self.content.layer.shadowOpacity = 0.8;
    self.content.layer.shadowColor =  [UIColor orangeColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  ZKBaseTableViewCell.m
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/24.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import "ZKBaseTableViewCell.h"

@implementation ZKBaseTableViewCell


+ (instancetype)initWithTableView:(UITableView *)tableView{
    NSString *cellID = NSStringFromClass([self class]);
    id cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil] firstObject];
        
    }
    return cell;
}

+ (instancetype)initWithTableView:(UITableView *)tableView andIdentifier:(NSString *)identifier{
    id cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpSubViews];
        
        
    }
    return self;
}

- (void)setUpSubViews{
    
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

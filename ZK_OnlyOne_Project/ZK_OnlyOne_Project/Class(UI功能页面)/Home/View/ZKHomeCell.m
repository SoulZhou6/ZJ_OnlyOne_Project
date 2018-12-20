//
//  ZKHomeCell.m
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/13.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import "ZKHomeCell.h"
#import "ZKHomeObj.h"

@implementation ZKHomeCell


+(instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier index:(NSInteger)index{
    
    
    ZKHomeCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZKHomeCell" owner:self options:nil] objectAtIndex:index];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)setHomeObj:(ZKHomeObj *)model index:(NSInteger)index{
    
//    DLog(@" %ld==%@== %lu",index,model.imageUrls,(unsigned long)model.imageUrls.count);
    
    switch (index) {
        case 0:
            self.contentOne.text = model.title;
            [self.oneImgOne setImageWithURL:[NSURL URLWithString:model.thumbnail_pic_s] placeholderImage:DefaultImage];
            [self.oneImgTwo setImageWithURL:[NSURL URLWithString:model.thumbnail_pic_s02] placeholderImage:DefaultImage];
            [self.oneImgThree setImageWithURL:[NSURL URLWithString:model.thumbnail_pic_s03] placeholderImage:DefaultImage];
            self.sourceOne.text = [NSString stringWithFormat:@"数据来源: %@     发布时间: %@",model.author_name,model.date];
            
            break;
        case 1:
            
            self.contentTwo.text = model.title;
            [self.contentTwo sizeToFit];
            [self.TwoImage setImageWithURL:[NSURL URLWithString:model.thumbnail_pic_s] placeholderImage:DefaultImage];
           self.sourceTwo.text = [NSString stringWithFormat:@"数据来源: %@     发布时间: %@",model.author_name,model.date];
            break;
        case 2:
            self.contentThree.text = model.title;
            
            self.sourceThree.text = [NSString stringWithFormat:@"数据来源: %@   发布时间: %@",model.author_name,model.date];
            break;
            
        default:
            break;
    }
   
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

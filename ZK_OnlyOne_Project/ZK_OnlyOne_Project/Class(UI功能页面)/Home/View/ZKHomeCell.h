//
//  ZKHomeCell.h
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/13.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKHomeObj.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZKHomeCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier index:(NSInteger)index;

//// 第一个cell
@property (weak, nonatomic) IBOutlet UILabel *contentOne;
@property (weak, nonatomic) IBOutlet UIImageView *oneImgOne;
@property (weak, nonatomic) IBOutlet UIImageView *oneImgTwo;
@property (weak, nonatomic) IBOutlet UIImageView *oneImgThree;
@property (weak, nonatomic) IBOutlet UILabel *sourceOne;

//// 第二个cell
@property (weak, nonatomic) IBOutlet UILabel *contentTwo;
@property (weak, nonatomic) IBOutlet UIImageView *TwoImage;
@property (weak, nonatomic) IBOutlet UILabel *sourceTwo;

//// 第三个cell
@property (weak, nonatomic) IBOutlet UILabel *contentThree;
@property (weak, nonatomic) IBOutlet UILabel *sourceThree;

//// 第四个cell
@property (weak, nonatomic) IBOutlet UILabel *contentFour;
@property (weak, nonatomic) IBOutlet UIImageView *fourImgOne;
@property (weak, nonatomic) IBOutlet UIImageView *fourImgTwo;
@property (weak, nonatomic) IBOutlet UILabel *sourceFour;


- (void)setHomeObj:(ZKHomeObj *)model index:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END

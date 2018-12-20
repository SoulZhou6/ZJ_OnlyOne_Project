//
//  ZKHomeHeadView.h
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/19.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKWeatherObj.h"
#import <SDWebImage/FLAnimatedImageView+WebCache.h>
NS_ASSUME_NONNULL_BEGIN

@interface ZKHomeHeadView : UIView
+ (instancetype)initWithNibFrame:(CGRect)frame;

@property (weak, nonatomic) IBOutlet UIView *weatherView;
@property (weak, nonatomic) IBOutlet FLAnimatedImageView *bgImage;

@property (weak, nonatomic) IBOutlet UILabel *todayDagree;
@property (weak, nonatomic) IBOutlet UILabel *city;
@property (weak, nonatomic) IBOutlet UILabel *todayMaxMinGagree;
@property (weak, nonatomic) IBOutlet UIImageView *todayImg;
@property (weak, nonatomic) IBOutlet UILabel *todayStatus;

@property (weak, nonatomic) IBOutlet UILabel *torrow;
@property (weak, nonatomic) IBOutlet UILabel *torrowStatus;
@property (weak, nonatomic) IBOutlet UILabel *torrowMaxMinGagree;
@property (weak, nonatomic) IBOutlet UIImageView *torrowImg;

@property (weak, nonatomic) IBOutlet UILabel *afterTomorrow;
@property (weak, nonatomic) IBOutlet UILabel *afterTomorrowStatus;
@property (weak, nonatomic) IBOutlet UILabel *afterTomorrowMaxMinAggree;
@property (weak, nonatomic) IBOutlet UIImageView *afterTomorrowImg;




@property (nonatomic,strong)ZKWeatherObj * weatherObj;
@end

NS_ASSUME_NONNULL_END

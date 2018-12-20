//
//  ZKHomeHeadView.m
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/19.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import "ZKHomeHeadView.h"
#import "ZKForecastObj.h"
@implementation ZKHomeHeadView


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.bgImage.layer.cornerRadius = 3.0f;
    self.bgImage.layer.masksToBounds = YES;

}

+ (instancetype)initWithNibFrame:(CGRect)frame
{
    NSArray *viewArr = [[NSBundle mainBundle] loadNibNamed:@"ZKHomeHeadView" owner:nil options:nil];
    ZKHomeHeadView *view = [viewArr lastObject];
    CGPoint point = (CGPoint){0,0};
    CGSize size = (CGSize){frame.size.width,frame.size.height};
    view.frame = (CGRect){point,size};
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (void)setWeatherObj:(ZKWeatherObj *)weatherObj{
    
    ZKForecastObj * forecast = [ZKForecastObj yy_modelWithDictionary:[weatherObj.forecast firstObject]];
    ZKForecastObj * forecastOne = [ZKForecastObj yy_modelWithDictionary:weatherObj.forecast[1]];
     ZKForecastObj * forecastTwo = [ZKForecastObj yy_modelWithDictionary:weatherObj.forecast[2]];
//    if([forecast.type isEqualToString:@"多云"]){
    
    
//    NSString *filepath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:@"cloudy.gif" ofType:nil];
//    NSData *imagedata = [NSData dataWithContentsOfFile:filepath];
//
//    FLAnimatedImage *image=  [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://img1.imgtn.bdimg.com/it/u=473895314,616407725&fm=206&gp=0.jpg"]]];
    
//    }
    self.todayImg.image = [UIImage imageNamed:@"duoyun"];
    self.todayDagree.text = [NSString stringWithFormat:@"%@°",weatherObj.wendu];
    self.city.text = [NSString stringWithFormat:@"%@市",weatherObj.city];
    self.todayMaxMinGagree.text = [NSString stringWithFormat:@"%@/%@",forecast.high,forecast.low];
    self.todayStatus.text = [NSString stringWithFormat:@"%@ %@",forecast.type,weatherObj.ganmao];
    
    self.torrow.text = forecastOne.date;
    self.torrowImg.image = [UIImage imageNamed:@"duoyun"];
    self.torrowStatus.text = forecastOne.type;
    self.torrowMaxMinGagree.text = [NSString stringWithFormat:@"%@/%@",[forecastOne.high substringFromIndex:2],[forecastOne.low substringFromIndex:2]];
    
    self.afterTomorrow.text = forecastTwo.date;
    self.afterTomorrowImg.image = [UIImage imageNamed:@"yin"];
    self.afterTomorrowStatus.text = forecastTwo.type;
    self.afterTomorrowMaxMinAggree.text = [NSString stringWithFormat:@"%@/%@",[forecastTwo.high substringFromIndex:2],[forecastTwo.low substringFromIndex:2]];
}

@end

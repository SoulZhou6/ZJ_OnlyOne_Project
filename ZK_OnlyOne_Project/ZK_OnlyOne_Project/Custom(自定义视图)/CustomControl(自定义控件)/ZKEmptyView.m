//
//  ZKEmptyView.m
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/11.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import "ZKEmptyView.h"

@implementation ZKEmptyView

-(instancetype)initWithFrame:(CGRect)frame titlt:(NSString *)title
{
    if (self == [super initWithFrame:frame]) {
        
        self.frame = frame;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_Empty_pages"]];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(80);
            make.centerX.mas_equalTo(self);
            make.width.height.mas_equalTo(150);
        }];
        
        UILabel *label = [[UILabel alloc] init];
        label.font = BOLD_FONT(13);
        label.textColor = RGBA(200, 200, 200, 1);
        label.text = title;
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(imageView.mas_bottom).mas_offset(12);
            make.centerX.mas_equalTo(self);
        }];
    }
    return self;
}

@end

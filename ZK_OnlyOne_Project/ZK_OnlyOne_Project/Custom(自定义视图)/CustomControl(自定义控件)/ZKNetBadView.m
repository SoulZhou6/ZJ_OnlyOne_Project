//
//  ZKNetBadView.m
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/12.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import "ZKNetBadView.h"

@implementation ZKNetBadView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *netBadImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_network_error"]];
        [self addSubview:netBadImageView];
        [netBadImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(72.5);
            make.width.mas_equalTo(94.5);
            make.height.mas_equalTo(75);
            make.centerX.mas_equalTo(self);
        }];
        
        UILabel *title_label = [[UILabel alloc] init];
        title_label.text = @"网络不太给力";
        title_label.font = FONT(15);
        title_label.textColor =[UIColor colorWithHexString:@"#323232"];
        [self addSubview:title_label];
        [title_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(netBadImageView.mas_bottom).mas_offset(40);
            make.centerX.mas_equalTo(self);
        }];
        
        UILabel *noticeLabel = [[UILabel alloc] init];
        noticeLabel.text = @"请查看网络连接后点击";
        noticeLabel.font = FONT(12.5);
        noticeLabel.textColor =[UIColor colorWithHexString:@"#989898"];
        [self addSubview:noticeLabel];
        [noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(title_label.mas_bottom).mas_offset(40);
            make.centerX.mas_equalTo(self).mas_offset(-10);
        }];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"重试" forState:UIControlStateNormal];
        button.titleLabel.font = FONT(12.5);
        [button setTitleColor:[UIColor colorWithHexString:@"#06b5e5"] forState:UIControlStateNormal];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(noticeLabel.mas_right).mas_offset(5);
            make.centerY.mas_equalTo(noticeLabel);
        }];
        
        [button addTarget:self action:@selector(reStart) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)reStartCallBack:(reStartBlock)block
{
    _block = block;
}

-(void)reStart
{
    if (self.block) {
        self.block();
    }
}

@end

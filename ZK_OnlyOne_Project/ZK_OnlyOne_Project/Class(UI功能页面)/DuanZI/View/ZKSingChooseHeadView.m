//
//  ZKSingChooseHeadView.m
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/25.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import "ZKSingChooseHeadView.h"

@implementation ZKSingChooseHeadView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

+ (instancetype)initWithNibFrame:(CGRect)frame Index:(NSInteger)index
{
    NSArray *viewArr = [[NSBundle mainBundle] loadNibNamed:@"ZKSingChooseHeadView" owner:nil options:nil];
    ZKSingChooseHeadView *view = viewArr[index];
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

@end

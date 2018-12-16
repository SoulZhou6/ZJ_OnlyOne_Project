//
//  UILabel+Extension.h
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/11.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Extension)
/**根据宽度求高度  content 计算的内容  width 计算的宽度 font字体大小*/
+ (CGFloat)getLabelHeightWithText:(NSString *)text width:(CGFloat)width font: (CGFloat)font;

//// 计算高度
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;
//// 计算宽度
+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font;


@end

NS_ASSUME_NONNULL_END

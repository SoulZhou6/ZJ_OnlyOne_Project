//
//  UIColor+Extension.h
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/11.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Extension)
// 透明度固定为1，以0x开头的十六进制转换成的颜色
+ (UIColor *)colorWithHex:(long)hexColor;
// 0x开头的十六进制转换成的颜色,透明度可调整
+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity;
// 颜色转换三：iOS中十六进制的颜色（以#开头）转换为UIColor
+ (UIColor *) colorWithHexString: (NSString *)color;

// 设置背景颜色为渐变色
+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr;



/**应用主题色*/
+ (UIColor *)colorThemeColor;
//导航栏毛玻璃效果导致的色差  ，假导航用这个上色
+ (UIColor *)newThemeColor;

/**应用辅助色*/
+ (UIColor *)colorAssistColor;
/**应用常用灰*/
+ (UIColor *)colorLightGrayColor;

/**随机色*/
+ (UIColor *)colorWithRandom;

/**HUD的背景颜色*/
+(UIColor *)colorHudColor;

/**导航栏颜色*/
+ (UIColor *)colorNavigationBarColor;

/**view背景色*/
+ (UIColor *)colorBackGroundColor;
/**分割线灰*/
+ (UIColor *)colorBoardLineColor;
/**view纯白背景色*/
+ (UIColor *)colorWhiteColor;
/**view偏灰色背景色*/
+(UIColor *)viewBackGroundColor;
/**登录&注册输入框分割线颜色*/
+ (UIColor *)colorLoginRgisterLineColor;


/**深色字体*/
+ (UIColor *)colorDarkTextColor;
/**浅色字*/
+ (UIColor *)colorLightTextColor;
/**渐变*/
+ (CAGradientLayer *)shadowAsInverseWithFrame:(CGRect)frame;


/**
 修改颜色的辅助色
 */
+ (UIColor *)colorTextAssistColor;

/**
 常用按钮字体&背景颜色
 */
+ (UIColor *)totalLabelColor;

/**
 按钮辅助色
 */
+ (UIColor *)colorButtonAssistColor;

@end

NS_ASSUME_NONNULL_END

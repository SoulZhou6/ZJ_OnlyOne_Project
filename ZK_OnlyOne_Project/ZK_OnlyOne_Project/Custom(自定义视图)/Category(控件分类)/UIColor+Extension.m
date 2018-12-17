//
//  UIColor+Extension.m
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/11.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)
// 透明度固定为1，以0x开头的十六进制转换成的颜色
+ (UIColor*) colorWithHex:(long)hexColor;
{
    return [UIColor colorWithHex:hexColor alpha:1.];
}
// 0x开头的十六进制转换成的颜色,透明度可调整
+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity
{
    float red = ((float)((hexColor & 0xFF0000) >> 16))/255.0;
    float green = ((float)((hexColor & 0xFF00) >> 8))/255.0;
    float blue = ((float)(hexColor & 0xFF))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:opacity];
}
// 颜色转换三：iOS中十六进制的颜色（以#开头）转换为UIColor
+ (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // 判断前缀并剪切掉
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}


//绘制渐变色颜色的方法
+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr{
    
    //    CAGradientLayer类对其绘制渐变背景颜色、填充层的形状(包括圆角)
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = view.bounds;
    
    //  创建渐变色数组，需要转换为CGColor颜色
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexString:fromHexColorStr].CGColor,(__bridge id)[UIColor colorWithHexString:toHexColorStr].CGColor];
    
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    
    //  设置颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = @[@0,@1];
    
    return gradientLayer;
}

+(UIColor *)colorWithRandom{
    
    CGFloat red = arc4random()%256/255.0;
    CGFloat green = arc4random()%256/255.0;
    CGFloat blue = arc4random()%256/255.0;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}

+(UIColor *)colorThemeColor
{
    return [UIColor colorWithHexString:@"1296db"];
}

//用主题色导致色差明显
+ (UIColor *)newThemeColor
{
    return [UIColor colorWithRed:236/255.0 green:185/255.0 blue:103/255.0 alpha:1];
}

+(UIColor *)colorAssistColor{
    
    return [UIColor colorWithRed:242/255.0 green:170/255.0 blue:15/255.0 alpha:1];
}

+(UIColor *)colorHudColor {
    
    return [UIColor colorWithRed:36/255.0 green:36/255.0 blue:36/255.0 alpha:0.8];
}

+(UIColor *)colorLightGrayColor{
    
    return [UIColor colorWithRed:152/255.0 green:152/255.0 blue:152/255.0 alpha:1];
}

+(UIColor *)colorBackGroundColor{
    
    return [UIColor colorWithHexString:@"F8F8F8"];
}

+(UIColor *)colorBoardLineColor{
    
    return [UIColor colorWithHexString:@"E8E8E8"];
}

+ (UIColor *)colorWhiteColor{
    
    return [UIColor colorWithHexString:@"FFFFFF"];
}

+ (UIColor *)viewBackGroundColor {
    
    return [UIColor colorWithHexString:@"F1F1F1"];
}

+ (UIColor *)colorLoginRgisterLineColor {
    
    return [UIColor colorWithHexString:@"fed1a6"];
}


+ (UIColor *)colorDarkTextColor{
    
    return [UIColor colorWithHexString:@"323232"];
}

+ (UIColor *)colorLightTextColor{
    
    return [UIColor colorWithHexString:@"989898"];
}

+(UIColor *)colorNavigationBarColor{
    
    return [UIColor colorWithRed:235/255.0 green:176/255.0 blue:70/255.0 alpha:1];
    //return [UIColor colorWithHexString:@"fbb65e"];
}

+ (CAGradientLayer *)shadowAsInverseWithFrame:(CGRect)frame
{
    CAGradientLayer *newShadow = [[CAGradientLayer alloc] init];
    newShadow.frame = frame;
    newShadow.startPoint = CGPointMake(0, .5);
    newShadow.endPoint = CGPointMake(0, 1);
    //添加渐变的颜色组合（颜色透明度的改变）
    newShadow.colors = [NSArray arrayWithObjects:
                        (id)[[[UIColor colorThemeColor] colorWithAlphaComponent:.95] CGColor],
                        (id)[[[UIColor colorThemeColor] colorWithAlphaComponent:.9] CGColor],
                        (id)[[[UIColor colorThemeColor] colorWithAlphaComponent:.85] CGColor],
                        (id)[[[UIColor colorThemeColor] colorWithAlphaComponent:.8] CGColor],
                        (id)[[[UIColor colorThemeColor] colorWithAlphaComponent:.75] CGColor],
                        (id)[[[UIColor colorThemeColor] colorWithAlphaComponent:.7] CGColor],
                        (id)[[[UIColor colorThemeColor] colorWithAlphaComponent:.65] CGColor],
                        (id)[[[UIColor colorThemeColor] colorWithAlphaComponent:.6] CGColor],
                        (id)[[[UIColor colorThemeColor] colorWithAlphaComponent:0.55] CGColor],
                        nil];
    //    newShadow.locations = locations;
    return newShadow;
}

/**
 修改颜色的辅助色
 */
+ (UIColor *)colorTextAssistColor{
    
    return [UIColor colorWithHexString:@"ff4200"];
}


/**
 常用按钮字体&背景颜色
 */
+ (UIColor *)totalLabelColor {
    
    return [UIColor colorWithHexString:@"fbb65e"];
}

/**
 按钮辅助色
 */
+ (UIColor *)colorButtonAssistColor{
    
    return [UIColor colorWithHexString:@"ff9850"];
}


@end

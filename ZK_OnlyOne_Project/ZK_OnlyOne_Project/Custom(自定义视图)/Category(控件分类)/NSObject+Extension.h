//
//  NSObject+Extension.h
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/12.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define ZK_THEME_COLOR @"ZK_THEME_COLOR"
#define ZK_THEME_IMAGE @"ZK_THEME_IMAGE"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Extension)
// 添加到主题属性池
- (void)addToThemeColorPool:(NSString *)propertyName;

// 添加到主题属性池,颜色参数为缺省
// 例子: [button addToThemeColorPoolWithSelector:@selector(setTitleColor:forState:) objects:@[FA_THEME_COLOR, @(UIControlStateSelected)]];
- (void)addToThemeColorPoolWithSelector:(SEL)selector objects:(NSArray *)objects;

// 添加到主题图片池,图片参数为缺省
// 例子: [tabBarBackgroundImageView addToThemeImagePoolWithSelector:@selector(setImage:) objects:@[FA_THEME_IMAGE]];
// 图片注意使用拉伸避免导航显示问题: UIImage *img = [[UIImage imageNamed:@"testImage/bannerB"] resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
// 图片注意 imageWithRenderingMode 会和拉伸冲突
- (void)addToThemeImagePoolWithSelector:(SEL)selector objects:(NSArray *)objects;

// 设置主题色
- (void)setThemeColor:(UIColor *)color;

// 设置主题色和主题背景图
- (void)setThemeColor:(UIColor *)color image:(UIImage *)themeImage;

// 从主题池移除
- (void)removeFromThemeColorPoolWithSelector:(SEL)selector;
@end

NS_ASSUME_NONNULL_END

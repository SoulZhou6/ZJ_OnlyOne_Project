//
//  UIBarButtonItem+Extension.h
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/16.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action;


/** 高亮状态 */
+ (instancetype)itemWithImage:(NSString *)img highlightImg:(NSString *)highlightImg target:(id)target action:(SEL)action;

/** 选中状态 */
+ (instancetype)itemWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage target:(id)target action:(SEL)action;

/** 高亮状态+Title  */
+ (instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image hightImage:(UIImage *)hightImage target:(id)target action:(SEL)action;

/** 选中状态+Title */
+ (instancetype)itemWithTitle:(NSString *)title Image:(UIImage *)image selectImage:(UIImage *)selectImage target:(id)target action:(SEL)action;
@end

NS_ASSUME_NONNULL_END

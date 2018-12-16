//
//  ZKButton.h
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/11.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, ZKButtonStyle){
    ZKButtonStyleTop,       // 图片在上，文字在下
    ZKButtonStyleLeft,      // 图片在左，文字在右
    ZKButtonStyleRight,     // 图片在右，文字在左
    ZKButtonStyleBottom,    // 图片在下，文字在上
};
@interface ZKButton : UIButton
/**
 KYButton的样式(Top、Left、Right、Bottom)
 */
@property (nonatomic, assign) ZKButtonStyle style;

/**
 图片和文字的间距
 */
@property (nonatomic, assign) CGFloat space;

/**
 整个KYButton(包含ImageV and titleV)的内边距
 */
@property (nonatomic, assign) CGFloat delta;
@end

NS_ASSUME_NONNULL_END

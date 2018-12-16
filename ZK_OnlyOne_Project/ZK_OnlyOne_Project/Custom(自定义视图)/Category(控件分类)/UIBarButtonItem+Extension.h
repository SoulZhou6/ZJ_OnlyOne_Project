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
@end

NS_ASSUME_NONNULL_END

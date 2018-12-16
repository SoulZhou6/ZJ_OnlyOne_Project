//
//  UITextView+Extension.h
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/11.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (Extension)
/**计算内容的高度*/
+ (float) heightForTextView: (UITextView *)textView WithText: (NSString *) strText;
@end

NS_ASSUME_NONNULL_END

//
//  ZKEmptyView.h
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/11.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZKEmptyView : UIView

/**
 列表空视图

 @param frame 视图大小
 @param title 视图填充标题
 @return 返回视图
 */
-(instancetype)initWithFrame:(CGRect)frame titlt:(NSString *)title;
@end

NS_ASSUME_NONNULL_END

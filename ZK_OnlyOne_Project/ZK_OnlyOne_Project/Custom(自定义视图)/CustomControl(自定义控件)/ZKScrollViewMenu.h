//
//  ZKScrollViewMenu.h
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/17.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZKScrollViewMenu;

typedef void(^ScrollDidBlock)(NSInteger index);

@protocol ZKScrollViewMenuDelegate<NSObject>
@optional
- (void)scroll:(ZKScrollViewMenu *)scroll didSelectItemAtIndex:(NSInteger)index;

@end
@interface ZKScrollViewMenu : UIView

- (instancetype)initWithOrigin:(CGPoint)origin
                        height:(CGFloat)height;

- (instancetype)initWithOrigin:(CGPoint)origin
                        height:(CGFloat)height
                        titles:(NSArray *)titles;

- (instancetype)initWithOrigin:(CGPoint)origin
                         width:(CGFloat)width
                        height:(CGFloat)height
                        titles:(NSArray *)titles;

/** 滚动到指定位置(并选中) */
- (void)scrollToAtIndex:(NSInteger)index;
/** 隐藏底部分割线(默认显示) */
@property (nonatomic, assign) BOOL hideLine;
/** 获取滚动的索引位置 */
@property (nonatomic, copy) ScrollDidBlock scrollDidBlock;
/** 设置菜单选中的颜色 */
@property (nonatomic, strong) UIColor *tintColor;
/** 标题数组(外界设置) */
@property (nonatomic, strong) NSArray *titleStringGroup;

@property (nonatomic, weak) id<ZKScrollViewMenuDelegate> delegate;

@property (nonatomic, assign) CGPoint scrollPoint;
@end

NS_ASSUME_NONNULL_END

//
//  ZKSegmentView.h
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/25.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol  ZKSegmentViewDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface ZKSegmentView : UIView


#pragma mark - 属性
//标题数组
@property (nonatomic, copy) NSArray *titles;
//未选中文字、边框、滑块颜色
@property (nonatomic, strong) UIColor *textColor;
//背景、选中文字颜色，当设置为透明时，选中文字为白色
@property (nonatomic, strong) UIColor *viewColor;
//选中的标题
@property (nonatomic) NSInteger selectNumber;

#pragma mark - 方法
/*
 初始化方法
 设置标题
 */
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;

/*
 设置标题
 */
- (void)setTitles:(NSArray *)titles;

/*
 设置选中的标题
 超出范围，则为最后一个标题
 
 或者使用隐藏的
 - (void)setSelectNumber:(NSInteger)selectNumber
 方法，默认无动画效果。
 */
- (void)setSelectNumber:(NSInteger)selectNumber animate:(BOOL)animate;

#pragma mark - 代理

@property (nonatomic, weak) id <ZKSegmentViewDelegate>delegate;

@end

@protocol ZKSegmentViewDelegate <NSObject>

@optional

/*
 当滑动XSSegmentedView滑块时，或者XSSegmentedView被点击时，会调用此方法。
 */
- (void)zkSegmentedView:(ZKSegmentView *)ZKSegmentView selectTitleInteger:(NSInteger)integer;

/*
 是否允许被选中
 返回YES可以被选中
 返回NO不可以被选中
 */
- (BOOL)zkSegmentedView:(ZKSegmentView *)ZKSegmentView didSelectTitleInteger:(NSInteger)integer;
@end

NS_ASSUME_NONNULL_END

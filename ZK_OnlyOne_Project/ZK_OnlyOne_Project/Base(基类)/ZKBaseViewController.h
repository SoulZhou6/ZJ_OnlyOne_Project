//
//  ZKBaseViewController.h
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/14.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZKBaseViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

/**
 *  基类的table
 */
@property (nonatomic, strong) UITableView *tableView;





/**
 *  暂停列表上下拉刷新
 */
- (void)endRefreshing;

/**
 *  再次头部刷新
 */
- (void)recoverRefresh;

/**
 * 上下拉刷新处理(子类可重写)
 *
 * @param page 页码
 */
- (void)showRefreshing:(NSInteger)page;
@end

NS_ASSUME_NONNULL_END

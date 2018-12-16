//
//  ZKHomeViewController.h
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/11.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import "ZKBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN


@interface ZKHomeViewController : ZKBaseViewController


@property (strong, nonatomic)  UIScrollView *menuScrollView;
@property (strong, nonatomic)  UIScrollView *scrollView;
@property (strong, nonatomic) UIView *menuBgView;
@property (strong, nonatomic) NSArray *menuArray;
@property (strong, nonatomic) NSMutableArray *tableViewArray;
@property (strong, nonatomic) UITableView *refreshTableView;
@property (copy, nonatomic) NSString *menuTittle;

@property(nonatomic,strong)NSMutableArray * newsArray;
@end

NS_ASSUME_NONNULL_END

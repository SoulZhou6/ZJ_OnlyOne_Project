//
//  ZKSingChooseTableView.h
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/25.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZKSingChooseTableView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * tableView;

@property(nonatomic,strong)UIView *headView;

@property(nonatomic,strong)UIView *footView;

+(ZKSingChooseTableView *)singChooseTableWithFrame:(CGRect)frame;
@end

NS_ASSUME_NONNULL_END

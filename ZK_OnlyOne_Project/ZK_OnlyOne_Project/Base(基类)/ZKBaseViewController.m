//
//  ZKBaseViewController.m
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/14.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import "ZKBaseViewController.h"

@interface ZKBaseViewController ()

@end

@implementation ZKBaseViewController


#pragma mark - 懒加载视图
- (UITableView *)tableView{
    
    if (_tableView == nil) {
        
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0 , Screen_Width, Screen_Height - ZK_TopHeight-ZK_TabBarHeight) style:UITableViewStylePlain];
      
        //        _tableView = [[ZKTableViewProtocol alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];

        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    
    return _tableView;
}

- (void)endRefreshing {
//    [XDProgressHUD hideHUD]; // 移除菊花
    
    if ([self.tableView.mj_header isRefreshing]) {
        [self.tableView.mj_header endRefreshing];
    }
    if ([self.tableView.mj_footer isRefreshing]) {
        [self.tableView.mj_footer endRefreshing];
    }
}

#pragma mark - Life Cycle

- (UIStatusBarStyle)preferredStatusBarStyle {
    [super preferredStatusBarStyle];
    
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
//    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor viewBackGroundColor];
    
//    self.tableView.emptyDataSetSource   = self;
//    self.tableView.emptyDataSetDelegate = self;
//
//
//
//    [NC addObserver:self selector:@selector(recoverRefresh) name:NC_Reload_Home object:nil];
//    [NC addObserver:self selector:@selector(recoverRefresh) name:NC_Reload_Music object:nil];
}

- (void)recoverRefresh
{
    if (![self.tableView.mj_header isRefreshing]) {
        [self.tableView.mj_header beginRefreshing];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.view endEditing:YES];
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}



@end

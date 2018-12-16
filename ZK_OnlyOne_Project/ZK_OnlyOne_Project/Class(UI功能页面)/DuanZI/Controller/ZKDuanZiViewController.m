//
//  ZKDuanZiViewController.m
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/13.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import "ZKDuanZiViewController.h"
#import "ZKDuanziCell.h"
#import "ZKDuanziObj.h"
#import "zhTableViewAnimations.h"
#import "LCArrowView.h"

@interface ZKDuanZiViewController ()<UITableViewDelegate,UITableViewDataSource,SelectIndexPathDelegate>
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)LCArrowView * popView;
@end

@implementation ZKDuanZiViewController
{
    NSMutableArray *jokeArray;
    
    NSInteger selectIndex;
    NSInteger pageIndex;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    jokeArray = [[NSMutableArray alloc]init];
    selectIndex = 0;
    pageIndex = 1;
    [self.view addSubview:self.tableView];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"zk_dz_select_normal" highImageName:@"zk_dz_select_height" target:self action:@selector(clickSelectAction)];
    [self requestJokeData];
   
}



#pragma mark - 懒加载视图
- (UITableView *)tableView{
    
    if (_tableView == nil) {
        
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0 , Screen_Width, Screen_Height - ZK_TopHeight-ZK_TabBarHeight)];
        
//        _tableView = [[ZKTableViewProtocol alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 10)];
        headView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.tableHeaderView = headView;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
        _tableView.mj_header = header;
        
        MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
        _tableView.mj_footer =  footer;
        _tableView.zh_reloadAnimationType =  arc4random() % (10 - 0 + 1) + 0;
        [self.view addSubview:_tableView];
    }
    
    return _tableView;
}

#pragma mark - 点击了右上角筛选按钮
- (void)clickSelectAction{
    
    
    CGPoint point;
    //获取控件相对于window的   中心点坐标
    point = CGPointMake(Screen_Width-30 ,ZK_NavBarHeight);
    
    NSArray * titleArray = [[NSArray alloc]init];
    
    titleArray = @[@"最新段子",@"随机段子"];
    
    
    _popView = [[LCArrowView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) Origin:point Width:120 Height:36*titleArray.count Type:Type_UpRight Color:[UIColor colorWithRed:0.2737 green:0.2737 blue:0.2737 alpha:1.0] ];
    _popView.backView.layer.cornerRadius = 5;
    
    _popView.dataArray = titleArray;
    _popView.row_height      = 36;
    _popView.delegate        = self;
    _popView.titleTextColor  = [UIColor colorWithRed:0.2669 green:0.765 blue:1.0 alpha:1.0];
    [_popView popView];
    
}

- (void)selectIndexPathRow:(NSInteger)index{
    
    _tableView.zh_reloadAnimationType =  arc4random() % (10 - 0 + 1) + 0;
    selectIndex = index;
    [self requestJokeData];
}

#pragma mark - 下拉刷新
- (void)refreshData{
    
    pageIndex = 1;
    _tableView.zh_reloadAnimationType =  arc4random() % (10 - 0 + 1) + 0;
    [self requestJokeData];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark - 上拉加载
- (void)footRefresh{
    
    pageIndex += 1;
//    _tableView.zh_reloadAnimationType =  arc4random() % (10 - 0 + 1) + 0;
    [self requestJokeData];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark - 请求数据
- (void)requestJokeData{
    
    NSDictionary * parms;
    NSString * url = @"";
//    if (selectIndex == 0) {
//
//        parms = @{@"key":jokeAppKey,@"page":[NSString stringWithFormat:@"%ld",pageIndex],@"pagesize":@"20",
//                  @"time":[ZKDataEncrypt getNowTimeTimestamp3:[ZKDataEncrypt getYesTadayFromTimeTamp]]
//                  };
//        url = jokeListUrl;
//    }else
    if (selectIndex == 0){
        
        parms = @{@"key":jokeAppKey,@"page":[NSString stringWithFormat:@"%ld",pageIndex],@"pagesize":@"20"};
        url = jokeTextUrl;
    }else{
        
        pageIndex = 1;
        parms = @{@"key":jokeAppKey};
        url = randJokeTextUrl;
    }
    
    
    [[ZKManager shareManager] requestWithRoutineMethod:RequestMethodGet url:url showLoading:YES param:parms success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        DLog(@"%@",responseObject);
        if ([responseObject[@"error_code"] integerValue] == 0) {
            
            if(self->selectIndex == 0){
                
                if (self->pageIndex == 1) {
                    
                    self->jokeArray = responseObject[@"result"][@"data"];
                }else{
                    
                    NSArray * tempArray = [[NSArray alloc]init];
                    
                    tempArray = responseObject[@"result"][@"data"];
                    
                    if (tempArray.count!=0) {
                        
                        NSMutableArray *muArray = [NSMutableArray array];
                        [muArray addObjectsFromArray:self->jokeArray];
                        [muArray addObjectsFromArray:tempArray];
                        self->jokeArray = muArray;
                        if (tempArray.count<10) {
                            [self->_tableView.mj_footer endRefreshingWithNoMoreData];
                        }
                        
                    }else{
                        
                        [self->_tableView.mj_footer endRefreshingWithNoMoreData];
                    }
                }
                
                
            }else{
                
                self->jokeArray = responseObject[@"result"];
            }
            
            [self->_tableView reloadData];
            
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
        [[ZKManager shareManager] alertMsg:@"网络不给力"];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return jokeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZKDuanziCell *cell = [ZKDuanziCell cellWithTableView:tableView identifier:[NSString stringWithFormat:@"%ld",indexPath.row]];
    ZKDuanziObj * model = [ZKDuanziObj yy_modelWithDictionary:jokeArray[indexPath.row]];
    [cell setDuanZiObj:model];
    
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZKDuanziObj * model = [ZKDuanziObj yy_modelWithDictionary:jokeArray[indexPath.row]];
    CGFloat height = [UILabel getHeightByWidth:Screen_Width title:[ZKDataEncrypt getZZwithString:model.content] font:[UIFont systemFontOfSize:19]];
    return 1  + height+20;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end

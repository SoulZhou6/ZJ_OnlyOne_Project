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
#import "ZKHomeHeadView.h"
#import "DCCycleScrollView.h"
@interface ZKDuanZiViewController ()<SelectIndexPathDelegate,DCCycleScrollViewDelegate>
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
    [self setStyleView];
  
    [self requestJokeData];
   
}
#pragma mark - 设置界面
- (void)setStyleView{
    
    jokeArray = [[NSMutableArray alloc]init];
    selectIndex = 0;
    pageIndex = 1;
    self.tableView.frame =  CGRectMake(0, ZK_TopHeight , Screen_Width, Screen_Height - ZK_TopHeight-ZK_TabBarHeight);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 10)];
    headView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.tableHeaderView = headView;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    self.tableView.mj_header = header;
    WeakSelf;
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        
        self->pageIndex += 1;
        //    _tableView.zh_reloadAnimationType =  arc4random() % (10 - 0 + 1) + 0;
        [weakSelf requestJokeData];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
    
    self.tableView.zh_reloadAnimationType =  arc4random() % (10 - 0 + 1) + 0;
    [self.view addSubview:self.tableView];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"zk_dz_select_normal" highImageName:@"zk_dz_select_height" target:self action:@selector(clickSelectAction)];
}

#pragma mark - 点击了右上角筛选按钮
- (void)clickSelectAction{
    
    
    CGPoint point;
    //获取控件相对于window的   中心点坐标
    point = CGPointMake(Screen_Width-30 ,ZK_NavBarHeight);
    
    NSArray * titleArray = [[NSArray alloc]init];
    
    titleArray = @[@"最新",@"更新时间"];
    
    
    _popView = [[LCArrowView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) Origin:point Width:120 Height:36*titleArray.count Type:Type_UpRight Color:[UIColor colorWithRed:0.2737 green:0.2737 blue:0.2737 alpha:1.0] ];
    _popView.backView.layer.cornerRadius = 5;
    
    _popView.dataArray = titleArray;
    _popView.row_height      = 36;
    _popView.delegate        = self;
    _popView.titleTextColor  = [UIColor colorWithRed:0.2669 green:0.765 blue:1.0 alpha:1.0];
    [_popView popView];
    
}

- (void)selectIndexPathRow:(NSInteger)index{
    
    self.tableView.zh_reloadAnimationType =  arc4random() % (10 - 0 + 1) + 0;
    selectIndex = index;
    [self requestJokeData];
}

#pragma mark - 下拉刷新
- (void)refreshData{
    
    pageIndex = 1;
    self.tableView.zh_reloadAnimationType =  arc4random() % (10 - 0 + 1) + 0;
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
        
       parms = @{@"key":jokeAppKey,@"page":[NSString stringWithFormat:@"%ld",pageIndex],@"rows":@"20"};
        url = jokeTextUrl;
    }else{
        
        pageIndex = 1;
//        parms = @{@"key":jokeAppKey};
        url = jokeListUrl;
        parms = @{@"key":jokeAppKey,@"time":[[ZKDataEncrypt getNowTimeTimestamp3:[ZKDataEncrypt getYesTadayFromTimeTamp]] substringToIndex:10],@"page":[NSString stringWithFormat:@"%ld",pageIndex],@"rows":@"20",@"sort":@"desc"};
    }
    
    WeakSelf;
    [[ZKManager shareManager] requestWithRoutineMethod:RequestMethodGet url:url showLoading:YES param:parms success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        DLog(@"%@",responseObject);
        
        if ([responseObject[@"error_code"] integerValue] == 0) {
            
            if(self->selectIndex == 0){
                
                if (self->pageIndex == 1) {
                    
                    self->jokeArray = responseObject[@"result"];
                }else{
                    
                    NSArray * tempArray = [[NSArray alloc]init];
                    
                    tempArray = responseObject[@"result"];
                    
                    if (tempArray.count!=0) {
                        
                        NSMutableArray *muArray = [NSMutableArray array];
                        [muArray addObjectsFromArray:self->jokeArray];
                        [muArray addObjectsFromArray:tempArray];
                        self->jokeArray = muArray;
                        if (tempArray.count<10) {
                            [weakSelf.tableView.mj_footer endRefreshing];
                            
                        }
                        
                    }else{
                        
                        [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                    }
                }
                
            }else{
                
                self->jokeArray = responseObject[@"result"];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
               [weakSelf.tableView reloadData];
            });
            
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

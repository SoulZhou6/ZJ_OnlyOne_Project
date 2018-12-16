//
//  ZKHomeViewController.m
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/11.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import "ZKHomeViewController.h"
#import "ZKTableViewProtocol.h"
#import "ZKHomeCell.h"
#import "ZKHomeObj.h"

@interface ZKHomeViewController ()
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)ZKTableViewProtocol * protocol;
@end

@implementation ZKHomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"头条";
    _newsArray = [[NSMutableArray alloc]init];
    _refreshTableView = [[UITableView alloc]init];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
   
}

#pragma mark - 请求新闻数据
- (void)requestNewsListData{
    
    NSDictionary * parms = @{
                             @"key":newsAppKey,
                             @"type":@"shehui"
                             };
    [[ZKManager shareManager] requestWithRoutineMethod:RequestMethodGet url:newsUrl showLoading:NO param:parms success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        DLog(@"%@",responseObject);
        
        if([responseObject[@"error_code"] intValue] == 0){
            self->_newsArray = [[NSMutableArray alloc]initWithArray:responseObject[@"result"][@"data"]];
            [self->_refreshTableView reloadData];
        }
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
        [[ZKManager shareManager] alertMsg:@"网络不给力"];
    }];
}

- (void)clickAction{
    
//    NSString * urlString =@"http://api01.idataapi.cn:8000/article/idataapi?kw=苹果&KwPosition=3&sourceRegion=中国&sourceType=新闻网站&publishDateRange=1544313600,1544572800&apikey=FBYz9irqpMU3tfmqjZcxZ1ROg5M9NNV8BqkBkgOB14K7raBMQjvCi5P6bFTGc3sT";
    
    
    NSDictionary * parms = @{@"apikey":@"FBYz9irqpMU3tfmqjZcxZ1ROg5M9NNV8BqkBkgOB14K7raBMQjvCi5P6bFTGc3sT",
                             @"kw":@"科技",@"kwMode":@"3",@"publishDateRange":@"1544544877%2C1544602477",
                             @"sourceRegion":@"中国",@"sourceType":@"新闻网站"
                             };
    [[ZKManager shareManager] requestWithRoutineMethod:RequestMethodGet url:@"http://api01.idataapi.cn:8000/article/idataapi" showLoading:NO param:parms success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        DLog(@"%@",responseObject);
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}


@end

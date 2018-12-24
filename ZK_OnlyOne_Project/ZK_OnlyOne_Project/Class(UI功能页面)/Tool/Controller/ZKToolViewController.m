//
//  ZKToolViewController.m
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/13.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import "ZKToolViewController.h"
#import "ZKHomeHeadView.h"


@interface ZKToolViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ZKToolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    self.tableView.frame = CGRectMake(0, ZK_TopHeight, Screen_Width, Screen_Height-ZK_TopHeight-ZK_TabBarHeight);
    [self.view addSubview:self.tableView];



    
      [self requestWeatherData];
}

#pragma mark - 请求天气数据接口

- (void)requestWeatherData{
    
    NSDictionary * parms = @{@"city":@"深圳"};
    
    [[ZKManager shareManager] requestWithRoutineMethod:RequestMethodGet url:weatherUrl showLoading:YES param:parms success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        DLog(@"天气%@",responseObject);
        
        ZKHomeHeadView * headView = [ZKHomeHeadView initWithNibFrame:CGRectMake(0, 0, Screen_Width, 250)];
        self.tableView.tableHeaderView = headView;
        ZKWeatherObj * model = [ZKWeatherObj yy_modelWithDictionary:responseObject[@"data"]];
        [headView setWeatherObj:model];
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}


#pragma mark - tableview delegate / dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:nil];
    NSString *str = [NSString stringWithFormat:@"WRNavigationBar %zd",indexPath.row];
    cell.textLabel.text = str;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    BaseViewController *vc = [BaseViewController new];
//    vc.view.backgroundColor = [UIColor redColor];
//    NSString *str = [NSString stringWithFormat:@"右划返回查看效果 %zd",indexPath.row];
//    vc.customNavBar.title = str;
//    [self.navigationController pushViewController:vc animated:YES];
}




@end

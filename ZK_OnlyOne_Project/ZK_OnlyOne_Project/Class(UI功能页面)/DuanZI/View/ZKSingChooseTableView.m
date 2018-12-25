//
//  ZKSingChooseTableView.m
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/25.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import "ZKSingChooseTableView.h"

@implementation ZKSingChooseTableView


+ (ZKSingChooseTableView *)singChooseTableWithFrame:(CGRect)frame{
    
    ZKSingChooseTableView *table = [[ZKSingChooseTableView alloc]initWithViewFrame:frame];
    return table;
}

-(instancetype)initWithViewFrame:(CGRect)frame{
    self = [super init];
    if(self){
        self.frame = frame;
        [self addSubview:self.tableView];
    }
    return self;
}

- (UITableView *)tableView{
    
    if(_tableView == nil){
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, self.frame.size.height)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = _footView;
        _tableView.tableHeaderView = _headView;
        
        _tableView.separatorStyle = NO;
    }
   
    return _tableView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cells"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cells"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    cell.textLabel.text = @"12345678";
    
    return cell;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}



@end

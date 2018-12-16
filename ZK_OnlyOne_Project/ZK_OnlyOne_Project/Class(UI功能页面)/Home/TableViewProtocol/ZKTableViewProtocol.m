//
//  ZKTableViewProtocol.m
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/13.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import "ZKTableViewProtocol.h"
#import "ZKHomeCell.h"
#import "ZKHomeObj.h"
@implementation ZKTableViewProtocol

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _newsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * identifier = @"";
    NSInteger index = 0;
    
    ZKHomeObj * model = [ZKHomeObj yy_modelWithDictionary:_newsArray[indexPath.row]];
    
    if(model.thumbnail_pic_s03!=nil){
        
        identifier = @"HomeCellOne";
        index = 0;
    }else if (model.thumbnail_pic_s02!=nil){
        
        identifier = @"HomeCellTwo";
        index = 1;
    }else{
        
        identifier = @"HomeCellThree";
        index = 2;
    }
    
    
    ZKHomeCell * cell = [ZKHomeCell cellWithTableView:tableView identifier:identifier index:index];
    [cell setHomeObj:model index:index];
    
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
    
    ZKHomeObj * model = [ZKHomeObj yy_modelWithDictionary:_newsArray[indexPath.row]];
    
    if(model.thumbnail_pic_s03!=nil){
        
        return 150;
    }else if(model.thumbnail_pic_s02!=nil||model.thumbnail_pic_s!=nil){
        return 122;
    }else{
        return 96;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end

//
//  LCArrowTableView.m
//  Demo
//
//  Created by 吕中威 on 16/9/6.
//  Copyright © 2016年 吕中威. All rights reserved.
//

#import "LCArrowTableView.h"
#import "LCArrowCellTableViewCell.h"

@interface LCArrowTableView ()

//@property (nonatomic, strong) UITableView *tableView;

@end

@implementation LCArrowTableView
{
    
    UITableView *_tableView;
}

- (instancetype)initWithFrame:(CGRect)frame Origin:(CGPoint)origin Width:(CGFloat)width Height:(CGFloat)height Type:(DirectType)type Color:(UIColor *)color toview:(UIView * _Nonnull)view{
    
    if ([super initWithFrame:frame Origin:origin Width:width Height:height  Type:type Color:color ]) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,self.width, self.height - 1) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.scrollEnabled = NO;
        [self.backView addSubview:self.tableView];
    }
    return self;
}

//- (UITableView *)tableView{
//    
//    if (!_tableView) {
//        
//        
//    }
//    return _tableView;
//}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
#pragma mark -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.row_height == 0) {
        return 44;
    }else{
        return self.row_height;
    }
}
#pragma mark -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"cellIdentifier2";
    LCArrowCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LCArrowCellTableViewCell" owner:self options:nil] lastObject];
    }
    cell.backgroundColor = [UIColor clearColor];
//    cell.myImageView.image = [UIImage imageNamed:self.images[indexPath.row]];
    
    cell.descLabel.text = self.dataArray[indexPath.row];
    cell.descLabel.font = [UIFont systemFontOfSize:14];
    cell.descLabel.numberOfLines = 0;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.descLabel.textColor = [UIColor lightGrayColor];
    if (self.dataArray.count == 1) {
        self.tableView.bounces = NO;
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectIndexPathRow:)]) {
        [self.delegate selectIndexPathRow:indexPath.row];
        [self removeFromSuperview];
    }
}

@end

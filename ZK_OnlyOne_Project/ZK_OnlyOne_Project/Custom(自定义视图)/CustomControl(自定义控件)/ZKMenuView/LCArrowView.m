//
//  LCArrowView.m
//  Demo
//
//  Created by 吕中威 on 1SPACE/9/SPACE.
//  Copyright © 201SPACE年 吕中威. All rights reserved.
//

#import "LCArrowView.h"
#import "LCArrowCellTableViewCell.h"
#define Length 5

#define SPACE 15

@implementation LCArrowView    

- (instancetype)initWithFrame:(CGRect)frame Origin:(CGPoint)origin  Width:(CGFloat) width
                       Height:(CGFloat) height Type:(DirectType)type Color:(UIColor *)color{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.35];
        self.origin = origin;// 箭头的位置
        self.type = type; // 类型
        self.width = width;
        self.height = height;
        self.userInteractionEnabled = NO;
        self.backView = [[UIView alloc] initWithFrame:CGRectMake(origin.x, origin.y, self.width, self.height)];
        self.backView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.backView];
        [self setBackViewFrame];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,self.width, self.height) style:UITableViewStylePlain];
        _tableView.dataSource = self;
//        _tableView.backgroundColor = [UIColor orangeColor];
        _tableView.delegate = self;
        _tableView.scrollEnabled = NO;
        [self.backView addSubview:self.tableView];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (self.type == Type_UpRight) {
        
        CGFloat startX = self.origin.x;
        CGFloat startY = self.origin.y + SPACE;
        CGContextMoveToPoint(context, startX, startY);
        CGContextAddLineToPoint(context, startX + Length, startY + Length);
        CGContextAddLineToPoint(context, startX - Length, startY + Length);
    }else if (self.type == Type_UpLeft){
        
        CGFloat startX = self.origin.x;
        CGFloat startY = self.origin.y + SPACE;
        CGContextMoveToPoint(context, startX, startY);
        CGContextAddLineToPoint(context, startX + Length, startY + Length);
        CGContextAddLineToPoint(context, startX - Length, startY + Length);
        
    }else if (self.type == Type_DownLeft){
        
        CGFloat startX = self.origin.x;
        CGFloat startY = self.origin.y - SPACE;
        CGContextMoveToPoint(context, startX, startY);
        CGContextAddLineToPoint(context, startX - Length, startY - Length);
        CGContextAddLineToPoint(context, startX + Length, startY - Length);

    }else{
        
        CGFloat startX = self.origin.x;
        CGFloat startY = self.origin.y - SPACE;
        CGContextMoveToPoint(context, startX, startY);
        CGContextAddLineToPoint(context, startX - Length, startY - Length);
        CGContextAddLineToPoint(context, startX + Length, startY - Length);
    }
    CGContextClosePath(context);
    [RGB(255,255,255) setFill];
    [RGB(255,255,255) setStroke];
    CGContextDrawPath(context, kCGPathFillStroke);
}

- (void)setBackViewFrame{
    
    
    if (self.type == Type_UpRight){
        
        self.backView.center = CGPointMake(self.origin.x , self.origin.y + SPACE + Length);
        self.backView.layer.anchorPoint = CGPointMake(0.8, 0);
        
    }else if (self.type == Type_UpLeft){
        
       self.backView.center = CGPointMake(self.origin.x , self.origin.y + SPACE + Length);
        self.backView.layer.anchorPoint = CGPointMake(0.2, 0);
    }else if (self.type == Type_DownLeft){
        
        self.backView.center = CGPointMake(self.origin.x , self.origin.y - SPACE - Length);
         self.backView.layer.anchorPoint = CGPointMake(0.2, 1);
    }else{
            self.backView.center = CGPointMake(self.origin.x , self.origin.y - SPACE - Length);
          self.backView.layer.anchorPoint = CGPointMake(0.8, 1);
    }
    
}


- (void)popView{

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [window addSubview:self];
    
    self.backView.alpha = 0.f;
    self.backView.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    [UIView animateWithDuration:0.2f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.backView.transform = CGAffineTransformMakeScale(1.05f, 1.05f);
        self.backView.alpha = 1.f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.08f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.backView.transform = CGAffineTransformIdentity;
            self.userInteractionEnabled = YES;
        } completion:nil];
    }];
}
#pragma mark -
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (![[touches anyObject].view isEqual:self.backView]) {
        
        [self dismiss];
    }
    
}
#pragma mark -
- (void)dismiss
{
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 0;
        self.backView.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}


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
    cell.descLabel.textColor = [UIColor colorWithHexString:@"#333333"];
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

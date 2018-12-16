//
//  LCArrowView.h
//  Demo
//
//  Created by 吕中威 on 16/9/6.
//  Copyright © 2016年 吕中威. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectIndexPathDelegate <NSObject>

- (void)selectIndexPathRow:(NSInteger )index;

@end

typedef NS_ENUM(NSInteger, DirectType){
    
    Type_UpLeft,
    Type_UpRight,
    Type_DownRight,
    Type_DownLeft
};

@interface LCArrowView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UIView * _Nonnull backView;
@property (assign, nonatomic) CGPoint origin; //初始位置
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) DirectType type;

// 初始化方法
- (instancetype _Nonnull)initWithFrame:(CGRect) frame
                                 Origin:(CGPoint) origin
                                  Width:(CGFloat) width
                                 Height:(CGFloat) height
                                   Type:(DirectType)type
                                  Color:( UIColor * _Nonnull ) color;

- (void)popView;
- (void)dismiss;


@property (nonatomic, strong) UITableView *tableView;

// titles
@property (nonatomic, strong) NSArray           * _Nonnull dataArray;
// images
@property (nonatomic, strong) NSArray           * _Nonnull images;
// height
@property (nonatomic, assign) CGFloat           row_height;
// font
@property (nonatomic, assign) CGFloat           fontSize;
// textColor
@property (nonatomic, strong) UIColor           * _Nonnull titleTextColor;
@property (nonatomic, assign) NSTextAlignment   textAlignment;
// delegate
@property (nonatomic, assign) id <SelectIndexPathDelegate> _Nonnull delegate;

@end

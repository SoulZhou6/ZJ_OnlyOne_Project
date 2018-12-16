//
//  LCArrowTableView.h
//  Demo
//
//  Created by 吕中威 on 16/9/6.
//  Copyright © 2016年 吕中威. All rights reserved.
//

#import "LCArrowView.h"

@protocol SelectIndexPathDelegate <NSObject>

- (void)selectIndexPathRow:(NSInteger )index;

@end

@interface LCArrowTableView : LCArrowView<UITableViewDelegate, UITableViewDataSource>
// titles
@property (nonatomic, strong) NSArray           *  dataArray;
// images
@property (nonatomic, strong) NSArray           *  images;
// height
@property (nonatomic, assign) CGFloat           row_height;
// font
@property (nonatomic, assign) CGFloat           fontSize;
// textColor
@property (nonatomic, strong) UIColor           *  titleTextColor;
@property (nonatomic, assign) NSTextAlignment   textAlignment;
// delegate
@property (nonatomic, assign) id <SelectIndexPathDelegate>  delegate;

@end

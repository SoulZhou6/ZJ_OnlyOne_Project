//
//  ZKScrollViewMenu.m
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/17.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import "ZKScrollViewMenu.h"


@interface ZKScrollViewMenu()
/** 可滚动容器 */
@property (nonatomic, strong) UIScrollView *pageScrollView;
/** 保存所有的按钮 */
@property (nonatomic, strong) NSMutableArray *buttonObjects;
/** 标题数组 */
@property (nonatomic, strong) NSArray *titleObjects;
/** 记录选中的按钮 */
@property (nonatomic, strong) UIButton *recordButton;
/** 滚动索引 */
@property (nonatomic, strong) UIView *scrollingView;
/** 底部分割线 */
@property (nonatomic, strong) UIView *lineView;

@end

@implementation ZKScrollViewMenu

#pragma mark - Lazy

- (NSMutableArray *)buttonObjects
{
    if (!_buttonObjects) {
        
        _buttonObjects = [NSMutableArray arrayWithCapacity:0];
    }
    return _buttonObjects;
}


#pragma mark - Life Cycle

- (instancetype)initWithOrigin:(CGPoint)origin height:(CGFloat)height {
    
    if (self = [super initWithFrame:CGRectMake(origin.x, origin.y, [UIScreen mainScreen].bounds.size.width, height)]) {
        self.backgroundColor = [UIColor colorWhiteColor];
        if (!self.titleObjects) {
            self.titleObjects = [[NSArray alloc] init];
        }
    }
    return self;
}

- (instancetype)initWithOrigin:(CGPoint)origin height:(CGFloat)height titles:(NSArray *)titles
{
    return [self initWithOrigin:origin width:[UIScreen mainScreen].bounds.size.width height:height titles:titles];
}

- (instancetype)initWithOrigin:(CGPoint)origin width:(CGFloat)width height:(CGFloat)height titles:(NSArray *)titles {
    
    if (self = [super initWithFrame:CGRectMake(origin.x, origin.y, width, height)]) {
        if (titles && titles.count) {
            self.titleObjects = titles;
            [self configScroll];
        }
    }
    return self;
};


- (void)configScroll
{
    CGFloat itemWidth   = Screen_Width / 5;
    CGFloat lineHeight  = 0.5;
    
    self.pageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, self.frame.size.height - lineHeight)];
    self.pageScrollView.contentSize = CGSizeMake(itemWidth * self.titleObjects.count, 0);
    self.pageScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.pageScrollView];
    
    CGFloat lineY = CGRectGetMaxY(self.pageScrollView.frame);
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, lineY, Screen_Width, lineHeight)];
    self.lineView.hidden = NO; // 默认显示
    self.lineView.backgroundColor = [UIColor colorWithHexString:@"e8e8e8"];
    [self addSubview:self.lineView];
    
    CGFloat itemHeight = 30;
    CGFloat originY = (self.pageScrollView.frame.size.height - itemHeight) * 0.5;
    
    UIColor *selectorColor = _tintColor ? _tintColor : [UIColor colorThemeColor];
    
    self.scrollingView = [[UIView alloc] init];
    self.scrollingView.backgroundColor = selectorColor;
    
    CGFloat space = 2;
    for (NSInteger idx = 0; idx < self.titleObjects.count; idx++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(idx*itemWidth+space, originY, itemWidth, itemHeight);
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitle:self.titleObjects[idx] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorLightTextColor] forState:UIControlStateNormal];
        [button setTitleColor:selectorColor forState:UIControlStateSelected];
        [self.pageScrollView addSubview:button];
        button.tag = idx + 1000; //绑定tag值
        [button addTarget:self action:@selector(pagingScrollEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonObjects addObject:button];
        
        if (idx == 0) {
            CGFloat h = 2;
            CGFloat y = self.pageScrollView.max_Y-h-0.1;
            [button.titleLabel sizeToFit];
            
            self.scrollingView.y    = y;
            self.scrollingView.height  = h;
            self.scrollingView.width   = button.titleLabel.width;
            self.scrollingView.centerX = button.centerX;
            [self.pageScrollView addSubview:self.scrollingView];
            
            button.selected  = YES;
            _recordButton = button;
        }
    }
}

- (CGFloat)updateWidthCurrentText:(NSString *)text
{
    CGSize size = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30)
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}
                                     context:nil].size;
    
    return size.width;
}

#pragma mark - Setter && Getter

- (void)setTitleStringGroup:(NSArray *)titleStringGroup {
    _titleStringGroup = titleStringGroup;
    if (!titleStringGroup) return;
    
    self.titleObjects = titleStringGroup;
    [self configScroll];
}

- (CGPoint)scrollPoint {
    
    return self.pageScrollView.contentOffset;
}

- (void)setHideLine:(BOOL)hideLine {
    _hideLine = hideLine;
    
    self.lineView.hidden = hideLine;
}

- (void)setTintColor:(UIColor *)tintColor {
    _tintColor = tintColor;
    
    for (UIView *view in self.pageScrollView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [(UIButton *)view setTitleColor:tintColor forState:UIControlStateSelected];
        }else if ([view isKindOfClass:[UIView class]]) {
            view.backgroundColor = tintColor;
        }
    }
}

#pragma mark - ScrollView Action

- (void)scrollToAtIndex:(NSInteger)index {
    UIButton *button = self.buttonObjects[index];
    _recordButton.selected = NO;
    
    button.selected = YES;
    _recordButton = button;
    
    [self animaScrolling:button];
}

- (void)pagingScrollEvent:(UIButton *)button {
    if (button.selected) return;
    
    _recordButton.selected = !_recordButton.selected;
    _recordButton = button;
    
    button.selected = !button.selected;
    [self animaScrolling:button];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(scroll:didSelectItemAtIndex:)]) {
        
        [self.delegate scroll:self didSelectItemAtIndex:button.tag - 1000];
    }
    
    if (self.scrollDidBlock) {
        self.scrollDidBlock(button.tag - 1000);
    }
}

- (void)animaScrolling:(UIButton *)button {
    float offsetX = CGRectGetMinX(button.frame);
    
    [UIView animateWithDuration:0.25 animations:^{
        if (offsetX < Screen_Width/2) {
            [self.pageScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }else if (offsetX >= Screen_Width/2 && offsetX <= self.pageScrollView.contentSize.width - Screen_Width/2) {
            [self.pageScrollView setContentOffset:CGPointMake(offsetX - Screen_Width/2, 0) animated:YES];
        }else{ //加上button.width，防止点击产生遮挡
            [self.pageScrollView setContentOffset:CGPointMake(((self.pageScrollView.contentSize.width - Screen_Width) + button.width*0.5), 0) animated:YES];
        }
    } completion:^(BOOL finished) {
        self.scrollingView.width   = button.titleLabel.width;
        self.scrollingView.centerX = button.centerX;
    }];
}

- (void)updateScrollFont:(UIButton *)button
{
    for (int idx = 0; idx < self.buttonObjects.count; idx++) {
        if (idx == (button.tag-1000)) {
            UIButton *selectedView = self.buttonObjects[idx];
            selectedView.titleLabel.font = [UIFont systemFontOfSize:19];
        }else {
            UIButton *normalView = self.buttonObjects[idx];
            normalView.titleLabel.font = [UIFont systemFontOfSize:17];
        }
    }
}

@end

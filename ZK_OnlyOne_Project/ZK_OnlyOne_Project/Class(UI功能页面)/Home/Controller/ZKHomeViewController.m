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
#import "ZKScrollViewMenu.h"
#import "ZKWebBrowseViewController.h"


static NSString *const kNewsCellReuseIdentifier = @"kNewsCellReuseIdentifier";

@interface ZKHomeViewController ()<ZKScrollViewMenuDelegate, UIGestureRecognizerDelegate>
@property (nonatomic,strong)ZKTableViewProtocol * protocol;

@property (nonatomic, strong) ZKScrollViewMenu *scrollMenu;
@property (nonatomic, strong) NSMutableArray *newsObjects;
@property (nonatomic, strong) NSArray *titleObjects;
@property (nonatomic, strong) NSArray *idsObjects;

@property (nonatomic, strong) ZKHomeObj *selectModel;
@property (nonatomic, strong) UIButton  *reachButton;
@property (nonatomic, strong) NSString  *categoryId;

@property (nonatomic, assign) NSInteger scrollIndex;
@property (nonatomic, assign) NSInteger count;
@end

@implementation ZKHomeViewController



- (NSMutableArray *)newsObjects
{
    if (!_newsObjects) {
        
        _newsObjects = [[NSMutableArray alloc] init];
    }
    return _newsObjects;
}

- (NSArray *)titleObjects
{
    if (!_titleObjects) {
        
        _titleObjects = @[ @"头条",@"社会", @"国内",@"国际", @"娱乐",@"体育", @"军事",@"科技",@"财经",@"时尚"];
    }
    return _titleObjects;
}

- (NSArray *)idsObjects
{
    if (!_idsObjects) {
        
        _idsObjects = @[@"top", @"shehui",@"guonei",@"guoji",@"yule",@"tiyu",@"junshi",@"keji",@"caijing",@"shishang"];
    }
    return _idsObjects;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"头条";
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self configSubview];
   
}


- (void)configSubview
{
    self.categoryId  = @"top"; //默认加载全部
    self.scrollIndex = 0;
    
    ZKScrollViewMenu *scrollMenu = [[ZKScrollViewMenu alloc] initWithOrigin:CGPointMake(0, 0) height:40 titles:self.titleObjects];
    scrollMenu.delegate = self;
    [self.view addSubview:scrollMenu];
    self.scrollMenu = scrollMenu;
    
    CGFloat tableY = CGRectGetMaxY(scrollMenu.frame);
    CGFloat tableH = KIsiPhoneX ? (Screen_Height-88-83-tableY) : (Screen_Height-49-64-tableY);
    self.tableView.frame = CGRectMake(0, tableY, Screen_Width, tableH);
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
   
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.reachButton];
    
    // 添加轻扫手势
    [self addLeftSwipGesture:self.tableView];
    [self addRightSwipGesture:self.tableView];
    
    WeakSelf;
    self.tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
         [weakSelf.newsObjects removeAllObjects];
        [weakSelf requestNewsListData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       
//        if (weakSelf.newsObjects.count) {
//            [weakSelf.newsObjects removeAllObjects];
//        }
        [weakSelf requestNewsListData];
    }];
    
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - 请求新闻数据
- (void)requestNewsListData{
    
    NSDictionary * parms = @{
                             @"key":newsAppKey,
                             @"type":self.categoryId
                             };
    WeakSelf;
    [[ZKManager shareManager] requestWithRoutineMethod:RequestMethodGet url:newsUrl showLoading:NO param:parms success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        DLog(@"%@",responseObject);
        
        if([responseObject[@"error_code"] intValue] == 0){
            NSArray * array = [[NSMutableArray alloc]initWithArray:responseObject[@"result"][@"data"]];
            for (int i=0; i<array.count; i++) {
                [weakSelf.newsObjects addObject:array[i]];
            }
            
            [weakSelf mainQueueRefresh];
        }
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
        [[ZKManager shareManager] alertMsg:@"网络不给力"];
    }];
}

// 主线程刷新
- (void)mainQueueRefresh
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self endRefreshing];
        [self.tableView reloadData];
    });
}

#pragma mark - UISwipeGestureRecognizer

- (void)addLeftSwipGesture:(UIView *)view
{
    UISwipeGestureRecognizer *swip = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipEvent:)];
    // 设置方向(一个手势只能定义一个方向)
    swip.direction = UISwipeGestureRecognizerDirectionLeft;
    swip.delegate = self;
    // 视图添加手势
    [view addGestureRecognizer:swip];
}

- (void)addRightSwipGesture:(UIView *)view
{
    UISwipeGestureRecognizer *swip = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipEvent:)];
    // 设置方向(一个手势只能定义一个方向)
    swip.direction = UISwipeGestureRecognizerDirectionRight;
    swip.delegate = self;
    // 视图添加手势
    [view addGestureRecognizer:swip];
}

- (void)swipEvent:(UISwipeGestureRecognizer *)swip {
    self.tableView.scrollEnabled = NO;
    NSTimeInterval duration = 0.75;
    
    if (swip.direction == UISwipeGestureRecognizerDirectionLeft) { //判断轻扫方向
        if (self.scrollIndex == self.idsObjects.count-1) return; // 防止crash
        self.scrollIndex++; //增加索引值
        
        CATransition *caAinimation = [CATransition animation];
        //设置动画的格式
        caAinimation.type = @"cube";
        //设置动画的方向
        caAinimation.subtype = @"fromRight";
        //设置动画的持续时间
        caAinimation.duration = duration;
        [self.view.superview.layer addAnimation:caAinimation forKey:nil];
        
    } if (swip.direction == UISwipeGestureRecognizerDirectionRight) {
        if (self.scrollIndex == 0) return;
        self.scrollIndex--;
        
        CATransition *caAinimation = [CATransition animation];
        //设置动画的格式
        caAinimation.type = @"cube";
        //设置动画的方向
        caAinimation.subtype = @"fromLeft";
        //设置动画的持续时间
        caAinimation.duration = duration;
        [self.view.superview.layer addAnimation:caAinimation forKey:nil];
    }
    
    self.categoryId = self.idsObjects[self.scrollIndex];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.scrollMenu scrollToAtIndex:self.scrollIndex];
        self.tableView.scrollEnabled = YES;
        [self.tableView.mj_header beginRefreshing]; //重刷列表
    });
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    return YES;
}

#pragma mark - table for data

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.newsObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    NSString * identifier = @"";
    NSInteger index = 0;
    if(_newsObjects.count>0){
        
        ZKHomeObj * model = [ZKHomeObj yy_modelWithDictionary:_newsObjects[indexPath.row]];
        
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
    }else{
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cells"];
        if (!cell) {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cells"];
        }
        
        return cell;
    }
    
}

#pragma mark - table for delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.newsObjects.count > indexPath.row) {
        ZKHomeObj *model = self.newsObjects[indexPath.row];
        
        ZKWebBrowseViewController *browseVC = [ZKWebBrowseViewController new];
        browseVC.model       = model;
        [browseVC loadWebURLSring:model.url];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            
            [self.navigationController pushViewController:browseVC animated:YES];
        });
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleNone;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(_newsObjects.count>0){
        
        ZKHomeObj * model = [ZKHomeObj yy_modelWithDictionary:_newsObjects[indexPath.row]];
        
        if(model.thumbnail_pic_s03!=nil){
            
            return 168;
        }else if(model.thumbnail_pic_s02!=nil||model.thumbnail_pic_s!=nil){
            return 122;
        }else{
            return 96;
        }
    }else{
        
        return 0;
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY > self.view.frame.size.height-158) {
        self.reachButton.hidden = NO;
    }else {
        self.reachButton.hidden = YES;
    }
}

#pragma mark - PagingScrollMenuDelegate

- (void)scroll:(ZKScrollViewMenu *)scroll didSelectItemAtIndex:(NSInteger)index {
    self.scrollIndex = index; //及时改变索引值
    
    self.navigationItem.title = _titleObjects[index];
    if (self.idsObjects.count == self.titleObjects.count) {
        
        self.categoryId = self.idsObjects[index];
    }
    // 重新请求列表
    [self.tableView.mj_header beginRefreshing];
}

@end

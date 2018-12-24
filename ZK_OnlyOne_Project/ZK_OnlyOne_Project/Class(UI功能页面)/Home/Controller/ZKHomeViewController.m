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
#import "WRNavigationBar.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
static NSString *const kNewsCellReuseIdentifier = @"kNewsCellReuseIdentifier";


#define NAVBAR_COLORCHANGE_POINT (-IMAGE_HEIGHT + NAV_HEIGHT*2)
#define NAV_HEIGHT 64
#define IMAGE_HEIGHT 260
#define SCROLL_DOWN_LIMIT 70
#define LIMIT_OFFSET_Y -(IMAGE_HEIGHT + SCROLL_DOWN_LIMIT)


@interface ZKHomeViewController ()<ZKScrollViewMenuDelegate, UIGestureRecognizerDelegate,SDCycleScrollViewDelegate>
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

@property (nonatomic, strong) SDCycleScrollView *advView;
@property (nonatomic, strong) NSMutableArray *adImageArray;
@property (nonatomic, strong) NSMutableArray *adTitleArray;
@end

@implementation ZKHomeViewController



- (NSMutableArray *)adImageArray{
    
    if (!_adImageArray) {
        
        _adImageArray = [[NSMutableArray alloc]init];
    }
    
    return _adImageArray;
}
- (NSMutableArray *)adTitleArray{
    
    if (!_adTitleArray) {
        
        _adTitleArray = [[NSMutableArray alloc]init];
    }
    
    return _adTitleArray;
}

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
        
        _titleObjects = @[@"社会", @"国内",@"国际", @"娱乐",@"体育", @"军事",@"科技",@"财经",@"时尚"];
    }
    return _titleObjects;
}

- (NSArray *)idsObjects
{
    if (!_idsObjects) {
        
        _idsObjects = @[@"shehui",@"guonei",@"guoji",@"yule",@"tiyu",@"junshi",@"keji",@"caijing",@"shishang"];
    }
    return _idsObjects;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(IMAGE_HEIGHT-64, 0, 0, 0);
//    self.navigationItem.title = @"头条";

    [self requestWeiChatNewsData];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configSubview];
    
    
    
     [self wr_setNavBarBackgroundAlpha:0];
    
    [self requestNewsListData];
   
}


- (void)configSubview
{
    self.categoryId  = @"shehui"; //默认加载全部
    self.scrollIndex = 0;
    
    
    ZKScrollViewMenu *scrollMenu = [[ZKScrollViewMenu alloc] initWithOrigin:CGPointMake(0, 0) height:40 titles:self.titleObjects];
    scrollMenu.delegate = self;
//    [self.view addSubview:scrollMenu];
    self.scrollMenu = scrollMenu;
    
    
    CGFloat tableY = CGRectGetMaxY(scrollMenu.frame);
    CGFloat tableH = KIsiPhoneX ? (Screen_Height-88-83) : (Screen_Height-49);
    self.tableView.frame = CGRectMake(0, 0, Screen_Width, tableH);
//    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, tableH) style:UITableViewStylePlain];
    
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.scrollMenu;
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
    
//    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - 请求新闻头条数据数据
- (void)requestWeiChatNewsData{
    
    NSDictionary * parms = @{@"key":newsAppKey,@"type":@"top"};
    [[ZKManager shareManager] requestWithRoutineMethod:RequestMethodGet url:newsUrl showLoading:YES param:parms success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        DLog(@"%@",responseObject);
        if ([responseObject[@"error_code"] intValue] == 0) {
            
            [self handleWeiChatData:responseObject[@"result"][@"data"]];
        }
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
        [[ZKManager shareManager] alertMsg:@"网络不给力"];
    }];
}

#pragma mark - 处理新闻头条数据数据
- (void)handleWeiChatData:(NSMutableArray *)array{
    
    
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    
    for (int i=0; i<array.count; i++) {
        
        ZKHomeObj * model = [ZKHomeObj yy_modelWithDictionary:array[i]];
        
        if (model.thumbnail_pic_s!=nil&&![model.thumbnail_pic_s isKindOfClass:[NSNull class]]) {
            
            [arr addObject:model];
        }
    }
    
    NSMutableArray * imageArray = [[NSMutableArray alloc]init];
    NSMutableArray * titleArray = [[NSMutableArray alloc]init];
    for (int i=0; i<5; i++) {
        
        ZKHomeObj * model = arr[i];
        
        [imageArray addObject:model.thumbnail_pic_s];
        [titleArray addObject:model.title];
    }
    
    
    _advView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, -IMAGE_HEIGHT, Screen_Width, IMAGE_HEIGHT) imageNamesGroup:imageArray];
    _advView.pageDotColor = [UIColor grayColor];
    _advView.currentPageDotColor = [UIColor orangeColor];
    _advView.titlesGroup = titleArray;
    _advView.titleLabelHeight = IMAGE_HEIGHT * 0.25;
    _advView.titleLabelTextColor = [UIColor whiteColor];
    _advView.titleLabelTextFont = [UIFont systemFontOfSize:18];
    _advView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    
    [self.tableView addSubview:_advView];
    
}

#pragma mark - 滑动图点击回调方法
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    
}

#pragma mark - 请求新闻数据
- (void)requestNewsListData{
    
    NSDictionary * parms = @{
                             @"key":newsAppKey,
                             @"type":self.categoryId
                             };
    WeakSelf;
    [[ZKManager shareManager] requestWithRoutineMethod:RequestMethodGet url:newsUrl showLoading:YES param:parms success:^(NSURLSessionDataTask *operation, id responseObject) {
        
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
//        [self requestNewsListData];
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
        }else if (model.thumbnail_pic_s!=nil&& model.thumbnail_pic_s02 == nil){
            
            identifier = @"HomeCellTwo";
            index = 1;
        }else if(model.thumbnail_pic_s == nil){
            
            identifier = @"HomeCellThree";
            index = 2;
        }else{
            
            identifier = @"HomeCellFour";
            index = 3;
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
        [browseVC loadWebURLSring:model.url];
        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
            
            [self.navigationController pushViewController:browseVC animated:YES];
//        });
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
        }else if(model.thumbnail_pic_s!=nil||model.thumbnail_pic_s02==nil){
            return 122;
        }else if(model.thumbnail_pic_s == nil){
            return 96;
        }else{
            return 194;
        }
    }else{
        
        return 0;
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



//- (SDCycleScrollView *)advView
//{
//    if (_advView == nil) {
//        NSArray *localImages = @[@"localImg6", @"localImg7", @"localImg8", @"localImg9", @"localImg10"];
//        NSArray *descs = @[@"韩国防部回应停止部署萨德:遵照最高统帅指导方针",
//                           @"勒索病毒攻击再次爆发 国内校园网大面积感染",
//                           @"Win10秋季更新重磅功能：跟安卓与iOS无缝连接",
//                           @"《琅琊榜2》为何没有胡歌？胡歌：我看过剧本，离开是种保护",
//                           @"阿米尔汗在印度的影响力，我国的哪位影视明星能与之齐名呢？"];
//
//    }
//    return _advView;
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;

    if (offsetY > NAVBAR_COLORCHANGE_POINT)
    {
        CGFloat alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / NAV_HEIGHT;
        [self wr_setNavBarBackgroundAlpha:alpha];
    }
    else
    {
        [self wr_setNavBarBackgroundAlpha:0];
    }
//
//    //限制下拉的距离
    if(offsetY < LIMIT_OFFSET_Y) {
        [scrollView setContentOffset:CGPointMake(0, LIMIT_OFFSET_Y)];
    }
//
//     改变图片框的大小 (上滑的时候不改变)
//     这里不能使用offsetY，因为当（offsetY < LIMIT_OFFSET_Y）的时候，y = LIMIT_OFFSET_Y 不等于 offsetY
//        CGFloat newOffsetY = scrollView.contentOffset.y;
//        if (newOffsetY < -IMAGE_HEIGHT)
//        {
//            self.advView.frame = CGRectMake(0, newOffsetY, Screen_Width, -newOffsetY);
//        }
    
    if (offsetY > self.view.frame.size.height-158) {
        self.reachButton.hidden = NO;
    }else {
        self.reachButton.hidden = YES;
    }
}

@end

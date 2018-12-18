//
//  ZKVideoViewController.m
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/13.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import "ZKVideoViewController.h"
#import <ZFPlayer/ZFPlayer.h>
#import <ZFPlayer/ZFAVPlayerManager.h>
#import <ZFPlayer/KSMediaPlayerManager.h>

#import <ZFPlayer/ZFPlayerControlView.h>
#import "ZKVideoObj.h"
#import "ZKVideoCell.h"


static NSString *kIdentifier = @"kIdentifier";

@interface ZKVideoViewController ()<UITableViewDelegate,UITableViewDataSource,ZKTableViewCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) ZFPlayerControlView *controlView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *urls;
@end

@implementation ZKVideoViewController



#pragma mark - getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView registerClass:[ZKVideoCell class] forCellReuseIdentifier:kIdentifier];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        /// 停止的时候找出最合适的播放
        @weakify(self)
        _tableView.zf_scrollViewDidStopScrollCallback = ^(NSIndexPath * _Nonnull indexPath) {
            @strongify(self)
            [self playTheVideoAtIndexPath:indexPath scrollToTop:NO];
        };
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.view addSubview:self.tableView];
    
    [self requestData];
    
    ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
    //    KSMediaPlayerManager *playerManager = [[KSMediaPlayerManager alloc] init];
    //    ZFIJKPlayerManager *playerManager = [[ZFIJKPlayerManager alloc] init];
    
    /// player的tag值必须在cell里设置
    self.player = [ZFPlayerController playerWithScrollView:self.tableView playerManager:playerManager containerViewTag:100];
    self.player.controlView = self.controlView;
    self.player.assetURLs = self.urls;
    /// 0.8是消失80%时候，默认0.5
    self.player.playerDisapperaPercent = 0.8;
    /// 移动网络依然自动播放
    self.player.WWANAutoPlay = YES;
    @weakify(self)
    self.player.playerDidToEnd = ^(id  _Nonnull asset) {
        @strongify(self)
        if (self.player.playingIndexPath.row < self.urls.count - 1) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.player.playingIndexPath.row+1 inSection:0];
            [self playTheVideoAtIndexPath:indexPath scrollToTop:YES];
        } else {
            [self.player stopCurrentPlayingCell];
        }
    };
    
    self.player.orientationWillChange = ^(ZFPlayerController * _Nonnull player, BOOL isFullScreen) {
        @strongify(self)
        [self setNeedsStatusBarAppearanceUpdate];
        [UIViewController attemptRotationToDeviceOrientation];
        self.tableView.scrollsToTop = !isFullScreen;
    };
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
//    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame);
//    CGFloat h = CGRectGetMaxY(self.view.frame);
    self.tableView.frame = CGRectMake(0, 0, Screen_Width, Screen_Height - ZK_TopHeight-ZK_TabBarHeight);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    @weakify(self)
    [self.tableView zf_filterShouldPlayCellWhileScrolled:^(NSIndexPath *indexPath) {
        @strongify(self)
        [self playTheVideoAtIndexPath:indexPath scrollToTop:NO];
    }];
}


- (void)requestData {
    self.urls = @[].mutableCopy;
    
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
//    NSData *data = [NSData dataWithContentsOfFile:path];
//    NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//
//    self.dataSource = @[].mutableCopy;
//    NSArray *videoList = [rootDict objectForKey:@"list"];
//    for (NSDictionary *dataDic in videoList) {
//        ZKVideoObj *data = [[ZKVideoObj alloc] init];
//        [data setValuesForKeysWithDictionary:dataDic];
//        ZKTableViewCellLayout *layout = [[ZKTableViewCellLayout alloc] initWithData:data];
//        [self.dataSource addObject:layout];
//        NSString *URLString = [data.video_url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//        NSURL *url = [NSURL URLWithString:URLString];
//        [self.urls addObject:url];
//    }
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    params[@"new_recommend_type"] = @"3";
    params[@"pn"] = @(1);
    params[@"dl"] = @"505F80E58F3817291B7768CE59A90AF8";
    params[@"sign"] = @"3DD6882F963C25F5FA1ECA558F8CEF48";
    params[@"_timestamp"] = @"1537782764313";
    params[@"timestamp"] = @"1537782764313";
    params[@"net_type"] = @"1";
    
    params[@"_client_type"] = @"1";
    params[@"_client_version"] = @"2.2.0";
    params[@"_os_version"] = @"12.0";
    params[@"_phone_imei"] = @"9A910F65D70DBAE95866E00B75934C78|com.baidu.nani";
    params[@"_phone_newimei"] = @"9A910F65D70DBAE95866E00B75934C78|com.baidu.nani";
    
    params[@"brand"] = @"iPad";
    params[@"brand_type"] = @"Unknown iPad";
    params[@"cuid"] = @"9A910F65D70DBAE95866E00B75934C78|com.baidu.nani";
    params[@"diuc"] = @"C2D95DB95D613410309F81193FB324F01F9B14E32FHFSIKTGGF";
    params[@"from"] = @"AppStore";
    params[@"model"] = @"Unknown iPad";
    params[@"nani_idfa"] = @"86294854-68D7-49CD-A8FD-6804980FE590";
    params[@"subapp_type"] = @"nani";
    //
    //    dic[@"z_id"] = @"FWUSehM4YgkAAAACVAEAAG8Ba0plAAAQAAAAAAAAAAA8OfwlgbRLLLw6XQUnvgx0Zj0GMglnRRgjOWAYewAyClV3VyNCSQZjA0AUT1MsfCA";
    //    dic[@"dl"] = @"B650D852850FD5D326774B621C25ECCE";
    //    dic[@"sign"] = @"602DB4C8DF0203B34DBB69B3A1E1F0AC";
    
    params[@"z_id"] = @"rFrPVimBUvWH5P7FBld1NBSx7OoCUk8yiHZ8-LLBkC1Wfri7C904CDCrYh9EgDRp64f3LSQZAfGS3XO0hD5ri4w";
    params[@"tbs"] = @"73254f0d29744cbf1537693822";
    
    // 推荐列表
    NSString *url = @"http://c.tieba.baidu.com/c/f/nani/recommend/list";
    [[ZKManager shareManager] requestWithRoutineMethod:RequestMethodGet url:url showLoading:YES param:params success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        NSLog(@"%@",responseObject);
        
        if ([responseObject[@"error_code"] integerValue] == 0) {
            NSDictionary *data = responseObject[@"data"];
            
//            self.has_more = [data[@"has_more"] boolValue];
            
//            NSMutableArray *array = [NSMutableArray new];
            self.dataSource = @[].mutableCopy;
            for (NSDictionary *dic in data[@"video_list"]) {
                ZKVideoObj *model = [ZKVideoObj yy_modelWithDictionary:dic];
//                [array addObject:model];
                
                ZKTableViewCellLayout *layout = [[ZKTableViewCellLayout alloc] initWithData:model];
                [self.dataSource addObject:layout];
                NSString *URLString = [model.video_url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                NSURL *url = [NSURL URLWithString:URLString];
                [self.urls addObject:url];
                
                [self.tableView reloadData];
            }
            
            
        }else {
            NSLog(@"%@", responseObject);
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        DLog(@"%@",error);
    }];
}

- (BOOL)shouldAutorotate {
    /// 如果只是支持iOS9+ 那直接return NO即可，这里为了适配iOS8
    return self.player.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (self.player.isFullScreen && self.player.orientationObserver.fullScreenMode == ZFFullScreenModeLandscape) {
        return UIInterfaceOrientationMaskLandscape;
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.player.isFullScreen) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    return self.player.isStatusBarHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

#pragma mark - UIScrollViewDelegate 列表播放必须实现

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [scrollView zf_scrollViewDidEndDecelerating];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [scrollView zf_scrollViewDidEndDraggingWillDecelerate:decelerate];
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    [scrollView zf_scrollViewDidScrollToTop];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [scrollView zf_scrollViewDidScroll];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [scrollView zf_scrollViewWillBeginDragging];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZKVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentifier];
    [cell setDelegate:self withIndexPath:indexPath];
    cell.layout = self.dataSource[indexPath.row];
    [cell setNormalMode];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    /// 如果正在播放的index和当前点击的index不同，则停止当前播放的index
    if (self.player.playingIndexPath != indexPath) {
        [self.player stopCurrentPlayingCell];
    }
    /// 如果没有播放，则点击进详情页会自动播放
    if (!self.player.currentPlayerManager.isPlaying) {
        [self playTheVideoAtIndexPath:indexPath scrollToTop:NO];
    }
    /// 到详情页
//    ZFPlayerDetailViewController *detailVC = [ZFPlayerDetailViewController new];
//    detailVC.player = self.player;
//    @weakify(self)
//    /// 详情页返回的回调
//    detailVC.detailVCPopCallback = ^{
//        @strongify(self)
//        [self.player updateScrollViewPlayerToCell];
//    };
//    /// 详情页点击播放的回调
//    detailVC.detailVCPlayCallback = ^{
//        @strongify(self)
//        [self zf_playTheVideoAtIndexPath:indexPath];
//    };
//    [self.navigationController pushViewController:detailVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZKTableViewCellLayout *layout = self.dataSource[indexPath.row];
    return layout.height;
}

#pragma mark - ZKTableViewCellDelegate

- (void)zk_playTheVideoAtIndexPath:(NSIndexPath *)indexPath {
    [self playTheVideoAtIndexPath:indexPath scrollToTop:NO];
}

#pragma mark - private method

/// play the video
- (void)playTheVideoAtIndexPath:(NSIndexPath *)indexPath scrollToTop:(BOOL)scrollToTop {
    [self.player playTheIndexPath:indexPath scrollToTop:scrollToTop];
    ZKTableViewCellLayout *layout = self.dataSource[indexPath.row];
    [self.controlView showTitle:layout.data.title
                 coverURLString:layout.data.thumbnail_url
                 fullScreenMode:layout.isVerticalVideo?ZFFullScreenModePortrait:ZFFullScreenModeLandscape];
}

- (ZFPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [ZFPlayerControlView new];
    }
    return _controlView;
}




@end

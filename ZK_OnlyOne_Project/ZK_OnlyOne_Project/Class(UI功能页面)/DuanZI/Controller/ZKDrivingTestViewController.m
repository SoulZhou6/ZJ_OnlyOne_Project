//
//  ZKDrivingTestViewController.m
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/25.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import "ZKDrivingTestViewController.h"
#import "ZKSegmentView.h"
#import "WRNavigationBar.h"

#import "ZKSingChooseTableView.h"
@interface ZKDrivingTestViewController ()<ZKSegmentViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong)ZKSegmentView * segmentView;
@property (nonatomic,strong)UICollectionView * collectionView;
@property (nonatomic,strong)ZKSingChooseTableView * singChooseTableView;
@property (nonatomic,strong)NSArray * queryObjects;
@end

@implementation ZKDrivingTestViewController


- (NSArray *)queryObjects{
    
    if(_queryObjects == nil){
        
        _queryObjects = [[NSArray alloc]init];
    }
    
    return  _queryObjects;
}

#pragma mark - 初始化collectionView
- (UICollectionView *)collectionView{
    
    if (_collectionView==nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        //确定水平滑动方向
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        //   [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];垂直方向
        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-50) collectionViewLayout:flowLayout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.pagingEnabled = YES;
        self.collectionView.scrollEnabled = YES;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.showsVerticalScrollIndicator = NO;
        self.collectionView.backgroundColor = [UIColor whiteColor];
        //注册Cell，必须要有
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
        
    }
    
    return _collectionView;
}
#pragma mark - 设置导航栏选项卡
- (ZKSegmentView *)segmentView{
    
    if (_segmentView == nil) {
        
        _segmentView = [[ZKSegmentView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width/3, 30) titles:@[@"消息",@"电话"]];
        
        self.segmentView.delegate = self;
        [self.segmentView setSelectNumber:0 animate:YES];
    }
    
    return _segmentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   [WRNavigationBar wr_setDefaultNavBarBarTintColor:[UIColor whiteColor]];
    self.navigationItem.titleView = self.segmentView;
    [self.view addSubview:self.collectionView];
}

#pragma mark - 请求题库接口数据
- (void)requestQueryData{
    
    NSDictionary * parms = @{@"key":queryAppkey,@"subject":@"1",@"model":@"c1",@"testType":@"rand"};
    WeakSelf;
    [[ZKManager shareManager] requestWithRoutineMethod:RequestMethodGet url:queryUrl showLoading:YES param:parms success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        if ([responseObject[@"error_code"] intValue] == 0) {
            
            weakSelf.queryObjects = responseObject[@"result"];
            [weakSelf.collectionView reloadData];
        }else{
            
            [[ZKManager shareManager] alertMsg:responseObject[@"reason"]];
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
        [[ZKManager shareManager] alertMsg:@"网络不给力"];
    }];
}

#pragma mark - ZKSegmentViewDelegate
- (void)xsSegmentedView:(ZKSegmentView *)ZKSegmentedView selectTitleInteger:(NSInteger)integer {
    
    NSLog(@"select:%ld",(long)integer);
    
}

- (BOOL)xsSegmentedView:(ZKSegmentView *)ZKSegmentedView didSelectTitleInteger:(NSInteger)integer {
    
    NSLog(@"didSelect:%ld",(long)integer);
    
    return YES;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 15;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *Idenfire = @"CollectionViewCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Idenfire forIndexPath:indexPath];
    
    _singChooseTableView = [ZKSingChooseTableView singChooseTableWithFrame:CGRectMake(0, 30, Screen_Width, self.view.frame.size.height-120)];
    
    [cell.contentView addSubview:_singChooseTableView];
    
    return cell;
}


#pragma mark --UICollectionViewDelegate
- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0); // 上, 左, 下, y右
}


#pragma mark --设置每个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(Screen_Width , Screen_Height-50);
}

//定义每个UICollectionView 的 margin
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
// 两行之间的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
@end

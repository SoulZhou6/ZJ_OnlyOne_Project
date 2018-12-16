//
//  ZKTabBarController.m
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/12.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import "ZKTabBarController.h"
#import "ZKHomeViewController.h"
#import "ZKNavigationViewController.h"
#import "ZKDuanZiViewController.h"
#import "ZKVideoViewController.h"
#import "ZKToolViewController.h"
@interface ZKTabBarController ()

@end

@implementation ZKTabBarController

+ (instancetype)tabbar
{
    ZKTabBarController *tab = [[ZKTabBarController alloc] initWithControllers];
    return tab;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0,0,Screen_Width,49)];
    backView.backgroundColor =  [UIColor groupTableViewBackgroundColor];
    [self.tabBar insertSubview:backView atIndex:0];
    self.tabBar.opaque = YES;
    
//    [self.tabBar addToThemeColorPool:@"tintColor"];
    //设置导航栏背景图片
   
    // tabbar背景图主题管理
    UIImage *tabbarimage=[[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImageView *tabBarBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.tabBar.frame.size.width, self.tabBar.frame.size.height)];
    tabBarBackgroundImageView.image = tabbarimage;
    [self.tabBar insertSubview:tabBarBackgroundImageView atIndex:1];
//    [tabBarBackgroundImageView addToThemeImagePoolWithSelector:@selector(setImage:) objects:NULL];
}

- (instancetype)initWithControllers
{
    if (self = [super init])
    {
        [self addChildViewController:[[ZKHomeViewController alloc] init] image:@"zk_tabbar_zx_normal" seletedImage:@"zk_tabbar_zx_selected" title:@"资讯"];
        [self addChildViewController:[[ZKDuanZiViewController alloc] init] image:@"zk_tabbar_dz_normal"  seletedImage:@"zk_tabbar_dz_selected"  title:@"段子"];
        [self addChildViewController:[[ZKVideoViewController alloc] init] image:@"zk_tabbar_sp_normal"  seletedImage:@"zk_tabbar_sp_selected"  title:@"视频"];
        [self addChildViewController:[[ZKToolViewController alloc] init] image:@"zk_tabbar_gj_normal"  seletedImage:@"zk_tabbar_gj_selected"  title:@"工具"];
    }
    return self;
}

- (void)addChildViewController:(UIViewController *)childVC image:(NSString *)image seletedImage:(NSString *)selectedImageName title:(NSString *)title
{
    // 3.设置tabBarItem的选中文字大小
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#666666"];
    textAttrs[NSFontAttributeName] = FONT(10);
    [childVC.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    // 3.设置tabBarItem的选中文字颜色
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#1296db"];
    selectedTextAttrs[NSFontAttributeName] = FONT(10);
    [childVC.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    // 4.标题
    //    childVC.tabBarItem.title = title;
    childVC.title = title;
    // 5.正常图标
    UIImage * normalImage = [[UIImage imageNamed:image]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    childVC.tabBarItem.image = normalImage;
    // 6.选中图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    //    if (iOS7) {
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//告诉系统这张图片用原图(别渲染)
    childVC.tabBarItem.selectedImage = selectedImage;
    
    
    // 包装导航条
    ZKNavigationViewController *nav = [[ZKNavigationViewController alloc] initWithRootViewController:childVC];
    
    [self addChildViewController:nav];
}

- (UIImage *)scaleImage:(NSString *)imageName
{
    UIImage *img = [UIImage imageNamed:imageName];
    CGFloat width = 23.6;
    
    CGSize origin = img.size;
    origin.height = width / origin.width * origin.height;
    origin.width = width;
    
    UIGraphicsBeginImageContextWithOptions(origin, NO, [UIScreen mainScreen].scale);
    [img drawInRect:CGRectMake(0, 0, origin.width, origin.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

@end

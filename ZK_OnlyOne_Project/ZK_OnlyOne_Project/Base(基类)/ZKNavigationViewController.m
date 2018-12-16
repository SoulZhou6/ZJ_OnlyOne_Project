//
//  ZKNavigationViewController.m
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/12.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import "ZKNavigationViewController.h"
#import "NSObject+Extension.h"

@interface ZKNavigationViewController ()
@end

@implementation ZKNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // navi背景图片主题管理
    [self.navigationBar setBackgroundImage:[[UIImage imageNamed:@"bannerB"] resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar addToThemeImagePoolWithSelector:@selector(setBackgroundImage:forBarMetrics:) objects:@[ZK_THEME_IMAGE ,@(UIBarMetricsDefault)]];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationController.navigationBar.hidden = NO;
    CGFloat height = KIsiPhoneX?88:64;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithFrame:CGRectMake(0, 0, Screen_Width, height) color:[UIColor orangeColor] alpha:1.0] forBarMetrics:UIBarMetricsDefault];
    
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
   
}


@end

//
//  ZKWebBrowseViewController.h
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/17.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import "ZKBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class ZKHomeObj;

typedef void(^KYWkwebViewControllerBackBlock)(void);

@interface ZKWebBrowseViewController : ZKBaseViewController

@property (nonatomic,assign)NSInteger isRead;
@property (nonatomic,assign)BOOL isMessageBool;
@property (nonatomic,strong)KYWkwebViewControllerBackBlock wkwebViewControllerBackBlock;
/**
 加载纯外部链接网页
 
 @param string URL地址
 */
- (void)loadWebURLSring:(NSString *)string;

/**
 加载本地网页
 
 @param string 本地HTML文件名
 */
- (void)loadWebHTMLSring:(NSString *)string;

/**
 加载外部链接POST请求(注意检查 XFWKJSPOST.html 文件是否存在 )
 
 @param string 需要POST的URL地址
 @param postData post请求块
 */
- (void)POSTWebURLSring:(NSString *)string postData:(NSString *)postData;
/// news model
@property (nonatomic, strong) ZKHomeObj *model;
@end

NS_ASSUME_NONNULL_END

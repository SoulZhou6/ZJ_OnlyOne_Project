//
//  ZKManager.h
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/11.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

typedef NS_ENUM(NSUInteger,RequestMethod){
    RequestMethodPost = 0,
    RequestMethodGet,
    RequestMethodPut
};

typedef void (^Suceess)(NSURLSessionDataTask *operation, id responseObject);

typedef void (^Failure)(NSURLSessionDataTask *operation, NSError *error);

typedef void(^Progress)(NSProgress * uploadProgress);

NS_ASSUME_NONNULL_BEGIN

@interface ZKManager : NSObject
+(instancetype)shareManager;

@property(nonatomic,assign)BOOL isReLogin;

/** 按钮倒计时*/
-(void)setTheCountdownButton:(UIButton *)button startWithTime:(NSInteger)timeLine  countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color;

/** 传入一个view找到他的上级控制器*/
-(UIViewController *)viewController:(UIView *)view;

/** 寻找当前显示的控制器*/
-(UIViewController*)currentVisibleViewController;

/** 提示*/
-(void)alertMsg:(NSString *)msg;
/** token失效的提示*/
- (UIAlertController *)alertTokenMsg:(NSString *)msg;

/** 判断手机号码格式*/
-(BOOL)isPhoneNum:(NSString *)phoneNu;

/** 网络请求(json格式)*/
- (void)requestWithMethod:(RequestMethod)method MainUrl:(NSString *)mainUrl url:(NSString *)url body:(NSData *)body showLoading:(BOOL)show useToken:(BOOL)useToken isSign:(BOOL)isSign param:(NSMutableDictionary *)param success:(Suceess)success failure:(Failure)failure;

/** 网络请求(http格式)*/
-(void)requestHttpWithMethod:(RequestMethod)method MainUrl:(NSString *)mainUrl url:(NSString *)url body:(NSData *)body showLoading:(BOOL)show useToken:(BOOL)useToken param:(NSDictionary *)param success:(Suceess)success failure:(Failure)failure;

/** 上传图片*/
- (void)requestWithImageMethod:(RequestMethod)method MainUrl:(NSString *)mainUrl url:(NSString *)url imagesArray:(NSMutableArray *)imagesArray showLoading:(BOOL)show isSign:(BOOL)isSign param:(NSMutableDictionary *)param progress:(Progress)progress success:(Suceess)success failure:(Failure)failure;

/**通常规网络请求 接口地址没变化，一次性的*/
- (void)requestWithRoutineMethod:(RequestMethod)method url:(NSString *)url  showLoading:(BOOL)show param:(NSDictionary *)param success:(Suceess)success failure:(Failure)failure;

/*storyboard 控制器的公共方法*/

- (id)loadStoryBoardViewControllerWhithIdentifier:(NSString *)identifier;

/**获取手机型号*/
- (NSString *)iphoneType;

@end

NS_ASSUME_NONNULL_END

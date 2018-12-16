//
//  ZKManager.m
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/11.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import "ZKManager.h"
#import <sys/utsname.h>
#import <UIKit/UIKit.h>
@implementation ZKManager

#pragma mark - 单列
static ZKManager *_manager;

static id _manager;

+ (instancetype)shareManager
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc] init];
    });
    
    return _manager;
}


+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _manager = [super allocWithZone:zone];
    });
    
    return _manager;
}


- (id)copyWithZone:(NSZone *)zone
{
    return _manager;
}


-(void)setTheCountdownButton:(UIButton *)button startWithTime:(NSInteger)timeLine  countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color
{
    //倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0, 0, queue);
    //每秒执行一次
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL,0), 1.0 * NSEC_PER_SEC,0);
    dispatch_source_set_event_handler(_timer, ^{
        
        //倒计时结束，关闭
        if (timeOut == 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                button.backgroundColor = mColor;
                [button setTitle:@"重新获取" forState:UIControlStateNormal];
                button.userInteractionEnabled =YES;
                [button setTitleColor:[UIColor colorWithHexString:@"#f5b99c"] forState:UIControlStateNormal];
            });
        } else {
            int seconds = timeOut % 60;
            NSString *timeStr = [NSString stringWithFormat:@"%0.1d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                button.backgroundColor = color;
                [button setTitle:[NSString stringWithFormat:@"%@%@",timeStr,subTitle]forState:UIControlStateNormal];
                button.userInteractionEnabled =NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}


-(UIViewController *)viewController:(UIView *)view{
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

//获取Window当前显示的ViewController
-(UIViewController*)currentVisibleViewController{
    //获得当前活动窗口的根视图
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1)
    {
        //根据不同的页面切换方式，逐步取得最上层的viewController
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}


#pragma mark -提示
-(void)alertMsg:(NSString *)msg
{
    
    [WSProgressHUD showImage:nil status:msg];
}

#pragma mark - token失效的提示
- (UIAlertController *)alertTokenMsg:(NSString *)msg{
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * confirm = [UIAlertAction actionWithTitle:@"重新登录" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:token];
//        [[NSNotificationCenter defaultCenter] postNotificationName:loginTokenInvalidNotification object:nil];
        
    }];
    [alert addAction:confirm];
    
    return alert;
    
}

#pragma mark -判断手机号码格式
#pragma mark - 判断手机号码格式
-(BOOL)isPhoneNum:(NSString *)phoneNum{
    
    
    if (phoneNum.length != 11)
    {
        return NO;
    }
    
    else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:phoneNum];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:phoneNum];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:phoneNum];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
    
}

#pragma mark -网络请求
- (void)requestWithMethod:(RequestMethod)method MainUrl:(NSString *)mainUrl url:(NSString *)url body:(NSData *)body showLoading:(BOOL)show  useToken:(BOOL)useToken isSign:(BOOL)isSign param:(NSMutableDictionary *)param success:(Suceess)success failure:(Failure)failure
{
    if (show) {
        
        [WSProgressHUD setSecondProrityIndicatorStyle:WSProgressHUDIndicatorMMSpinner];
        [WSProgressHUD showWithMaskType:WSProgressHUDMaskTypeClear];
    }
    
    //    NSString * string = [ZKMD5encrypt sortMD5Dictionary:param];
    
    //    NSDictionary * dict = [ZKMD5encrypt parseQueryString:string];
    
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 15.0f;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",mainUrl,url];
    //    if (useToken) {
    //        [manager.requestSerializer setValue:TOKEN forHTTPHeaderField:@"token"];
    //
    //    }
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",
                                                         @"text/html",
                                                         @"application/json",
                                                         @"application/json;charset=utf-8", nil];
    manager.requestSerializer.timeoutInterval = 10.0f;
    
//    [param setObject:PROJECT_VERSION forKey:@"version"];
    [param setObject:@"app" forKey:@"channel"];
    [param setObject:@"ios" forKey:@"ZKplatform"];
//    [param setObject:[ZKMD5encrypt getNowTimeTimestamp3] forKey:@"timeStamp"];
    
//    if(isSign){
//        NSString * sign = [ZKMD5encrypt sortMD5Dictionary:param];
//        [param setObject:sign forKey:@"sign"];
//    }
    
    if (method == RequestMethodPost) {
        [manager POST:urlStr parameters:param progress:^(NSProgress * _Nonnull uploadProgress)
         {
             
         }
         
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  
                  
                  [WSProgressHUD dismiss];
                  if([[responseObject objectForKey:@"code"] integerValue] == 4001){
                      [task cancel];
                      UIViewController * current = [self currentVisibleViewController];
                      [current presentViewController:[[ZKManager shareManager] alertTokenMsg:@"登录已过期，请重新登录"] animated:YES completion:nil];
                      return;
                  }else{
                      
                      success(task,responseObject);
                  }
                  
              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  
                  [WSProgressHUD dismiss];
                  failure(task,error);
                  
              }];
    }
    else if(method == RequestMethodGet)
    {
        [manager GET:urlStr parameters:param progress:^(NSProgress * _Nonnull uploadProgress)
         {
             
         }
         
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 [WSProgressHUD dismiss];
                 if([[responseObject objectForKey:@"code"] integerValue] == 4001){
                     
                     [task cancel];
                     UIViewController * current = [self currentVisibleViewController];
                     [current presentViewController:[[ZKManager shareManager] alertTokenMsg:@"登录已过期，请重新登录"] animated:YES completion:nil];
                     return;
                 }else{
                     
                     success(task,responseObject);
                 }
             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 [WSProgressHUD dismiss];
                 failure(task,error);
             }];
    }
    
    else
    {
        [manager PUT:urlStr parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [WSProgressHUD dismiss];
            success(task,responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [WSProgressHUD dismiss];
            failure(task,error);
        }];
    }
}

- (void)requestHttpWithMethod:(RequestMethod)method MainUrl:(NSString *)mainUrl url:(NSString *)url body:(NSData *)body showLoading:(BOOL)show useToken:(BOOL)useToken param:(NSDictionary *)param success:(Suceess)success failure:(Failure)failure
{
    if (show) {
        [WSProgressHUD setSecondProrityIndicatorStyle:WSProgressHUDIndicatorMMSpinner];
        [WSProgressHUD showWithMaskType:WSProgressHUDMaskTypeClear];
    }
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 15.0f;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",mainUrl,url];
//    if (useToken) {
//        [manager.requestSerializer setValue:TOKEN forHTTPHeaderField:@"token"];
//        
//    }
    [manager.requestSerializer setValue:@"channel" forHTTPHeaderField:@"app"];
    [manager.requestSerializer setValue:@"ZKplatform" forHTTPHeaderField:@"ios"];
    [manager.requestSerializer setValue:@"version" forHTTPHeaderField:@"IOS_VERSION"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",
                                                         @"text/html",
                                                         @"application/json",
                                                         @"application/json;charset=utf-8", nil];
    manager.requestSerializer.timeoutInterval = 10.0f;
    
    if (method == RequestMethodPost) {
        [manager POST:urlStr parameters:param progress:^(NSProgress * _Nonnull uploadProgress)
         {
         }
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  [WSProgressHUD dismiss];
                  success(task,responseObject);
                  
                  
              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  failure(task,error);
                  [WSProgressHUD dismiss];
                  
              }];
    }
    else if(method == RequestMethodGet)
    {
        [manager GET:urlStr parameters:param progress:^(NSProgress * _Nonnull uploadProgress)
         {
             
         }
         
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 [WSProgressHUD dismiss];
                 
                 success(task,responseObject);
                 
             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 [WSProgressHUD dismiss];
                 
                 failure(task,error);
             }];
    }
    
    else
    {
        [manager PUT:urlStr parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [WSProgressHUD dismiss];
            success(task,responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [WSProgressHUD dismiss];
            
            failure(task,error);
        }];
    }
}

#pragma mark - 上传图片
- (void)requestWithImageMethod:(RequestMethod)method MainUrl:(NSString *)mainUrl url:(NSString *)url imagesArray:(NSMutableArray *)imagesArray showLoading:(BOOL)show isSign:(BOOL)isSign param:(NSMutableDictionary *)param progress:(Progress)progress success:(Suceess)success failure:(Failure)failure{
    
    if (show) {
        
        [WSProgressHUD setSecondProrityIndicatorStyle:WSProgressHUDIndicatorMMSpinner];
        [WSProgressHUD showWithMaskType:WSProgressHUDMaskTypeClear];
    }
    
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 15.0f;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",mainUrl,url];
    //    if (useToken) {
    //        [manager.requestSerializer setValue:TOKEN forHTTPHeaderField:@"token"];
    //
    //    }
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",
                                                         @"text/html",
                                                         @"application/json",
                                                         @"application/json;charset=utf-8", nil];
    manager.requestSerializer.timeoutInterval = 30.0f;
    
//    [param setObject:PROJECT_VERSION forKey:@"version"];
    [param setObject:@"app" forKey:@"channel"];
    [param setObject:@"ios" forKey:@"ZKplatform"];
    
//    [param setObject:[ZKMD5encrypt getNowTimeTimestamp3] forKey:@"timeStamp"];
//    if(isSign){
//        NSString * sign = [ZKMD5encrypt sortMD5Dictionary:param];
//        [param setObject:sign forKey:@"sign"];
//    }
    
    [manager POST:urlStr parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //如果是多张图片上传，可以在此增加for循环
        int i = 0;
        for (UIImage *image in imagesArray) {
            
            NSData *imageData = UIImagePNGRepresentation([UIImage imageCompressWithSimple:image]);
            NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
            NSString *imagePath = [NSString stringWithFormat:@"%f.png", time];
            NSString *imageName = [NSString stringWithFormat:@"ios_%d", i];
            i++;
            //多张上传的时候name不能一样
            [formData appendPartWithFileData:imageData
                                        name:imageName
                                    fileName:imagePath
                                    mimeType:@"image/png"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"upload head image progress:%@",uploadProgress);
        progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [WSProgressHUD dismiss];
        success(task,responseObject);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [WSProgressHUD dismiss];
        failure(task,error);
    }];
    
}

#pragma mark - 普通常规网络请求
- (void)requestWithRoutineMethod:(RequestMethod)method url:(NSString *)url  showLoading:(BOOL)show param:(NSDictionary *)param success:(Suceess)success failure:(Failure)failure{
    
    if (show) {
        
        [WSProgressHUD setSecondProrityIndicatorStyle:WSProgressHUDIndicatorMMSpinner];
        [WSProgressHUD showWithMaskType:WSProgressHUDMaskTypeClear];
    }
    
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 15.0f;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSString *urlStr = [NSString stringWithFormat:@"%@",url];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",
                                                         @"text/html",
                                                         @"application/json",
                                                         @"text/javascript",
                                                         @"application/json;charset=utf-8", nil];
    manager.requestSerializer.timeoutInterval = 30.0f;
    
    if (method == RequestMethodPost) {
        [manager POST:urlStr parameters:param progress:^(NSProgress * _Nonnull uploadProgress)
         {
         }
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  [WSProgressHUD dismiss];
                  success(task,responseObject);
                  
                  
              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  failure(task,error);
                  [WSProgressHUD dismiss];
                  
              }];
    }
    else if(method == RequestMethodGet)
    {
        [manager GET:urlStr parameters:param progress:^(NSProgress * _Nonnull uploadProgress)
         {
             
         }
         
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 [WSProgressHUD dismiss];
                 
                 success(task,responseObject);
                 
             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 [WSProgressHUD dismiss];
                 
                 failure(task,error);
             }];
    }
    
    else
    {
        [manager PUT:urlStr parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [WSProgressHUD dismiss];
            success(task,responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [WSProgressHUD dismiss];
            
            failure(task,error);
        }];
    }
}

#pragma mark 加载 storyboard 控制器的公共方法

- (id)loadStoryBoardViewControllerWhithIdentifier:(NSString *)identifier{
    
    return [[UIStoryboard storyboardWithName:@"ZKCustom" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:identifier];
}

#pragma mark - 获取手机型号
- (NSString *)iphoneType{
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString*platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if([platform isEqualToString:@"iPhone1,1"])  return@"iPhone 2G";
    
    if([platform isEqualToString:@"iPhone1,2"])  return@"iPhone 3G";
    
    if([platform isEqualToString:@"iPhone2,1"])  return@"iPhone 3GS";
    
    if([platform isEqualToString:@"iPhone3,1"])  return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,2"])  return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,3"])  return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone4,1"])  return@"iPhone 4S";
    
    if([platform isEqualToString:@"iPhone5,1"])  return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,2"])  return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,3"])  return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone5,4"])  return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone6,1"])  return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone6,2"])  return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone7,1"])  return@"iPhone 6 Plus";
    
    if([platform isEqualToString:@"iPhone7,2"])  return@"iPhone 6";
    
    if([platform isEqualToString:@"iPhone8,1"])  return@"iPhone 6s";
    
    if([platform isEqualToString:@"iPhone8,2"])  return@"iPhone 6s Plus";
    
    if([platform isEqualToString:@"iPhone8,4"])  return@"iPhone SE";
    
    if([platform isEqualToString:@"iPhone9,1"])  return@"iPhone 7";
    
    if([platform isEqualToString:@"iPhone9,3"])  return@"iPhone 7";
    
    if([platform isEqualToString:@"iPhone9,2"])  return@"iPhone 7 Plus";
    
    if([platform isEqualToString:@"iPhone9,4"])  return@"iPhone 7 Plus";
    
    if([platform isEqualToString:@"iPhone10,1"]) return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,4"]) return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,2"]) return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,5"]) return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,3"]) return@"iPhone X";
    
    if([platform isEqualToString:@"iPhone10,6"]) return@"iPhone X";
    
    return platform;
}
@end

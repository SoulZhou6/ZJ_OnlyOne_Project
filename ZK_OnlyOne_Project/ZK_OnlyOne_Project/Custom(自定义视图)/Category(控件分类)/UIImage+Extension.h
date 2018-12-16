//
//  UIImage+Extension.h
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/11.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Extension)
/** 让图片按照指定尺寸缩放*/
- (UIImage*) scaleImageWithSize:(CGSize)size;

/** 截取图片的某一部分*/
- (UIImage *)getPartOfImage:(UIImage *)img rect:(CGRect)partRect;

/// 返回一张不超过屏幕尺寸的 image
+ (UIImage *)imageSizeWithScreenImage:(UIImage *)image;


/*垂直翻转*/
- (UIImage *)flipVertical;

/*水平翻转*/
- (UIImage *)flipHorizontal;

/*改变size*/
- (UIImage *)resizeToWidth:(CGFloat)width height:(CGFloat)height;

/*裁切*/
//+ (UIImage *)cropImageWithX:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height;

/** 根据颜色生成一张图片*/
+ (UIImage *)imageWithFrame:(CGRect)frame color:(UIColor *)backColor alpha:(CGFloat)alpha;

/** 把一个view生成一张图片*/
+(UIImage *)makeImageWithView:(UIView *)view withSize:(CGSize)size;


/** 截取正方形的图片*/
+(UIImage*)getSubImage:(UIImage *)image mCGRect:(CGRect)mCGRect
            centerBool:(BOOL)centerBool;
//绘制虚线
+(UIImage *)drawLineOfDashByImageView:(UIImageView *)imageView;

//颜色转换成图片(带圆角的)
+ (UIImage *)imageWithColor:(UIColor *)color redius:(CGFloat)redius size:(CGSize)size;
//将图片截成圆形图片
+ (UIImage *)imagewithImage:(UIImage *)image;



/**
 创建1*1大小的纯色图片
 
 @param color 图片
 颜色
 @return 创建的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;


/**
 创建指定大小、颜色的图片
 
 @param color 图片颜色
 @param size 图片大小
 @return 创建的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;


/**
 创建纯色背景、文字居中的图片
 
 @param color 图片背景色
 @param size 图片大小
 @param attributeString 居中文字
 @return 创建的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size text:(NSAttributedString *)attributeString;


/**
 裁剪圆形图片
 
 @param image 需要裁剪的图片
 @param inset 裁剪inset
 @return 裁剪后的图片
 */
+ (UIImage *)ellipseImage:(UIImage *)image withInset:(CGFloat)inset;


/**
 裁剪带边框的圆形图片
 
 @param image 需要裁剪的图片
 @param inset 裁剪inset
 @param width 边框宽度
 @param color 边框颜色
 @return 裁剪后的图片
 */
+ (UIImage *)ellipseImage: (UIImage *) image withInset:(CGFloat)inset withBorderWidth:(CGFloat)width withBorderColor:(UIColor*)color;


+ (UIImage *)createScanImage:(NSString *)url;



/**
 根据屏幕的宽高等比压缩图片   上传原图
 
 @param image 传入要压缩的图片
 @return 压缩后，返回压缩的图片
 */
+ (UIImage*)imageCompressWithSimple:(UIImage*)image;
@end

NS_ASSUME_NONNULL_END

//
//  ZJLaunchAdController.h
//  ZJLaunchAd
//
//  Created by ZeroJ on 16/10/9.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ZJLaunchAdCallbackType) {
    ZJLaunchAdCallbackTypeClickAd,
    ZJLaunchAdCallbackTypeClickSkipBtn,
    ZJLaunchAdCallbackTypeShowFinish
};
// 各种点击响应block
typedef void(^ZJLaunchAdFinishHandler)(ZJLaunchAdCallbackType callbackType);
// 设置广告图片block
typedef void(^ZJLaunchAdSetAdImageHandler)(UIImageView *imageView);
// 设置跳过按钮的属性block
typedef void(^ZJLaunchAdSetSkipBtnHandler)(UIButton *skipBtn, NSInteger currentTime);

@interface ZJLaunchAdController : UIViewController

/**
 *  广告显示时间 默认为 5s
 */
@property (assign, nonatomic) NSInteger countDownTime;
/**
 *  自定义广告图片的frame
 *  默认情况下需要显示启动图片的时候, 设置广告的高度为屏幕高度的2/3
 *  不需要显示启动图片的时候, 广告高度和屏幕高度相同
 */
@property (assign, nonatomic) CGRect adImageViewFrame;

/**
 *  类似网易新闻的半屏广告的初始化方法
 *
 *  @param launchImage       设置需要显示的启动图片
 *  @param setAdImageHandler 设置广告图片的block
 *  @param finishHandler     回调block
 *
 *  @return
 */
- (instancetype)initWithLaunchImage:(UIImage *)launchImage setAdImageHandler:(ZJLaunchAdSetAdImageHandler)setAdImageHandler finishHandler:(ZJLaunchAdFinishHandler)finishHandler;
/**
 *  全屏广告的初始化方法
 *
 *  @param setAdImageHandler 设置广告图片的block
 *  @param finishHandler     回调block
 *
 *  @return
 */
- (instancetype)initWithSetAdImageHandler:(ZJLaunchAdSetAdImageHandler)setAdImageHandler finishHandler:(ZJLaunchAdFinishHandler)finishHandler;
/**
 *  设置跳过按钮的属性, 文字, 背景...
 *
 *  @param setSkipBtnHandler setSkipBtnHandler
 */
- (void)setSkipBtnHandler:(ZJLaunchAdSetSkipBtnHandler)setSkipBtnHandler;
@end

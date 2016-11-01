
//
//  ZJLaunchAdController.m
//  ZJLaunchAd
//
//  Created by ZeroJ on 16/10/9.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJLaunchAdController.h"

@interface ZJLaunchAdController () {
    BOOL _isBegin;
}
// 启动图片
@property (strong, nonatomic) UIImage *launchImage;
// 全屏显示启动图片
@property (strong, nonatomic) UIImageView *launchImageView;
// 显示广告图片
@property (strong, nonatomic) UIImageView *adImageView;
// 跳过按钮
@property (strong, nonatomic) UIButton *skipBtn;
// 倒计时
@property (strong, nonatomic) NSTimer *timer;

@property (copy, nonatomic) ZJLaunchAdFinishHandler finishHandler;
@property (copy, nonatomic) ZJLaunchAdSetSkipBtnHandler setSkipBtnHandler;

@end

@implementation ZJLaunchAdController


- (instancetype)initWithLaunchImage:(UIImage *)launchImage setAdImageHandler:(ZJLaunchAdSetAdImageHandler)setAdImageHandler finishHandler:(ZJLaunchAdFinishHandler)finishHandler {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _finishHandler = [finishHandler copy];
        _launchImage = launchImage;
        if (launchImage) {
            // 需要显示启动图片的时候, 设置广告的高度为屏幕的2/3
            _adImageViewFrame = CGRectMake(0.f, 0.f, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height*2/3);
        }
        else {
            _adImageViewFrame = [[UIScreen mainScreen] bounds];
            
        }
        // 调用设置广告图片的block  -- 不管外界怎样加载图片 (可能使用SDWebimage来加载)都无所谓
        setAdImageHandler(self.adImageView);
        // 注意触发setter方法
        self.countDownTime = 5;

    }
    return self;
}

// 便利构造器
- (instancetype)initWithSetAdImageHandler:(ZJLaunchAdSetAdImageHandler)setAdImageHandler finishHandler:(ZJLaunchAdFinishHandler)finishHandler {
    return [self initWithLaunchImage:nil setAdImageHandler:setAdImageHandler finishHandler:finishHandler];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加手势到self.view上面, 响应广告的点击
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapedAdHandler)];
    tapGes.numberOfTapsRequired = 1;
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:tapGes];
    
    if (_launchImage) {
        self.launchImageView.image = _launchImage;
        // 先添加启动图片到最下面
        [self.view addSubview:self.launchImageView];
    }
    // 再添加广告图
    [self.view addSubview:self.adImageView];
    // 最后添加跳过按钮
    [self.view addSubview:self.skipBtn];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    if (_launchImage) {
        self.launchImageView.frame = self.view.bounds;
    }
    self.adImageView.frame = _adImageViewFrame;
    
    {
        // 根据文字自适应
        [self.skipBtn sizeToFit];
        CGRect skipBtnFrame = self.skipBtn.bounds;
        CGFloat margin = 20.f;
        skipBtnFrame.origin.x = self.view.bounds.size.width - margin - skipBtnFrame.size.width;
        skipBtnFrame.origin.y = margin;
        // 左右间隙设为 5
        skipBtnFrame.size.width += 10;
        self.skipBtn.frame = skipBtnFrame;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self startTimer];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self stopTimer];
}
- (void)dealloc {
    [self stopTimer];
}

// 开启timer
- (void)startTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerHandler:) userInfo:nil repeats:YES];
    // 添加到运行循环中
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    [self.timer fire];
}
// 停止timer
- (void)stopTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)skipBtnOnClick:(UIButton *)skipBtn {
    if (_finishHandler) {
        _finishHandler(ZJLaunchAdCallbackTypeClickSkipBtn);
    }
}
- (void)tapedAdHandler {
    if (_finishHandler) {
        _finishHandler(ZJLaunchAdCallbackTypeClickAd);
    }
}

- (void)timerHandler:(NSTimer *)timer {
    if (!_isBegin) {
        _isBegin = YES;
        return;
    }
    self.countDownTime--;
    if (_countDownTime == 0 && _finishHandler) {
        //销毁计时器
        [self stopTimer];
        _finishHandler(ZJLaunchAdCallbackTypeShowFinish);
    }


}

- (void)setSkipBtnHandler:(ZJLaunchAdSetSkipBtnHandler)setSkipBtnHandler {
    _setSkipBtnHandler = [setSkipBtnHandler copy];
}

- (void)setCountDownTime:(NSInteger)countDownTime {
    _countDownTime = countDownTime;
    if (self.setSkipBtnHandler) {
        self.setSkipBtnHandler(self.skipBtn, countDownTime);
    }
    else {
        
        [self.skipBtn setTitle:[NSString stringWithFormat:@"%lds 跳过", countDownTime] forState:UIControlStateNormal];
    }
    if (!_isBegin) {// 更新一次
        [self.view setNeedsLayout];
    }
}

- (void)setAdImageViewFrame:(CGRect)adImageViewFrame {
    _adImageViewFrame = adImageViewFrame;
    [self.view setNeedsLayout];
}

- (UIImageView *)adImageView {
    if (!_adImageView) {
        UIImageView *imageView = [UIImageView new];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.clipsToBounds = YES;
        _adImageView = imageView;
    }
    return _adImageView;
}

- (UIImageView *)launchImageView {
    if (!_launchImageView) {
        UIImageView *imageView = [UIImageView new];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.clipsToBounds = YES;
        _launchImageView = imageView;
    }
    return _launchImageView;
}

- (UIButton *)skipBtn {
    if (!_skipBtn) {
        UIButton *skipBtn = [UIButton new];
        skipBtn.layer.masksToBounds = YES;
        skipBtn.layer.cornerRadius = 10.f;
        skipBtn.backgroundColor = [UIColor blackColor];
        [skipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        skipBtn.titleLabel.font = [UIFont systemFontOfSize:16.f];
        [skipBtn addTarget:self action:@selector(skipBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        _skipBtn = skipBtn;
    }
    return _skipBtn;
}

@end

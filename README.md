# ZJLaunchAd
一个使用方便的侧滑测单, 抽屉菜单, 支持四种打开和关闭的动画, 支持缩放, 可以设置打开的手势的位置, 可以设置在那些页面可以打开抽屉菜单

* [ZJLaunchAd 展示启动广告](https://github.com/jasnig/ZJLaunchAd), 一个简单, 方便的启动广告展示, 可以同时展示logo. 使用可能是下面这样的.



![launch.gif](http://upload-images.jianshu.io/upload_images/1271831-8d108a5ff2f378db.gif?imageMogr2/auto-orient/strip)


```
ZJLaunchAdController *launchVc = [[ZJLaunchAdController alloc] initWithLaunchImage:nil setAdImageHandler:^(UIImageView *imageView) {
        // 这里可以直接使用SDWebimage等来请求服务器提供的广告图片(SDWebimage会处理好gif图片的显示)
        // 不过你需要注意选择SDWebimage的缓存策略
        imageView.image = [UIImage imageNamed:@"adImage"];
        
    } finishHandler:^(ZJLaunchAdCallbackType callbackType) {
        switch (callbackType) {
            case ZJLaunchAdCallbackTypeClickAd:
                // 点击了广告, 展示相应的广告即可
                NSLog(@"点击了广告, 展示相应的广告即可");
                
                break;
            case ZJLaunchAdCallbackTypeShowFinish:
                NSLog(@"展示广告图片结束, 可以进入App");

                break;
            case ZJLaunchAdCallbackTypeClickSkipBtn:
                NSLog(@"点击了跳过广告, 可以进入App");

                break;
        }
    }];
```
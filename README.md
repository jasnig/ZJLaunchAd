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


> 这是我写的<iOS_CUSTOMIZE_ANALYSIS>这本书籍中的一个demo, 如果你希望知道具体的实现过程和其他的一些常用效果的实现, 那么你应该能轻易在网上下载到免费的盗版书籍. 

> 当然作为本书的写作者, 还是希望有人能支持正版书籍. 如果你有意购买书籍, 在[这篇文章中](http://www.jianshu.com/p/510500f3aebd), 介绍了书籍中所有的内容和书籍适合阅读的人群, 和一些试读章节, 以及购买链接. 在你准备购买之前, 请一定读一读里面的说明. 否则, 如果不适合你阅读, 虽然书籍售价35不是很贵, 但是也是一笔损失.


> 如果你希望联系到我, 你可以联系QQ:597769272
> 或者通过[简书](http://www.jianshu.com/users/fb31a3d1ec30/latest_articles)联系到我
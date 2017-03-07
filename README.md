# YDQ
仿[悦动圈](https://itunes.apple.com/cn/app/%E6%82%A6%E5%8A%A8%E5%9C%88-%E8%B7%91%E6%AD%A5%E8%AE%A1%E6%AD%A5%E5%87%8F%E8%82%A5100-%E9%A2%86%E7%BA%A2%E5%8C%85%E7%9A%84%E8%BF%90%E5%8A%A8%E5%81%A5%E5%BA%B7%E7%A4%BE%E5%8C%BA/id872341407?mt=8)运动APP

# 索引
- [第一天](#第一天)
	- [获取图片资源](#获取图片资源)
	- [新建工程，基础配置](#新建工程，基础配置)
	- [接口 API 获取](#接口API获取)
	- [搭建框架](#搭建框架)
- [第二天](#第二天)



# 第一天
## 获取图片资源

用[PP助手](http://pro.25pp.com/)下载[悦动圈](https://itunes.apple.com/cn/app/%E6%82%A6%E5%8A%A8%E5%9C%88-%E8%B7%91%E6%AD%A5%E8%AE%A1%E6%AD%A5%E5%87%8F%E8%82%A5100-%E9%A2%86%E7%BA%A2%E5%8C%85%E7%9A%84%E8%BF%90%E5%8A%A8%E5%81%A5%E5%BA%B7%E7%A4%BE%E5%8C%BA/id872341407?mt=8)官方 App 的 ipa 包，使用归档工具解压 ipa 包，找到 Payload 文件夹，看到 SprotBar 显示包内容，里面就有整个 App 的资源文件，能在里面找到 AppIcon，Lanch 启动图，引导图等。

![](http://o6heygfyq.bkt.clouddn.com/Snip20170307_3.png?imageView2/0/h/400/w/350)

但是还有很多图片是找不到的，因为在一个 Assets.car 的文件里面，需要用到一个工具把里面的图片资源导出来，这个工具叫[cartool](https://github.com/steventroughtonsmith/cartool)，可以用 XCode 打开，在 main.m 文件里删除 idiomSuffixForCoreThemeIdiom 方法，新建一个文件夹用来接收导出来的图片，如下配置：

![](http://o6heygfyq.bkt.clouddn.com/Snip20170307_4.png?imageView2/0/h/400/w/550)

再运行一下工程，图片资源就导出到添加的文件夹里面了。

## 新建工程，基础配置

新建一个工程项目，配置应用名称、BundleId、部署版本、横竖屏等这些信息，再将图片资源导入，配置下 AppIcon，启动图

## 接口API获取

使用 [Charles](https://www.charlesproxy.com/) 工具，配置一下，https 请求需要在手机端安装 SSL 证书，获取到每个页面的 API，做好对应的整理，主要有请求方式，请求参数，请求地址的获取。

> 关于 [Charles](https://www.charlesproxy.com/) 如何使用的相关介绍可以参照唐老师写的这篇[博客](http://blog.devtang.com/2015/11/14/charles-introduction/)

## 搭建框架

![](http://o6heygfyq.bkt.clouddn.com/yuedongquankuangjia.gif?imageView2/0/h/600/w/450)

底部是一个 UITabBarController 主控制器，有 SportsViewController、ChallengeViewController、ProfileViewController 5个子控制器，采用 storyboard 的方式搭建，并按照 MVVM 的架构模式新建好文件夹目录：

![](http://o6heygfyq.bkt.clouddn.com/Snip20170307_5.png?imageView2/0/h/600/w/350)

修改 TabBar 的全局颜色：

```Objective-C
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 修改TabBar的全局颜色
    [UITabBar appearance].tintColor = CLJTabBarTintColor;
    
    return YES;
}
```

将各个子控制器添加到 TabBarController 上去：

```Objective-C
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatViewControllerWithStoryboard:@"Sports"];
    [self creatViewControllerWithStoryboard:@"Challenge"];
    [self creatViewControllerWithStoryboard:@"Explore"];
    [self creatViewControllerWithStoryboard:@"Social"];
    [self creatViewControllerWithStoryboard:@"Profile"];
}

// 通过Storyboard添加子控制器
- (void)creatViewControllerWithStoryboard:(NSString *)storyboard
{
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:storyboard bundle:nil];
    UIViewController *vc = [sb instantiateInitialViewController];
    [self addChildViewController:vc];
}
```

# 第二天
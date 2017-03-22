## YDQ
仿[悦动圈](https://itunes.apple.com/cn/app/%E6%82%A6%E5%8A%A8%E5%9C%88-%E8%B7%91%E6%AD%A5%E8%AE%A1%E6%AD%A5%E5%87%8F%E8%82%A5100-%E9%A2%86%E7%BA%A2%E5%8C%85%E7%9A%84%E8%BF%90%E5%8A%A8%E5%81%A5%E5%BA%B7%E7%A4%BE%E5%8C%BA/id872341407?mt=8)运动APP

## 索引
- [第一天](#第一天)
	- [获取图片资源](#获取图片资源)
	- [新建工程，基础配置](#新建工程，基础配置)
	- [接口 API 获取](#接口API获取)
	- [搭建tabBar框架](#搭建tabBar框架)
- [第二天](#第二天)
	- [用 cocoapods 集成第三方库](#用 cocoapods 集成第三方库)
	- [网络请求/数据处理/数据缓存层封装](#网络请求/数据处理/数据缓存层封装)
	- [界面分析-首页](#界面分析-首页)
		- [第一步](#第一步)
		- [第二步](#第二步)



## 第一天
### 获取图片资源

用[PP助手](http://pro.25pp.com/)下载[悦动圈](https://itunes.apple.com/cn/app/%E6%82%A6%E5%8A%A8%E5%9C%88-%E8%B7%91%E6%AD%A5%E8%AE%A1%E6%AD%A5%E5%87%8F%E8%82%A5100-%E9%A2%86%E7%BA%A2%E5%8C%85%E7%9A%84%E8%BF%90%E5%8A%A8%E5%81%A5%E5%BA%B7%E7%A4%BE%E5%8C%BA/id872341407?mt=8)官方 App 的 ipa 包，使用归档工具解压 ipa 包，找到 Payload 文件夹，看到 SprotBar 显示包内容，里面就有整个 App 的资源文件，能在里面找到 AppIcon，Lanch 启动图，引导图等。

![](http://o6heygfyq.bkt.clouddn.com/Snip20170307_3.png?imageView2/0/h/400/w/350)

但是还有很多图片是找不到的，因为在一个 Assets.car 的文件里面，需要用到一个工具把里面的图片资源导出来，这个工具叫[cartool](https://github.com/steventroughtonsmith/cartool)，可以用 XCode 打开，在 main.m 文件里删除 idiomSuffixForCoreThemeIdiom 方法，新建一个文件夹用来接收导出来的图片，如下配置：

![](http://o6heygfyq.bkt.clouddn.com/Snip20170307_4.png?imageView2/0/h/400/w/550)

再运行一下工程，图片资源就导出到添加的文件夹里面了。

### 新建工程，基础配置

新建一个工程项目，配置应用名称、BundleId、部署版本、横竖屏等这些信息，再将图片资源导入，配置下 AppIcon，启动图

### 接口API获取

使用 [Charles](https://www.charlesproxy.com/) 工具，配置一下，https 请求需要在手机端安装 SSL 证书，获取到每个页面的 API，做好对应的整理，主要有请求方式，请求参数，请求地址的获取。

> 关于 [Charles](https://www.charlesproxy.com/) 如何使用的相关介绍可以参照唐老师写的这篇[博客](http://blog.devtang.com/2015/11/14/charles-introduction/)

### 搭建tabBar框架

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

## 第二天
### 用 cocoapods 集成第三方库
进入项目文件夹目录下，使用 cocoapods 添加一些常用的第三方库，首先安装 cocoapods，可能要升级一下版本，cocoapods 常用命令：

```
pod init # 初始化 pod，会在项目文件夹下生成一个 podfile 文件
pod search 第三方库名称 # 搜索第三方库

pod install # 安装第三方库
pod update # 更新第三方库

```

>注意: 执行 pod install / update 命令的时候会升级 CocoaPods 的 spec 仓库，加一个参数可以省略这一步，然后速度就会提升不少。加参数的命令如下：

>```
# 安装
pod install --verbose --no-repo-update
# 更新
pod update --verbose --no-repo-update

>```

![](http://o6heygfyq.bkt.clouddn.com/Snip20170322_7.png?imageView2/0/w/400)

### 网络请求/数据处理/数据缓存层封装

### 界面分析-首页

分析一下首页界面的布局层次，首先底部是一个竖直方向滚动的 collectionView，有两个 item。

第一个 item 中间有一个 pageTitleView 以及 pageContentView，并且两者是关联绑定的，其中 pageContentView 也是一个 collectionView，但是是水平滚动的，pageTitleView 随着 pageContentView 滚动，上面的文字颜色会有一个跟随渐变过渡的效果，文字下面的小滑条也有一个水平位移的动画效果。

竖直 collectionView 的第二个 item 是一个 tableView，上面是一个悬浮的 hearderView，地下是几个不同类型的 cell：

第一个 item：

![](http://o6heygfyq.bkt.clouddn.com/Snip20170322_4.png?imageView2/0/w/600)

第二个 item:

![](http://o6heygfyq.bkt.clouddn.com/Snip20170322_5.png?imageView2/0/w/600)

#### 第一步

按照 UI 视图的层次结构，遵循从父视图到子视图，从上到下的顺序进行页面布局，先搭建最下面的那个 collectionView，然后搭建 collectionView 第一个 item 里面的 UI，一个是 pageTitleView，一个是 pageContentView，并且这两个 view，在很多界面都能用得到，属于公共的 UI 组建，应该封装起来，第一步实现下过如下：

![](http://o6heygfyq.bkt.clouddn.com/Snip20170322_6.gif?imageView2/0/w/370)

>**注意点：**
>>1. pageContentView 的滑动距离、滑动进度以及颜色渐变的计算；
>>2. pageTitleView 和 pageContentView 之间互相的响应传值；
>>3. 在 viewDidLoad 的方法里告诉控制器，不要调整UIScrollView的内边距，将`automaticallyAdjustsScrollViewInsets` 属性要设置为 `NO`，不然系统会自动将 scrollView 的 y 坐标加 64。

#### 第二步

1. 搭建第一个 item
	- 顶部几个 view，天气、钥匙、红包、等级；
		
	- 中间的圆环视图，cycleView，下面的几个按钮，寻宝、分享得红包之类；
	- 最下面的两个跳转 url 的广告按钮，一个指示上拖的箭头按钮；


2. 搭建第二个 item




















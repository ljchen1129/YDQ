//
//  SportsMainCollectionView.m
//  YueDongQuan
//
//  Created by 陈良静 on 2017/3/8.
//  Copyright © 2017年 陈良静. All rights reserved.
//

#import "YDQSportsContainerView.h"
#import "YDQSportsTopViewController.h"

static NSString *const kCollectionViewCellIdentifier = @"collectionViewCellIdentifier";
static NSInteger const kConllectionItems = 2;

@interface YDQSportsContainerView () <UICollectionViewDataSource, UICollectionViewDelegate>

/// 子控制器数组
@property(nonatomic, strong)NSArray *childVcs;

/// 父控制器
@property(nonatomic, strong) UIViewController *parnentVc;

/// collectionView
@property(nonatomic, strong) UICollectionView *collectionView;

/// collectionView 开始滑动时的竖直偏移量
@property(nonatomic, assign) CGFloat startOffsetY;

@end

@implementation YDQSportsContainerView

- (instancetype)initWithFrame:(CGRect)frame controllers:(NSArray <UIViewController *>*)childVcs parnentVc:(UIViewController *)parnentVc
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _childVcs = childVcs;
        _parnentVc = parnentVc;
        
        [self setupUI];
    }
    
    return self;
}

#pragma mark - UI

- (void)setupUI
{
    // 1. 把子控制器添加到父控制器上
    for (UIViewController *vc in self.childVcs)
    {
        [self.parnentVc addChildViewController:vc];
    }
    
    // 2.添加collectionView
    [self addSubview:self.collectionView];
    self.collectionView.frame = self.bounds;
    
    // 注册cell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCollectionViewCellIdentifier];
}

#pragma mark - publicMothed

- (void)setCurrentIndex:(int)index
{
    CGFloat offY = index * self.collectionView.clj_height;
    [self.collectionView setContentOffset:CGPointMake(0, offY) animated:YES];
}

#pragma mark - UICollectionViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.startOffsetY = scrollView.contentOffset.y;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 1.先判断是上滑还是下滑
    CGFloat currentOffsetY = scrollView.contentOffset.y;
    CGFloat scrollViewH = scrollView.bounds.size.height;
    YDQSportsTopViewController *topVc = (YDQSportsTopViewController *)self.childVcs[0];
    SportsType type = [topVc getCurrentSportType];
    if (currentOffsetY > self.startOffsetY && currentOffsetY > scrollViewH / 2)
    {
        // 上滑
        if (_slidUpCallBack)
        {
            _slidUpCallBack(type);
        }
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return kConllectionItems;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCellIdentifier forIndexPath:indexPath];
    
    // 设置之前先把contentView上的子视图清除掉
    for (UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }

    // 设置cell的内容
    UIViewController *childVc = self.childVcs[indexPath.item];
    childVc.view.frame = cell.contentView.bounds;
    [cell.contentView addSubview:childVc.view];
    
    return cell;
}

#pragma mark - setter

- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = self.bounds.size;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.pagingEnabled = YES;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    
    return _collectionView;
}

@end

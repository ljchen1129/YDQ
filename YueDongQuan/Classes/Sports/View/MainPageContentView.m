//
//  SportsTopContentView.m
//  YueDongQuan
//
//  Created by 陈良静 on 2017/3/8.
//  Copyright © 2017年 陈良静. All rights reserved.
//

#import "MainPageContentView.h"

static NSString *const kCollectionViewCellIdentifier = @"collectionViewCellIdentifier";

@interface MainPageContentView () <UICollectionViewDataSource, UICollectionViewDelegate>

/// 子控制器数组
@property(nonatomic, strong)NSArray *childVcs;

/// 父控制器
@property(nonatomic, strong) UIViewController *parnentVc;

/// collectionView
@property(nonatomic, strong) UICollectionView *collectionView;

/// collectionView 开始滑动时的水平偏移量
@property(nonatomic, assign) CGFloat startOffsetX;

/// 标识，是否是强制要滚动
@property(nonatomic, assign) BOOL isForbidScroll;

@end

@implementation MainPageContentView

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

#pragma mark - publicMethod

- (void)setCurrentIndex:(int)index
{
    self.isForbidScroll = YES;
    
    CGFloat offX = index * self.collectionView.clj_width;
    [self.collectionView setContentOffset:CGPointMake(offX, 0) animated:NO];
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
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    
    return _collectionView;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger countItems = [self.childVcs count];
    
    return countItems;
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

#pragma mark - UICollectionViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.isForbidScroll = NO;
    self.startOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 需要获取的信息
    /*
     1. 滑动的进度比例 progress
     2. 开始的索引位置
     3. 目标的索引位置
     */
    
    // 判断是不是来自点击事件
    if (self.isForbidScroll)
    {
        return;
    }
    
    CGFloat progess = 0;
    int sourceIndex = 0;
    int targetIndex = 0;
    
    // 1.先判断是左滑还是右滑
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    CGFloat scrollViewW = scrollView.bounds.size.width;
    if (currentOffsetX > self.startOffsetX)
    {
        // 左滑
        sourceIndex = (int)(currentOffsetX / scrollViewW);
        targetIndex = sourceIndex + 1;
        if (targetIndex >= self.childVcs.count)
        {
            targetIndex = (int)(self.childVcs.count - 1);
        }
        
        progess = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW);
        // 当滑动结束时，结束偏移量减去起始偏移量正好等于一个scrollViewW时
        if (currentOffsetX - self.startOffsetX == scrollViewW)
        {
            progess = 1;
            // 滑动结束，目标索引等于起始索引
            targetIndex = sourceIndex;
        }
    }
    else
    {
        // 右滑
        targetIndex = (int)(currentOffsetX / scrollViewW);
        sourceIndex = targetIndex + 1;
        if (sourceIndex >= self.childVcs.count)
        {
            sourceIndex = (int)(self.childVcs.count - 1);
        }
        
        progess = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW));
    }
    
    if ([self.delegate respondsToSelector:@selector(pageContentView:ScrollSourceIndex:targetIndex:progress:)]) {
        [self.delegate pageContentView:self ScrollSourceIndex:sourceIndex targetIndex:targetIndex progress:progess];
    }
}

@end


//
//  SportsBottomViewController.m
//  YueDongQuan
//
//  Created by 陈良静 on 2017/3/8.
//  Copyright © 2017年 陈良静. All rights reserved.
//

#import "YDQSportsBottomViewController.h"
#import "YDQSportsBottomTableHeader.h"

@interface YDQSportsBottomViewController () <UITableViewDataSource, UITableViewDelegate>

/// 表格视图
@property(nonatomic, strong) UITableView *tableView;

/// header
@property(nonatomic, strong) YDQSportsBottomTableHeader *header;

@end

@implementation YDQSportsBottomViewController

#pragma mark - liftCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置UI
    [self setUI];
}

#pragma mark - UI

- (void)setUI
{
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
    
    // 注册头视图
    [self.tableView registerClass:[YDQSportsBottomTableHeader class] forHeaderFooterViewReuseIdentifier:YDQSportsBottomTableHeaderIndetifierId];
}

#pragma mark - publicMothed

- (void)resetUIWith:(SportsType)type
{
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"行号：%ld", indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return YDQSportsBottomTableHeaderHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    YDQSportsBottomTableHeader *header = [YDQSportsBottomTableHeader headerWithTableView:tableView];
    header.sildDown = ^{
        if (_slidDown)
        {
            _slidDown();
        }
    };
    
    header.doSportsCallBack = ^(SportsType type) {
        YDQLog(@"type:%ld", type);
    };
    
    self.header = header;
    
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - setter

- (void)setSportsType:(SportsType)sportsType
{
    _sportsType = sportsType;
    
    self.header.sportsType = _sportsType;
}

#pragma mark - getter

- (UITableView*)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    
    return _tableView;
}

@end

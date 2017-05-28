
//
//  SportsBottomViewController.m
//  YueDongQuan
//
//  Created by 陈良静 on 2017/3/8.
//  Copyright © 2017年 陈良静. All rights reserved.
//

#import "YDQSportsBottomViewController.h"

#import "YDQSportsBottomTableHeader.h"
#import "YDQSportsBottomTableFooter.h"
#import "YDQSportsBottomTableSectionHeader.h"
#import "YDQSportsBottomTableSectionFooter.h"
#import "YDQSportsBottomSportsDataCell.h"
#import "YDQSportsBottomBodyWeightCell.h"
#import "YDQSportsBottomNewAchievementCell.h"
#import "YDQSportsBottomSportsDrysCell.h"
#import "YDQSportsBottomNomalCell.h"
#import "YDQSportsModel.h"
#import <AFNetworking.h>

static CGFloat const kTableViewContentInsetBottom = 60.0;

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
    
    // 请求网络数据
    [self loadData];
}

- (void)loadData
{
    NSMutableDictionary *parms = [NSMutableDictionary dictionary];
    parms[@"user_id"] = @149688199;
    parms[@"topic_id"] = @16993467;
    parms[@"oper_type"] = @"specify";
    parms[@"from"] = @"homepage";
    parms[@"f"] = @"ios";
    parms[@"v"] = @"3.8.8";
//    parms[@"language"] = @"zh-Hans";
//    parms[@"locale"] = @"CN";
//    parms[@"os"] = @"10.3.1";
//    parms[@"phone_type"] = @"iPhoneSE";
////    parms[@"sign"] = @"xcAtvuGEqLhXIsHbW7sB26VsAVY%3D";
//    parms[@"source"] = @"ios";
//    parms[@"user_id"] = @"149688120";
//    parms[@"ver"] = @"3.3.8";
//    parms[@"xyy"] = @"zpxnw1gvf4m9d6hr";
//    user_id=149688199&topic_id=16993467&oper_type=specify&sid=zpxnw1gvf4m9d6hr
    
//    begin_cnt=0&client_user_id=149688199&device_id=idfa_B2CFB040-8C32-47C4-9824-375793F4B0E5&end_cnt=1&kind_id=3&language=zh-Hans&locale=CN&os=10.3.1&phone_type=iPhoneSE&sign=xcAtvuGEqLhXIsHbW7sB26VsAVY%3D&source=ios&timezone=%2B8&user_id=149688199&ver=3.3.8&xyy=zpxnw1gvf4m9d6hr
    
//    [YDQSportsModel requestPOSTWithUrl:@"https://sslsharecircle.51yund.com/circle/topicSubject?topic_id=16993467&oper_type=specify&f=ios&user_id=149688199&v=3.3.8&from=homepage" paramtes:parms modelClass:[YDQSportsModel class] target:self complete:^(BaseModel *baseModel) {
//        
//    }];
    
    [YDQSportsModel requestGETWithUrl:@"https://sslsharecircle.51yund.com/circle/topicSubject?topic_id=16993467&oper_type=specify&f=ios&user_id=149688199&v=3.3.8&from=homepage" paramtes:nil modelClass:[YDQSportsModel class]
hudType:RequestHUDTypeDefault target:self enableView:YES complete:^(BaseModel *baseModel) {
    
}];
    

    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager GET:@"http://api.budejie.com/api/api_open.php?a=category&c=subscribe" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
//    } failure:^(NSURLSessionTask *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];

}

#pragma mark - UI

- (void)setUI
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_offset(0.0);
        make.top.mas_offset(YDQSportsBottomTableHeaderHeight);
    }];
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YDQSportsBottomSportsDataCell class]) bundle:nil] forCellReuseIdentifier:YDQSportsBottomSportsDataCellIdentifierId];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YDQSportsBottomBodyWeightCell class]) bundle:nil] forCellReuseIdentifier:YDQSportsBottomBodyWeightCellIdentifierId];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YDQSportsBottomNewAchievementCell class]) bundle:nil] forCellReuseIdentifier:YDQSportsBottomNewAchievementCellIdentifierId];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YDQSportsBottomSportsDrysCell class]) bundle:nil] forCellReuseIdentifier:YDQSportsBottomSportsDrysCellIndentifierId];
    [self.tableView registerClass:[YDQSportsBottomNomalCell class] forCellReuseIdentifier:YDQSportsBottomNomalCellIdentifierId];
    
    // heaer
    [self.view addSubview:self.header];
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_offset(0.0);
        make.height.mas_offset(YDQSportsBottomTableHeaderHeight);
    }];
    
    // footer
    YDQSportsBottomTableFooter *footer = [[YDQSportsBottomTableFooter alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100.0)];
    self.tableView.tableFooterView = footer;
}

#pragma mark - publicMothed

- (void)resetUIWith:(SportsType)type
{
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section)
    {
        return 2;
    }
    if (1 == section)
    {
        // 新成就
        return 1;
    }
    else if (2 == section)
    {
        // 运动干货
        return 3;
    }
    else if (3 == section)
    {
        // 新闻资讯
        return 3;
    }
    else
    {
        // 健康周报
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    kSelfWeak;
    if (0 == indexPath.section)
    {
        if (indexPath.row == 0)
        {
            YDQSportsBottomSportsDataCell *cell = [YDQSportsBottomSportsDataCell cellWithTableView:tableView index:indexPath];
            cell.sportsDataBtnClick = ^{
                DLog(@"sportsDataBtnClick");
            };
            return cell;
        }
        else
        {
            YDQSportsBottomBodyWeightCell *cell = [YDQSportsBottomBodyWeightCell cellWithTableView:tableView index:indexPath];
            cell.goWeightManagerClick = ^{
                DLog(@"goWeightManagerClick");
            };
            return cell;
        }
    }
    else if (1 == indexPath.section)
    {
        // 新成就
        YDQSportsBottomNewAchievementCell *cell = [YDQSportsBottomNewAchievementCell cellWithTableView:tableView index:indexPath];
    
        return cell;
    }
    else if (2 == indexPath.section && 0 == indexPath.row)
    {
        // 运动干货
        YDQSportsBottomSportsDrysCell *cell = [YDQSportsBottomSportsDrysCell cellWithTableView:tableView];
        return cell;
    }
    else
    {
        YDQSportsBottomNomalCell *cell = [YDQSportsBottomNomalCell cellWithTableView:tableView index:indexPath];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section)
    {
        if (indexPath.row == 0)
        {
            return YDQSportsBottomSportsDataCellHeight;
        }
        else
        {
            return YDQSportsBottomBodyWeightCellHeight;
        }
    }
    else if (1 == indexPath.section)
    {
        return YDQSportsBottomNewAchievementCellHeight;
    }
    else if (2 == indexPath.section && 0 == indexPath.row)
    {
        return YDQSportsBottomSportsDrysCellHeight;
    }
    else
    {
        return YDQSportsBottomNomalCellHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (0 == section)
    {
        return CGFLOAT_MIN;
    }
    else
    {
        return YDQSportsBottomTableSectionHeaderHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (0 == section)
    {
        return CGFLOAT_MIN;
    }
    else
    {
        return YDQSportsBottomTableSectionFooterHeight;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (0 == section)
    {
        return nil;
    }
    else
    {
        YDQSportsBottomTableSectionHeader *header = [YDQSportsBottomTableSectionHeader headerWithTableView:tableView];
        NSString *title = [self tableViewSectionHeaderTitles][section - 1];
        header.title = title;
        return header;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (0 == section)
    {
        return nil;
    }
    else
    {
        YDQSportsBottomTableSectionFooter *footer = [YDQSportsBottomTableSectionFooter footerWithTableView:tableView];
        NSString *title = [self tableViewSectionFooterTitles][section - 1];
        footer.title = title;
        footer.footerClick = ^(NSString *footerTitle) {
            NSLog(@"%@",footerTitle);
        };
        
        return footer;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (0  == indexPath.section && 1 == indexPath.row)
    {
        NSLog(@"体重/体脂");
    }
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, kTableViewContentInsetBottom, 0);
        _tableView.backgroundColor = [UIColor clearColor];
    }
    
    return _tableView;
}

- (YDQSportsBottomTableHeader *)header
{
    if (!_header)
    {
        _header = [[YDQSportsBottomTableHeader alloc] initWithFrame:CGRectZero];
        kSelfWeak;
        _header.sildDown = ^{
            if (weakSelf.slidDown)
            {
                weakSelf.slidDown();
            }
        };
        
        _header.doSportsCallBack = ^(SportsType type) {
            DLog(@"type:%ld", type);
        };
    }
    
    return _header;
}

- (NSArray *)tableViewSectionHeaderTitles
{
    return @[@"新成就", @"运动干货", @"新闻资讯", @"健康周报"];
}

- (NSArray *)tableViewSectionFooterTitles
{
    return @[@"查看我的成就", @"更多文章", @"更多文章", @"查看详情"];
}

@end

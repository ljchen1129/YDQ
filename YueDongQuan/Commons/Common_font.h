//
//  Common_font.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 14-10-27.
//  Copyright (c) 2014年 zhangshaoyu. All rights reserved.
//  功能描述：常用字体

#ifndef zhangshaoyu_Common_font_h
#define zhangshaoyu_Common_font_h

/*********************** Font ***************************/

#pragma mark - 字体

#pragma mark 大小-细体
 
/// 9号字体
#define kFontSize9 [UIFont systemFontOfSize:9.0]

/// 10号字体
#define kFontSize10 [UIFont systemFontOfSize:10.0]

/// 11号字体
#define kFontSize11 [UIFont systemFontOfSize:11.0]

/// 12号字体
#define kFontSize12 [UIFont systemFontOfSize:12.0]

/// 13号字体
#define kFontSize13 [UIFont systemFontOfSize:13.0]

/// 14号字体
#define kFontSize14 [UIFont systemFontOfSize:14.0]

/// 15号字体
#define kFontSize15 [UIFont systemFontOfSize:15.0]

/// 16号字体
#define kFontSize16 [UIFont systemFontOfSize:16.0]

/// 17号字体
#define kFontSize17 [UIFont systemFontOfSize:17.0]

/// 18号字体
#define kFontSize18 [UIFont systemFontOfSize:18.0]

/// 19号字体
#define kFontSize19 [UIFont systemFontOfSize:19.0]

/// 20号字体
#define kFontSize20 [UIFont systemFontOfSize:20.0]

/// 21号字体
#define kFontSize21 [UIFont systemFontOfSize:21.0]

/// 22号字体
#define kFontSize22 [UIFont systemFontOfSize:22.0]

/// 24号字体
#define kFontSize24 [UIFont systemFontOfSize:24.0]

/// 25号字体
#define kFontSize25 [UIFont systemFontOfSize:25.0]

/// 30号字体
#define kFontSize30 [UIFont systemFontOfSize:30.0]

/// 40号字体
#define kFontSize40 [UIFont systemFontOfSize:40.0]

/// 50号字体
#define kFontSize50 [UIFont systemFontOfSize:50.0]

/// 60号字体
#define kFontSize60 [UIFont systemFontOfSize:60.0]

#pragma mark 大小-粗体

/// 10号粗字体
#define kFontSizeBold10 [UIFont boldSystemFontOfSize:10.0]

/// 11号粗字体
#define kFontSizeBold11 [UIFont boldSystemFontOfSize:11.0]

/// 12号粗字体
#define kFontSizeBold12 [UIFont boldSystemFontOfSize:12.0]

/// 13号粗字体
#define kFontSizeBold13 [UIFont boldSystemFontOfSize:13.0]

/// 14号粗字体
#define kFontSizeBold14 [UIFont boldSystemFontOfSize:14.0]

/// 15号粗字体
#define kFontSizeBold15 [UIFont boldSystemFontOfSize:15.0]

/// 16号粗字体
#define kFontSizeBold16 [UIFont boldSystemFontOfSize:16.0]

/// 17号粗字体
#define kFontSizeBold17 [UIFont boldSystemFontOfSize:17.0]

/// 18号粗字体
#define kFontSizeBold18 [UIFont boldSystemFontOfSize:18.0]

/// 20号字粗体
#define kFontSizeBold20 [UIFont boldSystemFontOfSize:20.0]

/// 21号字粗体
#define kFontSizeBold21 [UIFont boldSystemFontOfSize:21.0]
 

/*
// 字体适配
#pragma mark 大小-细体

/// 9号字体
#define kFontSize9 [UIFont systemFontOfSize:AutoWHGetHeight(9.0)]

/// 10号字体
#define kFontSize10 [UIFont systemFontOfSize:AutoWHGetHeight(10.0)]

/// 11号字体
#define kFontSize11 [UIFont systemFontOfSize:AutoWHGetHeight(11.0)]

/// 12号字体
#define kFontSize12 [UIFont systemFontOfSize:AutoWHGetHeight(12.0)]

/// 13号字体
#define kFontSize13 [UIFont systemFontOfSize:AutoWHGetHeight(13.0)]

/// 14号字体
#define kFontSize14 [UIFont systemFontOfSize:AutoWHGetHeight(14.0)]

/// 15号字体
#define kFontSize15 [UIFont systemFontOfSize:AutoWHGetHeight(15.0)]

/// 16号字体
#define kFontSize16 [UIFont systemFontOfSize:AutoWHGetHeight(16.0)]

/// 17号字体
#define kFontSize17 [UIFont systemFontOfSize:AutoWHGetHeight(17.0)]

/// 18号字体
#define kFontSize18 [UIFont systemFontOfSize:AutoWHGetHeight(18.0)]

/// 19号字体
#define kFontSize19 [UIFont systemFontOfSize:AutoWHGetHeight(19.0)]

/// 20号字体
#define kFontSize20 [UIFont systemFontOfSize:AutoWHGetHeight(20.0)]

/// 21号字体
#define kFontSize21 [UIFont systemFontOfSize:AutoWHGetHeight(21.0)]

/// 22号字体
#define kFontSize22 [UIFont systemFontOfSize:AutoWHGetHeight(22.0)]

/// 23号字体
#define kFontSize23 [UIFont systemFontOfSize:AutoWHGetHeight(23.0)]

/// 24号字体
#define kFontSize24 [UIFont systemFontOfSize:AutoWHGetHeight(24.0)]

/// 25号字体
#define kFontSize25 [UIFont systemFontOfSize:AutoWHGetHeight(25.0)]

/// 30号字体
#define kFontSize30 [UIFont systemFontOfSize:AutoWHGetHeight(30.0)]

/// 40号字体
#define kFontSize40 [UIFont systemFontOfSize:AutoWHGetHeight(40.0)]

/// 50号字体
#define kFontSize50 [UIFont systemFontOfSize:AutoWHGetHeight(50.0)]

/// 60号字体
#define kFontSize60 [UIFont systemFontOfSize:AutoWHGetHeight(60.0)]

#pragma mark 大小-粗体

/// 10号粗字体
#define kFontSizeBold10 [UIFont boldSystemFontOfSize:AutoWHGetHeight(10.0)]

/// 11号粗字体
#define kFontSizeBold11 [UIFont boldSystemFontOfSize:AutoWHGetHeight(11.0)]

/// 12号粗字体
#define kFontSizeBold12 [UIFont boldSystemFontOfSize:AutoWHGetHeight(12.0)]

/// 13号粗字体
#define kFontSizeBold13 [UIFont boldSystemFontOfSize:AutoWHGetHeight(13.0)]

/// 14号粗字体
#define kFontSizeBold14 [UIFont boldSystemFontOfSize:AutoWHGetHeight(14.0)]

/// 15号粗字体
#define kFontSizeBold15 [UIFont boldSystemFontOfSize:AutoWHGetHeight(15.0)]

/// 16号粗字体
#define kFontSizeBold16 [UIFont boldSystemFontOfSize:AutoWHGetHeight(16.0)]

/// 17号粗字体
#define kFontSizeBold17 [UIFont boldSystemFontOfSize:AutoWHGetHeight(17.0)]

/// 18号粗字体
#define kFontSizeBold18 [UIFont boldSystemFontOfSize:AutoWHGetHeight(18.0)]

/// 20号字粗体
#define kFontSizeBold20 [UIFont boldSystemFontOfSize:AutoWHGetHeight(20.0)]

/// 21号字粗体
#define kFontSizeBold21 [UIFont boldSystemFontOfSize:AutoWHGetHeight(21.0)]

/// 35号字粗体
#define kFontSizeBold35 [UIFont boldSystemFontOfSize:AutoWHGetHeight(35.0)]
*/

/*********************** Font ***************************/

#endif

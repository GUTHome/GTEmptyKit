//
//  GTEmptyManager.h
//  GTEmptyKit
//
//  Created by cocomanber on 2019/5/5.
//  Copyright © 2019 cocomanber. All rights reserved.
//  该功能类仅仅是把常用的部分功能转出来而已，复杂而又个性化的设置，可直接在需求VC里使用底层库操作来满足你的需求
//  比如标题或者副标题需求是富文本的...点击重新加载后，改变图标或更改文字描述的...就直接操作源库比较方便点。
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface GTEmptyManager : NSObject
<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

#pragma mark - datasource

/// 占位图 default nil
@property (nonatomic, strong, nullable) UIImage *emptyImage;

/// 大标题 default @""
@property (nonatomic, copy, nullable) NSString *emptyTitle;
/// 配合[emptyTitle]使用 default systemFontOfSize:17.0f
@property (nonatomic, strong) UIFont *emptyTitleFont;
/// 配合[emptyTitle]使用 default darkGrayColor
@property (nonatomic, strong) UIColor *emptyTitleColor;

/// 副标题 default @""
@property (nonatomic, copy, nullable) NSString *emptySubtitle;
/// 配合[emptySubtitle]使用 default systemFontOfSize:15.0f
@property (nonatomic, strong) UIFont *emptySubtitleFont;
/// 配合[emptySubtitle]使用 default lightGrayColor
@property (nonatomic, strong) UIColor *emptySubtitleColor;

/// 按钮 default nil
@property (nonatomic, copy, nullable) NSString *emptyBtnTitle;
/// 配合[emptyBtnTitle]使用 default systemFontOfSize:17.0f
@property (nonatomic, strong) UIFont *emptyBtntitleFont;
/// 配合[emptyBtnTitle]使用 default whiteColor
@property (nonatomic, strong) UIColor *emptyBtnTitleColor;
/// 配合[emptyBtnTitle]使用 default nil
@property (nonatomic, strong, nullable) UIImage *emptyBtnImage;
/// 配合[emptyBtnTitle]使用 default nil
@property (nonatomic, strong, nullable) UIImage *emptyBtnBackgroundImage;

/// 自定义通用的空白view
@property (nonatomic, strong) UIView *customView;

/// 空白页整体位置默认是在tableView居中显示: default 0，自定义的视图请设置为 -view.height/2.0
@property (nonatomic) CGFloat emptyVerticalOffset;

/// 空白页的图片、按钮、文案之间的间距大小: default 20
@property (nonatomic) CGFloat emptySpaceHeight;

#pragma mark - delegate

/// 添加空白页后ScrollView是否可以继续拖拽: default YES
@property (nonatomic) BOOL allowScroll;

/// default YES
@property (nonatomic) BOOL userInteractionEnabled;

/// 添加空白页后ScrollView是否可以展示: default NO
/// 注意，在这为YES时，可直接修改loadDoneDisplay属性
@property (nonatomic, copy, nullable) BOOL(^shouldDisplay)(void);

/// 空白页区域点击
@property (nonatomic, copy, nullable) void(^emptyViewTapBlock)(void);

/// 按钮点击
@property (nonatomic, copy, nullable) void(^emptyBtnClickBlock)(void);

/// 空白页的图片是否执行动画: default YES
@property (nonatomic, copy, nullable) BOOL(^shouldStartImageViewAnimate)(void);

/// 图片的动画
/// 注意: shouldStartAnimate==NO || imageAnimation==nil || emptyImage==nil 三者成立一个就不执行动画
@property (nonatomic, strong) CAAnimation *imageAnimation;

/// life cricle
@property (nonatomic, copy, nullable) void(^emptyViewWillAppear)(void);
@property (nonatomic, copy, nullable) void(^emptyViewWillDisappear)(void);
@property (nonatomic, copy, nullable) void(^emptyViewDidAppear)(void);
@property (nonatomic, copy, nullable) void(^emptyViewDidDisappear)(void);

@end


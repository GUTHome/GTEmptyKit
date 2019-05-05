//
//  GTEmptyKit.h
//  GTEmptyKit
//
//  Created by cocomanber on 2019/5/5.
//  Copyright © 2019 cocomanber. All rights reserved.
//

#import "GTEmptyManager.h"

@interface UIScrollView (GTEmptyKit)

/// 控制是否添加即可见，一般的处理时，添加scrollView时空白页不可见，所以默认为NO
@property (nonatomic, assign) BOOL loadDoneDisplay;

/// 配置类
@property (nonatomic, strong) GTEmptyManager *manager;

@end

@interface UITableView (GTEmptyKit)

- (void)emptyViewManagerBlock:(nullable void (^)(GTEmptyManager *manager))managerBlock;

- (void)emptyViewManager:(nullable GTEmptyManager *)manager;

@end

@interface UICollectionView (GTEmptyKit)

- (void)emptyViewManagerBlock:(nullable void (^)(GTEmptyManager *manager))managerBlock;

- (void)emptyViewManager:(nullable GTEmptyManager *)manager;

@end


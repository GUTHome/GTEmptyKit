//
//  GTEmptyKit.m
//  GTEmptyKit
//
//  Created by cocomanber on 2019/5/5.
//  Copyright © 2019 cocomanber. All rights reserved.
//

#import "GTEmptyKit.h"
#import <objc/runtime.h>

static char const * const kGTEmptyKit = "kGTEmptyKit";
static char const * const kGTEmptyKitLoadDoneDisplay = "kGTEmptyKitLoadDoneDisplay";

@implementation UIScrollView (EmptyConfiger)

- (GTEmptyManager *)manager
{
    GTEmptyManager *manager = objc_getAssociatedObject(self, kGTEmptyKit);
    if ([manager isKindOfClass:[GTEmptyManager class]] && manager) {
        return manager;
    }
    return nil;
}
- (void)setManager:(GTEmptyManager *)manager
{
    objc_setAssociatedObject(self, kGTEmptyKit, manager, OBJC_ASSOCIATION_RETAIN);
}

- (void)setLoadDoneDisplay:(BOOL)loadDoneDisplay
{
    objc_setAssociatedObject(self, kGTEmptyKitLoadDoneDisplay, @(loadDoneDisplay), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)loadDoneDisplay
{
    BOOL loadDoneDisplay_ = [objc_getAssociatedObject(self, kGTEmptyKitLoadDoneDisplay) boolValue];
    return loadDoneDisplay_;
}

@end


@implementation UITableView (EmptyAsistant)

- (void)emptyViewManagerBlock:(nullable void (^)(GTEmptyManager *manager))managerBlock
{
    GTEmptyManager *manager = [GTEmptyManager new];
    !managerBlock ?: managerBlock(manager);
    self.manager = manager;
    self.emptyDataSetSource = self.manager;
    self.emptyDataSetDelegate = self.manager;
}

- (void)emptyViewManager:(nullable GTEmptyManager *)manager
{
    self.manager = manager ?: [GTEmptyManager new];
    self.emptyDataSetSource = self.manager;
    self.emptyDataSetDelegate = self.manager;
}

@end

@implementation UICollectionView (EmptyAsistant)

- (void)emptyViewManagerBlock:(nullable void (^)(GTEmptyManager *manager))managerBlock
{
    GTEmptyManager *manager = [GTEmptyManager new];
    !managerBlock ?: managerBlock(manager);
    self.manager = manager;
    self.emptyDataSetSource = self.manager;
    self.emptyDataSetDelegate = self.manager;
}

- (void)emptyViewManager:(nullable GTEmptyManager *)manager
{
    self.manager = manager ?: [GTEmptyManager new];
    self.emptyDataSetSource = self.manager;
    self.emptyDataSetDelegate = self.manager;
}

@end

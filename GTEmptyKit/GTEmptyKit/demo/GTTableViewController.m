//
//  GTTableViewController.m
//  GTEmptyKit
//
//  Created by cocomanber on 2019/5/5.
//  Copyright © 2019 cocomanber. All rights reserved.
//

#import "GTTableViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "GTEmptyKit.h"
#import "GTCustomView.h"

@interface GTTableViewController ()
<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, assign)NSInteger numbers;

@end

@implementation GTTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.numbers = 0;
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
    
    __weak __typeof(&*self)weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf reload];
    }];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemTrash) target:self action:@selector(clean)];
    self.navigationItem.rightBarButtonItem = item;
    
    /// 占位图配置
    
    //配置方法1
    if (1) {
        [self.tableView emptyViewManagerBlock:^(GTEmptyManager *manager) {
            
            UIImage *image = [UIImage imageNamed:@"blank_button"];
            image = [image stretchableImageWithLeftCapWidth:image.size.width/2.0 topCapHeight:image.size.height/2.0];
            manager.emptyBtnBackgroundImage = image;
            
            CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
            anim.values = @[@0.8, @1, @1.2, @0.9, @1.1, @1];
            anim.duration = 0.6;
            manager.imageAnimation = anim;
            
            manager.emptyTitle = @"这是主标题";
            manager.emptyTitleFont = [UIFont boldSystemFontOfSize:22];
            manager.emptySubtitle = @"这是几句话的副标题描述详细的原因，这是几句话的副标题描述详细的原因，这是几句话的副标题描述详细的原因";
            manager.emptyImage = [UIImage imageNamed:@"image_empty"];
            manager.emptySpaceHeight = 20;
            manager.emptyBtnTitle = @"点击刷新";
            manager.emptyBtntitleFont = [UIFont boldSystemFontOfSize:19];
            manager.emptyVerticalOffset = -50;
            manager.emptyBtnClickBlock = ^{
                [[[UIAlertView alloc] initWithTitle:@"提示" message:@"添加你的需求再这个block" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
            };
            manager.shouldDisplay = ^{
                return weakSelf.tableView.loadDoneDisplay;
            };
            manager.emptyViewTapBlock = ^{
                [[[UIAlertView alloc] initWithTitle:@"提示" message:@"添加你的需求再这个block" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
            };
        }];
    }
    
    //配置方法2
    if (0) {
        
        GTEmptyManager *manager = [GTEmptyManager new];
        UIImage *image = [UIImage imageNamed:@"blank_button"];
        image = [image stretchableImageWithLeftCapWidth:image.size.width/2.0 topCapHeight:image.size.height/2.0];
        manager.emptyBtnBackgroundImage = image;
        
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        anim.values = @[@0.8, @1, @1.2, @0.9, @1.1, @1];
        anim.duration = 0.6;
        manager.imageAnimation = anim;
        
        manager.emptyTitle = @"这是主标题";
        manager.emptyTitleFont = [UIFont boldSystemFontOfSize:22];
        manager.emptySubtitle = @"这是几句话的副标题描述详细的原因，这是几句话的副标题描述详细的原因，这是几句话的副标题描述详细的原因";
        manager.emptyImage = [UIImage imageNamed:@"image_empty"];
        manager.emptySpaceHeight = 20;
        manager.emptyBtnTitle = @"点击刷新";
        manager.emptyBtntitleFont = [UIFont boldSystemFontOfSize:19];
        manager.emptyVerticalOffset = -50;
        manager.emptyBtnClickBlock = ^{
            [[[UIAlertView alloc] initWithTitle:@"提示" message:@"添加你的需求再这个block" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        };
        manager.shouldDisplay = ^{
            return weakSelf.tableView.loadDoneDisplay;
        };
        manager.emptyViewTapBlock = ^{
            [[[UIAlertView alloc] initWithTitle:@"提示" message:@"添加你的需求再这个block" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        };
        [self.tableView emptyViewManager:manager];
    }
    
    //配置方法3 - 自定义view
    if (0) {
        
        GTEmptyManager *manager = [GTEmptyManager new];
        
        //type2
        GTCustomView *view = [[NSBundle mainBundle] loadNibNamed:@"GTCustomView" owner:nil options:nil].firstObject;
        manager.customView = view;
        manager.emptyVerticalOffset = -view.frame.size.height / 2.0;
        
        //type1
//        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        [activityView startAnimating];
//        manager.customView = activityView;
        
        manager.shouldDisplay = ^BOOL{
            return weakSelf.tableView.loadDoneDisplay;
        };
        [self.tableView emptyViewManager:manager];
    }
}

- (void)clean{
    self.numbers = 0;
    self.tableView.loadDoneDisplay = YES;
    [self.tableView reloadData];
}

- (void)reload{
    __weak __typeof(&*self)weakSelf = self;
    self.numbers += 5;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        weakSelf.tableView.loadDoneDisplay = YES;
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    });
}

#pragma mark - tableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.numbers;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"UITableViewCell"];
        cell.textLabel.text = [NSString stringWithFormat:@"------->>>>>>>%ld", indexPath.row];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return _tableView;
}

@end

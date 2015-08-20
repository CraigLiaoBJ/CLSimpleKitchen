//
//  CLMainViewController.m
//  SimpleKitchen
//
//  Created by Craig Liao on 15/8/13.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//


#import "CLMainViewController.h"
#import "CLRecipeViewController.h"
#import "CLSelectionViewController.h"
#import "CLNewTableViewController.h"
#import "CLMineTableViewController.h"
#import "CLMenuViewController.h"
#import "CLSoupViewController.h"
//#define kWIDTH self.view.frame.size.width
//#define kHEIGHT self.view.frame.size.height
#define vW WIDTH-20
#define PAGECOUNT 6

@interface CLMainViewController ()<UIScrollViewDelegate>{
    UIScrollView *headView;
}
@property(nonatomic,strong) UIScrollView *scrollView;
@end

@implementation CLMainViewController

UIViewController *_currentVC;
CLRecipeViewController *_firstVC;
CLMenuViewController *_secondVC;
CLSelectionViewController *_thirdVC;
CLSoupViewController *_fourthVC;
CLNewTableViewController *_fiveVC;
CLMineTableViewController *_sixthVC;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadHeaderView];
    [self setupView];
}

// 滚动视图
- (void)setupView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)- 64)];
    
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * PAGECOUNT, CGRectGetHeight(self.view.bounds)- 64);
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.directionalLockEnabled = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    
    [self.view addSubview:_scrollView];
    
    
    _firstVC = [[CLRecipeViewController alloc] init];
    _secondVC = [[CLMenuViewController alloc] init];
    _thirdVC = [[CLSelectionViewController alloc] init];
    _fourthVC = [[CLSoupViewController alloc] init];
    _fiveVC = [[CLNewTableViewController alloc] init];
    _sixthVC = [[CLMineTableViewController alloc] init];

    
    NSArray *VCArray = @[_firstVC, _secondVC, _thirdVC, _fourthVC, _fiveVC, _sixthVC];
    
    for (int i = 0; i < VCArray.count; i ++) {
        UIViewController *VC = VCArray[i];
        VC.view.frame = CGRectMake(0 + kWIDTH * i, 0, kWIDTH, kHEIGHT - 64);
        
        [self addChildViewController:VC];
        [_scrollView addSubview:VC.view];
    }
}

// 加载顶上控制视图的滚动图
- (void)loadHeaderView
{
    headView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20 , kWIDTH, 44)];
    // 设置该view 为导航栏的
    self.navigationItem.titleView = headView;
    
    headView.contentSize = CGSizeMake(kWIDTH, 44);
    headView.tag = 400;
    headView.scrollEnabled = YES;
    headView.showsHorizontalScrollIndicator = NO;
    headView.showsVerticalScrollIndicator = NO;
    
    NSArray *headArray = @[@"荐", @"类", @"精", @"汤", @"新", @"我"];
    
    for (int i = 0; i < PAGECOUNT; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * ((kWIDTH) / 5), 2, kWIDTH / 5, 40);
        btn.tag = 800 + i;
        [btn setTitle:headArray[i] forState:(UIControlStateNormal)];
        
        if (i == 0) {
            btn.titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
            [btn setTitleColor:CLRedColor forState:(UIControlStateNormal)];
        } else {
            btn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
            [btn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        }
        
        [btn addTarget:self action:@selector(selectTableView:) forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:btn];
    }
    // 添加按钮上的小横线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 42, (kWIDTH - 4) / 5, 2)];
    lineView.backgroundColor = CLRedColor;
    lineView.tag = 300;
    [headView addSubview:lineView];
}

//选择标签
- (void)selectTableView:(UIButton *)btn
{
    UIView *view = [headView viewWithTag:300];
    _scrollView.contentOffset = CGPointMake(kWIDTH * (btn.tag - 800), 0) ;
    view.frame = CGRectMake( (kWIDTH - 0) / (PAGECOUNT - 1) * (_scrollView.contentOffset.x / kWIDTH), 42, (kWIDTH - 4) / (PAGECOUNT - 1), 2);
    
    for (int i = 0; i < PAGECOUNT; i ++) {
        UIButton *btn1 = (UIButton *)[headView viewWithTag:800+i];
        btn1.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    [btn setTitleColor:CLRedColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
}

#pragma mark -- UIScrollViewDelegate实现方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIView *view = [headView viewWithTag:300];
    view.frame = CGRectMake(kWIDTH / (PAGECOUNT - 1) * (_scrollView.contentOffset.x / kWIDTH), 42, kWIDTH / (PAGECOUNT - 1), 2);
    
        UIScrollView *labelView = (UIScrollView *)[headView viewWithTag:400];
        if (view.frame.origin.x <= kWIDTH / (PAGECOUNT - 1) * 2) {
            labelView.contentOffset = CGPointMake(view.frame.origin.x - 14, 0);
        } else {
            labelView.contentOffset = CGPointMake(((kWIDTH) - 0) / (PAGECOUNT - 1) * 2, 0);
        }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    UIButton *btn = (UIButton *)[headView viewWithTag:800 + (int)_scrollView.contentOffset.x / kWIDTH];
    [self selectTableView:btn];
}

@end

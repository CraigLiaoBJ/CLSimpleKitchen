//
//  CLHeaderView.m
//  SimpleKitchen
//
//  Created by Craig Liao on 15/8/11.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "CLHeaderView.h"

@implementation CLHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
       // headerView = [[UIView alloc] init];
        //[self addSubview:headerView];
//        [self setupButtons];
        [self setupSegmentedController];
    }
    return self;
}

//- (void)layoutSubviews{
//    headerView.frame = CGRectMake(0, 0, kWW, 44);
//    headerView.backgroundColor = [UIColor lightGrayColor];
//    headerView.userInteractionEnabled = YES;
//    [self setupButtons];
//}

- (void)setupSegmentedController{
    
    //导航栏上的分段控制器
    _segmentedControl=[[UISegmentedControl alloc] initWithItems:@[@"做法", @"材料", @"相关常识", @"相宜相克"]];
    _segmentedControl.frame = CGRectMake(0, 0, kWW, 35);
    
    [_segmentedControl addTarget:self action:@selector(Selectbutton:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_segmentedControl];
    _segmentedControl.selectedSegmentIndex = 0;
    
    _segmentedControl.tintColor = CLRedColor;//去掉颜色,现在整个segment都看不见
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],
                                             NSForegroundColorAttributeName:[UIColor whiteColor]};
    [_segmentedControl setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];//设置文字属性
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],
                                               NSForegroundColorAttributeName:CLRedColor};
    [_segmentedControl setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
}


- (void)Selectbutton:(UISegmentedControl *)btn{
    if (self.headerViewDelegate && [self.headerViewDelegate respondsToSelector:@selector(btnClicked:)]) {
        [self.headerViewDelegate btnClicked:btn];
    }
}

@end

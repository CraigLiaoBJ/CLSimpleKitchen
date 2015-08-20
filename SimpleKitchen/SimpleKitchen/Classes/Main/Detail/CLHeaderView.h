//
//  CLHeaderView.h
//  SimpleKitchen
//
//  Created by Craig Liao on 15/8/11.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HeaderViewDelegate <NSObject>

- (void)btnClicked:(UISegmentedControl *)btn;

@end

@interface CLHeaderView : UIView
@property (nonatomic, assign) id<HeaderViewDelegate>headerViewDelegate;

@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@end

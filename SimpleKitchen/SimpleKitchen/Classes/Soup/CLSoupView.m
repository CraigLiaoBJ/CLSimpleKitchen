//
//  CLSoupView.m
//  SimpleKitchen
//
//  Created by Craig Liao on 15/8/14.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "CLSoupView.h"

@implementation CLSoupView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        _sectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_sectionBtn];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _sectionBtn.frame = CGRectMake(0, 0, kWW, 20);
}

@end

//
//  CLMaterialView.m
//  SimpleKitchen
//
//  Created by Craig Liao on 15/8/17.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "CLMaterialCell.h"

@implementation CLMaterialCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.view = [[UIView alloc] init];
        [self addSubview:self.view];
    }
    return self;
}

- (void)layoutSubviews{
    self.view.frame = CGRectMake(0, 0, kWW, kHH);
    self.view.backgroundColor = [UIColor yellowColor];
}

@end

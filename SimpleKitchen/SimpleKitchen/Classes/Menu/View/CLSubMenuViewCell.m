//
//  CLSubMenuViewCell.m
//  SimpleKitchen
//
//  Created by Craig Liao on 15/8/13.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "CLSubMenuViewCell.h"

@implementation CLSubMenuViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _imageBig = [[UIImageView alloc] init];
        [self addSubview:_imageBig];
        
        _nameLabel = [[UILabel alloc] init];
        [self addSubview:_nameLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];

    self.imageBig.frame = CGRectMake(0, 0, kWW, kHH - 30);
    
    self.nameLabel.frame = CGRectMake(0, kHH - 25, kWW, 20);
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    self.nameLabel.numberOfLines = 0;
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    
}

@end

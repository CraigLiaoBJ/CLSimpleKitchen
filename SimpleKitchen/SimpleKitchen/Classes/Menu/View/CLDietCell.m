//
//  CLDietCell.m
//  SimpleKitchen
//
//  Created by Craig Liao on 15/8/15.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "CLDietCell.h"

@implementation CLDietCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _mainImage = [[UIImageView alloc] init];
        [self addSubview:_mainImage];
        
        _nameLabel = [[UILabel alloc] init];
        [self addSubview:_nameLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _mainImage.frame = CGRectMake(0, 0, kWW / 3, kWW / 3);
    _nameLabel.frame = CGRectMake(kWW /3, kWW /6 - 10, kWW - kWW /3, 20);
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.font = [UIFont systemFontOfSize:13];
    
}
@end

//
//  CLMenuCollectionViewCell.m
//  SimpleKitchen
//
//  Created by Craig Liao on 15/8/13.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "CLMenuCollectionViewCell.h"

@interface CLMenuCollectionViewCell ()
@end

@implementation CLMenuCollectionViewCell

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

    self.imageBig.frame = CGRectMake(0, 0, kWW, kWW);

    self.nameLabel.frame = CGRectMake(0, kWW - 30, kWW, 20);
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    
}



@end

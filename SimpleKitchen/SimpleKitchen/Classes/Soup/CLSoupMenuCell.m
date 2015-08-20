//
//  CLSoupMenuCell.m
//  SimpleKitchen
//
//  Created by Craig Liao on 15/8/14.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "CLSoupMenuCell.h"

@interface CLSoupMenuCell ()
@end

@implementation CLSoupMenuCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _label = [[UILabel alloc] init];
        [self addSubview:_label];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _label.frame = CGRectMake(0, 0, kWW, 20);
    _label.font = [UIFont boldSystemFontOfSize:14];
    _label.backgroundColor = [UIColor whiteColor];
    _label.layer.cornerRadius = 5.0f;
    _label.layer.masksToBounds = YES;
}


//- (void)setSoupMenuModel:(CLModelItem *)soupMenuModel{
//    _label.text = soupMenuModel.name;
//}

@end

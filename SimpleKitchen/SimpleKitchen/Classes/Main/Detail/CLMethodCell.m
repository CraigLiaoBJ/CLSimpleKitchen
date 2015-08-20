//
//  CLDetailTableViewCell.m
//  SimpleKitchen
//
//  Created by Craig Liao on 15/8/11.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "CLMethodCell.h"

@interface CLMethodCell ()

@property (nonatomic, strong) UIImageView *cellImageView;

@property (nonatomic, strong) UIImageView *methodImageView;

@property (nonatomic, strong) UILabel *methodLabel;

@property (nonatomic, strong) UILabel *orderLabel;

@end

@implementation CLMethodCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _cellImageView = [[UIImageView alloc] init];
        [self addSubview:_cellImageView];
        
        _methodImageView = [[UIImageView alloc] init];
        [self addSubview:_methodImageView];
        
        _methodLabel = [[UILabel alloc] init];
        [self addSubview:_methodLabel];
        
        _orderLabel = [[UILabel alloc] init];
        [self addSubview:_orderLabel];
    }
     return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];

    self.cellImageView.frame = CGRectMake(5, 5, kWW - 10, 240);
    self.cellImageView.backgroundColor = [UIColor colorWithRed:1.000 green:0.941 blue:0.926 alpha:1.000];
    
    self.methodImageView.frame = CGRectMake(30, 10, kWW - 60, 160);
    self.methodImageView.backgroundColor = [UIColor purpleColor];
    
    self.methodLabel.frame = CGRectMake(60, 170, kWW / 3 * 2, 80);
    self.methodLabel.font = [UIFont systemFontOfSize:13];
    self.methodLabel.numberOfLines = 0;
    
    self.orderLabel.frame = CGRectMake(5, 175, 40, 40);
    self.orderLabel.backgroundColor = [UIColor colorWithRed:0.887 green:0.652 blue:0.749 alpha:1.000];
    self.orderLabel.textAlignment = NSTextAlignmentCenter;
    self.orderLabel.textColor = [UIColor whiteColor];
    self.orderLabel.layer.cornerRadius = 20.f;
    self.orderLabel.layer.masksToBounds = YES;
    
}

- (void)setModelItem:(CLModelItem *)modelItem{
    
    NSURL *url = [NSURL URLWithString:modelItem.imagePath];
    [self.methodImageView sd_setImageWithURL:url];
    
    self.methodLabel.text = modelItem.describe;
    
    self.orderLabel.text = modelItem.order_id;
}

@end

//
//  CLNewCell.m
//  SimpleKitchen
//
//  Created by Craig Liao on 15/8/13.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "CLNewCell.h"
@interface CLNewCell (){
    UIImageView *_cellImageView;
    UIImageView *_titleImageView;
    UILabel *_titleLabel;
    UILabel *_contentLabel;
}

@end

@implementation CLNewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _cellImageView = [[UIImageView alloc] init];
        [self addSubview:_cellImageView];
        
        _titleImageView = [[UIImageView alloc] init];
        [_cellImageView addSubview:_titleImageView];
        
        _titleLabel = [[UILabel alloc] init];
        [self addSubview:_titleLabel];
        
        _contentLabel = [[UILabel alloc] init];
        [self addSubview:_contentLabel];
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    _cellImageView.frame = CGRectMake(0, 5, kWW, 90);
    _cellImageView.backgroundColor = [UIColor colorWithRed:1.000 green:0.945 blue:0.952 alpha:1.000];
    
    _titleImageView.frame = CGRectMake(5, 0, 120, 90);
    
    _titleLabel.frame = CGRectMake(130, 10, kWW - 135, 20);
    _titleLabel.font = [UIFont boldSystemFontOfSize:15];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.numberOfLines = 0;
    
    _contentLabel.frame = CGRectMake(130, 40, kWW - 135, 50);
    _contentLabel.font = [UIFont systemFontOfSize:12];
    _contentLabel.textColor = [UIColor blackColor];

    _contentLabel.numberOfLines = 0;
    
}

- (void)setClNewModel:(CLModelItem *)clNewModel{
    NSURL *url = [NSURL URLWithString:clNewModel.titleImageFile];
    [_titleImageView sd_setImageWithURL:url];
    
    _titleLabel.text = clNewModel.name;
    
    _contentLabel.text = clNewModel.content;
    
}
@end

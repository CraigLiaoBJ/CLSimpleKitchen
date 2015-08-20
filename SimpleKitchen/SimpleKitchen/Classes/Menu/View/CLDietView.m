//
//  CLDietView.m
//  SimpleKitchen
//
//  Created by Craig Liao on 15/8/15.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "CLDietView.h"
@interface CLDietView (){
    UIImageView *_fullImageView;
    UILabel *_contentLabel;
    UIButton *_moreBtn;
}

@end

@implementation CLDietView

#pragma mark -- 重写初始化方法
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _fullImageView = [[UIImageView alloc] init];
        [self addSubview:_fullImageView];
        
        _contentLabel = [[UILabel alloc] init];
        [self addSubview:_contentLabel];
        
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_moreBtn];
    }
    return self;
}

#pragma mark -- 布局
- (void)layoutSubviews{

    _contentLabel.frame = CGRectMake(10, 5, kWW -20, 90);
    _contentLabel.font = [UIFont systemFontOfSize:13];
    
    _moreBtn.frame = CGRectMake(kWW / 8 * 7.5, 100, 20, 20);
    [_moreBtn setImage:[UIImage imageNamed:@"iconfont-zhankai"] forState:UIControlStateNormal];
    [_moreBtn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.isShow) {
        _contentLabel.numberOfLines = 0;
        [_contentLabel sizeToFit];
    } else {
        _contentLabel.numberOfLines = 5;
    }
    _moreBtn.frame = CGRectMake(_moreBtn.frame.origin.x, _contentLabel.frame.size.height + _contentLabel.frame.origin.y, 20, 20);
}

#pragma mark -- 重写模型的setter方法
- (void)setHeadItem:(CLModelItem *)headItem{
    
    NSURL *url = [NSURL URLWithString:headItem.imageFilename];
    [_fullImageView sd_setImageWithURL:url];
    
    NSString *string = [NSString stringWithFormat:@"%@\n%@\n%@", headItem.diseaseDescribe, headItem.fitEat, headItem.lifeSuit];
    _contentLabel.text = string;
    
}

#pragma mark -- button的点击事件
- (void)didClickBtn:(UIButton *)btn{
    _HBlock();
}

#pragma mark -- 封装下获取高度的方法
- (CGFloat)getHeightWithString:(NSString *)string font:(CGFloat)font width:(CGFloat)width{
    //获取字符串的高度
    
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width, 100000) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.height;
}


@end
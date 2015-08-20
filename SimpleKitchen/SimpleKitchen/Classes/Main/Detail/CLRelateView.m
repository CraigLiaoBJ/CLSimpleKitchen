//
//  CLRelateView.m
//  SimpleKitchen
//
//  Created by Craig Liao on 15/8/17.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "CLRelateView.h"

@implementation CLRelateView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.rltModel = self.rltArray.lastObject;
        
        UIImageView *titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(((float)100 / (float)375) * kWW, 20, kWW - 2 * (((float)100 / (float)375) * kWW), ((float)130 / (float)667) * kHH)];
        [titleImageView sd_setImageWithURL:[NSURL URLWithString:self.rltModel.imagePath] placeholderImage:[UIImage imageNamed:@"zhanwei"]];
        [self addSubview:titleImageView];
        
        UIImageView *bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,(((float)130 / (float)667) * kHH) + 40, kWW, 300)];
        bottomImageView.image = [UIImage imageNamed:@"bottom"];
        [self addSubview:bottomImageView];
        
        UILabel *firstLable = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, bottomImageView.frame.size.width - 60, 120)];
        firstLable.font = [UIFont boldSystemFontOfSize:14];
        firstLable.text = self.rltModel.nutritionAnalysis;
        firstLable.numberOfLines = 0;
        [bottomImageView addSubview:firstLable];
        
        UILabel *lineLable = [[UILabel alloc] initWithFrame:CGRectMake(5, 130, kWW - 10, 1)];
        lineLable.adjustsFontSizeToFitWidth = YES;
        lineLable.backgroundColor = [UIColor purpleColor];
        lineLable.textColor = [UIColor greenColor];
        [bottomImageView addSubview:lineLable];
        
        UILabel *aLable = [[UILabel alloc] initWithFrame:CGRectMake(30, 150, 80, 20)];
        aLable.text = @"制作指导";
        aLable.layer.cornerRadius = 10;
        aLable.layer.masksToBounds = YES;
        aLable.font = [UIFont boldSystemFontOfSize:16];
        aLable.textAlignment = NSTextAlignmentCenter;
        aLable.backgroundColor = [UIColor grayColor];
        [bottomImageView addSubview:aLable];
        
        UILabel *secondLable = [[UILabel alloc] initWithFrame:CGRectMake(30, 150, bottomImageView.frame.size.width - 60, 120)];
        secondLable.font = [UIFont boldSystemFontOfSize:14];
        secondLable.numberOfLines = 0;
        secondLable.textAlignment = NSTextAlignmentJustified;
        secondLable.text = self.rltModel.productionDirection;
        [bottomImageView addSubview:secondLable];
        
        self.contentSize = CGSizeMake(0, (((float)130 / (float)667) * kHH) + 40 + 300);
    }
    return self;
}

@end

//
//  CLAlertView.m
//  SimpleKitchen
//
//  Created by Craig Liao on 15/8/17.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "CLAlertView.h"
@interface CLAlertView ()

@property (nonatomic, strong) UILabel *dtlLeftLable;
@property (nonatomic, strong) UILabel *centerLable;
@property (nonatomic, strong) UIImageView *rightImageView;

@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UILabel *leftLable;
@property (nonatomic, strong) UILabel *rightLable;

@end

@implementation CLAlertView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        CLModelItem *firstModel = self.altArray.firstObject;
        CLModelItem *secondModel = self.altArray.lastObject;
        self.leftImageView = [[UIImageView alloc] init];
        self.leftImageView.frame = CGRectMake(0, 0, 60, self.frame.size.height);
        [self addSubview:self.leftImageView];
        
        self.leftLable = [[UILabel alloc] init];
        self.leftLable.frame = CGRectMake(60, 0, 80, self.frame.size.height);
        self.leftLable.adjustsFontSizeToFitWidth = YES;
        self.leftLable.numberOfLines = 0;
        self.leftLable.textAlignment = NSTextAlignmentCenter;
        self.leftLable.font = [UIFont boldSystemFontOfSize:17];
        self.leftLable.textColor = [UIColor colorWithRed:192/256.0 green:180/256.0 blue:96/256.0 alpha:1.0];
        self.leftLable.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.leftLable];
        
        self.rightLable = [[UILabel alloc] init];
        self.rightLable.frame = CGRectMake(140, 0, self.frame.size.width - 140, self.frame.size.height);
        self.rightLable.font = [UIFont boldSystemFontOfSize:14];
        self.rightLable.numberOfLines = 0;
        self.rightLable.textAlignment = NSTextAlignmentCenter;
        self.rightLable.backgroundColor = [UIColor colorWithRed:192/256.0 green:180/256.0 blue:96/256.0 alpha:0.7];
        [self addSubview:self.rightLable];

        self.dtlLeftLable = [[UILabel alloc] init];
        self.dtlLeftLable.frame = CGRectMake(0, 0, 60, 30);
        self.dtlLeftLable.textColor = [UIColor whiteColor];
        self.dtlLeftLable.backgroundColor = [UIColor colorWithRed:60/256.0 green:71/256.0 blue:33/256.0 alpha:1.0];
        self.dtlLeftLable.font = [UIFont boldSystemFontOfSize:20];
        self.dtlLeftLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.dtlLeftLable];
        
        self.centerLable = [[UILabel alloc] init];
        self.centerLable.frame = CGRectMake(60, 0, self.frame.size.width - 110, 30);
        self.centerLable.textColor = [UIColor colorWithRed:13/256.0 green:61/256.0 blue:23/256.0 alpha:1.0];
        self.centerLable.font = [UIFont boldSystemFontOfSize:15];
        self.centerLable.textAlignment = NSTextAlignmentCenter;
        self.centerLable.backgroundColor = [UIColor colorWithRed:192/256.0 green:180/256.0 blue:96/256.0 alpha:0.7];
        [self addSubview:self.centerLable];
        
        self.rightImageView = [[UIImageView alloc] init];
        self.rightImageView.frame = CGRectMake(self.frame.size.width - 50, 0, 50, 30);
        [self addSubview:self.rightImageView];


        
        // 相宜

        self.dtlLeftLable.text = @"相宜";
        NSString *str = [NSString stringWithFormat:@"%@与下列食物相宜",firstModel.materialName];
        self.centerLable.text = str;
        [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:firstModel.imageName]];
        [self addSubview:self.dtlLeftLable];
        
        for (int i = 0; i < firstModel.FitArray.count; i ++) {
            
//            PackageView *aPackView = [[PackageView alloc] initWithFrame:CGRectMake(20, 60 + (45 * i), kViewWidth - 40, 40)];
            [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:[firstModel.FitArray[i] imageName]]];
            self.leftLable.text = [firstModel.FitArray[i] materialName];
            self.rightLable.text = [firstModel.FitArray[i] contentDescription];
        }
        
        UILabel *lineLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 20 + 60 + 45 *(firstModel.FitArray.count - 1) + 40, kWW - 20, 1)];
        lineLable.backgroundColor = [UIColor purpleColor];
        [self addSubview:lineLable];
        
        // 相克
//        XiangYiView *xiangkeView = [[XiangYiView alloc] initWithFrame:CGRectMake(20, 20 + 120 + 45 *(firstModel.FitArray.count - 1), kViewWidth - 40, 30)];
        self.dtlLeftLable.text = @"相克";
        
        if (secondModel.GramArray.count != 0) {
            
            NSString *str1 = [NSString stringWithFormat:@"%@与下列食物相克",secondModel.materialName];
            self.centerLable.text = str1;
            [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:secondModel.imageName]];
            
            // 相克的内容
            for (int i = 0; i < secondModel.GramArray.count; i ++) {
                
//                PackageView *bPackageView = [[PackageView alloc] initWithFrame:CGRectMake(20, 190 + 45 *(firstModel.FitArray.count - 1) + 45 * i, kViewWidth - 40, 40)];
                [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:[secondModel.GramArray[i] imageName]]];
                self.leftLable.text = [secondModel.GramArray[i] materialName];
                self.rightLable.text = [secondModel.GramArray[i] contentDescription];
            }
            
        } else {
            self.centerLable.text = @"无相克内容";;
            self.rightImageView.backgroundColor = [UIColor whiteColor];
        }
        self.leftLable.backgroundColor = [UIColor colorWithRed:158/256.0 green:15/256.0 blue:24/256.0 alpha:0.8];
        self.centerLable.textColor = [UIColor colorWithRed:158/256.0 green:15/256.0 blue:24/256.0 alpha:0.7];
        
        self.contentSize = CGSizeMake(0, 20 + 49 + 190 + 45 * (firstModel.FitArray.count - 1) + 45 * (secondModel.GramArray.count - 1));
        }
    return self;
}

@end

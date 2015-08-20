//
//  CLModelItem.h
//  SimpleKitchen
//
//  Created by Craig Liao on 15/8/11.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLSecondGrade.h"

@interface CLModelItem : NSObject

////Recipe轮播图
@property (nonatomic, copy) NSString *vegetable_id;//id号

@property (nonatomic, copy) NSString *imagePathPortrait;//竖屏图片

@property (nonatomic, copy) NSString *imagePathThumbnails;//图标图片

@property (nonatomic, copy) NSString *englishName;//英文名字

@property (nonatomic, copy) NSString *name;//名称

//Recipe详情
@property (nonatomic, copy) NSString *describe;//描述

@property (nonatomic, copy) NSString *imagePath;//图片

@property (nonatomic, copy) NSString *order_id;//步骤顺序号

//所需材料
@property (nonatomic, copy) NSString *fittingRestriction;// 土豆200克，青椒20克，红椒15克，蒜末少许
@property (nonatomic, copy) NSString *method;// 盐2克，味精、辣椒油、芝麻油、食用油各适量
@property (nonatomic, copy) NSString *imagePathLandscape;// 图片URL
@property (nonatomic, copy) NSString *materialVideoPath;// 第一个视频URL
@property (nonatomic, copy) NSString *productionProcessPath;// 第二个视频URL
@property (nonatomic, strong) NSMutableArray *imageArray; //图片数组

//相关常识
@property (nonatomic, copy) NSString *nutritionAnalysis;
@property (nonatomic, copy) NSString *productionDirection;

//相宜相克
@property (nonatomic ,copy) NSString *materialName; // 相宜的对象 名字
@property (nonatomic ,copy) NSString *imageName; // 图片URL
@property (nonatomic ,strong) NSMutableArray *FitArray; // 相宜 数组
@property (nonatomic ,strong) NSMutableArray *GramArray; // 相克 数组

@property (nonatomic, copy) NSString *contentDescription; // 会出现的症状



//分类次目录
@property (nonatomic, strong) NSMutableArray *subMenuArray;//次目录数组
@property (nonatomic, strong) CLSecondGrade *secondModel;//小模型

//精品
@property (nonatomic, copy) NSString *imageFilename;//照片

//新鲜事
@property (nonatomic, copy) NSString *content;//内容描述
@property (nonatomic, strong) NSString *freshId;//ID号
@property (nonatomic, strong) NSString *type;//类型
@property (nonatomic, copy) NSString *titleImageFile;//图片文件
@property (nonatomic, strong) NSArray *vegetable;//内容数组

//汤
//@property (nonatomic, copy) NSString *hotwater;

//对症食疗
@property (nonatomic, copy) NSString *diseaseId;

@property (nonatomic, copy) NSString *diseaseName;
@property (nonatomic, copy) NSString *diseaseDescribe;
@property (nonatomic, copy) NSString *fitEat;
@property (nonatomic, copy) NSString *lifeSuit;


@end

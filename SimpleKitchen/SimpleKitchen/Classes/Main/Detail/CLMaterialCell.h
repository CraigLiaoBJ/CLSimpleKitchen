//
//  CLMaterialView.h
//  SimpleKitchen
//
//  Created by Craig Liao on 15/8/17.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLMaterialCell : UITableViewCell

@property (nonatomic, strong) UIView *view;

@property (nonatomic, strong) CLModelItem *materialItem;

@property (nonatomic, strong) NSArray *mtlArray;

@property (nonatomic, strong) NSArray *imageArray;

@end

//
//  CLDietView.h
//  SimpleKitchen
//
//  Created by Craig Liao on 15/8/15.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ChangeFrame) ();//定义一个block返回的参数是size.

@interface CLDietView : UICollectionReusableView

@property (nonatomic, copy) ChangeFrame HBlock;

@property (nonatomic, strong) CLModelItem *headItem;

//判断是否展开
@property (nonatomic, assign) BOOL isShow;

@end

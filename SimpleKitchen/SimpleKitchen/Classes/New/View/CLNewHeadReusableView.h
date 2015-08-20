//
//  CLNewHeadReusableView.h
//  SimpleKitchen
//
//  Created by Craig Liao on 15/8/14.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ChangeFrame) ();//定义一个block返回的参数是size.

@interface CLNewHeadReusableView : UICollectionReusableView

@property (nonatomic, strong) CLModelItem *headItem;

@property (nonatomic, copy) ChangeFrame HBlock;

//判断是否展开
@property (nonatomic, assign) BOOL isShow;

//新的高度
//@property (nonatomic, assign) CGFloat NewHeight;


@end

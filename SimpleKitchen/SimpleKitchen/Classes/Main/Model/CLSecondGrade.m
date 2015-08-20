//
//  CLSecondGrade.m
//  SimpleKitchen
//
//  Created by Craig Liao on 15/8/13.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "CLSecondGrade.h"

@implementation CLSecondGrade

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]||[key isEqualToString:@"diseaseId"]) {
        self.menuId = value;
    }
}
@end

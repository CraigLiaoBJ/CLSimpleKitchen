//
//  CLModelItem.m
//  SimpleKitchen
//
//  Created by Craig Liao on 15/8/11.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "CLModelItem.h"
#import "CLSecondGrade.h"

@implementation CLModelItem

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"vegetable_id"]||[key isEqualToString:@"id"]) {
        self.vegetable_id = value;
    }
    if ([key isEqualToString:@"freshId"]) {
        self.freshId = [value stringValue];
    }

    if ([key isEqualToString:@"secondgrade"]||[key isEqualToString:@"hotwater"]) {

        self.subMenuArray = [[NSMutableArray alloc] initWithCapacity:1];
        for (NSDictionary *tempDic in value) {
           _secondModel = [[CLSecondGrade alloc] init];
            [_secondModel setValuesForKeysWithDictionary:tempDic];
            [self.subMenuArray addObject:_secondModel];
        }
    }
    
    if ([key isEqualToString:@"TblSeasoning"]) {
        
        self.imageArray = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dict in value) {
            
            CLModelItem *model = [[CLModelItem alloc] init];
            
            [model setValuesForKeysWithDictionary:dict];
            
            [self.imageArray addObject:model];
        }
    }
    
    if ([key isEqualToString:@"Fitting"] && value != nil) {
        
        self.FitArray = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dict in value) {
            
            CLModelItem *model = [[CLModelItem alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [self.FitArray addObject:model];
        }
    } else if ([key isEqualToString:@"Gram"] && value != nil) {
        
        self.GramArray = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dict in value) {
            
            CLModelItem *model = [[CLModelItem alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [self.GramArray addObject:model];
        }
    }


    
}

@end

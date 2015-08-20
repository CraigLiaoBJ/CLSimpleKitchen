//
//  CLRecipeViewController.m
//  SimpleKitchen
//
//  Created by Craig Liao on 15/8/11.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "CLRecipeViewController.h"
#import "AutoView.h"
#import "CLModelItem.h"

@interface CLRecipeViewController (){
    NSMutableArray *imagesArray;
    NSMutableArray *titlesArray;
    CLModelItem *modelItem;
}

@property (nonatomic, strong) NSMutableArray *recipeArray;

@end

@implementation CLRecipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor= [UIColor whiteColor];
    imagesArray = [NSMutableArray array];
    titlesArray = [NSMutableArray array];
    self.recipeArray = [NSMutableArray array];
    
    [self loadData];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark -- 添加轮播图
- (void)setupScrollView{
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    AutoView *autoView = [AutoView imageScrollViewWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT) imageLinkURL:imagesArray placeHolderImageName:nil pageControlShowStyle:UIPageControlShowStyleCenter];
    
    autoView.isNeedCycleRoll = YES;
    [autoView setImageTitleArray:titlesArray withShowStyle:ImageTitleShowStyleRight];
    
    autoView.imageMoveTime = 3.0f;
    
    __weak typeof (self) recipeSelf = self;
    autoView.callBack = ^(NSInteger index, NSString *imageURL){
        CLDetailTableViewController *detailView = [[CLDetailTableViewController alloc] init];
        detailView.detailId = [self.recipeArray[index] vegetable_id];
        [recipeSelf.navigationController pushViewController:detailView animated:YES];
    };
    [self.view addSubview:autoView];
}

#pragma mark -- 加载数据
- (void)loadData{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:RecipeUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        //1.获取大字典
        NSDictionary *dict = (NSDictionary *)responseObject;
        //2.获取需要取值的数组
        NSArray *dataArray = dict[@"data"];
        //3.遍历这个字典并取值
        for (NSDictionary *tempDict in dataArray) {
            modelItem = [[CLModelItem alloc] init];
            [modelItem setValuesForKeysWithDictionary:tempDict];
            [self.recipeArray addObject:modelItem];
            [imagesArray addObject:modelItem.imagePathPortrait];
            [titlesArray addObject:modelItem.name];
            NSLog(@"%@", modelItem.vegetable_id);

        }
        [self setupScrollView];
    
        NSLog(@"JSON: %ld", dataArray.count);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"Error: %@", error);
    }];
}

@end

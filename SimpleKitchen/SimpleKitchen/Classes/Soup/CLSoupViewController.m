//
//  CLSoupViewController.m
//  SimpleKitchen
//
//  Created by Craig Liao on 15/8/13.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "CLSoupViewController.h"
#import "CLSpMenuController.h"
#import "CLSoupMenuCell.h"
#import "CLSoupView.h"

@interface CLSoupViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>{
    CLModelItem *_sectionModel;

}

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSMutableArray *sectionArray;

@end

@implementation CLSoupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    self.sectionArray = [NSMutableArray array];
    
    [self setupCollectionView];
    [self loadData];
    
}

#pragma mark -- 集合视图创建
- (void)setupCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(kWIDTH / 4, 20);
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.minimumLineSpacing = 5;
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 10, 10, 10);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT - 64) collectionViewLayout:flowLayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor colorWithRed:0.602 green:0.972 blue:1.000 alpha:1.000];
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[CLSoupMenuCell class] forCellWithReuseIdentifier:@"CELL"];
    //注册区头
    [self.collectionView registerClass:[CLSoupView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HEADCELL"];

    
}

#pragma mark -- 加载数据
- (void)loadData{
    __weak typeof(self) weakSelf = self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:SoupMenu parameters:nil success:^(AFHTTPRequestOperation * operation, id responseObject) {
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSArray *array = dict[@"data"];
        for (NSDictionary *tempDic in array) {
            CLModelItem *sectionModel = [[CLModelItem alloc] init];
            [sectionModel setValuesForKeysWithDictionary:tempDic];
            [self.sectionArray addObject:sectionModel];
        }

        [weakSelf.collectionView reloadData];
        
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        
    }];
    
}

#pragma mark -- 分区数量
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.sectionArray.count;
}

#pragma mark -- cell数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if ([self.dataArray containsObject:@(section)]) {
        CLModelItem *model = self.sectionArray[section];
        return model.subMenuArray.count;
    }else {
        return 0;
    }
}

#pragma mark -- cell的重用机制
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
 
    CLSoupMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    CLModelItem *model = self.sectionArray[indexPath.section];
    cell.label.text = [model.subMenuArray[indexPath.row] name];

    
    return cell;

}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    CLSoupView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HEADCELL" forIndexPath:indexPath];
    
    
    view.sectionBtn.tag = indexPath.section;
    
    [view.sectionBtn setTitle:[NSString stringWithFormat:@"%@", [self.sectionArray[indexPath.section] name]]forState:UIControlStateNormal];
    
    [view.sectionBtn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];

    return view;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(0, 20);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CLSpMenuController *spMenuVC = [[CLSpMenuController alloc] init];
    
    CLModelItem *model = self.sectionArray[indexPath.section];
    spMenuVC.subId = [model.subMenuArray[indexPath.row] menuId];
    
    [self.navigationController pushViewController:spMenuVC animated:YES];
}

- (void)didClickBtn:(UIButton *)btn{
    
    if ([self.dataArray containsObject:@(btn.tag)]) {
        [self.dataArray removeObject:@(btn.tag)];
    } else {
        [self.dataArray addObject:@(btn.tag)];
    }
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:btn.tag]];
}

@end

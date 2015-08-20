//
//  CLSelectionViewController.m
//  SimpleKitchen
//
//  Created by Craig Liao on 15/8/11.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "CLSelectionViewController.h"
#import "CLMenuCollectionViewCell.h"
#import "CLSDetailViewController.h"

@interface CLSelectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation CLSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray = [NSMutableArray array];
    [self setupCollectionView];
    [self loadData];
}

#pragma mark -- 添加集合视图
- (void)setupCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(110, 110);
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.minimumLineSpacing = 5;
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 10, 10, 10);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT -  64) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = CLRedColor;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[CLMenuCollectionViewCell class] forCellWithReuseIdentifier:@"CELL"];
}

#pragma mark -- 加载数据
- (void)loadData{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    __weak typeof(self) weakSelf = self;
    [manager GET:SelectionUrl parameters:nil success:^(AFHTTPRequestOperation * operation, id responseObject) {
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSArray *array = dict[@"data"];
        for (NSDictionary *tempDic in array) {
            CLModelItem *selectItem = [[CLModelItem alloc] init];
            [selectItem setValuesForKeysWithDictionary:tempDic];
            [weakSelf.dataArray addObject:selectItem];
        }
        [weakSelf.collectionView reloadData];
        
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        
    }];
}

#pragma mark -- dataSource 代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CLMenuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    NSURL *url = [NSURL URLWithString:[self.dataArray[indexPath.row] imageFilename]];
    [cell.imageBig sd_setImageWithURL:url];
    
    cell.nameLabel.text = [self.dataArray[indexPath.row] name];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CLSDetailViewController *SDVC = [[CLSDetailViewController alloc] init];
    SDVC.typeId = [self.dataArray[indexPath.row] vegetable_id];
    [self.navigationController pushViewController:SDVC animated:YES];
}

@end

//
//  CLSDetailViewController.m
//  SimpleKitchen
//
//  Created by Craig Liao on 15/8/13.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "CLSDetailViewController.h"
#import "CLModelItem.h"
#import "CLDetailTableViewController.h"
#import "CLSubMenuViewCell.h"

@interface CLSDetailViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation CLSDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [NSMutableArray array];
    [self setupCollectionView];
    [self loadData];

}

#pragma mark -- 集合视图加载
- (void)setupCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(110, 100);
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.minimumLineSpacing = 5;
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 10, 10, 10);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor colorWithRed:0.531 green:1.000 blue:0.962 alpha:1.000];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[CLSubMenuViewCell class] forCellWithReuseIdentifier:@"CELL"];
    
}


#pragma mark -- 加载数据
- (void)loadData{
    NSString *string = [SelectDetail stringByAppendingFormat:@"%@", self.typeId];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    __weak typeof(self) weakSelf = self;
    [manager GET:string parameters:nil success:^(AFHTTPRequestOperation * operaion, id responseObject){
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSArray *array = dict[@"data"];
        for (NSDictionary *tempDic in array) {
            CLModelItem *sItem = [[CLModelItem alloc] init];
            [sItem setValuesForKeysWithDictionary:tempDic];
            [weakSelf.dataArray addObject:sItem];
        }
        [weakSelf.collectionView  reloadData];
        
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        
    }];
}

#pragma mark -- dataSource 代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CLSubMenuViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    NSURL *url = [NSURL URLWithString:[self.dataArray[indexPath.row] imagePathThumbnails]];
    [cell.imageBig sd_setImageWithURL:url];
    
    cell.nameLabel.text = [self.dataArray[indexPath.row] name];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CLDetailTableViewController *detailVC = [[CLDetailTableViewController alloc] init];
    detailVC.detailId = [self.dataArray[indexPath.row] vegetable_id];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    cell.backgroundColor = [UIColor whiteColor];
}

@end

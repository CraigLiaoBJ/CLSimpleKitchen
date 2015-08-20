//
//  CLSubMenuViewController.m
//  SimpleKitchen
//
//  Created by Craig Liao on 15/8/13.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "CLSubMenuViewController.h"
#import "CLSubMenuViewCell.h"
#import "CLDetailTableViewController.h"

@interface CLSubMenuViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

static NSInteger n = 1;
@implementation CLSubMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:1.000 green:0.799 blue:0.713 alpha:1.000];
    self.dataArray = [NSMutableArray array];
    [self setupCollectionView];
    [self loadData];
}

#pragma mark -- 添加集合视图
- (void)setupCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(110, 100);
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.minimumLineSpacing = 5;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 10, 10, 10);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[CLSubMenuViewCell class] forCellWithReuseIdentifier:@"CELL"];
}

#pragma mark -- 加载数据
- (void)loadData{
    NSString *string = [SubMenu stringByAppendingFormat:@"%@&page=%ld&pageRecord=10&is_traditional=0&phonetype=1", self.subId, n];
    __weak typeof(self) weakSelf = self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:string parameters:nil success:^(AFHTTPRequestOperation * operation, id responseObject) {
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSArray *dataArray = dict[@"data"];
        for (NSDictionary *tempDic in dataArray) {
            CLModelItem *subMenu = [[CLModelItem alloc] init];
            [subMenu setValuesForKeysWithDictionary:tempDic];
            [weakSelf.dataArray addObject:subMenu];
        }
        [self.collectionView reloadData];
        
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        
    }];
}


#pragma mark -- collectionView的datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CLSubMenuViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    NSURL *url = [NSURL URLWithString:[self.dataArray[indexPath.row] imagePath]];
    [cell.imageBig sd_setImageWithURL:url];
    cell.nameLabel.text = [self.dataArray[indexPath.row] name];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CLDetailTableViewController *DetailVC = [[CLDetailTableViewController alloc] init];
    DetailVC.detailId = [self.dataArray[indexPath.row] vegetable_id];
    [self.navigationController pushViewController:DetailVC animated:YES];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    cell.backgroundColor = [UIColor whiteColor];
}


@end

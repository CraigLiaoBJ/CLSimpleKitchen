//
//  CLDietViewController.m
//  SimpleKitchen
//
//  Created by Craig Liao on 15/8/15.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "CLDietViewController.h"
#import "CLDtDetailController.h"
#import "CLDietCell.h"

@interface CLDietViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation CLDietViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    NSLog(@"对症食疗%@", self.officeId);

    [self setupCollectionView];
    [self loadData];

}

- (void)setupCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(155, 50);
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 20, 10, 20);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT) collectionViewLayout:flowLayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor colorWithRed:0.485 green:0.649 blue:0.667 alpha:1.000];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[CLDietCell class] forCellWithReuseIdentifier:@"CELL"];
}

- (void)loadData{
    NSString *string = [DietUrl stringByAppendingFormat:@"%@&is_traditional=0", self.officeId];
    NSLog(@"%@", string);
    __weak typeof(self) weakSelf = self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:string parameters:nil success:^(AFHTTPRequestOperation * operation, id responseObject) {
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSArray *array = dict[@"data"];
        for (NSDictionary *tempDic in array) {
            CLModelItem *model = [[CLModelItem alloc] init];
            [model setValuesForKeysWithDictionary:tempDic];
            [weakSelf.dataArray addObject:model];
            NSLog(@"diet %@", model.diseaseId);
        }
        [weakSelf.collectionView reloadData];
        
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;

}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CLDietCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    NSURL *url = [NSURL URLWithString:[self.dataArray[indexPath.row] imageName]];
    [cell.mainImage sd_setImageWithURL:url];
    
    cell.nameLabel.text = [self.dataArray[indexPath.row] diseaseName];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CLDtDetailController *newDetailVC = [[CLDtDetailController alloc] init];
    CLModelItem *model = self.dataArray[indexPath.row];
    newDetailVC.NewDetailId = model.diseaseId;
    newDetailVC.dietDetailModel = model;
    
    [self.navigationController pushViewController:newDetailVC animated:YES];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    cell.backgroundColor = [UIColor whiteColor];
}

@end

//
//  CLSpMenuController.m
//  SimpleKitchen
//
//  Created by Craig Liao on 15/8/15.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "CLSpMenuController.h"
#import "CLSubMenuViewCell.h"
@interface CLSpMenuController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UICollectionView *collectionView;

@end

static NSInteger n = 1;
@implementation CLSpMenuController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    NSLog(@"subid = %@" , self.subId);
    [self setupCollectionView];
    [self loadData];
}

- (void)setupCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(100, 130);
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.minimumLineSpacing = 5;
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 10, 10, 10);
    
    self.collectionView  = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT) collectionViewLayout:flowLayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[CLSubMenuViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)loadData{
    NSString *string = [SubSpMenu stringByAppendingFormat:@"%@&is_traditional=0&page=%ld&pageRecord=10", self.subId, n];
    
    NSLog(@"%@", string);
    __weak typeof(self) weakSelf = self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:string parameters:nil success:^(AFHTTPRequestOperation * operation, id responseObject) {
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSArray *array = dict[@"data"];
        for (NSDictionary *tempDic in array) {
            CLModelItem *soupMenu = [[CLModelItem alloc] init];
            [soupMenu setValuesForKeysWithDictionary:tempDic];
            [weakSelf.dataArray addObject:soupMenu];
            NSLog(@"%@", soupMenu.name);
            NSLog(@"%@", soupMenu.vegetable_id);
        }
        [weakSelf.collectionView reloadData];
        
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        
    }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CLSubMenuViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    CLModelItem *model = self.dataArray[indexPath.row];
    
    NSURL *url = [NSURL URLWithString:model.imageFilename];

    [cell.imageBig sd_setImageWithURL:url];
    cell.nameLabel.font = [UIFont systemFontOfSize:11];
    cell.nameLabel.text = model.name;
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CLDetailTableViewController *detailVC = [[CLDetailTableViewController alloc] init];
    CLModelItem *model = self.dataArray[indexPath.row];
    detailVC.detailId = model.vegetable_id;
    [self.navigationController pushViewController:detailVC animated:YES];
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end

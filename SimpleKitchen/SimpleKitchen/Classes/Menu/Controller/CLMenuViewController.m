//
//  CLMenuViewController.m
//  SimpleKitchen
//
//  Created by Craig Liao on 15/8/13.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "CLMenuViewController.h"
#import "CLDietViewController.h"
#import "CLModelItem.h"
#import "CLSecondGrade.h"
#import "CLMenuCollectionViewCell.h"
#import "CLSubMenuViewController.h"

@interface CLMenuViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate>{
    NSString *modelName;
}

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *subArray;

@end

@implementation CLMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    self.subArray = [NSMutableArray array];
    [self setupCollectionView];

    [self loadData];

}

#pragma mark -- 添加集合视图
- (void)setupCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(100, 100);
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.minimumLineSpacing = 5;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 10, 10, 10);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT - 64) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor colorWithRed:0.000 green:1.000 blue:1.000 alpha:0.080];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];
    [self setupTableView];

    [self.collectionView registerClass:[CLMenuCollectionViewCell class] forCellWithReuseIdentifier:@"CELL"];
}

#pragma mark -- 加载数据
- (void)loadData{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    __weak typeof(self) weakSelf = self;
    [manager GET:MenuUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        //1.获取大字典
        NSDictionary *dict = (NSDictionary *)responseObject;
        //2.获取需要取值的数组
        NSArray *dataArray = dict[@"data"];
        //3.遍历这个字典并取值
        for (NSDictionary *tempDict in dataArray) {
            CLModelItem *mnItem = [[CLModelItem alloc] init];
            [mnItem setValuesForKeysWithDictionary:tempDict];
            [weakSelf.dataArray addObject:mnItem];
        }
        [weakSelf.dataArray removeLastObject];
        [weakSelf.dataArray removeLastObject];
        [weakSelf.dataArray removeLastObject];
        [weakSelf.dataArray removeLastObject];

        [weakSelf.collectionView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"Error: %@", error);
    }];
}

#pragma mark -- 添加tableview
- (void)setupTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(-kWIDTH / 3, 0, kWIDTH / 3, kHEIGHT) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = CLRedColor;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
    self.tableView.hidden = YES;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELL"];
}

#pragma mark -- 集合视图datasource代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CLMenuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
        NSURL *url = [NSURL URLWithString:[self.dataArray[indexPath.row] imagePath]];
        [cell.imageBig sd_setImageWithURL:url];
        cell.nameLabel.text = [self.dataArray[indexPath.row] name];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{


    self.subArray = [self.dataArray[indexPath.row] subMenuArray];
    modelName = [self.dataArray[indexPath.row] name];
    
    [self.tableView reloadData];

    if (self.collectionView.frame.origin.x == 0 ) {
        [UIView animateWithDuration:0.25 animations:^{
            self.tableView.hidden = NO;

            self.tableView.frame = CGRectMake(0, 0 , kWIDTH / 3, kHEIGHT);

            self.collectionView.frame = CGRectMake(kWIDTH / 3, 0, kWIDTH - kWIDTH / 3, kHEIGHT);
            }];
    } else {
        [UIView animateWithDuration:0.25 animations:^{
            self.tableView.frame = CGRectMake(- kWIDTH / 3, 0, kWIDTH / 3 , kHEIGHT);
            self.tableView.hidden = YES;

            self.collectionView.frame = CGRectMake(0, 0, kWIDTH, kHEIGHT);
            }];
    }
}

#pragma mark -- tableView 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.subArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    cell.textLabel.text = [self.subArray[indexPath.row] name];
    NSLog(@"%@", cell.textLabel.text);
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.backgroundColor = CLRedColor;
    cell.alpha = 0.5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CLModelItem *modelItem = self.dataArray[indexPath.row];
    CLSecondGrade *model = self.subArray[indexPath.row];
    
    if ([modelName isEqualToString:@"对症食疗"]) {
        NSLog(@"modelItem.name%@", modelItem.name);

        CLDietViewController *dietVC = [[CLDietViewController alloc] init];
        
        dietVC.officeId = model.menuId;
        [self.navigationController pushViewController:dietVC animated:YES];
        
    } else {
        
        CLSubMenuViewController *subVC = [[CLSubMenuViewController alloc] init];
        subVC.subId = model.menuId;
        [self.navigationController pushViewController:subVC animated:YES];
    }

}
@end

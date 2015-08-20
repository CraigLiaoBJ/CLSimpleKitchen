//
//  CLDtDetailController.m
//  SimpleKitchen
//
//  Created by Craig Liao on 15/8/15.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "CLDtDetailController.h"
#import "CLSubMenuViewCell.h"
#import "CLDietView.h"

@interface CLDtDetailController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>{
    CLModelItem *modelItem;
}

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, assign) CGFloat height;

@end

static NSInteger n = 1;
@implementation CLDtDetailController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isShow = NO;
    
    self.dataArray = [NSMutableArray array];
    modelItem = [[CLModelItem alloc] init];
    [self setupCollectionView];
    [self loadData];
    
}

#pragma mark -- 加载集合视图
- (void)setupCollectionView{
    //flowLayout的设置
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(110, 120);
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.minimumLineSpacing = 5;
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 10, 10, 10);
    
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    //collectionView的设置
    self.collectionView = [[UICollectionView alloc ]initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT) collectionViewLayout:flowLayout];
    
    self.collectionView.backgroundColor = [UIColor colorWithRed:1.000 green:0.874 blue:0.925 alpha:1.000];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:self.collectionView];
    
    //注册cell
    [self.collectionView registerClass:[CLSubMenuViewCell class] forCellWithReuseIdentifier: @"CELL"];
    
    //collection头视图的注册   奇葩的地方来了，头视图也得注册
    [self.collectionView registerClass:[CLDietView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HEADCELL"];
}

#pragma mark --
- (void)loadData{
    NSString *string = [DietDetailUrl stringByAppendingFormat:@"%@&page=%ld&pageRecord=8&phonetype=0&is_traditional=0", self.NewDetailId, n];
    NSLog(@"%@", string);
    __weak typeof(self) weakSelf = self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:string parameters:nil success:^(AFHTTPRequestOperation * operation, id responseObject) {
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSArray *array = dict[@"data"];
        for (NSDictionary *tempDic in array) {
            CLModelItem *model = [[CLModelItem alloc] init];
            [model setValuesForKeysWithDictionary:tempDic];
            [self.dataArray addObject:model];
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

//设置cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CLSubMenuViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    NSURL *url = [NSURL URLWithString:[self.dataArray[indexPath.row] imagePathThumbnails]];
    [cell.imageBig sd_setImageWithURL:url];
    
    cell.nameLabel.text = [self.dataArray[indexPath.row] name];
    return cell;
}

//设置头部视图的frame
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (self.isShow) {
        return CGSizeMake(0, _height + 30);
    } else {
        return CGSizeMake(0, 120);
    }
}

#pragma mark <UICollectionViewDelegate>
//头部视图的重用方法
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    CLDietView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HEADCELL" forIndexPath:indexPath];
    //赋值
    headView.headItem = self.dietDetailModel;
    
    NSString *string = [NSString stringWithFormat:@"%@\n%@\n%@", self.dietDetailModel.diseaseDescribe, self.dietDetailModel.fitEat, self.dietDetailModel.lifeSuit];
    //计算高度
    _height= [self getHeightWithString:string font:13 width:kWIDTH-20];
    
    headView.backgroundColor = [UIColor colorWithRed:0.938 green:0.985 blue:1.000 alpha:1.000];
    
    headView.isShow = self.isShow;
    
    //block传值
    headView.HBlock = ^() {
        self.isShow = !self.isShow;
        [self.collectionView reloadData];
    };
    
    return headView;
}

//cell的背景
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    cell.backgroundColor = [UIColor whiteColor];
}

//点击进入详情界面
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CLDetailTableViewController *detailVC = [[CLDetailTableViewController alloc] init];
    detailVC.detailId = [self.dataArray[indexPath.row] vegetable_id];
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark -- 封装下获取高度的方法
- (CGFloat)getHeightWithString:(NSString *)string font:(CGFloat)font width:(CGFloat)width{
    //获取字符串的高度
    
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width, 100000) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.height;
}


@end

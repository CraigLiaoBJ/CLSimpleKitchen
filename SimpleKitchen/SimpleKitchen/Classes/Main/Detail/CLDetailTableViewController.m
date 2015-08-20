//
//  CLDetailTableViewController.m
//  SimpleKitchen
//
//  Created by Craig Liao on 15/8/11./Users/craigliao/Desktop/ddd.gif
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//
#import <MediaPlayer/MediaPlayer.h>
#import "CLDetailTableViewController.h"
#import "CLMethodCell.h"
#import "CLHeaderView.h"
#import "CLMaterialCell.h"
#import "CLRelateView.h"
#import "CLAlertView.h"



@interface CLDetailTableViewController ()<HeaderViewDelegate>{
    CLHeaderView *_headerView;
    CLMaterialCell *_materialView;
    CLRelateView *_relateView;
    CLAlertView *_alertView;
}

@property (nonatomic, strong) UIView *playerView;// 播放器视图

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *methodArray;
@property (nonatomic, strong) NSMutableArray *materialArray;
@property (nonatomic, strong) NSMutableArray *relateArray;
@property (nonatomic, strong) NSMutableArray *alertArray;

@end

@implementation CLDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    self.methodArray = [NSMutableArray array];
    self.materialArray = [NSMutableArray array];
    self.relateArray = [NSMutableArray array];
    self.alertArray = [NSMutableArray array];
    
    _headerView = [[CLHeaderView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 35)];
    _headerView.backgroundColor = [UIColor colorWithRed:0.978 green:0.938 blue:0.925 alpha:1.000];
    
    // 播放器视图
    self.playerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, ((float)200 / (float)667) * kHEIGHT)];
//    [self.view addSubview:self.playerView];
    [self addItemToPlayerView];
    [self loadMethodData];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kWIDTH, kHEIGHT - 64) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.playerView;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    switch (_headerView.segmentedControl.selectedSegmentIndex) {
        case 0:
        [self.tableView registerClass:[CLMethodCell class] forCellReuseIdentifier:@"CELL"];
            break;
        case 1:
        [self.tableView registerClass:[CLMaterialCell class] forCellReuseIdentifier:@"CELL"];
            
        default:
            break;
    }
 

}

#pragma mark -- 加载做法数据
- (void)loadMethodData{
    
    __weak typeof(self) methodSelf = self;
    NSString *string = [MethodUrl stringByAppendingFormat:@"%@&type=2&phonetype=0&is_traditional=0", self.detailId];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:string parameters:nil success:^ (AFHTTPRequestOperation * operation, id responseObject) {
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSArray *dataArray = dict[@"data"];
        for (NSDictionary *tempDic in dataArray) {
            CLModelItem *modelItem = [[CLModelItem alloc] init];
            [modelItem setValuesForKeysWithDictionary:tempDic];
            [methodSelf.methodArray addObject:modelItem];
        }
        [methodSelf.tableView reloadData];
        
    } failure:^ (AFHTTPRequestOperation * operation, NSError * error) {
        
    }];
}

#pragma mark -- 加载所需材料数据
- (void)loadMaterialData{
    __weak typeof(self) materialSelf = self;
    NSString *string = [MaterialUrl stringByAppendingFormat:@"%@&type=1&phonetype=0&is_traditional=0", self.detailId];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:string parameters:nil success:^(AFHTTPRequestOperation * operation, id responseObject) {
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSArray *dataArray = dict[@"data"];
        for (NSDictionary *tempDic in dataArray) {
            CLModelItem *modelItem = [[CLModelItem alloc] init];
            [modelItem setValuesForKeysWithDictionary:tempDic];
            [materialSelf.materialArray addObject:modelItem];
        }
        _materialView.mtlArray = materialSelf.materialArray;
        
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
    }];
}

#pragma mark -- 加载相关数据
- (void)loadRelateData{
    __weak typeof(self) relateSelf = self;
    NSString *string = [RelatelUrl stringByAppendingFormat:@"%@&type=4&phonetype=0&is_traditional=0", self.detailId];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:string parameters:nil success:^(AFHTTPRequestOperation * operation, id responseObject) {
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSArray *dataArray = dict[@"data"];
        for (NSDictionary *tempDic in dataArray) {
            CLModelItem *modelItem = [[CLModelItem alloc] init];
            [modelItem setValuesForKeysWithDictionary:tempDic];
            [relateSelf.relateArray addObject:modelItem];
        }
        _relateView.rltArray = relateSelf.relateArray;
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
    }];
}

#pragma mark -- 加载相宜相克数据
- (void)loadAlertData{
    __weak typeof(self) alertSelf = self;
    NSString *string = [AlertUrl stringByAppendingFormat:@"%@&type=4&phonetype=0&is_traditional=0", self.detailId];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:string parameters:nil success:^(AFHTTPRequestOperation * operation, id responseObject) {
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSArray *dataArray = dict[@"data"];
        for (NSDictionary *tempDic in dataArray) {
            CLModelItem *modelItem = [[CLModelItem alloc] init];
            [modelItem setValuesForKeysWithDictionary:tempDic];
            [alertSelf.alertArray addObject:modelItem];
        }
        _alertView.altArray = alertSelf.alertArray;
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
    }];
}


#pragma mark -- 添加播放器
-(void)addItemToPlayerView // 播放器视图
{
    UIImageView *aImageView = [[UIImageView alloc] initWithFrame:self.playerView.frame];
    [aImageView sd_setImageWithURL:[NSURL URLWithString:@"http://f.hiphotos.baidu.com/zhidao/pic/item/a08b87d6277f9e2f522ee9e01e30e924b899f33b.jpg"] placeholderImage:[UIImage imageNamed:@"zhanwei"]];
    aImageView.userInteractionEnabled = YES;
    [self.playerView addSubview:aImageView];
    
    UIImageView *bImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    bImageView.center = CGPointMake(aImageView.frame.size.width / 2, aImageView.frame.size.height / 2);
    bImageView.image = [UIImage imageNamed:@"play"];
    [self.playerView addSubview:bImageView];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClickAction)];
//    [self.playerView addGestureRecognizer:tap];
    
    // 使用 通知中心 监察播放状态，当播完当前视频时 切换下一个视频
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayerPlaybackStateChanged:)
                                                 name:MPMoviePlayerPlaybackStateDidChangeNotification
                                               object:nil];
}

#pragma mark ************** 播放器 通知中心 会触发的方法 监测播放状态的变化 ****************
- (void)moviePlayerPlaybackStateChanged:(NSNotification *)notification {
    MPMoviePlayerController *moviePlayer = notification.object;
    MPMoviePlaybackState playbackState = moviePlayer.playbackState;
    switch (playbackState) {
        case MPMoviePlaybackStateStopped:
        {
            //NSLog(@"停止");
            break;
        }
            
        case MPMoviePlaybackStatePlaying:
        {
            //NSLog(@"播放");
            break;
        }
            
        case MPMoviePlaybackStatePaused:
        {
            //NSLog(@"暂停");
            break;
        }
            
        case MPMoviePlaybackStateInterrupted:
        {
            //NSLog(@"未知");
            break;
        }
            
        case MPMoviePlaybackStateSeekingForward:
        {
            //NSLog(@"快进/快退");
            break;
        }
            
        case MPMoviePlaybackStateSeekingBackward:
        {
            //NSLog(@"啦啦");
            break;
        }
            
        default:
            break;
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (0 == _headerView.segmentedControl.selectedSegmentIndex) {
        return self.methodArray.count;

    } else {
        return 1;
    }
    
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == _headerView.segmentedControl.selectedSegmentIndex) {
        CLMethodCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
        
        cell1.modelItem = self.methodArray[indexPath.row];
        
        return cell1;
    } else {
        CLMaterialCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
        
//        cell.materialItem = self.methodArray[indexPath.row];
        
        return cell2;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    _headerView.headerViewDelegate = self;
    
     return _headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == _headerView.segmentedControl.selectedSegmentIndex) {
        return 250;
        
    } else {
        return 300;
    }
}

- (void)btnClicked:(UISegmentedControl *)btn
{
    switch (btn.selectedSegmentIndex) {
        case 0:
            [self loadMethodData];
            [self.tableView reloadData];
            break;
        case 1:
//            _materialView = [[CLMaterialCell alloc] initWithFrame:self.view.bounds];
//            [self loadMaterialData];
//            [self.view addSubview:_materialView];
            [self.tableView reloadData];
            break;
        case 2:
            _relateView = [[CLRelateView alloc] initWithFrame:self.view.bounds];
            [self loadRelateData];
            [self.view addSubview:_relateView];
            [self.tableView reloadData];

            break;
        case 3:
            _alertView = [[CLAlertView alloc] initWithFrame:self.view.bounds];
            [self loadAlertData];
            [self.view addSubview:_alertView];
            [self.tableView reloadData];

            break;
            
        default:
            break;
    }
}

@end

//
//  CLNewTableViewController.m
//  SimpleKitchen
//
//  Created by Craig Liao on 15/8/11.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "CLNewTableViewController.h"
#import "CLNewDetailViewController.h"
#import "CLNewCell.h"

@interface CLNewTableViewController ()

@property (nonatomic, strong) NSMutableArray *dataArray;

@end
static NSInteger n = 1;
@implementation CLNewTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 100;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    [self.tableView registerClass:[CLNewCell class] forCellReuseIdentifier:@"CELL"];
    [self loadData];

}

#pragma mark -- 加载数据
- (void)loadData{
    
    NSString *string = [NewUrl stringByAppendingFormat:@"%ld&pageRecord=10&phonetype=1", n];
    __weak typeof(self) weakSelf = self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:string parameters:nil success:^(AFHTTPRequestOperation * operation, id responseObject) {
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSArray *array = dict[@"data"];
        for (NSDictionary *tempDic in array) {
            CLModelItem *newItem = [[CLModelItem alloc ]init];
            [newItem setValuesForKeysWithDictionary:tempDic];
            [weakSelf.dataArray addObject:newItem];
            NSLog(@"%@", newItem.name);
        }
        
        [weakSelf.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        
    }];
    
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CLNewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    cell.clNewModel = self.dataArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.backgroundColor = [UIColor colorWithRed:0.825 green:1.000 blue:0.934 alpha:1.000];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CLNewDetailViewController *NewDetailVC = [[CLNewDetailViewController alloc] init];
    NewDetailVC.NewDetailId = [self.dataArray[indexPath.row] freshId];
    [self.navigationController pushViewController:NewDetailVC animated:YES];
}

@end

//
//  MJFreshViewController.m
//  AFNetworkingTutorial
//
//  Created by Hanslen Chen on 2017/6/21.
//  Copyright © 2017年 Jiahe Chen. All rights reserved.
//

#import "MJFreshViewController.h"
#import <MJRefresh.h>

@interface MJFreshViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MJFreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    default
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];

    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    NSArray *refreshingImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"wow"], nil]; //图片太大会容易不被触发_(:3=)_
    [header setImages:refreshingImages forState:MJRefreshStateRefreshing];
    [header setTitle:@"I am loading _(:3=)_" forState:MJRefreshStateRefreshing];
    
//    change text
//    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
//    [header setTitle:@"I am loading =w=" forState:MJRefreshStateRefreshing];
//    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
//    [self.tableView.mj_header beginRefreshing];
}


-(void)refresh{
    NSLog(@"I am refreshing");
    
//    [self.tableView.mj_header endRefreshing];
}
-(void)loadMore{
    NSLog(@"I am loading more data");
}

-(void)loadNewData{
    NSLog(@"Cust");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = @"=w=";
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

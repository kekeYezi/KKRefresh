//
//  KKViewController.m
//  KKRefresh
//
//  Created by Daniel on 04/21/2018.
//  Copyright (c) 2018 Daniel. All rights reserved.
//

#import "KKViewController.h"
#import "KKRefreshView.h"

@interface KKViewController () <UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) KKRefreshView *demoRefreshView;

@end

@implementation KKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.view addSubview:self.demoRefreshView];
    
    UIImage *image = [[UIImage imageNamed:@"xx"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *stockQueryButton = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(findStock)];
    stockQueryButton.accessibilityLabel = @"zero";
    if (stockQueryButton){
        [self.navigationItem setRightBarButtonItem:stockQueryButton];
    }
    
    NSMutableArray *tmpAry = [NSMutableArray array];
    for (int i = 0; i < 100; i ++) {
        [tmpAry addObject:@"1"];
    }
    [self.demoRefreshView kk_refreshTableViewWithData:tmpAry totalCount:100];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)findStock {
    [self.demoRefreshView.totalDataAry removeAllObjects];
    [self.demoRefreshView kk_refreshTableViewWithData:@[] totalCount:100];
}

- (KKRefreshView *)demoRefreshView {
    if (!_demoRefreshView) {
        _demoRefreshView = [[KKRefreshView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height - 40) KKstyle:UITableViewStylePlain];
//        _demoRefreshView.backgroundColor = UIColorFromRGB(0xf6f6f6);
        _demoRefreshView.refreshTableView.delegate = self;
        _demoRefreshView.refreshTableView.dataSource = self;
        _demoRefreshView.refreshTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _demoRefreshView.refreshTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        // 下拉刷新
        [_demoRefreshView kk_setRefreshHeader:^{
            NSLog(@"update");
            NSMutableArray *tmpAry = [NSMutableArray array];
            for (int i = 0; i < 100; i ++) {
                [tmpAry addObject:@"1"];
            }
            [self.demoRefreshView kk_refreshTableViewWithData:tmpAry totalCount:100];
        }];
        
        [_demoRefreshView kk_setFreshImage:[UIImage imageNamed:@"KKRefresh.bundle/logo"]];
    }
    return _demoRefreshView;
}

#pragma mark - TableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.demoRefreshView.totalDataAry.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"GJCommonCardUnreceivedCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.textLabel.text = @"1";
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

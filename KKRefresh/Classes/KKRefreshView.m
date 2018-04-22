//
//  KKRefreshView.m
//  KKRefresh
//
//  Created by keke on 2018/4/21.
//

#import "KKRefreshView.h"
#import "KKGifHeader.h"

@interface KKRefreshView() <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate> {
    BOOL loading;
}

@property (nonatomic, strong) KKDIYHeader *header;

@end

@implementation KKRefreshView

- (instancetype)init {
    if (self = [super init]){
        [self initAllWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame KKstyle:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame]){
        [self initAllWithFrame:frame style:style];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]){
        [self initAllWithFrame:frame style:UITableViewStylePlain];
    }
    return self;
}

- (void)initAllWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self.totalDataAry = [NSMutableArray array];
    self.currentPage = 0;
    self.refreshTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:style];
    self.refreshTableView.backgroundColor = [UIColor clearColor];
    self.refreshTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self insetAdjustment];
    [self addSubview:self.refreshTableView];
    self.refreshTableView.emptyDataSetSource = self;
    self.refreshTableView.emptyDataSetDelegate = self;
    self.refreshTableView.tableFooterView = [UIView new];
    self.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00];
}

- (void)insetAdjustment {
#ifdef __IPHONE_11_0
    if (@available(iOS 11.0, *)) {
        self.refreshTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.refreshTableView.estimatedRowHeight = 0;
        self.refreshTableView.estimatedSectionHeaderHeight = 0;
        self.refreshTableView.estimatedSectionFooterHeight = 0;
    } else {
        // Fallback on earlier versions
    }
#endif
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"暂无数据";
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName: [UIColor grayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView {
    if (loading) {
        return nil;
    }else{
        //加入你自定义的view
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [activityView startAnimating];
        return activityView;
    }
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    [self kk_beginFresh];
}

- (void)kk_setRefreshHeader:(dispatch_block_t)block {
    //    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    //    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    //        if (block) {
    //            block();
    //        }
    //    }];
    //
    //    // 设置自动切换透明度(在导航栏下面自动隐藏)
    //    header.automaticallyChangeAlpha = YES;
    //
    //    // 隐藏时间
    //    header.lastUpdatedTimeLabel.hidden = YES;
    //
    //    self.refreshTableView.mj_header = header;
    
    self.header = [KKDIYHeader headerWithRefreshingBlock:^{
        if (block) {
            block();
        }
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.header.automaticallyChangeAlpha = YES;
    //    // 隐藏时间
    //    header.lastUpdatedTimeLabel.hidden = YES;
    self.refreshTableView.mj_header = self.header;
}

- (void)kk_setFreshImage:(UIImage *)image {
    self.header.freshingImageView.image = image;
    self.header.freshView.circleImage = image;
}

- (void)kk_setDIYRefreshHeader:(dispatch_block_t)block {
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    KKDIYHeader *header = [KKDIYHeader headerWithRefreshingBlock:^{
        if (block) {
            block();
        }
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    
    //    // 隐藏时间
    //    header.lastUpdatedTimeLabel.hidden = YES;
    self.refreshTableView.mj_header = header;
    
}

- (void)kk_setAnimationMJrefreshHeader:(dispatch_block_t)block {
    KKGifHeader *header = [KKGifHeader headerWithRefreshingBlock:^{
        if (block) {
            block();
        }
    }];
    //    header.lastUpdatedTimeLabel.hidden = YES;
    self.refreshTableView.mj_header = header;
}

- (void)kk_setRefreshFooter:(dispatch_block_t)block {
    self.refreshTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (block) {
            block();
        }
    }];
    // 设置了底部inset
    self.refreshTableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    self.refreshTableView.mj_footer.automaticallyHidden = YES;
    [self.refreshTableView.mj_footer.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj class] == [UILabel class]) {
            [(UILabel *)obj setTextColor:[UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1]];
            [(UILabel *)obj setFont:[UIFont systemFontOfSize:14]];
        }
    }];
    
    // 忽略掉底部inset
    //    self.refreshTableView.mj_footer.ignoredScrollViewContentInsetBottom = -30;
    
}

- (void)kk_refreshTableViewWithData:(NSArray *)dataAry totalCount:(NSInteger)totalCount {
    self.totalCount = totalCount;
    
    if (self.currentPage == 0) {
        [self.totalDataAry removeAllObjects];
    }
    
    [dataAry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.totalDataAry addObject:obj];
    }];
    
    [self kk_freshEndAction];
}

- (void)kk_endHeaderRefresh {
    [self.refreshTableView.mj_header endRefreshing];
}

- (void)kk_endFooterRefresh {
    [self.refreshTableView.mj_footer endRefreshing];
}

- (void)kk_beginFresh {
    [self.refreshTableView.mj_header beginRefreshing];
}

- (void)kk_endRefresh{
    [self kk_endHeaderRefresh];
    [self kk_endFooterRefresh];
}

- (void)kk_showFooterView{
    //    [self.refreshTableView.mj_footer endRefreshingWithNoMoreData];
    self.refreshTableView.mj_footer.hidden = NO;
}

- (void)kk_hidenFooterView{
    [self.refreshTableView.mj_footer endRefreshingWithNoMoreData];
    self.refreshTableView.mj_footer.hidden = YES;
}

- (void)kk_freshEndAction{
    self.currentPage ++;
//    if (self.currentPage == self.totalPage) {
//        [self hidenFooterView];
//    }else{
//        [self showFooterView];
//    }
    
    [self kk_endRefresh];
    [self.refreshTableView reloadData];
    
    if (self.totalDataAry.count >= self.totalCount || self.totalDataAry.count == 0) {
        [self kk_hidenFooterView];
    }else{
        [self kk_showFooterView];
    }
    loading = YES;
    [self.refreshTableView reloadEmptyDataSet];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

@interface KKCollectionView()

@end

@implementation KKCollectionView

//- (void)setRefreshHeader:(dispatch_block_t)block{
//    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
//    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        if (block) {
//            block();
//        }
//    }];
//
//    // 设置自动切换透明度(在导航栏下面自动隐藏)
//    header.automaticallyChangeAlpha = YES;
//
//    // 隐藏时间
//    header.lastUpdatedTimeLabel.hidden = YES;
//
//    self.mj_header = header;
//}

- (void)kk_setRefreshHeader:(dispatch_block_t)block{
    KKDIYHeader *header = [KKDIYHeader headerWithRefreshingBlock:^{
        if (block) {
            block();
        }
    }];
    
    header.automaticallyChangeAlpha = YES;// 设置自动切换透明度(在导航栏下面自动隐藏)
    //    header.lastUpdatedTimeLabel.hidden = YES;// 隐藏时间
    self.mj_header = header;
}

- (void)kk_setAnimationMJrefreshHeader:(dispatch_block_t)block{
    KKGifHeader *header = [KKGifHeader headerWithRefreshingBlock:^{
        if (block) {
            block();
        }
    }];
    //    header.lastUpdatedTimeLabel.hidden = YES;
    self.mj_header = header;
}

- (void)kk_setDIYRefreshHeader:(dispatch_block_t)block {
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    KKDIYHeader *header = [KKDIYHeader headerWithRefreshingBlock:^{
        if (block) {
            block();
        }
    }];
    
    header.automaticallyChangeAlpha = YES;// 设置自动切换透明度(在导航栏下面自动隐藏)
    //    header.lastUpdatedTimeLabel.hidden = YES;    // 隐藏时间
    self.mj_header = header;
}

- (void)kk_setRefreshFooter:(dispatch_block_t)block {
    self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (block) {
            block();
        }
    }];
    
    self.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);// 设置了底部inset
    self.mj_footer.automaticallyHidden = YES;
    [self.mj_footer.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj class] == [UILabel class]) {
            [(UILabel *)obj setTextColor:[UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1]];
            [(UILabel *)obj setFont:[UIFont systemFontOfSize:14]];
        }
    }];
    // 忽略掉底部inset
    //    self.refreshTableView.mj_footer.ignoredScrollViewContentInsetBottom = -30;
}

- (void)kk_endHeaderRefresh {
    [self.mj_header endRefreshing];
}

- (void)kk_endFooterRefresh {
    [self.mj_footer endRefreshing];
}

- (void)kk_beginFresh {
    [self.mj_header beginRefreshing];
}

- (void)kk_endRefresh {
    [self kk_endHeaderRefresh];
    [self kk_endFooterRefresh];
}

- (void)kk_showFooterView {
    //    [self.refreshTableView.mj_footer endRefreshingWithNoMoreData];
    self.mj_footer.hidden = NO;
}

- (void)kk_hidenFooterView {
    [self.mj_footer endRefreshingWithNoMoreData];
    self.mj_footer.hidden = YES;
}

@end

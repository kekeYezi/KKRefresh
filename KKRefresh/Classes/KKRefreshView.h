//
//  KKRefreshView.h
//  KKRefresh
//
//  Created by keke on 2018/4/21.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "KKDIYHeader.h"
#import "UIScrollView+EmptyDataSet.h"

typedef void (^KKRefreshViewDidSelectBlock)(UITableView *tableview,NSIndexPath *index);

@interface KKRefreshView : UIView

/**
 *  当前页数  默认从0开始
 */
@property(nonatomic,assign) NSInteger currentPage;

/**
 *  总页数
 */
@property(nonatomic,assign) NSInteger totalPage;

/**
 *  总数据量
 */
@property(nonatomic,assign) NSInteger totalCount;

/**
 *  主tableview
 */
@property (nonatomic,strong) UITableView *refreshTableView;

/**
 *  数据源
 */
@property (nonatomic,strong) NSMutableArray *totalDataAry;

/**
 初始化方法 指定类型
 
 @param frame frame
 @param style style
 
 */
-(instancetype)initWithFrame:(CGRect)frame KKstyle:(UITableViewStyle)style;

/**
 *  点击事件的抛出
 */
@property (nonatomic, copy) KKRefreshViewDidSelectBlock didSelectBlock;

/**
 *  //!!!: 根据接口返回的数据进行刷新,显示是否加载完成等逻辑，必须实现，
 并且要把需要加载的数据填充完再调用
 *
 *  @param dataAry    装载数据的数组
 *  @param totalCount 总数量
 */
- (void)kk_refreshTableViewWithData:(NSArray *)dataAry totalCount:(NSInteger)totalCount;

/**
 *  普通的下拉刷新
 *
 */
- (void)kk_setRefreshHeader:(dispatch_block_t)block;

/**
 *  自定义view 作为下拉刷新
 *
 */
- (void)kk_setDIYRefreshHeader:(dispatch_block_t)block;

/**
 *  带gif动画的下拉刷新
 */
- (void)kk_setAnimationMJrefreshHeader:(dispatch_block_t)block;

/**
 * 上拉加载
 */
- (void)kk_setRefreshFooter:(dispatch_block_t)block;

/**
 *  结束上拉和上拉
 */
- (void)kk_endRefresh;

/**
 *  //!!!: 结束请求的时候调用
 */
- (void)kk_freshEndAction;

/**
 *  //!!!: 开启下拉刷新功能
 */
- (void)kk_beginFresh;

- (void)kk_setFreshImage:(UIImage *)image;

@end

@interface KKCollectionView : UICollectionView

/**
 *  普通的下拉刷新
 *
 */
- (void)kk_setRefreshHeader:(dispatch_block_t)block;

/**
 *  自定义view 作为下拉刷新
 *
 */
- (void)kk_setDIYRefreshHeader:(dispatch_block_t)block;

/**
 *  带gif动画的下拉刷新
 */
- (void)kk_setAnimationMJrefreshHeader:(dispatch_block_t)block;

/**
 * 上拉加载
 */
- (void)kk_setRefreshFooter:(dispatch_block_t)block;

/**
 *  结束上拉和上拉
 */
- (void)kk_endRefresh;

/**
 *  //!!!: 开启下拉刷新功能
 */
- (void)kk_beginFresh;

@end

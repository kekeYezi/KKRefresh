//
//  KKDIYHeader.m
//  DZNEmptyDataSet
//
//  Created by keke on 2018/4/21.
//

#import "KKDIYHeader.h"
#import "KKRefreshingView.h"

#define KKRefresh_isPad       (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define KKRefresh_ScreenH     ([[UIScreen mainScreen]bounds].size.height)
#define KKRefresh_ScreenW     ([[UIScreen mainScreen]bounds].size.width)
#define KKRefresh_SCREEN_RATIO_CEIL(a)  (ceil((((int)KKRefresh_ScreenW == 320 || KKRefresh_isPad) ? (320.0 / 375) : (((int)KKRefresh_ScreenW == 375) ? 1.0 : (414.0 / 375))) * (a) ))//向上取整

@interface KKDIYHeader()

@property (strong, nonatomic) UILabel *descLabel;

@property (assign, nonatomic) BOOL isLoaded; //是否已经 完成了下拉刷新

@end

@implementation KKDIYHeader
- (void)prepare {
    [super prepare];
    
    // 设置控件的高度
    self.mj_h =70;
    
    self.freshView = [[CircleView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.freshView.center = CGPointMake(KKRefresh_ScreenW/2 - KKRefresh_SCREEN_RATIO_CEIL(60), 40);
    self.freshView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.freshView];
    
    self.freshingView = [[KKRefreshingView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.freshingView.center = CGPointMake(KKRefresh_ScreenW/2 - KKRefresh_SCREEN_RATIO_CEIL(60), 40);
    self.freshingView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.freshingView];
    
    self.freshingImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"KKRefresh.bundle/logo"]];
    self.freshingImageView.frame = CGRectMake(0, 0, 20, 20);
    self.freshingImageView.center = CGPointMake(KKRefresh_ScreenW/2 - KKRefresh_SCREEN_RATIO_CEIL(60) + 2, 40 + 2);
    [self addSubview:self.freshingImageView];
    
    self.descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    self.descLabel.center = CGPointMake(KKRefresh_ScreenW/2 + 77, 40);
    self.descLabel.text = @"下拉即可刷新...";
    self.descLabel.textColor = [UIColor grayColor];
    self.descLabel.font = [UIFont systemFontOfSize:14];
    
    [self addSubview:self.descLabel];
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews {
    [super placeSubviews];
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change {
    [super scrollViewContentSizeDidChange:change];
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change {
    [super scrollViewPanStateDidChange:change];
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state {
    MJRefreshCheckState;
    switch (state) {
            case MJRefreshStateIdle:{
                if (self.isLoaded) { //刷新完成后
                    self.descLabel.text = @"加载完成";
                    self.isLoaded = NO;
                    self.freshView.hidden = YES;
                    self.freshingView.hidden = YES;
                    self.freshingImageView.hidden = YES;
                    [self.freshingView kk_removeCircle];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        self.descLabel.text = @"下拉即可刷新...";
                        self.freshView.hidden = NO;
                        self.freshingView.hidden = YES;
                        self.freshingImageView.hidden = YES;
                        [self.freshingView kk_removeCircle];
                    });
                } else {
                    self.descLabel.text = @"下拉即可刷新...";
                    self.freshView.hidden = NO;
                    self.freshingView.hidden = YES;
                    self.freshingImageView.hidden = YES;
                    [self.freshingView kk_removeCircle];
                }
                break;
            }
            case MJRefreshStatePulling:
            self.descLabel.text = @"释放即可刷新...";
            self.freshView.hidden = NO;
            self.freshingView.hidden = YES;
            self.freshingImageView.hidden = YES;
            [self.freshingView kk_removeCircle];
            break;
            case MJRefreshStateRefreshing:
            self.descLabel.text = @"加载中...";
            self.freshView.hidden = YES;
            self.freshingView.hidden = NO;
            self.freshingImageView.hidden = NO;
            [self.freshingView kk_startCircle];
            self.isLoaded = YES;
            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent {
    [super setPullingPercent:pullingPercent];
    
    if (pullingPercent < 0) {
        pullingPercent = 0;
    }else if (pullingPercent > 1){
        pullingPercent = 1;
    }
    _freshView.ratio = pullingPercent;
    [_freshView setNeedsDisplay];
}

@end

@implementation CircleView

- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.69 green:0.76 blue:0.83 alpha:1.00].CGColor);
    CGContextAddArc(context, 25, 25, 13, -M_PI_2, -M_PI_2 + (M_PI * 2  - M_PI_4 / 2)* _ratio, 0);
    CGContextDrawPath(context, kCGPathStroke);
    CGContextStrokePath(context);
    
    UIImage *img = self.circleImage;
    [img drawInRect:CGRectMake(25 - 8, 25 - 8, img.size.width, img.size.height)];
}

- (UIImage *)circleImage {
    if (!_circleImage) {
        _circleImage = [UIImage imageNamed:@"KKRefresh.bundle/logo.png"];
    }
    return _circleImage;
}

@end

//
//  KKDIYHeader.h
//  DZNEmptyDataSet
//
//  Created by keke on 2018/4/21.
//

#import "MJRefresh.h"

@class CircleView,KKRefreshingView;
@interface KKDIYHeader : MJRefreshHeader

@property (strong, nonatomic) CircleView *freshView;

@property (strong, nonatomic) KKRefreshingView *freshingView;

@property (strong, nonatomic) UIImageView *freshingImageView;

@end

@interface CircleView : UIView

@property CGFloat ratio;

@property (strong, nonatomic) UIImage *circleImage;

@end

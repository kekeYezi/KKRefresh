//
//  KKRefreshingView.h
//  DZNEmptyDataSet
//
//  Created by keke on 2018/4/21.
//

#import <UIKit/UIKit.h>

@interface KKRefreshingView : UIView

@property (nonatomic, assign) BOOL circleLineColorWhite;

- (void)kk_startCircle;

- (void)kk_removeCircle;

@end

//
//  CFBarrageView.h
//  CFBarrage
//
//  Created by cf on 2017/12/16.
//  Copyright © 2017年 chenfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,CFBarrageViewDisplayMode)
{
    CFBarrageViewDisplayModeWithDefault = 0,
    CFBarrageViewDisplayModeWithTop,
    CFBarrageViewDisplayModeWithMiddle,
    CFBarrageViewDisplayModeWithBottom,
};

@protocol CFBarrageViewDelegate  <NSObject>

@optional

- (void)barrageViewDidselectTextlabel:(UILabel *)label;

@end

@interface CFBarrageView : UIView

@property (nonatomic, assign) NSInteger animationTimeInterval;//时间波动范围，默认为0
@property (nonatomic, weak) id<CFBarrageViewDelegate> delegate;
@property (nonatomic, assign) CFBarrageViewDisplayMode displayMode;

- (void)sendBarrage:(NSArray *)array;

@end

//
//  CFBarrageView.m
//  CFBarrage
//
//  Created by cf on 2017/12/16.
//  Copyright © 2017年 chenfeng. All rights reserved.
//

#import "CFBarrageView.h"
#import "UIView+Frame.h"

@interface CFBarrageView ()

@end

@implementation CFBarrageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        _displayMode = CFBarrageViewDisplayModeWithDefault;
    }
    return self;
}

//由于uiivew animation动画使得label在移动过程中无法响应， 所以用touch捕获移动过程中label的触摸事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = touches.anyObject;//获取触摸对象
    CGPoint point = [touch  locationInView:self];
    NSArray *subViews = self.subviews;
    for(UIView *subView in subViews){
        if([subView isKindOfClass:[UILabel class]]){ //是要找的label
            CALayer *layer = subView.layer.presentationLayer; //显示层
            if(CGRectContainsPoint(layer.frame, point)){ //触摸点在显示层中，返回label
                
                if ([self.delegate respondsToSelector:@selector(barrageViewDidselectTextlabel:)]) {
                    
                    UILabel *label = (UILabel *)subView;
                    NSLog(@"tag = %ld",label.tag);
                    [self.delegate barrageViewDidselectTextlabel:label];
                    
                }
            }
        }
    }
}

- (void)sendBarrage:(NSArray *)array
{
    if (array == nil) {
        return;
    }
    //[_barrageTexts removeAllObjects];
    
    for (int i = 0; i < [array count]; i++) {
        
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.textColor = [UIColor darkTextColor];
        textLabel.font = [UIFont systemFontOfSize:16];
        textLabel.tag = i+ 100;
        textLabel.text = array[i];
        
        //计算宽高
        CGSize size = [textLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16],NSFontAttributeName, nil]];
        textLabel.bounds = CGRectMake(0, 0, size.width, size.height);

        NSInteger height = self.height -  textLabel.height;
        
        if (_displayMode != CFBarrageViewDisplayModeWithDefault) {
            height = self.height/3 -  textLabel.height;
        }
        
        NSInteger width = self.width - textLabel.width;
        
        //生成随机坐标
        CGFloat x = self.width + arc4random()%width;
        
        CGFloat y = arc4random()%height;
        
        if (_displayMode == CFBarrageViewDisplayModeWithTop) {
        }
        else if (_displayMode == CFBarrageViewDisplayModeWithMiddle)
        {
            y = y + self.height/3;
        }
        else if (_displayMode == CFBarrageViewDisplayModeWithBottom)
        {
            y = y + (self.height/3) * 2;
        }
        
        textLabel.frame = CGRectMake(x, y, size.width, size.height);
        
        if (textLabel.width > self.width) {
            textLabel.width = self.width;
        }
        [self addSubview:textLabel];
        
        [self performingAnimation:textLabel];
        
    }
    
}

- (void)performingAnimation:(UILabel *)label
{
    NSInteger time = 4;
    
    __block UILabel *b_label = label;
    
    if (_animationTimeInterval >= 0) {
       time =  4 + random() % _animationTimeInterval;
    }
    
    //平移动画从左到右
    [UIView animateWithDuration:time animations:^{
        
        b_label.x = 0 - b_label.frame.size.width * 1.5;
        
        } completion:^(BOOL finished) {
            //移除
            [b_label removeFromSuperview];
            b_label = nil;
    }];
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

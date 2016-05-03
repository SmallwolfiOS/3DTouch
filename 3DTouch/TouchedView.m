//
//  TouchedView.m
//  3DTouch
//
//  Created by Jason on 16/4/29.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "TouchedView.h"

@implementation TouchedView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [touches anyObject];
    NSLog(@"%f",touch.force);
    self.backgroundColor = [UIColor colorWithRed:(touch.force / touch.maximumPossibleForce )green:0 blue:1 alpha:1];
    if (touch.force == touch.maximumPossibleForce)
    {
        //20/3
        NSLog(@"最大值：%f",touch.maximumPossibleForce);
//        NSLog(@"%f",touch.force);
    }
    
    
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.backgroundColor = [UIColor yellowColor];
}


@end

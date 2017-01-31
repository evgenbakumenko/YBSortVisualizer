//
//  YBSortVisualizationView.m
//  YBSortVisualizer
//
//  Created by Evgen Bakumenko on 1/30/17.
//  Copyright © 2017 Evgen Bakumenko. All rights reserved.
//

#import "YBSortVisualizationView.h"
#import "YBCircleView.h"

#define kCircleRadius 35
#define kSwapAnimationDuration 1.0

@interface YBSortVisualizationView()

@property (assign) NSUInteger maxElement;
@property (nonatomic, strong) dispatch_queue_t serialQueue;
@property (nonatomic, strong) dispatch_group_t animationsGroup;
@property (nonatomic, copy) NSMutableArray *elementViews;

@end

@implementation YBSortVisualizationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)reloadWithData:(NSArray *)unsortedData{
    for (UIView *subview in [self subviews]) {
        [subview removeFromSuperview];
    }
    
    _maxElement = [[unsortedData valueForKeyPath:@"@max.intValue"] intValue];
    
    for (int index = 0; index < unsortedData.count; index++){
        [self addElementWithValue:unsortedData[index] atIndex:index];
    }
}

- (void)addElementWithValue:(NSNumber *)value atIndex:(NSInteger)index{
    float valueRatio = [value floatValue]/_maxElement;
    YBCircleView *elementView = [[YBCircleView alloc] initWithFrame:CGRectMake((index * (kCircleRadius + 20)), kCircleRadius, kCircleRadius , kCircleRadius ) value:[value integerValue]];
    elementView.tag = (index + 1);
    [self addSubview:elementView];
}

- (void)swapElementAtIndex:(NSInteger)fromIndex withElementAtIndex:(NSInteger)toIndex{
    if (!_serialQueue) {
        _serialQueue = dispatch_queue_create("com.example.serialQueue", 0);
    }
    
    if (!_animationsGroup){
        _animationsGroup = dispatch_group_create();
    }
    
    dispatch_async(_serialQueue, ^{
        dispatch_group_enter(_animationsGroup);
        
        YBCircleView *fromElement = (YBCircleView *)[self viewWithTag:(fromIndex + 1)];
        YBCircleView *toElement = (YBCircleView *)[self viewWithTag:(toIndex + 1)];
        
        CGRect fromElementFrame = fromElement.frame;
        CGRect toElementFrame = toElement.frame;

        
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:kSwapAnimationDuration animations:^{
                [fromElement setFrame:toElementFrame];
                [toElement setFrame:fromElementFrame];
                fromElement.tag = (toIndex + 1);
                toElement.tag = (fromIndex + 1);
            } completion:^(BOOL finished) {
                dispatch_group_leave(_animationsGroup);
            }];

        });
    
        dispatch_group_wait(_animationsGroup, DISPATCH_TIME_FOREVER);
    });
    
}

@end

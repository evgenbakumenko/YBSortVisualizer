//
//  YBSortVisualizationView.m
//  YBSortVisualizer
//
//  Created by Evgen Bakumenko on 1/30/17.
//  Copyright © 2017 Evgen Bakumenko. All rights reserved.
//

#import "YBSortVisualizationView.h"
#import "YBCircleView.h"
#import "YBIndexIndicatorView.h"

static NSInteger kCircleRadius = 35;
static NSInteger kIndexIndicatorViewHeight = 35;
static NSInteger kAnimationDuration = 1.0;

@interface YBSortVisualizationView()

@property (assign) NSUInteger maxElement;
@property (assign) NSUInteger minElement;
@property (nonatomic, strong) dispatch_queue_t serialQueue;
@property (nonatomic, strong) dispatch_group_t animationsGroup;
@property (nonatomic, strong) YBIndexIndicatorView *indexOfIView;
@property (nonatomic, strong) YBIndexIndicatorView *indexOfJView;
@property (nonatomic, strong) YBIndexIndicatorView *indexOfKView;

@end

@implementation YBSortVisualizationView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIBezierPath *border = [UIBezierPath bezierPathWithRect:rect];
    [UIColor.blackColor setStroke];
    [border setLineWidth:1.0];
    [border stroke];
}

- (void)reloadWithData:(NSArray *)unsortedData{
    for (UIView *subview in [self subviews]) {
        [subview removeFromSuperview];
    }
    
    if (unsortedData.count > 0) {
        _maxElement = [[unsortedData valueForKeyPath:@"@max.intValue"] intValue];
        _minElement = [[unsortedData valueForKeyPath:@"@min.intValue"] intValue];
        
        //add unsorted elements
        for (int index = 0; index < unsortedData.count; index++){
            [self addElementWithValue:unsortedData[index] atIndex:index];
        }
        
        if (![_indexOfIView superview] && ![_indexOfJView superview] && ![_indexOfKView superview]) {
            [self addIndexesIndicatorsViews];
        }
    }
}

- (void)addElementWithValue:(NSNumber *)value atIndex:(NSInteger)index{
    float valueRatio = (_maxElement != _minElement) ? (([value floatValue] - _minElement)/(_maxElement - _minElement)) : 1;
    YBCircleView *elementView = [[YBCircleView alloc] initWithFrame:CGRectMake(kCircleRadius/2 + (index * (kCircleRadius)), self.frame.size.height/2 - kCircleRadius, kCircleRadius, kCircleRadius) value:[value integerValue] ratio:valueRatio];
    elementView.tag = (index + 1);
    [self addSubview:elementView];
}

- (void)addIndexesIndicatorsViews {
    _indexOfIView = [[YBIndexIndicatorView alloc] initWithFrame:CGRectMake(0, self.frame.size.height/2 , kIndexIndicatorViewHeight, kIndexIndicatorViewHeight) indexIdicatorString:@"i"];
    [self addSubview:_indexOfIView];
    
    _indexOfJView = [[YBIndexIndicatorView alloc] initWithFrame:CGRectMake(0, self.frame.size.height/2  + kIndexIndicatorViewHeight, kIndexIndicatorViewHeight, kIndexIndicatorViewHeight) indexIdicatorString:@"j"];
    [self addSubview:_indexOfJView];
    
    _indexOfKView = [[YBIndexIndicatorView alloc] initWithFrame:CGRectMake(0, self.frame.size.height/2  + kIndexIndicatorViewHeight * 2, kIndexIndicatorViewHeight, kIndexIndicatorViewHeight) indexIdicatorString:@"k"];
    [self addSubview:_indexOfKView];
}

- (void)swapElementWithSortStep:(YBShellSortStep *)step{
    if (!_serialQueue) {
        _serialQueue = dispatch_queue_create("com.example.serialQueue", 0);
    }
    
    if (!_animationsGroup){
        _animationsGroup = dispatch_group_create();
    }
    
    dispatch_async(_serialQueue, ^{
        dispatch_group_enter(_animationsGroup);
        //get new centers for swaped elements
        YBCircleView *fromElement = (YBCircleView *)[self viewWithTag:(step.exchangeFromIndex + 1)];
        YBCircleView *toElement = (YBCircleView *)[self viewWithTag:(step.exchangeToIndex + 1)];
        
        CGPoint fromElementCenter = fromElement.center;
        CGPoint toElementCenter = toElement.center;
     
        //get new centers for indexes indicators view
        YBCircleView *iElement = (YBCircleView *)[self viewWithTag:(step.indexOfI + 1)];
        YBCircleView *jElement = (YBCircleView *)[self viewWithTag:(step.indexOfJ + 1)];
        YBCircleView *kElement = (YBCircleView *)[self viewWithTag:(step.indexOfK + 1)];
        
        CGPoint indexOfJViewNewCenter = CGPointMake(jElement.center.x, _indexOfJView.center.y);
        CGPoint indexOfIViewNewCenter = CGPointMake(iElement.center.x, _indexOfIView.center.y);
        CGPoint indexOfKViewNewCenter = CGPointMake(kElement.center.x, _indexOfKView.center.y);

        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:kAnimationDuration animations:^{
                //update indexs indicators position
                [_indexOfJView setCenter:indexOfJViewNewCenter];
                [_indexOfIView setCenter:indexOfIViewNewCenter];
                [_indexOfKView setCenter:indexOfKViewNewCenter];
                
                fromElement.tag = (step.exchangeToIndex + 1);
                toElement.tag = (step.exchangeFromIndex + 1);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:kAnimationDuration animations:^{
                    //swap elements
                    [fromElement setCenter:toElementCenter];
                    [toElement setCenter:fromElementCenter];
                } completion:^(BOOL finished) {
                     dispatch_group_leave(_animationsGroup);
                }];
            }];
        });
    
        dispatch_group_wait(_animationsGroup, DISPATCH_TIME_FOREVER);
    });
    
}

@end

//
//  YBSortVisualizationView.m
//  YBSortVisualizer
//
//  Created by Evgen Bakumenko on 1/30/17.
//  Copyright © 2017 Evgen Bakumenko. All rights reserved.
//

#import "YBSortVisualizationView.h"
#import "YBCircleView.h"

#define kCircleRadius 70

@interface YBSortVisualizationView()

@property (assign) NSUInteger maxElement;

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
    
    for (NSNumber *value in unsortedData) {
        [self addElementWithValue:value atIndex:[unsortedData indexOfObject:value]];
    }
}

- (void)addElementWithValue:(NSNumber *)value atIndex:(NSInteger)index{
    float valueRatio = [value floatValue]/_maxElement;
    YBCircleView *elementView = [[YBCircleView alloc] initWithFrame:CGRectMake(index * kCircleRadius + 5, kCircleRadius, kCircleRadius * valueRatio, kCircleRadius * valueRatio)];
    [self addSubview:elementView];
}

@end

//
//  YBSortVisualizationView.h
//  YBSortVisualizer
//
//  Created by Evgen Bakumenko on 1/30/17.
//  Copyright © 2017 Evgen Bakumenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBShellSortStep.h"

static NSInteger kMaxValuesInUnsortedArray =  9;

@interface YBSortVisualizationView : UIView

- (void)reloadWithData:(NSArray *)unsortedData;
- (void)swapElementWithSortStep:(YBShellSortStep *)step;

@end

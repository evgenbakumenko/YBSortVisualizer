//
//  YBSortVisualizationView.h
//  YBSortVisualizer
//
//  Created by Evgen Bakumenko on 1/30/17.
//  Copyright © 2017 Evgen Bakumenko. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMaxValuesInUnsortedArray 10

@interface YBSortVisualizationView : UIView

- (void)reloadWithData:(NSArray *)unsortedData;
- (void)swapElementAtIndex:(NSInteger)firstIndex withElementAtIndex:(NSInteger)secondIndex;

@end

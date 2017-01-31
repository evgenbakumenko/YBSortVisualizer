//
//  YBShellSortStep.h
//  YBSortVisualizer
//
//  Created by Evgen Bakumenko on 1/31/17.
//  Copyright © 2017 Evgen Bakumenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YBShellSortStep : NSObject

@property (nonatomic, assign, readonly) NSInteger indexOfI;
@property (nonatomic, assign, readonly) NSInteger indexOfJ;
@property (nonatomic, assign, readonly) NSInteger indexOfK;
@property (nonatomic, assign, readonly) NSInteger exchangeFromIndex;
@property (nonatomic, assign, readonly) NSInteger exchangeToIndex;

- (id)initWithIndexOfI:(NSInteger)indexOfI
                indexOfJ:(NSInteger)indexOfJ
                indexOfK:(NSInteger)indexOfK;
- (void)setExchangeFromIndex:(NSInteger)exchangeFromIndex andExchangeToIndex:(NSInteger)exchangeToIndex;


@end

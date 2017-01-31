//
//  YBShellSortStep.m
//  YBSortVisualizer
//
//  Created by Evgen Bakumenko on 1/31/17.
//  Copyright © 2017 Evgen Bakumenko. All rights reserved.
//

#import "YBShellSortStep.h"

@implementation YBShellSortStep

- (id)initWithIndexOfI:(NSInteger)indexOfI
                indexOfJ:(NSInteger)indexOfJ
                indexOfK:(NSInteger)indexOfK{
    if (self = [super init]){
        _indexOfI = indexOfI;
        _indexOfJ = indexOfJ;
        _indexOfK = indexOfK;
    }
    return self;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"Shell sort step: i = %ld, j = %ld, k = %ld. \nExchange from index: %ld to index: %ld", _indexOfI, _indexOfJ, _indexOfK, _exchangeFromIndex, _exchangeToIndex];
}

#pragma mark - Exchange indexes

- (void)setExchangeFromIndex:(NSInteger)exchangeFromIndex andExchangeToIndex:(NSInteger)exchangeToIndex
{
    _exchangeFromIndex = exchangeFromIndex;
    _exchangeToIndex = exchangeToIndex;
}

@end

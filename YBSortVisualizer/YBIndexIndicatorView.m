//
//  YBIndexIndicatorView.m
//  YBSortVisualizer
//
//  Created by Evgen Bakumenko on 1/31/17.
//  Copyright © 2017 Evgen Bakumenko. All rights reserved.
//

#import "YBIndexIndicatorView.h"

@interface YBIndexIndicatorView()

@property (nonatomic, copy) NSString *indexIndicator;

@end

@implementation YBIndexIndicatorView

- (id)initWithFrame:(CGRect)frame indexIdicatorString:(NSString *)indexIndicator{
    if (self = [super initWithFrame:frame]) {
        _indexIndicator = [indexIndicator copy];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    [self setBackgroundColor:UIColor.clearColor];
}

- (void)drawRect:(CGRect)rect{
    //adding label with value
    UIFont* font = [UIFont boldSystemFontOfSize:12];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setAlignment:NSTextAlignmentCenter];
    
    NSDictionary* stringAttrs = @{ NSFontAttributeName : font, NSForegroundColorAttributeName : UIColor.blackColor, NSParagraphStyleAttributeName : paragraphStyle};
    
    NSAttributedString* attrStr = [[NSAttributedString alloc] initWithString:_indexIndicator attributes:stringAttrs];
    
    [attrStr drawWithRect:rect options:NSStringDrawingUsesLineFragmentOrigin context:NULL];

}

@end

//
//  YBCircleView.m
//  YBSortVisualizer
//
//  Created by Evgen Bakumenko on 1/30/17.
//  Copyright © 2017 Evgen Bakumenko. All rights reserved.
//

#import "YBCircleView.h"

@interface YBCircleView()

@property (assign) NSInteger value;

@end

@implementation YBCircleView

#pragma mark - Init

- (id)initWithFrame:(CGRect)frame value:(NSInteger)value{
    if (self = [super initWithFrame:frame]){
        _value = value;
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [self setBackgroundColor:UIColor.clearColor];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(context, rect);
    CGContextSetFillColor(context, CGColorGetComponents([[UIColor colorWithRed:92.0/255.0 green:125.0/255.0	blue:158.0/255.0 alpha:1.0] CGColor]));
    CGContextFillPath(context);
    
    UIFont* font = [UIFont boldSystemFontOfSize:12];
    
    NSDictionary* stringAttrs = @{ NSFontAttributeName : font, NSForegroundColorAttributeName : UIColor.whiteColor};
    
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld", _value] attributes:stringAttrs];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setAlignment:NSTextAlignmentCenter];

    [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attrStr.string length])];
    
    [attrStr drawWithRect:rect options:NSStringDrawingUsesLineFragmentOrigin context:NULL];
}

@end

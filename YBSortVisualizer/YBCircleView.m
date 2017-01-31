//
//  YBCircleView.m
//  YBSortVisualizer
//
//  Created by Evgen Bakumenko on 1/30/17.
//  Copyright © 2017 Evgen Bakumenko. All rights reserved.
//

#import "YBCircleView.h"


static NSInteger kValueLabelFontSize = 10;

@interface YBCircleView()

@property (assign) NSInteger value;
@property (assign) CGFloat ratio;

@end

@implementation YBCircleView

#pragma mark - Init

- (id)initWithFrame:(CGRect)frame value:(NSInteger)value ratio:(CGFloat)ratio{
    if (self = [super initWithFrame:frame]){
        _value = value;
        _ratio = ratio;
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
    //calculate new rect using ratio to differ elements visually
    CGRect ratioRect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width - ((rect.size.width/4) * (1 -_ratio)), rect.size.height - ((rect.size.height/4) * (1 -_ratio)));
    
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(context, ratioRect);
    CGContextSetFillColor(context, CGColorGetComponents([[UIColor colorWithRed:92.0/255.0 green:125.0/255.0	blue:158.0/255.0 alpha:1.0] CGColor]));
    CGContextFillPath(context);
    
    //adding label with value
    UIFont* font = [UIFont boldSystemFontOfSize:kValueLabelFontSize];
    
    NSDictionary* stringAttrs = @{NSFontAttributeName : font, NSForegroundColorAttributeName : UIColor.whiteColor};
    
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld", _value] attributes:stringAttrs];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setAlignment:NSTextAlignmentCenter];

    [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attrStr.string length])];
    
    //Find the rect that the string will draw into **inside the maxTextRect**
    CGRect actualRect = [attrStr boundingRectWithSize:ratioRect.size options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    //Offset the actual rect inside the maxTextRect
    // this will center vertically and horizontally
    CGRect drawRect = CGRectMake(CGRectGetMinX(ratioRect) + ((CGRectGetWidth(ratioRect) - CGRectGetWidth(actualRect)) * 0.5)
                                 , CGRectGetMinY(ratioRect) + ((CGRectGetHeight(ratioRect) - CGRectGetHeight(actualRect)) * 0.5)
                                 , CGRectGetWidth(actualRect)
                                 , CGRectGetHeight(actualRect));
    
    [attrStr drawWithRect:drawRect options:NSStringDrawingUsesLineFragmentOrigin context:NULL];
}

@end

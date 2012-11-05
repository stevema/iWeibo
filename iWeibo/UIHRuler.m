//
//  UIHRuler.m
//  Giglr
//
//  Created by Zhu Yuzhou on 9/7/12.
//  Copyright (c) 2012 Giglr. All rights reserved.
//


#import "UIHRuler.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIHRuler

-(id)initWithFrame:(CGRect)frame
{
    self = [self initWithFrame:frame withPrimaryColor:nil withSecondaryColor:nil];
    
    return self;
}

- (id)initWithFrame:(CGRect)frame withPrimaryColor:(UIColor *)color1 withSecondaryColor:(UIColor *)color2
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        if (color1 == nil)
        {
            color1 = [UIColor colorWithRed:0.88f green:0.88f blue:0.88f alpha:1.0f];
        }
        
        if (color2 == nil)
        {
            color2 = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
        }
        
        CAShapeLayer *lineShape = nil;
        CGMutablePathRef linePath = nil;
        linePath = CGPathCreateMutable();
        lineShape = [CAShapeLayer layer];
        
        lineShape.lineWidth = 1.0f;
        lineShape.lineCap = kCALineCapRound;
        lineShape.strokeColor = [color1 CGColor];
        
        int x = 0;
        int toX = self.bounds.size.width;
        CGPathMoveToPoint(linePath, NULL, x, 0);
        CGPathAddLineToPoint(linePath, NULL, toX, 0);
        lineShape.path = linePath;
        
        lineShape.path = linePath;
        CGPathRelease(linePath);
        
        [self.layer addSublayer:lineShape];
        
        lineShape = nil;
        linePath = nil;
        linePath = CGPathCreateMutable();
        lineShape = [CAShapeLayer layer];
        
        lineShape.lineWidth = 1.0f;
        lineShape.lineCap = kCALineCapRound;
        lineShape.strokeColor = [color2 CGColor];
        
        CGPathMoveToPoint(linePath, NULL, x, 1);
        CGPathAddLineToPoint(linePath, NULL, toX, 1);
        lineShape.path = linePath;
        
        lineShape.path = linePath;
        CGPathRelease(linePath);
        
        [self.layer addSublayer:lineShape];
    }
    return self;
}


@end

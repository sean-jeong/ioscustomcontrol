//
//  CERangeRulerLayer.m
//  CERangeSlider
//
//  Created by Sean Jeong on 8/17/16.
//  Copyright © 2016 tare. All rights reserved.
//

#import "CERangeRulerLayer.h"
#import "CERangeSlider.h"


@implementation CERangeRulerLayer {
    NSMutableArray<UIBezierPath*> *pathArray;
}




- (void) drawInContext:(CGContextRef)ctx {
    
    /*
    // first
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    [aPath moveToPoint:CGPointMake(0, 0)];
    [aPath addLineToPoint:CGPointMake(0, self.bounds.size.height)];
    CGContextSetStrokeColorWithColor(ctx, [UIColor blueColor].CGColor);
    CGContextSetLineWidth(ctx, 2);
    CGContextAddPath(ctx, aPath.CGPath);
    CGContextStrokePath(ctx);
    //[aPath closePath];
    //CGContextClosePath(ctx);
    
    
    // second
    UIBezierPath *bPath = [UIBezierPath bezierPath];
    [bPath moveToPoint:CGPointMake(self.bounds.size.width, 0)];
    [bPath addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextSetLineWidth(ctx, 2);
    CGContextAddPath(ctx, bPath.CGPath);
    CGContextStrokePath(ctx);
    //[bPath closePath];
    //*/
    pathArray = [self arrangePath];
    
    for(UIBezierPath *aPath in pathArray) {
        CGContextSetStrokeColorWithColor(ctx, [UIColor blueColor].CGColor);
        CGContextSetLineWidth(ctx, 2);
        CGContextAddPath(ctx, aPath.CGPath);
        //CGContextStrokePath(ctx);
        CGContextDrawPath(ctx, kCGPathStroke);
        //CGContextClosePath(ctx);
    }
    
    
}

- (NSMutableArray*)arrangePath {

    NSMutableArray *paths = [[NSMutableArray alloc] init];
    for(int i=0; i<self.slider.sectionCount; i++) {
        CGPoint prevPoint = CGPointMake(i*[self getDistance], 0);
        if ( i==0 ) {
            prevPoint.x += 1;
        } else if ( i==(self.slider.sectionCount-1) ) {
            prevPoint.x -= 1;
        }
        
        UIBezierPath *aPath = [UIBezierPath bezierPath];
        [aPath moveToPoint:prevPoint];
        [aPath addLineToPoint:CGPointMake(prevPoint.x, self.bounds.size.height)];
        [paths addObject:aPath];
    }
    return paths;
}

- (CGFloat)getDistance {
    return (self.bounds.size.width / (self.slider.sectionCount-1));
}

@end

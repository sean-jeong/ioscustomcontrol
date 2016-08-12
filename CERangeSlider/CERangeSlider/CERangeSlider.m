//
//  CERangeSlider.m
//  CERangeSlider
//
//  Created by Sean Jeong on 8/12/16.
//  Copyright © 2016 tare. All rights reserved.
//

#import "CERangeSlider.h"
#import "CERangeSliderKnobLayer.h"
#import <QuartzCore/QuartzCore.h>

@implementation CERangeSlider {
    CALayer *_trackLayer;
    CERangeSliderKnobLayer *_upperKnobLayer;
    CERangeSliderKnobLayer *_lowerKnobLayer;
    
    float _knobWidth;
    float _useableTrackLength;
    
    CGPoint _previousTouchPoint;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
   
    self = [super initWithFrame:frame];
    if (self) {
        _maximumValue = 10.0;
        _minimumValue = 0.0;
        _upperValue = 8.0;
        _lowerValue = 2.0;
        
        _trackLayer = [CALayer layer];
        _trackLayer.backgroundColor = [UIColor blueColor].CGColor;
        [self.layer addSublayer:_trackLayer];
        
        _upperKnobLayer = [CERangeSliderKnobLayer layer];
        _upperKnobLayer.slider = self;
        _upperKnobLayer.backgroundColor = [UIColor greenColor].CGColor;
        [self.layer addSublayer:_upperKnobLayer];
        
        _lowerKnobLayer = [CERangeSliderKnobLayer layer];
        _lowerKnobLayer.slider = self;
        _lowerKnobLayer.backgroundColor = [UIColor greenColor].CGColor;
        [self.layer addSublayer:_lowerKnobLayer];
        
        [self setLayerFrames];
    }
    return self;
}

/**
setNeedsDisplay : call drawRect
//**/
 
- (void) setLayerFrames {
    _trackLayer.frame = CGRectInset(self.bounds, 0, self.bounds.size.height / 3.5);
    [_trackLayer setNeedsDisplay];
    
    _knobWidth = self.bounds.size.height;
    _useableTrackLength = self.bounds.size.width - _knobWidth;
    
    float upperKnobCenter = [self positionForValue:_upperValue];
    _upperKnobLayer.frame = CGRectMake(upperKnobCenter - _knobWidth / 2, 0, _knobWidth, _knobWidth);
    
    float lowerKnobCenter = [self positionForValue:_lowerValue];
    _lowerKnobLayer.frame = CGRectMake(lowerKnobCenter - _knobWidth / 2 , 0, _knobWidth, _knobWidth);
    
    [_upperKnobLayer setNeedsDisplay];
    [_lowerKnobLayer setNeedsDisplay];
}

- (float) positionForValue:(float)value
{
    return _useableTrackLength * (value - _minimumValue) / (_maximumValue - _minimumValue) + (_knobWidth / 2);
}


- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    _previousTouchPoint = [touch locationInView:self];
    
    // hit test the knob layers
    if (CGRectContainsPoint(_lowerKnobLayer.frame, _previousTouchPoint)) {
        _lowerKnobLayer.highlighted = YES;
        [_lowerKnobLayer setNeedsDisplay];
    } else if (CGRectContainsPoint(_upperKnobLayer.frame, _previousTouchPoint)) {
        _upperKnobLayer.highlighted = YES;
        [_upperKnobLayer setNeedsDisplay];
    }
    
    return _upperKnobLayer.highlighted || _lowerKnobLayer.highlighted;
}

#define BOUND(VALUE, UPPER, LOWER) MIN(MAX(VALUE, LOWER), UPPER)

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {

    CGPoint touchPoint = [touch locationInView:self];
    
    // 1. determine by how much the user has drgged
    float delta = touchPoint.x - _previousTouchPoint.x;
    float valueDelta = (_maximumValue - _minimumValue) * delta / _useableTrackLength;
    
    _previousTouchPoint = touchPoint;
    
    // 2. update the values
    if (_lowerKnobLayer.highlighted) {
        <#statements#>
    }
    
    
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    
}


@end































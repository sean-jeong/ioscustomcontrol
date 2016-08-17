//
//  CERangeSlider.m
//  CERangeSlider
//
//  Created by Sean Jeong on 8/12/16.
//  Copyright © 2016 tare. All rights reserved.
//

#import "CERangeSlider.h"
#import "CERangeSliderKnobLayer.h"
#import "CERangeSliderTrackLayer.h"
#import "CERangeRulerLayer.h"
#import <QuartzCore/QuartzCore.h>

@implementation CERangeSlider {
    CERangeSliderTrackLayer *_trackLayer;
    CERangeSliderKnobLayer *_upperKnobLayer;
    CERangeSliderKnobLayer *_lowerKnobLayer;
    CERangeRulerLayer *_upperRuler;
    CERangeRulerLayer *_lowerRuler;
    
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
        
        _trackHighlightColor = [UIColor colorWithRed:0.0 green:0.45 blue:0.94 alpha:1.0];
        _trackColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        _knobColor = [UIColor whiteColor];
        _curvaceousness = 1.0;
        
        
        _maximumValue = 10.0;
        _minimumValue = 0.0;
        _upperValue = 8.0;
        _lowerValue = 2.0;
        _sectionCount = 3;
        
        // ruler
        _upperRuler = [CERangeRulerLayer layer];
        _upperRuler.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.5].CGColor;
        _upperRuler.slider = self;
        [self.layer addSublayer:_upperRuler];
        
        _lowerRuler = [CERangeRulerLayer layer];
        _lowerRuler.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.5].CGColor;
        _lowerRuler.slider = self;
        [self.layer addSublayer:_lowerRuler];
        
        _trackLayer = [CERangeSliderTrackLayer layer];
        _trackLayer.slider = self;
        //_trackLayer.backgroundColor = [UIColor blueColor].CGColor;
        [self.layer addSublayer:_trackLayer];
        
        _upperKnobLayer = [CERangeSliderKnobLayer layer];
        _upperKnobLayer.slider = self;
        //_upperKnobLayer.backgroundColor = [UIColor greenColor].CGColor;
        [self.layer addSublayer:_upperKnobLayer];
        
        _lowerKnobLayer = [CERangeSliderKnobLayer layer];
        _lowerKnobLayer.slider = self;
        //_lowerKnobLayer.backgroundColor = [UIColor greenColor].CGColor;
        [self.layer addSublayer:_lowerKnobLayer];
        
        
        
        [self setLayerFrames];
    }
    return self;
}

/**
setNeedsDisplay : call drawRect
**/
 
- (void) setLayerFrames {
    
    CGRect trackFrame = CGRectMake(0, 20, self.bounds.size.width, 20);
    
    _trackLayer.frame = trackFrame; //CGRectInset(self.bounds, 0, self.bounds.size.height / 3.5);
    [_trackLayer setNeedsDisplay];
    
    _knobWidth = trackFrame.size.height;//self.bounds.size.height;
    _useableTrackLength = trackFrame.size.width - _knobWidth;
    
    
    
    float upperKnobCenter = [self positionForValue:_upperValue];
    _upperKnobLayer.frame = CGRectMake(upperKnobCenter - _knobWidth / 2, 20, _knobWidth, _knobWidth);
    
    float lowerKnobCenter = [self positionForValue:_lowerValue];
    _lowerKnobLayer.frame = CGRectMake(lowerKnobCenter - _knobWidth / 2 , 20, _knobWidth, _knobWidth);
    
    _upperRuler.frame = CGRectMake(trackFrame.origin.x, trackFrame.origin.y - 10 - 1, trackFrame.size.width, 10);
    _lowerRuler.frame = CGRectMake(trackFrame.origin.x, trackFrame.origin.y + trackFrame.size.height + 1, trackFrame.size.width, 10);
    
    
    [_upperKnobLayer setNeedsDisplay];
    [_lowerKnobLayer setNeedsDisplay];
    [_upperRuler setNeedsDisplay];
    [_lowerRuler setNeedsDisplay];
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
        _lowerValue += valueDelta;
        _lowerValue = BOUND(_lowerValue, _upperValue, _minimumValue);
    }
    if (_upperKnobLayer.highlighted) {
        _upperValue += valueDelta;
        _upperValue = BOUND(_upperValue, _maximumValue, _lowerValue);
    }
    
    // 3. Update the UI State
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    [self setLayerFrames];
    
    [CATransaction commit];
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
    return YES;
    
    
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    _lowerKnobLayer.highlighted = _upperKnobLayer.highlighted = NO;
    [_lowerKnobLayer setNeedsDisplay];
    [_upperKnobLayer setNeedsDisplay];
}


@end































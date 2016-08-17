//
//  CERangeSlider.h
//  CERangeSlider
//
//  Created by Sean Jeong on 8/12/16.
//  Copyright © 2016 tare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CERangeSlider : UIControl

@property (nonatomic) float maximumValue;
@property (nonatomic) float minimumValue;
@property (nonatomic) float upperValue;
@property (nonatomic) float lowerValue;

@property (nonatomic) UIColor *trackColor;
@property (nonatomic) UIColor *trackHighlightColor;
@property (nonatomic) UIColor *knobColor;
@property (nonatomic) float curvaceousness;
@property (nonatomic) int   sectionCount;
@property (nonatomic) CGSize *knobSize;

- (float) positionForValue:(float)value;

@end

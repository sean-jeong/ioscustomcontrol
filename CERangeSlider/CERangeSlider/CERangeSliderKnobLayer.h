//
//  CERangeSliderKnobLayer.h
//  CERangeSlider
//
//  Created by Sean Jeong on 8/12/16.
//  Copyright © 2016 tare. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@class CERangeSlider;

@interface CERangeSliderKnobLayer : CALayer

@property BOOL highlighted;
@property (weak) CERangeSlider* slider;

@end

//
//  ViewController.m
//  CERangeSlider
//
//  Created by Sean Jeong on 8/12/16.
//  Copyright © 2016 tare. All rights reserved.
//

#import "ViewController.h"
#import "CERangeSlider.h"

@interface ViewController () {
    CERangeSlider* _rangeSlider;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSUInteger margin = 20;
    CGRect sliderFrame = CGRectMake(margin, margin, self.view.frame.size.width - margin * 2, 30);
    _rangeSlider = [[CERangeSlider alloc] initWithFrame:sliderFrame];
    _rangeSlider.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:_rangeSlider];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

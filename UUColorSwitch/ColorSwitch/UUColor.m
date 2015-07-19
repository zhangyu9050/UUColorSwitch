//
//  UUColor.m
//  UUColorSwitch
//
//  Created by zhangyu on 15/7/20.
//  Copyright (c) 2015年 zhangyu. All rights reserved.
//

#import "UUColor.h"

@implementation UUColor

- (instancetype)initWithTextColor:(UUColorType)type
                           target:(UIView *)target
                          toColor:(UIColor *)toColor
                        fromColor:(UIColor *)fromColor{

    if (self = [super init]) {
        
        _toColor = toColor;
        _targetView = target;
        _fromColor = fromColor;
        _colorType = kUUColor_textColor;
    }
    
    return self;
}

- (instancetype)initWithTintColor:(UUColorType)type
                           target:(UIView *)target
                          toColor:(UIColor *)toColor
                        fromColor:(UIColor *)fromColor{
    
    if (self = [super init]) {
        
        _toColor = toColor;
        _targetView = target;
        _fromColor = fromColor;
        _colorType = kUUColor_textColor;
    }
    
    return self;
}


- (instancetype)initWithBackGroundColor:(UUColorType)type
                                 target:(UIView *)target
                                toColor:(UIColor *)toColor
                              fromColor:(UIColor *)fromColor{
    
    if (self = [super init]) {
        
        _toColor = toColor;
        _targetView = target;
        _fromColor = fromColor;
        _colorType = kUUColor_textColor;
    }
    
    return self;
}

@end

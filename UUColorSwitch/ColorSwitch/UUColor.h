//
//  UUColor.h
//  UUColorSwitch
//
//  Created by zhangyu on 15/7/20.
//  Copyright (c) 2015年 zhangyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {

    kUUColor_textColor = 1000,
    kUUColor_tintColor,
    kUUColor_backgroundColor
    
}UUColorType;

@interface UUColor : NSObject

@property (nonatomic, strong) UIView *targetView;
@property (nonatomic, strong) UIColor *toColor;
@property (nonatomic, strong) UIColor *fromColor;
@property (nonatomic, assign) UUColorType colorType;

- (instancetype)initWithTextColor:(UUColorType)type
                           target:(UIView *)target
                          toColor:(UIColor *)toColor
                        fromColor:(UIColor *)fromColor;

- (instancetype)initWithTintColor:(UUColorType)type
                           target:(UIView *)target
                          toColor:(UIColor *)toColor
                        fromColor:(UIColor *)fromColor;

- (instancetype)initWithBackGroundColor:(UUColorType)type
                                 target:(UIView *)target
                                toColor:(UIColor *)toColor
                              fromColor:(UIColor *)fromColor;

@end

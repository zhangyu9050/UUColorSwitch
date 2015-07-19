//
//  UUColorSwitch.h
//  UUColorSwitch
//
//  Created by zhangyu on 15/7/20.
//  Copyright (c) 2015年 zhangyu. All rights reserved.
//

#import <UIKit/UIKit.h>

/** @constant AMViralSwitch AMElementView View animated alongside the switch */
FOUNDATION_EXPORT NSString *const UUElementView;
/** @constant AMViralSwitch AMElementView Key-path for the animated view property */
FOUNDATION_EXPORT NSString *const UUElementKeyPath;
/** @constant AMViralSwitch AMElementView Starting point for the animated view */
FOUNDATION_EXPORT NSString *const UUElementFromValue;
/** @constant AMViralSwitch AMElementView End point for the animated view */
FOUNDATION_EXPORT NSString *const UUElementToValue;

@interface UUColorSwitch : UISwitch

@property (nonatomic, strong) NSArray *animationElementsOn;

/** Views animated when the switch is turned off
 *
 * Holds an array of dictionaries with the following structure:
 * @{
 *  AMElementView: someView,
 *  AMElementKeyPath: @"alpha",
 *  AMElementFromValue: @0,
 *  AMElementToValue: @1
 * }
 */
@property (nonatomic, strong) NSArray *animationElementsOff;


@property (nonatomic, copy) void (^completionOn)();

/** Animation 'off' completion
 *
 * Block called when the animation from 'on' to 'off' is completed
 */
@property (nonatomic, copy) void (^completionOff)();

@end

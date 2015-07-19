//
//  UUColorSwitch.m
//  UUColorSwitch
//
//  Created by zhangyu on 15/7/20.
//  Copyright (c) 2015年 zhangyu. All rights reserved.
//

#import "UUColorSwitch.h"

#define kDURATION   0.35

NSString *const UUElementView      = @"UUElementView";
NSString *const UUElementKeyPath   = @"UUElementKeyPath";
NSString *const UUElementFromValue = @"UUElementFromValue";
NSString *const UUElementToValue   = @"UUElementToValue";

@interface UUColorSwitch()

@property (nonatomic, strong) CAShapeLayer *shapeCircle;

@property (nonatomic, assign) CGFloat radius;

@end

@implementation UUColorSwitch

- (void)layoutSubviews {
    
    // Yay for math!
    CGFloat x = MAX(CGRectGetMidX(self.frame), self.superview.frame.size.width - CGRectGetMidX(self.frame));
    CGFloat y = MAX(CGRectGetMidY(self.frame), self.superview.frame.size.height - CGRectGetMidY(self.frame));
    self.radius = sqrt(x * x + y * y);
    
    _shapeCircle.frame = (CGRect){CGRectGetMidX(self.frame) - self.radius,
        CGRectGetMidY(self.frame) - self.radius, self.radius * 2, self.radius * 2};
    _shapeCircle.anchorPoint = CGPointMake(0.5, 0.5);
    _shapeCircle.path = [UIBezierPath bezierPathWithOvalInRect:(CGRect){0, 0, self.radius * 2, self.radius * 2}].CGPath;
}

- (void)didMoveToSuperview {
    
    [self.superview setClipsToBounds:YES];
    
    _shapeCircle = [CAShapeLayer layer];
    _shapeCircle.fillColor = self.onTintColor.CGColor;
    _shapeCircle.transform = CATransform3DMakeScale(0.0001, 0.0001, 0.0001);
    [self.superview.layer insertSublayer:_shapeCircle atIndex:0];
    
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.cornerRadius = self.frame.size.height / 2;
    
    if (self.superview) {
        [self addObserver:self forKeyPath:@"on" options:(NSKeyValueObservingOptionNew) context:nil];
    }
    
    [self addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
}

#pragma mark - Event Action

- (void)switchChanged:(UISwitch *)sender {

    if (sender.on) {
        [CATransaction begin];
        if (self.completionOn) {
            [CATransaction setCompletionBlock:self.completionOn];
        }
        
        // Reset
        [_shapeCircle removeAnimationForKey:@"scaleDown"];
        [_shapeCircle removeAnimationForKey:@"borderDown"];
        self.layer.borderWidth = 0;
        
        CABasicAnimation *scaleAnimation = [self animateKeyPath:@"transform.scale"
                                                      fromValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0001, 0.0001, 0.0001)]
                                                        toValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]
                                                         timing:kCAMediaTimingFunctionEaseIn];
        [_shapeCircle addAnimation:scaleAnimation forKey:@"scaleUp"];
        
        CABasicAnimation *borderAnimation = [self animateKeyPath:@"borderWidth" fromValue:@0 toValue:@1 timing:kCAMediaTimingFunctionEaseIn];
        [self.layer addAnimation:borderAnimation forKey:@"borderUp"];
        
        [self animateElementsFrom:self.animationElementsOn];
        [CATransaction commit];
        
    } else {
        [CATransaction begin];
        if (self.completionOff) {
            [CATransaction setCompletionBlock:self.completionOff];
        }
        
        // Reset
        [_shapeCircle removeAnimationForKey:@"scaleUp"];
        [_shapeCircle removeAnimationForKey:@"borderUp"];
        self.layer.borderWidth = 1;
        
        CABasicAnimation *scaleAnimation = [self animateKeyPath:@"transform.scale"
                                                      fromValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]
                                                        toValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0001, 0.0001, 0.0001)]
                                                         timing:kCAMediaTimingFunctionEaseOut];
        [_shapeCircle addAnimation:scaleAnimation forKey:@"scaleDown"];
        
        CABasicAnimation *borderAnimation = [self animateKeyPath:@"borderWidth" fromValue:@1 toValue:@0 timing:kCAMediaTimingFunctionEaseOut];
        [self.layer addAnimation:borderAnimation forKey:@"borderDown"];
        
        [self animateElementsFrom:self.animationElementsOff];
        [CATransaction commit];
        
    }
}

- (void)setOn:(BOOL)on animated:(BOOL)animated {
    
    [super setOn:on animated:animated];
    [self switchChanged:self];
}

#pragma mark - Observe

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    [self switchChanged:self];
}

#pragma mark - Private

- (void)animateElementsFrom:(NSArray *)elements {
    for (NSDictionary *element in elements) {
        if ([element[UUElementKeyPath] isEqualToString:@"textColor"] && [element[UUElementView] isKindOfClass:[UILabel class]]) {
            [UIView transitionWithView:element[UUElementView]
                              duration:kDURATION
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{
                                [(UILabel *)element[UUElementView] setTextColor:element[UUElementToValue]];
                            }
                            completion:nil];
        } else if ([element[UUElementKeyPath] isEqualToString:@"tintColor"] && [element[UUElementView] isKindOfClass:[UIButton class]]) {
            [UIView transitionWithView:element[UUElementView]
                              duration:kDURATION
                               options:UIViewAnimationOptionTransitionNone
                            animations:^{
                                [(UIButton *)element[UUElementView] setTintColor:element[UUElementToValue]];
                            }
                            completion:nil];
        } else {
            CABasicAnimation *elementAnimation = [self animateKeyPath:element[UUElementKeyPath]
                                                            fromValue:element[UUElementFromValue]
                                                              toValue:element[UUElementToValue]
                                                               timing:kCAMediaTimingFunctionEaseIn];
            [element[UUElementView] addAnimation:elementAnimation forKey:element[UUElementKeyPath]];
        }
    }
}


- (CABasicAnimation *)animateKeyPath:(NSString *)keyPath fromValue:(id)from toValue:(id)to timing:(NSString *)timing {
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animation.fromValue = from;
    animation.toValue = to;
    animation.repeatCount = 1;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:timing];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = kDURATION;
    return animation;
}


- (void)dealloc {
    
    [self removeObserver:self forKeyPath:@"on"];
}

@end

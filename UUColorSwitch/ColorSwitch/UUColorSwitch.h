//
//  UUColorSwitch.h
//  UUColorSwitch
//
//  Created by zhangyu on 15/7/20.
//  Copyright (c) 2015年 zhangyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UUColorSwitch : UISwitch

@property (nonatomic, copy) void (^completion)(BOOL isFinish);

@end

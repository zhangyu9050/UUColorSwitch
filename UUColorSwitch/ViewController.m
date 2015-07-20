//
//  ViewController.m
//  UUColorSwitch
//
//  Created by zhangyu on 15/7/20.
//  Copyright (c) 2015年 zhangyu. All rights reserved.
//

#import "ViewController.h"
#import "UUColorSwitch.h"

@interface ViewController ()

@property (nonatomic, strong) IBOutlet UILabel *lblBule;
@property (nonatomic, strong) IBOutlet UIView *buleView;
@property (nonatomic, strong) IBOutlet UUColorSwitch *colorSwitch;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self createSwitch];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createSwitch{
    

    _colorSwitch.animationElementsOn = @[
                                        @{ UUElementView: _buleView.layer,
                                           UUElementKeyPath: @"backgroundColor",
                                           UUElementFromValue: (id)[UIColor clearColor].CGColor,
                                           UUElementToValue: (id)[UIColor greenColor].CGColor }
                                        ];
    
    _colorSwitch.animationElementsOff = @[
                                         @{ UUElementView: _buleView.layer,
                                            UUElementKeyPath: @"backgroundColor",
                                            UUElementFromValue: (id)[UIColor clearColor].CGColor,
                                            UUElementToValue: (id)[UIColor clearColor].CGColor }
                                         ];

}

@end

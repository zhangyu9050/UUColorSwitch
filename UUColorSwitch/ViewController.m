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

@property (nonatomic, strong) UILabel *lbl;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UUColorSwitch *colorSwitch;



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
    
    _contentView = [[UIView alloc] init];
    _contentView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 300);
    [self.view addSubview:_contentView];
    
    _lbl = [[UILabel alloc] init];
    _lbl.frame = CGRectMake(20, 20, 100, 30);
    _lbl.text = @"123";
    
    [_contentView addSubview:_lbl];

    _colorSwitch = [[UUColorSwitch alloc] init];
    _colorSwitch.frame = CGRectMake(100, 100, 80, 80);
    _colorSwitch.onTintColor = [UIColor redColor];
    
    [_contentView addSubview:_colorSwitch];
    
    _colorSwitch.animationElementsOn = @[
                                        @{ UUElementView: _contentView.layer,
                                           UUElementKeyPath: @"backgroundColor",
                                           UUElementFromValue: (id)[UIColor clearColor].CGColor,
                                           UUElementToValue: (id)[UIColor greenColor].CGColor }
                                        ];
    
    _colorSwitch.animationElementsOff = @[
                                         @{ UUElementView: _contentView.layer,
                                            UUElementKeyPath: @"backgroundColor",
                                            UUElementFromValue: (id)[UIColor clearColor].CGColor,
                                            UUElementToValue: (id)[UIColor blackColor].CGColor }
                                         ];

}

@end

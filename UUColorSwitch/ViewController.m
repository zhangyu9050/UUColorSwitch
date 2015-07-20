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
@property (nonatomic, strong) IBOutlet UIImageView *buleImageView;
@property (nonatomic, strong) IBOutlet UUColorSwitch *colorSwitch;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self configSwitch];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configSwitch{
    
    __weak ViewController *weakSelf = self;
    _colorSwitch.completion = ^(BOOL isFinish){

        [weakSelf animateLabel:weakSelf.lblBule duration:.35f onAnimation:isFinish];
        [weakSelf animateImage:weakSelf.buleImageView duration:.35f onAnimation:isFinish];
    };

}

- (void)animateLabel:(UILabel *)label duration:(NSTimeInterval )duration onAnimation:(BOOL )onAnimation{

    [UIView transitionWithView:label
                      duration:duration
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        
                        UIColor *color = !onAnimation ? [UIColor colorWithRed:81/255.0 green:155/255.0 blue:249/255.0 alpha:1] : [UIColor whiteColor];
                        [label setTextColor:color];
                    }
                    completion:nil];
}

- (void)animateImage:(UILabel *)label duration:(NSTimeInterval )duration onAnimation:(BOOL )onAnimation{
    
    [UIView transitionWithView:label
                      duration:duration
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        
                        _buleImageView.image = [UIImage imageNamed:onAnimation ? @"img_phone_on" : @"img_phone_off"];
                    }
                    completion:nil];
}

@end

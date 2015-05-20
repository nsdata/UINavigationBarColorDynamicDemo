//
//  TempViewController.m
//  NavigationBarBgColorTest
//
//  Created by YangXudong on 15/5/19.
//  Copyright (c) 2015年 YangXudong. All rights reserved.
//

#import "TempViewController.h"
#import "UINavigationBar+BackgroundColor.h"

@interface TempViewController ()

@property (nonatomic, strong) UINavigationBar *bar;

@end

@implementation TempViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.navigationController.navigationBar action_reset];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.bar = self.navigationController.navigationBar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"101"]) {
        
        __weak TempViewController *weakSelf = self;
        
        [UIView animateKeyframesWithDuration:0.35
                                       delay:0
                                     options:UIViewKeyframeAnimationOptionCalculationModeLinear
                                  animations:^{
                                      
                                      [weakSelf.bar action_setSystemBarBackgroundAlpha:0];
                                      
                                  } completion:nil];
        
    }
}

@end

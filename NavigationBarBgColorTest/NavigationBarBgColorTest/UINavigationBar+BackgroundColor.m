//
//  UINavigationBar+BackgroundColor.m
//  NavigationBarBgColorTest
//
//  Created by YangXudong on 15/5/19.
//  Copyright (c) 2015年 YangXudong. All rights reserved.
//

#import "UINavigationBar+BackgroundColor.h"
#import <objc/runtime.h>

@interface UINavigationBar ()

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UIImageView *systemBackgroundView;

@end

static const void *BackViewKey = &BackViewKey;

static const void *SystemBackgroundViewKey = &SystemBackgroundViewKey;

@implementation UINavigationBar (BackgroundColor)

-(void)action_setBackgroundColor:(UIColor *)backgroundColor{
    
    if (!self.backView) {
        self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, 64)];
        self.backView.userInteractionEnabled = NO;
        [self insertSubview:self.backView atIndex:0];
    }
    
    if (self.systemBackgroundView.alpha > 0) {
        self.systemBackgroundView.alpha = 0;
    }
    
    self.backView.backgroundColor = backgroundColor;
}

-(void)action_setSystemBarBackgroundAlpha:(CGFloat)alpha {
    self.systemBackgroundView.alpha = alpha;
}

-(void)action_reset {
    self.systemBackgroundView.alpha = 1;
    [self.backView removeFromSuperview];
    self.backView = nil;
}

#pragma mark -

-(void)setBackView:(UIView *)backView
{
    objc_setAssociatedObject(self, BackViewKey, backView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIView *)backView
{
    return objc_getAssociatedObject(self, BackViewKey);
}

-(void)setSystemBackgroundView:(UIImageView *)systemBackgroundView
{
    objc_setAssociatedObject(self, SystemBackgroundViewKey, systemBackgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIImageView *)systemBackgroundView
{
    UIImageView *backgroundView = objc_getAssociatedObject(self, SystemBackgroundViewKey);
    
    if (!backgroundView) {
        
        for (UIView *view in self.subviews) {
            
            if ([view isKindOfClass:[UIImageView class]])
            {
                self.systemBackgroundView = (UIImageView *)view;
                backgroundView = (UIImageView *)view;
                break;
            }
        }
    }
    
    return backgroundView;
}

@end

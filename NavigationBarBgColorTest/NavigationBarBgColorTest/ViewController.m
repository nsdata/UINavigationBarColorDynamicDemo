//
//  ViewController.m
//  NavigationBarBgColorTest
//
//  Created by YangXudong on 15/5/19.
//  Copyright (c) 2015年 YangXudong. All rights reserved.
//

#import "ViewController.h"
#import "UINavigationBar+BackgroundColor.h"

@interface ViewController ()<UITableViewDataSource,UIScrollViewDelegate> {
    BOOL canChangeNavigationBarColor;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UIPanGestureRecognizer *pan;

@property (nonatomic, strong) UINavigationBar *bar;

@end

@implementation ViewController


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (!canChangeNavigationBarColor) {
        return;
    }
    
    UIColor *color = [UIColor colorWithRed:251./255.0 green:113./255.0 blue:114/255.0 alpha:1];
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY > 0) {
        CGFloat alpha = 1 - ((64-offsetY)/64);
        [self.navigationController.navigationBar action_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar action_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
}

#pragma mark -

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    canChangeNavigationBarColor = YES;
    [self scrollViewDidScroll:self.tableView];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    canChangeNavigationBarColor = NO;
}

-(void)viewDidDisappear:(BOOL)animated {
    [self.pan removeTarget:self action:@selector(action_pan:)];
    self.pan = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    self.pan = (UIPanGestureRecognizer *)self.navigationController.interactivePopGestureRecognizer;
    
    [self.pan addTarget:self action:@selector(action_pan:)];
    
    self.bar = self.navigationController.navigationBar;
}

- (void) action_pan:(UIPanGestureRecognizer *)pan {
    
    CGFloat pointX = [pan translationInView:self.view].x;
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat alpha = pointX/screenWidth;
    
    NSLog(@"alpha : %lf",alpha);
    
    [self.bar action_setSystemBarBackgroundAlpha:alpha];
}

#pragma mark - 

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"row : %d",(int)indexPath.row];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 60;
}

@end

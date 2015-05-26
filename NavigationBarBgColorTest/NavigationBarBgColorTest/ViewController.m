//
//  ViewController.m
//  NavigationBarBgColorTest
//
//  Created by YangXudong on 15/5/19.
//  Copyright (c) 2015年 YangXudong. All rights reserved.
//

#import "ViewController.h"
#import "UINavigationBar+BackgroundColor.h"
#import "UIViewController+NavigationBarColor.h"

@interface ViewController ()<UITableViewDataSource,UIScrollViewDelegate> {
    BOOL canChangeNavigationBarColor;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

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
    //如果不移除target 会在dealloc后继续接收事件 导致崩溃
    [self action_removeNavigationPanTarget];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    //加上左滑手势的监控 随着左滑改变系统bar的透明度
    [self action_addNavigationPanTarget];
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

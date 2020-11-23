//
//  ViewController.m
//  HBSearchNavDemo
//
//  Created by 胡明波 on 2020/11/23.
//  Copyright © 2020 yanruyu. All rights reserved.
//

#import "ViewController.h"
#import "HBSearchViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"搜索demo";
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 200, 200);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"点击搜索" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickSearchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
#pragma mark ==========点击按钮==========
-(void)clickSearchBtn:(UIButton *)btn{
    HBSearchViewController *vc = [[HBSearchViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end

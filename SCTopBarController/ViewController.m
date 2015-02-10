//
//  ViewController.m
//  SCTopBarController
//
//  Created by 2014-763 on 15/2/10.
//  Copyright (c) 2015年 meilishuo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titles = [NSArray arrayWithObjects:@"待付款", @"待发货", @"待收货", @"已完成", @"已关闭",nil];
}

- (void)clickButtonItem:(UIButton *)buttonItem {
    NSLog(@"%zd",buttonItem.tag);
}
@end

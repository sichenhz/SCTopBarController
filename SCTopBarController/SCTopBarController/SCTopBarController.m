//
//  MSTopBarController.m
//  MeiliShop
//
//  Created by 2014-763 on 15/2/10.
//  Copyright (c) 2015年 meilishuo. All rights reserved.
//

#import "SCTopBarController.h"

#define kTopTabBarHeight 40
#define kTopTabBarLineHeight 2
#define kScreenWidth [UIScreen mainScreen].bounds.size.width // 屏幕宽度
#define kScreenHeight [UIScreen mainScreen].bounds.size.height // 屏幕高度
#define Iphone6AndLater ([UIApplication sharedApplication].keyWindow.bounds.size.height >= 667) // 是否是iphone6及以上的设备
#define kBackGroundColor ([UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]) // 经典背景色
#define kLineColor ([UIColor colorWithRed:188/255.0 green:186/255.0 blue:193/255.0 alpha:1]) // 分割线颜色

@interface SCTopBarController ()
@end

@implementation SCTopBarController

#pragma mark - 惰性实例化
- (NSArray *)buttons {
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (void)addChildViewController:(UIViewController *)childController {
    [super addChildViewController:childController];
    
    childController.view.autoresizingMask = UIViewAutoresizingNone;
    childController.view.frame = CGRectMake(0, 64+kTopTabBarHeight, kScreenWidth, kScreenHeight - kTopTabBarHeight - 64);
    
    for (UIButton *button in self.buttons) {
        [button removeFromSuperview];
    }
    [self.buttons removeAllObjects];
    self.selectedViewController = nil;
    self.currentButtonItem = nil;
    [self.lineView removeFromSuperview];
    
    for (int i = 0; i < self.childViewControllers.count; i++) {
        UIButton *buttonItem = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonItem.frame = CGRectMake(kScreenWidth / self.childViewControllers.count * i, 0, kScreenWidth/self.childViewControllers.count, kTopTabBarHeight - 0.5);
        [buttonItem setTitle:[self.childViewControllers[i] tabBarItem].title forState:UIControlStateNormal];
        [buttonItem setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [buttonItem setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        if (Iphone6AndLater) {
            buttonItem.titleLabel.font = [UIFont systemFontOfSize:14.0];
        } else {
            buttonItem.titleLabel.font = [UIFont systemFontOfSize:12.0];
        }
        buttonItem.tag = i;
        [buttonItem addTarget:self action:@selector(clickWithAnimation:) forControlEvents:UIControlEventTouchUpInside];
        [self.topTabBar addSubview:buttonItem];
        [self.buttons addObject:buttonItem];
    }

    if (!self.selectedViewController) {
        [self clickWithAnimation:self.buttons[0]]; // 默认选中第一个子控制器
    }
}

#pragma mark buttonItem点击事件
- (void)clickWithAnimation:(UIButton *)buttonItem {
    
    CGSize size = [buttonItem.titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:buttonItem.titleLabel.font,NSFontAttributeName, nil]];
    CGFloat lineWidth = size.width;
    CGFloat lineWidthTotal = 0;
    for (UIButton *item in self.topTabBar.subviews) {
        if ([item isKindOfClass:[UIButton class]]) {
            CGSize size = [item.titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:buttonItem.titleLabel.font,NSFontAttributeName, nil]];
            CGFloat lineWidth = size.width;
            lineWidthTotal += lineWidth;
        }
    }
    CGFloat lineX = (kScreenWidth / self.childViewControllers.count - lineWidth) / 2 + buttonItem.frame.size.width * buttonItem.tag;
    CGFloat lineHeight = kTopTabBarLineHeight;
    CGFloat lineY = buttonItem.frame.size.height - kTopTabBarLineHeight;
    
    if (self.currentButtonItem) {
        self.currentButtonItem.selected = NO;
        [UIView animateWithDuration:0.2 animations:^{
            self.lineView.frame = CGRectMake(lineX, lineY, lineWidth, lineHeight);
        }];
    } else { // 默认选中第一个按钮
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(lineX, lineY, lineWidth, lineHeight)];
        lineView.backgroundColor = [UIColor redColor];
        [self.topTabBar addSubview:lineView];
        self.lineView = lineView;
    }
    buttonItem.selected = YES;
    self.currentButtonItem = buttonItem;
    self.selectedIndex = buttonItem.tag;
    
    [self chooseController:buttonItem.tag];
}


- (void)chooseController:(NSUInteger)selectedIndex
{
    self.selectedIndex = selectedIndex;
    // 移除旧控制器的view
    [self.selectedViewController.view removeFromSuperview];
    // 添加新控制器的view
    UIViewController *vc = self.childViewControllers[selectedIndex];
    [self.view addSubview:vc.view];
    
    self.selectedViewController = vc;
}


- (UIView *)topTabBar {
    if (!_topTabBar) {
        UIView *topTabBar = [[UIView alloc] init];
        topTabBar.frame = CGRectMake(0, 64, kScreenWidth, kTopTabBarHeight);
        topTabBar.backgroundColor = [UIColor whiteColor];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, kTopTabBarHeight - 0.5, kScreenWidth, 0.5)];
        line.backgroundColor = kLineColor;
        [topTabBar addSubview:line];
        [self.view addSubview:topTabBar];
        _topTabBar = topTabBar;
    }
    return _topTabBar;
}


@end

//
//  MSTopBarController.h
//  MeiliShop
//
//  Created by 2014-763 on 15/2/10.
//  Copyright (c) 2015年 meilishuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCTopBarController : UIViewController
/**
 *  当前选中标签的下标
 */
@property (nonatomic, assign) NSInteger selectedIndex;
/**
 *  当前选中的控制器
 */
@property(nonatomic, weak) UIViewController *selectedViewController;
/**
 *  当前选中的标签
 */
@property (nonatomic, assign) UIButton *currentButtonItem;
/**
 *  顶部tabbar条
 */
@property (nonatomic, weak) UIView *topTabBar;
/**
 *  bar条底部的线
 */
@property (nonatomic, weak) UIView *lineView;
/**
 *  所有的按钮
 */
@property (nonatomic, strong) NSMutableArray *buttons;


- (void)clickWithAnimation:(UIButton *)buttonItem;

@end

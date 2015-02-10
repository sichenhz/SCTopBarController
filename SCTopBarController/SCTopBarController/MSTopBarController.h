//
//  MSTopBarController.h
//  MeiliShop
//
//  Created by 2014-763 on 15/2/10.
//  Copyright (c) 2015年 meilishuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSTopBarController : UIViewController
/**
 *  当前选中的标签
 */
@property (nonatomic, weak) UIButton *currentButtonItem;
/**
 *  顶部tabbar条
 */
@property (nonatomic, weak) UIView *topTabBar;
/**
 *  bar条底部的线
 */
@property (nonatomic, weak) UIView *lineView;
/**
 *  所有标签的文字
 */
@property (nonatomic, strong) NSArray *titles;


- (void)clickButtonItem:(UIButton *)buttonItem;
@end

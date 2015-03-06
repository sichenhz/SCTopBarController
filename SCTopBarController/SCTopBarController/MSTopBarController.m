//
//  MSTopBarController.m
//  MeiliShop
//
//  Created by 2014-763 on 15/2/10.
//  Copyright (c) 2015年 meilishuo. All rights reserved.
//

#import "MSTopBarController.h"
#import "Common.h"
#import "UIView+Extension.h"

#define kTopTabBarHeight 40
#define kTopTabBarLineHeight 2
@interface MSTopBarController ()
@end

@implementation MSTopBarController

- (void)viewDidLoad {
    [super viewDidLoad];
        
}


#pragma mark - 惰性实例化
- (void)setTitles:(NSArray *)titles {
    if (_titles != titles) {
        _titles = titles;
        for (int i = 0; i < titles.count; i++) {
            UIButton *buttonItem = [UIButton buttonWithType:UIButtonTypeCustom];
            buttonItem.frame = CGRectMake(SCScreenWidth / titles.count * i, 0, SCScreenWidth/titles.count, kTopTabBarHeight);
            [buttonItem setTitle:titles[i] forState:UIControlStateNormal];
            [buttonItem setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [buttonItem setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            buttonItem.backgroundColor = [UIColor whiteColor];
            if (Iphone6AndLater) {
                buttonItem.titleLabel.font = [UIFont systemFontOfSize:14.0];
            } else {
                buttonItem.titleLabel.font = [UIFont systemFontOfSize:12.0];
            }
            buttonItem.tag = i;
            [buttonItem addTarget:self action:@selector(clickWithAnimation:) forControlEvents:UIControlEventTouchUpInside];
            [self.topTabBar addSubview:buttonItem];
        }
        // 点击第一个item
        UIButton *item = self.topTabBar.subviews[0];
        [self clickWithAnimation:item];
    }
}

- (UIView *)topTabBar {
    if (!_topTabBar) {
        UIView *topTabBar = [[UIView alloc] init];
        topTabBar.frame = CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), SCScreenWidth, kTopTabBarHeight);
        [self.view addSubview:topTabBar];
        self.topTabBar = topTabBar;
    }
    return _topTabBar;
}

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
    CGFloat lineX = (SCScreenWidth - lineWidthTotal) / (self.titles.count * 2) + (buttonItem.width * buttonItem.tag);
    CGFloat lineHeight = kTopTabBarLineHeight;
    CGFloat lineY = buttonItem.height - kTopTabBarLineHeight;
    
    if (self.currentButtonItem) {
        self.currentButtonItem.selected = NO;
        [UIView animateWithDuration:0.2 animations:^{
            self.lineView.frame = CGRectMake(lineX, lineY, lineWidth, lineHeight);
        }];
    } else {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(lineX, lineY, lineWidth, lineHeight)];
        lineView.backgroundColor = [UIColor redColor];
        [self.topTabBar addSubview:lineView];
        self.lineView = lineView;
    }
    buttonItem.selected = YES;
    self.currentButtonItem = buttonItem;
    
    [self clickButtonItem:buttonItem];
}

- (void)clickButtonItem:(UIButton *)buttonItem {
    // doSomething
}

@end

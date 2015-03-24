### 如何使用-SCTopBarController

![icon](http://img01.taobaocdn.com/imgextra/i1/135480037/TB23s9KcXXXXXXDXpXXXXXXXXXX_!!135480037.gif)

####创建类, 导入主头文件并继承

    #import "SCTopBarController.h"
    @interface ViewController : SCTopBarController
    @end

1.实例化一些控制器, 并添加为当前类的子控制器

    UIViewController *vc = [[UIViewController alloc] init];
    [self addChildViewController:vc];
    
2.设置标题

    vc.tabBarItem.title = @"首页";

3.通过clickWithAnimation:方法切换控制器, 也可重写该方法以实现一些额外的操作

    - (void)clickWithAnimation:(UIButton *)buttonItem {
	    [super clickWithAnimation:buttonItem];
    // 在这里执行额外的操作
    }

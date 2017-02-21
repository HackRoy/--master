//
//  JwNavigationController.m
//  Jw_ebank
//
//  Created by Jw on 16/3/9.
//  Copyright © 2016年 Jw. All rights reserved.
//

#import "JwNavigationController.h"
#import "UIBarButtonItem+Extension.h"

@interface JwNavigationController ()

@end

@implementation JwNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationBar.tintColor = [UIColor whiteColor];
    
    //用户图标判断
    UIImage *backImage = [UIImage imageNamed:@"nav"];
    
    CGSize navBarSize = self.navigationBar.bounds.size;
    backImage = [self scaleToSize:backImage size:CGSizeMake(navBarSize.width, navBarSize.height + 20)];
    
    [self.navigationBar setBackgroundImage:backImage forBarMetrics:UIBarMetricsDefault];
}

//调整图片大小
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

/**
 * push的时候隐藏tabBar
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
    [super pushViewController:viewController animated:animated];
}

////重写NavC的push方法
//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    if (self.viewControllers.count > 0)
//    {
//        viewController.hidesBottomBarWhenPushed = YES;
//        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self Action:@selector(backAction:) image:@"bs_camera_back" highImage:@"bs_camera_back"];
//    }
//    
//    [super pushViewController:viewController animated:animated];
//    self.navigationBar.barTintColor = [UIColor whiteColor];
//    
//}
////添加返回按钮的执行方法
//- (void)backAction:(UIBarButtonItem *)barButton
//{
//    [self popViewControllerAnimated:YES];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

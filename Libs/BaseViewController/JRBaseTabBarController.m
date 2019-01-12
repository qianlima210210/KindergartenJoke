//
//  JRBaseTabBarController.m
//  JingRuiOnlineSchool
//
//  Created by maqianli on 2018/9/13.
//  Copyright © 2018年 onesmart. All rights reserved.
//

#import "JRBaseTabBarController.h"

@interface JRBaseTabBarController ()

@end

@implementation JRBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initControllers];
}

//MARK: 初始化相关
-(void)initControllers{
    
    MQLLatestViewController *vc0 = [[MQLLatestViewController alloc]initWithNibName:@"MQLLatestViewController" bundle:nil];
    JRBaseNavigationController *nav0 = [[JRBaseNavigationController alloc]initWithRootViewController:vc0];
    NSString *title0 = @"Latest";
    UIImage *image0 = [UIImage imageNamed:@"private_icon_cart"];
    nav0.tabBarItem = [[UITabBarItem alloc]initWithTitle:title0 image:image0 selectedImage:nil];
    
    MQLHotViewController *vc1 = [[MQLHotViewController alloc]initWithNibName:@"MQLHotViewController" bundle:nil];
    JRBaseNavigationController *nav1 = [[JRBaseNavigationController alloc]initWithRootViewController:vc1];
    NSString *title1 = @"Hot";
    UIImage *image1 = [UIImage imageNamed:@"private_icon_lovemoney"];
    nav1.tabBarItem = [[UITabBarItem alloc]initWithTitle:title1 image:image1 selectedImage:nil];
    
    self.viewControllers = @[nav0, nav1];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//MARK: 屏幕方向相关
- (BOOL)shouldAutorotate{
    if (self.selectedViewController) {
        return [self.selectedViewController shouldAutorotate];
    }
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    if (self.selectedViewController) {
        return [self.selectedViewController supportedInterfaceOrientations];
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    if (self.selectedViewController) {
        return [self.selectedViewController preferredInterfaceOrientationForPresentation];
    }
    return UIInterfaceOrientationPortrait;
}

//MARK: 状态栏相关
- (BOOL)prefersStatusBarHidden{
    if (self.selectedViewController) {
        return [self.selectedViewController prefersStatusBarHidden];
    }
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    if (self.selectedViewController) {
        return [self.selectedViewController preferredStatusBarStyle];
    }
    return UIStatusBarStyleDefault;
}






@end

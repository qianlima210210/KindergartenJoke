//
//  MBProgressHUD+JRAdditional.m
//  JingRuiOnlineSchool
//
//  Created by maqianli on 2018/10/8.
//  Copyright © 2018 onesmart. All rights reserved.
//

#import "MBProgressHUD+JRAdditional.h"

@implementation MBProgressHUD (JRAdditional)

//只显示文本提示，一秒后自动移除
+(void)showHUDAddedTo:(UIView*)view text:(NSString*)text{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // Set the text mode to show only text.
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
    // Move to bottm center if you want.
    //hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    
    hud.removeFromSuperViewOnHide = YES;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.backgroundColor = [UIColor blackColor];
    
    [hud hideAnimated:YES afterDelay:1.f];
}

//显示自定义的视图，文字可选，一秒后自动移除
+(void)showHUDAddedTo:(UIView *)view customView:(UIView*)customView text:(NSString*)text{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // Set the custom view mode to show any view.
    hud.mode = MBProgressHUDModeCustomView;
    
    //Set your customView
    hud.customView = customView;
    
    // Looks a bit nicer if we make it square.
    //hud.square = YES;
    
    // Optional label text.
    hud.label.text = text;
    
    hud.removeFromSuperViewOnHide = YES;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.backgroundColor = [UIColor blackColor];
    
    [hud hideAnimated:YES afterDelay:1.f];
}

//运行等待提示，需自己控制结束
+(MBProgressHUD*)showHUDAddedTo:(UIView *)view animatedView:(UIImageView*)imageView text:(NSString*)text{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // Set the custom view mode to show any view.
    hud.mode = MBProgressHUDModeCustomView;
    
    //Set your customView
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anima.toValue = @(M_PI*2);
    anima.duration = 1.0f;
    anima.repeatCount = 10;
    [imageView.layer addAnimation:anima forKey:nil];
    
    hud.customView = imageView;
    
    // Optional label text.
    hud.label.text = text;
    
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.backgroundColor = [UIColor blackColor];
    
    return hud;
}

//MARK:具体提示接口
//对号图片的成功提示
+(void)showSuccessHUDAddedTo:(UIView*)view text:(NSString*)text{
    
    UIImage *image = [UIImage imageNamed:@"toast_right"];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    [MBProgressHUD showHUDAddedTo:view customView:imageView text:text];
}

//叉号图片的失败提示
+(void)showFailtureHUDAddedTo:(UIView*)view text:(NSString*)text{
    UIImage *image = [UIImage imageNamed:@"toast_wrong"];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    [MBProgressHUD showHUDAddedTo:view customView:imageView text:text];
}

//叹号图片的警告提示
+(void)showWarningHUDAddedTo:(UIView*)view text:(NSString*)text{
    UIImage *image = [UIImage imageNamed:@"toast_warning"];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    [MBProgressHUD showHUDAddedTo:view customView:imageView text:text];
}

//旋转图片的等待提示,需自己控制结束
+(MBProgressHUD*)showRotationHUDAddedTo:(UIView *)view text:(NSString*)text{
    UIImage *iamge = [UIImage imageNamed:@"toast_loading"];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:iamge];
    return [MBProgressHUD showHUDAddedTo:view animatedView:imageView text:text];
}


@end

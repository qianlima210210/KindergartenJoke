//
//  MBProgressHUD+JRAdditional.h
//  JingRuiOnlineSchool
//
//  Created by maqianli on 2018/10/8.
//  Copyright © 2018 onesmart. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (JRAdditional)

//一秒提示：只显示文本提示，一秒后自动移除
+(void)showHUDAddedTo:(UIView*)view text:(NSString*)text;

//一秒提示：显示自定义的视图，文字可选，一秒后自动移除
+(void)showHUDAddedTo:(UIView *)view customView:(UIView*)customView text:(NSString*)text;

//运行等待提示，需自己控制结束
+(MBProgressHUD*)showHUDAddedTo:(UIView *)view animatedView:(UIImageView*)iamgeView text:(NSString*)text;

//对号图片的成功提示
+(void)showSuccessHUDAddedTo:(UIView*)view text:(NSString*)text;

//叉号图片的失败提示
+(void)showFailtureHUDAddedTo:(UIView*)view text:(NSString*)text;

//叹号图片的警告提示
+(void)showWarningHUDAddedTo:(UIView*)view text:(NSString*)text;

//旋转图片的等待提示,需自己控制结束
+(MBProgressHUD*)showRotationHUDAddedTo:(UIView *)view text:(NSString*)text;


@end

NS_ASSUME_NONNULL_END

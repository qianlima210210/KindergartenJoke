//
//  JRViewCoordinateMacro.h
//  JingRuiOnlineSchool
//
//  Created by maqianli on 2018/9/13.
//  Copyright © 2018年 onesmart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//MARK: 手机、pad通用
//MARK: 屏幕宽度
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

//MARK: 屏幕高度
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

//MARK: 屏幕Bounds
#define kScreenBounds [UIScreen mainScreen].bounds

//MARK: 状态栏高度（20.f, iPhoneX下44.f）
#define kStatusBarHeight UIApplication.sharedApplication.statusBarFrame.size.height

//MARK: 手机视图坐标相关

//MARK: 判断是否4.0 英寸
#define IsFourInch (kScreenWidth * kScreenHeight == 320.0 * 568.0)

//MARK: 判断是否4.7 英寸
#define IsFourSevenInch (kScreenWidth * kScreenHeight == 375.0 * 667.0)

//MARK: 判断是否5.5英寸
#define IsFiveFiveInch (kScreenWidth * kScreenHeight == 414.0 * 736.0)

//MARK: 判断是否5.8英寸（iphone X/XS）
#define IsFiveEightInch (kScreenWidth * kScreenHeight == (375.0 * 812.0))

//MARK: 判断是否6.1英寸（iphone XR）
#define IsSixOneInch (kScreenWidth * kScreenHeight == (414.0 * 896.0))

//MARK: 判断是否6.5英寸（iphone XS Max）
#define IsSixFiveInch (kScreenWidth * kScreenHeight == (414.0 * 896.0))


//MARK: tabBar的高度（iPhoneX下为83）
extern CGFloat tabBarHeight(void);

//MARK: 导航栏高度
extern CGFloat navigationBarHeight(void);

//MARK: iPhoneX下，底部安全区域高度
extern CGFloat bottomSafeAreaHeight(void);

//MARK: 相对于iPhone6(375 * 667)的比例--iPhone 6，也是目前psd设计图尺寸，比例一般用于图片的等比拉伸
extern CGFloat viewScaleX_375(void);

//MARK:同上
extern CGFloat viewScaleY_667(void);


//MARK: pad视图坐标相关
//MARK: 判断是否9.7 英寸
#define IsNineSevenInch (kScreenWidth * kScreenHeight == 768.0 * 1024.0)

//MARK: 判断是否10.5 英寸
#define IsTenFiveInch (kScreenWidth * kScreenHeight == 834.0 * 1112.0)

//MARK: 判断是否12.9 英寸
#define IsTwelveNineInch (kScreenWidth * kScreenHeight == 1024.0 * 1366.0)

//MARK: tabBar的高度
extern CGFloat tabBarHeightOfPad(void);

//MARK: 导航栏高度
extern CGFloat navigationBarHeightOfPad(void);












